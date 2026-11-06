"""Generate the curated Kindlebane documentation pages from GameMaker data."""

from pathlib import Path
import re


ROOT = Path(__file__).resolve().parents[1]
SOURCE_FILE = ROOT / "objects" / "obj_gameInformation" / "Create_0.gml"
DOCS_DIR = ROOT / "docs"
CHARACTERS_DIR = DOCS_DIR / "characters"
ASSETS_DIR = DOCS_DIR / "assets"

LOREM = (
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
    "Integer vitae sem sed arcu consequat dignissim."
)


def slugify(value: str) -> str:
    return re.sub(r"-+", "-", re.sub(r"[^a-z0-9]+", "-", value.lower())).strip("-")


def extract_braced_block(source: str, opening_brace: int) -> str:
    return source[opening_brace + 1:find_braced_end(source, opening_brace)]


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


def parse_marked_declarations(source: str) -> list[dict]:
    marker_pattern = re.compile(
        r"^\s*///\s*@\s*doc-(section|character|parent)\s+(.+?)\s*$"
    )
    declaration_pattern = re.compile(
        r"^\s*(?:([A-Za-z_]\w*)\s*=\s*|([A-Za-z_]\w*)\s*:\s*)\{"
    )
    declarations = []
    pending = {}
    lines = source.splitlines(keepends=True)
    offset = 0
    for line in lines:
        marker = marker_pattern.match(line)
        if marker:
            pending[marker.group(1)] = marker.group(2).strip()
        elif line.strip():
            declaration = declaration_pattern.match(line)
            if declaration:
                if pending:
                    name = declaration.group(1) or declaration.group(2)
                    declarations.append(
                        {
                            "name": name,
                            "metadata": pending,
                            "opening_brace": offset + declaration.end() - 1,
                            "end_brace": find_braced_end(
                                source, offset + declaration.end() - 1
                            ),
                        }
                    )
                pending = {}
            elif not line.lstrip().startswith("//"):
                pending = {}
        offset += len(line)
    return declarations


def discover_character_data(source: str, declarations: list[dict]) -> dict[str, dict]:
    sections = {
        slugify(declaration["metadata"]["section"]): declaration
        for declaration in declarations
        if "section" in declaration["metadata"]
    }
    data = {}
    character_declarations = [
        declaration
        for declaration in declarations
        if "character" in declaration["metadata"]
    ]
    for declaration in character_declarations:
        character_name = declaration["metadata"]["character"]
        character_id = slugify(character_name)
        character_body = extract_braced_block(source, declaration["opening_brace"])
        stats = dict(
            re.findall(
                r"\b(attack|defense|magicAttack|magicDefense)\s*:\s*(\d+)\s*,",
                character_body,
            )
        )
        stats = {
            {
                "attack": "attack",
                "defense": "defense",
                "magicAttack": "magic_attack",
                "magicDefense": "magic_defense",
            }[name]: value
            for name, value in stats.items()
        }
        abilities_match = re.search(r"\babilities\s*:\s*\[", character_body)
        if abilities_match is None:
            raise ValueError(f"{character_id} must define an abilities array")
        abilities_start = character_body.index("[", abilities_match.start())
        abilities_source = character_body[:abilities_start] + "{"
        abilities_source += character_body[abilities_start + 1:]
        abilities_source = abilities_source.replace("]", "}", 1)
        abilities_body = extract_braced_block(abilities_source, abilities_start)
        abilities = re.findall(
            r'\{\s*name\s*:\s*"([^"]+)"\s*,\s*description\s*:\s*"([^"]+)"\s*\}',
            abilities_body,
        )
        expected_stats = {"attack", "defense", "magic_attack", "magic_defense"}
        if set(stats) != expected_stats:
            raise ValueError(f"{character_id} must define all four stats")
        if len(abilities) != 4:
            raise ValueError(f"{character_id} must define exactly four abilities")
        for stat, value in stats.items():
            if not 0 <= int(value) <= 100:
                raise ValueError(f"{character_id} {stat} must be between 0 and 100")
        parent_value = declaration["metadata"].get("parent")
        parent = slugify(parent_value) if parent_value else None
        if parent is None:
            containing_sections = [
                section_id
                for section_id, section in sections.items()
                if section["opening_brace"] < declaration["opening_brace"]
                and section["end_brace"] > declaration["opening_brace"]
            ]
            if len(containing_sections) == 1:
                parent = containing_sections[0]
        if parent and parent not in sections:
            raise ValueError(f"{character_name} references unknown section {parent_value}")
        data[character_id] = {
            "name": character_name,
            "stats": stats,
            "abilities": abilities,
            "parent": parent,
        }
    return sections, data


def write_character_page(character_id: str, character_data: dict) -> None:
    display_name = character_data["name"]
    stats = character_data["stats"]
    stat_rows = "\n".join(
        f"| {stat.replace('_', ' ').title()} | {stats[stat]} |"
        for stat in ("attack", "defense", "magic_attack", "magic_defense")
    )
    abilities = "\n\n".join(
        f"### {name}\n\n{description}"
        for name, description in character_data["abilities"]
    )
    page = f"""# {display_name}

![no image yet](../assets/no-image-yet.svg)

## Overview

{LOREM}

## Stats

| Stat | Value |
| --- | ---: |
{stat_rows}

## Abilities

{abilities}

## Story

{LOREM}
"""
    (CHARACTERS_DIR / f"{character_id}.md").write_text(page, encoding="utf-8")


def write_index(sections: dict[str, dict], character_data: dict[str, dict]) -> None:
    section_blocks = []
    for section_id, section in sections.items():
        title = section["metadata"]["section"]
        links = "\n".join(
            f"- [{data['name']}](characters/{character_id}.md)"
            for character_id, data in character_data.items()
            if data["parent"] == section_id
        )
        section_blocks.append(f"## {title}\n\n{links or '- No pages are available yet.'}")
    ungrouped = [
        character_id
        for character_id, data in character_data.items()
        if data["parent"] is None
    ]
    if ungrouped:
        section_blocks.append(
            "## Characters\n\n"
            + "\n".join(
                f"- [{data['name']}](characters/{character_id}.md)"
                for character_id, data in character_data.items()
                if character_id in ungrouped
            )
        )
    sections_text = "\n\n".join(section_blocks) or "- No documentation is available yet."
    page = f"""# Kindlebane Documentation

This is the internal reference for Kindlebane's characters, abilities, stories,
stats, and other game information.

{sections_text}
"""
    (DOCS_DIR / "index.md").write_text(page, encoding="utf-8")


def main() -> None:
    source = SOURCE_FILE.read_text(encoding="utf-8")
    declarations = parse_marked_declarations(source)
    sections, character_data = discover_character_data(source, declarations)
    CHARACTERS_DIR.mkdir(parents=True, exist_ok=True)
    ASSETS_DIR.mkdir(parents=True, exist_ok=True)
    write_index(sections, character_data)
    for character_id in character_data:
        write_character_page(character_id, character_data[character_id])


if __name__ == "__main__":
    main()
