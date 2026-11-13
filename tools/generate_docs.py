"""Generate curated documentation from marked GameMaker dictionaries."""

from pathlib import Path
import ast
import math
import operator
import re
import posixpath
import shutil


ROOT = Path(__file__).resolve().parents[1]
SOURCE_FILE = ROOT / "objects" / "obj_gameInfo" / "Create_0.gml"
DOCS_DIR = ROOT / "docs"
ASSETS_DIR = DOCS_DIR / "assets"
GENERATED_DIR = DOCS_DIR / "kindlebane-documentation"
GAME_SPRITES_DIR = ROOT / "sprites"
DOC_GAME_SPRITES_DIR = ASSETS_DIR / "game-sprites"

LOREM = (
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
    "Integer vitae sem sed arcu consequat dignissim."
)
STAT_KEYS = {"attack", "defense", "magicAttack", "magicDefense"}
STAT_MAXIMUMS = {
    "attack": 150,
    "defense": 100,
    "magicAttack": 150,
    "magicDefense": 100,
}
IMAGE_FIELDS = {"sprite", "headshot"}
NUMERIC_OPERATORS = {
    ast.Add: operator.add,
    ast.Sub: operator.sub,
    ast.Mult: operator.mul,
    ast.Div: operator.truediv,
    ast.FloorDiv: operator.floordiv,
    ast.Mod: operator.mod,
}


class DocumentedReference(dict):
    def __init__(self, value: dict, node: dict):
        super().__init__(value)
        self.node = node


def slugify(value: str) -> str:
    return re.sub(r"-+", "-", re.sub(r"[^a-z0-9]+", "-", value.lower())).strip("-")


def titleize(value: str) -> str:
    value = re.sub(r"([a-z0-9])([A-Z])", r"\1 \2", value)
    return " ".join(word.capitalize() for word in value.replace("_", " ").split())


def find_braced_end(source: str, opening_brace: int) -> int:
    depth = 0
    in_string = False
    escaped = False
    for index in range(opening_brace, len(source)):
        character = source[index]
        if in_string:
            if escaped:
                escaped = False
            elif character == "\\":
                escaped = True
            elif character == '"':
                in_string = False
        elif character == '"':
            in_string = True
        elif character == "{":
            depth += 1
        elif character == "}":
            depth -= 1
            if depth == 0:
                return index
    raise ValueError("Unclosed GameMaker struct")


def extract_braced_block(source: str, opening_brace: int) -> str:
    return source[opening_brace + 1 : find_braced_end(source, opening_brace)]


def parse_marked_declarations(source: str) -> list[dict]:
    marker_pattern = re.compile(
        r"^\s*///\s*@\s*(doc-[a-z0-9-]+)(?:\s+(.+?))?\s*$",
        re.IGNORECASE,
    )
    declaration_pattern = re.compile(
        r"^\s*(?:([A-Za-z_]\w*)\s*=\s*|([A-Za-z_]\w*)\s*:\s*)\{"
    )
    declarations = []
    pending = None
    offset = 0
    for line in source.splitlines(keepends=True):
        marker = marker_pattern.match(line)
        if marker:
            pending = {
                "marker": marker.group(1).lower(),
                "title": marker.group(2).strip() if marker.group(2) else None,
            }
        elif line.strip():
            declaration = declaration_pattern.match(line)
            if declaration:
                if pending:
                    name = declaration.group(1) or declaration.group(2)
                    opening_brace = offset + declaration.end() - 1
                    declarations.append(
                        {
                            "name": name,
                            "path": marker_path(pending["marker"]),
                            "title": pending["title"],
                            "opening_brace": opening_brace,
                            "end_brace": find_braced_end(source, opening_brace),
                        }
                    )
                pending = None
            elif not line.lstrip().startswith("//"):
                pending = None
        offset += len(line)
    return declarations


def marker_path(marker: str) -> tuple[str, ...]:
    value = marker.removeprefix("doc-").strip()
    return tuple(slugify(part) for part in value.split("-") if slugify(part))


def declaration_nodes(source: str) -> list[dict]:
    declarations = parse_marked_declarations(source)
    nodes = []
    for declaration in declarations:
        path = declaration["path"]
        if not path:
            raise ValueError("Documentation marker must contain a name")
        body = extract_braced_block(source, declaration["opening_brace"])
        is_root = len(path) == 1
        parent_path = path[:-1] if not is_root else ()
        node_path = path if is_root else (*path, slugify(declaration["name"]))
        nodes.append(
            {
                **declaration,
                "id": "-".join(node_path),
                "relative_file": "/".join((*path[:-1], slugify(declaration["name"])))
                + ".md",
                "parent": "-".join(parent_path) or None,
                "is_section": is_root,
                "title": declaration["title"]
                or titleize(path[-1] if is_root else declaration["name"]),
                "body": body,
            }
        )
    return nodes


def split_top_level(value: str) -> list[str]:
    parts = []
    start = 0
    depth = 0
    in_string = False
    escaped = False
    for index, character in enumerate(value):
        if in_string:
            if escaped:
                escaped = False
            elif character == "\\":
                escaped = True
            elif character == '"':
                in_string = False
        elif character == '"':
            in_string = True
        elif character in "[{":
            depth += 1
        elif character in "]}":
            depth -= 1
        elif character == "," and depth == 0:
            if value[start:index].strip():
                parts.append(value[start:index].strip())
            start = index + 1
    if value[start:].strip():
        parts.append(value[start:].strip())
    return parts


def parse_value(raw: str, resolve_reference):
    raw = raw.strip()
    if raw.startswith('"') and raw.endswith('"'):
        return raw[1:-1]
    if raw == "true":
        return True
    if raw == "false":
        return False
    if re.fullmatch(r"\d+", raw):
        return int(raw)
    if re.fullmatch(r"\d+\.\d+", raw):
        return float(raw)
    if raw.startswith("[") and raw.endswith("]"):
        return [
            parse_value(item, resolve_reference)
            for item in split_top_level(raw[1:-1])
        ]
    if raw.startswith("{") and raw.endswith("}"):
        return parse_entries(raw[1:-1], resolve_reference)
    if re.fullmatch(r"[A-Za-z_]\w*(?:\.[A-Za-z_]\w*)*", raw):
        resolved = resolve_reference(raw)
        if resolved is not None:
            return resolved
    evaluated = evaluate_numeric_expression(raw, resolve_reference)
    if evaluated is not None:
        return evaluated
    return raw


def evaluate_numeric_expression(expression: str, resolve_reference):
    try:
        syntax = ast.parse(expression, mode="eval").body
    except SyntaxError:
        return None

    def evaluate(node):
        if isinstance(node, ast.Constant) and type(node.value) in (int, float):
            return node.value
        if isinstance(node, ast.Name):
            value = resolve_reference(node.id)
            if isinstance(value, (int, float)) and not isinstance(value, bool):
                return value
            raise ValueError("Not a numeric name")
        if isinstance(node, ast.BinOp) and type(node.op) in NUMERIC_OPERATORS:
            return NUMERIC_OPERATORS[type(node.op)](
                evaluate(node.left), evaluate(node.right)
            )
        if isinstance(node, ast.UnaryOp) and isinstance(node.op, (ast.UAdd, ast.USub)):
            value = evaluate(node.operand)
            return value if isinstance(node.op, ast.UAdd) else -value
        if (
            isinstance(node, ast.Call)
            and isinstance(node.func, ast.Name)
            and node.func.id == "floor"
            and len(node.args) == 1
            and not node.keywords
        ):
            return math.floor(evaluate(node.args[0]))
        raise ValueError("Unsupported numeric expression")

    try:
        value = evaluate(syntax)
    except (ArithmeticError, ValueError):
        return None
    return value if math.isfinite(value) else None


def parse_entries(body: str, resolve_reference) -> dict:
    body = re.sub(r"^\s*///.*$", "", body, flags=re.MULTILINE)
    entries = {}
    for item in split_top_level(body):
        match = re.match(r"([A-Za-z_]\w*)\s*:\s*(.*)", item, re.DOTALL)
        if match:
            entries[match.group(1)] = parse_value(match.group(2), resolve_reference)
    return entries


def create_reference_resolver(source: str, documented_references: dict[str, dict]):
    assignments = {}
    for match in re.finditer(r"\b([A-Za-z_]\w*)\s*=\s*\{", source):
        opening_brace = source.index("{", match.start())
        assignments[match.group(1)] = extract_braced_block(source, opening_brace)
    constants = {
        match.group(1): match.group(2).strip()
        for match in re.finditer(
            r"\bvar\s+([A-Za-z_]\w*)\s*=\s*([^;\r\n]+);", source
        )
    }
    cache = {}
    constant_cache = {}

    def resolve(reference: str):
        if reference in constants:
            if reference not in constant_cache:
                constant_cache[reference] = parse_value(
                    constants[reference], resolve
                )
            return constant_cache[reference]
        parts = reference.split(".")
        root = parts[0]
        if root not in assignments:
            return None
        if root not in cache:
            cache[root] = parse_entries(assignments[root], resolve)
        value = cache[root]
        for part in parts[1:]:
            if not isinstance(value, dict) or part not in value:
                return None
            value = value[part]
        node = documented_references.get(reference)
        if node and isinstance(value, dict):
            return DocumentedReference(value, node)
        return value

    return resolve


def parse_struct_data(body: str, resolve_reference) -> dict:
    return parse_entries(body, resolve_reference)


def validate_node(node: dict, data: dict) -> None:
    for stat in STAT_KEYS.intersection(data):
        value = data[stat]
        maximum = STAT_MAXIMUMS[stat]
        if (
            isinstance(value, bool)
            or not isinstance(value, (int, float))
            or not math.isfinite(value)
            or not 0 <= value <= maximum
        ):
            raise ValueError(
                f"{node['title']} {stat} must be a number between 0 and {maximum}"
            )


def document_link(node: dict, target: dict) -> str:
    current = Path(node["relative_file"]).parent
    target_path = Path(target["relative_file"])
    relative = posixpath.relpath(target_path.as_posix(), current.as_posix())
    return f"[{target['title']}]({relative})"


def write_page(node: dict, data: dict, image_paths: dict[str, str]) -> None:
    page_path = GENERATED_DIR / node["relative_file"]
    page_path.parent.mkdir(parents=True, exist_ok=True)
    lines = [f"# {node['title']}", ""]
    for key, value in data.items():
        lines.extend(
            render_field(key, value, level=2, page_node=node, image_paths=image_paths)
        )
    lines.append("")
    page_path.write_text("\n".join(lines), encoding="utf-8")


def render_field(
    key: str, value, level: int, page_node: dict, image_paths: dict[str, str]
) -> list[str]:
    heading = "#" * level
    lines = [f"{heading} {titleize(key)}", ""]
    if key in IMAGE_FIELDS and value in image_paths:
        current = Path("kindlebane-documentation") / Path(page_node["relative_file"]).parent
        relative = posixpath.relpath(image_paths[value], current.as_posix())
        lines += [f"![{titleize(key)}]({relative})", ""]
    elif isinstance(value, DocumentedReference):
        lines += [document_link(page_node, value.node), ""]
    elif isinstance(value, dict):
        for child_key, child_value in value.items():
            lines += render_field(
                child_key, child_value, level + 1, page_node, image_paths
            )
    elif isinstance(value, list):
        for item in value:
            if isinstance(item, DocumentedReference):
                lines += [f"- {document_link(page_node, item.node)}"]
            elif isinstance(item, dict):
                item_title = item.get("name", item.get("id", "Item"))
                lines += [f"{'#' * (level + 1)} {item_title}", ""]
                for child_key, child_value in item.items():
                    if child_key != "name":
                        lines += render_field(
                            child_key, child_value, level + 2, page_node, image_paths
                        )
            else:
                lines += [f"- {format_value(item)}"]
        lines.append("")
    elif isinstance(value, str) and len(value) > 100:
        lines += [value, ""]
    else:
        lines += [format_value(value), ""]
    return lines


def collect_image_assets(value) -> set[str]:
    assets = set()
    if isinstance(value, dict):
        for key, child in value.items():
            if (
                key in IMAGE_FIELDS
                and isinstance(child, str)
                and re.fullmatch(r"spr_[A-Za-z0-9_]+", child)
            ):
                assets.add(child)
            else:
                assets.update(collect_image_assets(child))
    elif isinstance(value, list):
        for child in value:
            assets.update(collect_image_assets(child))
    return assets


def copy_documented_images(asset_names: set[str]) -> dict[str, str]:
    DOC_GAME_SPRITES_DIR.mkdir(parents=True, exist_ok=True)
    image_paths = {}
    for asset_name in sorted(asset_names):
        source_images = sorted((GAME_SPRITES_DIR / asset_name).glob("*.png"))
        if not source_images:
            raise FileNotFoundError(f"No exported PNG found for sprite {asset_name}")
        target = DOC_GAME_SPRITES_DIR / f"{asset_name}.png"
        shutil.copyfile(source_images[0], target)
        image_paths[asset_name] = f"assets/game-sprites/{target.name}"
    return image_paths


def format_value(value) -> str:
    if isinstance(value, bool):
        return "Yes" if value else "No"
    if isinstance(value, (dict, list)):
        return "Structured data"
    return str(value)


def write_index(nodes: list[dict]) -> None:
    sections = [node for node in reversed(nodes) if node["is_section"]]
    pages = [node for node in reversed(nodes) if not node["is_section"]]
    by_parent = {}
    for node in pages:
        by_parent.setdefault(node["parent"], []).append(node)

    def render_pages(parent: str, depth: int = 0) -> list[str]:
        lines = []
        for node in by_parent.get(parent, []):
            indent = "  " * depth
            lines.append(
                f"{indent}- [{node['title']}]"
                f"(kindlebane-documentation/{node['relative_file']})"
            )
            lines.extend(render_pages(node["id"], depth + 1))
        return lines

    page = """# Kindlebane Documentation

This is the internal reference for Kindlebane's characters, abilities, stories,
stats, and other game information.

## Documentation

"""
    sections_text = []
    for section in sections:
        sections_text.append(f"### {section['title']}")
        sections_text.append("")
        sections_text.extend(
            render_pages(section["id"]) or ["- No pages are available yet."]
        )
        sections_text.append("")
    page += "\n".join(sections_text) or "- No documentation is available yet."
    (DOCS_DIR / "index.md").write_text(page.rstrip() + "\n", encoding="utf-8")


def main() -> None:
    source = SOURCE_FILE.read_text(encoding="utf-8")
    nodes = declaration_nodes(source)
    documented_references = {
        ".".join((*node["path"][:-1], node["name"])): node
        for node in nodes
        if not node["is_section"]
    }
    resolve_reference = create_reference_resolver(source, documented_references)
    ids = {node["id"] for node in nodes}
    documented_data = {}
    image_assets = set()
    for node in nodes:
        if node["parent"] and node["parent"] not in ids:
            raise ValueError(
                f"{node['title']} references missing parent {node['parent']}"
            )
        data = parse_struct_data(node["body"], resolve_reference)
        validate_node(node, data)
        documented_data[node["id"]] = data
        image_assets.update(collect_image_assets(data))
    image_paths = copy_documented_images(image_assets)
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    for generated_page in GENERATED_DIR.rglob("*.md"):
        generated_page.unlink()
    legacy_pages_dir = DOCS_DIR / "pages"
    if legacy_pages_dir.exists():
        for generated_page in legacy_pages_dir.rglob("*.md"):
            generated_page.unlink()
    legacy_pages_dir = DOCS_DIR / "characters"
    if legacy_pages_dir.exists():
        for generated_page in legacy_pages_dir.rglob("*.md"):
            generated_page.unlink()
    for node in nodes:
        if node["is_section"]:
            continue
        write_page(node, documented_data[node["id"]], image_paths)
    write_index(nodes)


if __name__ == "__main__":
    main()
