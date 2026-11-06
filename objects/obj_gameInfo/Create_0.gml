// General Game Information
/// @doc-abilities
abilities = {
    /// @doc-abilities-ability Kindleshooter
    kindleshooter: {
        name: "Kindleshooter Fire Flame",
        description: "Shoots a flame that ignites enemies.",
        damage: 30,
    },
}

/// @doc-characters
characters = {
    ///@ doc-characters-character Apprentice
    apprentice: {
        name: "Apprentice",
        description: "A young mage in training.",
        attack: 50,
        defense: 50,
        magicAttack: 0,
        magicDefense: 25,
        abilities: [
            abilities.kindleshooter
        ],
    },
};