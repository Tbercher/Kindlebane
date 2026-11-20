import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

from tools import generate_docs


class GenerateDocsTests(unittest.TestCase):
    def test_builds_available_data_without_gameplay_validation(self):
        source = '''
/// @doc-abilities-ability Reckless Strike
recklessStrike: {
    attack: 300,
    defense: -10,
    magicAttack: unknown_formula(),
    sprite: spr_missing
}
/// @doc-team Initial Player Team
playerTeam = {
    members: []
};
'''
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source_file = root / "source.gml"
            source_file.write_text(source, encoding="utf-8")
            docs = root / "docs"
            with patch.multiple(
                generate_docs,
                SOURCE_FILE=source_file,
                DOCS_DIR=docs,
                ASSETS_DIR=docs / "assets",
                GENERATED_DIR=docs / "kindlebane-documentation",
                GAME_SPRITES_DIR=root / "sprites",
                DOC_GAME_SPRITES_DIR=docs / "assets" / "game-sprites",
            ):
                with self.assertLogs(level="WARNING") as warnings:
                    generate_docs.main()

            page = (docs / "kindlebane-documentation" / "abilities" / "recklessstrike.md").read_text(
                encoding="utf-8"
            )
            index = (docs / "index.md").read_text(encoding="utf-8")
            self.assertIn("## Attack\n\n300", page)
            self.assertIn("## Defense\n\n-10", page)
            self.assertIn("unknown_formula()", page)
            self.assertIn("spr_missing", page)
            self.assertIn("abilities/recklessstrike.md", index)
            self.assertIn("kindlebane-documentation/playerteam.md", index)
            self.assertTrue((docs / "kindlebane-documentation" / "playerteam.md").exists())
            self.assertTrue(any("missing parent" in item for item in warnings.output))
            self.assertTrue(any("spr_missing" in item for item in warnings.output))

    def test_circular_references_remain_as_source_text(self):
        resolver = generate_docs.create_reference_resolver(
            "var first = second;\nvar second = first;", {}
        )
        with self.assertLogs(level="WARNING"):
            result = generate_docs.parse_value("first", resolver)
        self.assertIn(result, {"first", "second"})

    def test_comments_do_not_hide_fields_or_remove_text_in_strings(self):
        body = '''
            magicAttack: 1, // testing
            // magicAttack: 0,
            magicDefense: 50,
            description: "See https://example.com",
            /* temporarily disabled: ability: false, */
            abilities: [first, second], // active abilities
            ultimate: last
        '''
        data = generate_docs.parse_entries(body, lambda reference: None)
        self.assertEqual(data["magicDefense"], 50)
        self.assertEqual(data["description"], "See https://example.com")
        self.assertEqual(data["abilities"], ["first", "second"])
        self.assertEqual(data["ultimate"], "last")


if __name__ == "__main__":
    unittest.main()
