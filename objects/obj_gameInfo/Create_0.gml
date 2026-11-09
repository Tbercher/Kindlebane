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
    /// @doc-characters-character Woodsman
    woodsman: {
        name: "Woodsman",
        village: "Loamvale",
        className: "Woodsman",
        description: "A Woodsman from Loamvale.",
        attack: 50,
        defense: 50,
        magicAttack: 0,
        magicDefense: 25,
        myHealth: 100,
        isPlaceholder: true,
        abilities: [abilities.kindleshooter],
		sprite: spr_placeholderCharacter
    },
    /// @doc-characters-character Apprentice
    apprentice: {
        name: "Apprentice",
        village: "Stonehearth",
        className: "Apprentice",
        description: "An Apprentice from Stonehearth.",
        attack: 50,
        defense: 50,
        magicAttack: 0,
        magicDefense: 25,
        myHealth: 100,
        isPlaceholder: true,
        abilities: [abilities.kindleshooter],
		sprite: spr_placeholderCharacter
    },
    /// @doc-characters-character Condemned
    condemned: {
        name: "Condemned",
        village: "Lawhold",
        className: "Condemned",
        description: "A Condemned survivor from Lawhold.",
        attack: 50,
        defense: 50,
        magicAttack: 0,
        magicDefense: 25,
        myHealth: 100,
        isPlaceholder: true,
        abilities: [abilities.kindleshooter],
    },
    /// @doc-characters-character Lamplighter
    lamplighter: {
        name: "Lamplighter",
        village: "Lumenhall",
        className: "Lamplighter",
        description: "A Lamplighter from Lumenhall.",
        attack: 50,
        defense: 50,
        magicAttack: 0,
        magicDefense: 25,
        myHealth: 100,
        isPlaceholder: true,
        abilities: [abilities.kindleshooter],
    },
};



/// @doc-villages
villages = {
    /// @doc-villages-village Loamvale
    loamvale: {
        name: "Loamvale",
        conquered: false,
        team: [
            characters.woodsman,
            characters.woodsman,
            characters.woodsman,
            characters.woodsman,
        ],
    },
    /// @doc-villages-village Stonehearth
    stonehearth: {
        name: "Stonehearth",
        conquered: false,
        team: [
            characters.apprentice,
            characters.apprentice,
            characters.apprentice,
            characters.apprentice,
        ],
    },
    /// @doc-villages-village Lawhold
    lawhold: {
        name: "Lawhold",
        conquered: false,
        team: [
            characters.condemned,
            characters.condemned,
            characters.condemned,
            characters.condemned,
        ],
    },
    /// @doc-villages-village Lumenhall
    lumenhall: {
        name: "Lumenhall",
        conquered: false,
        team: [
            characters.lamplighter,
            characters.lamplighter,
            characters.lamplighter,
            characters.lamplighter,
        ],
    },
};

// Current Game Info

//Should start as undefined and be changed when you select a village in the menu
currentVillage = "loamvale";