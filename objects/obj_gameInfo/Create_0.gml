// General Game Information
/// @doc-abilities
abilities = {
    /// @doc-abilities-ability Slash
    seekerSlash: {
        name: "Slash",
        description: "A basic physical attack with a sword.",
        cost: 0,
        strength: 1,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Flurry
    flurry: {
        name: "Flurry",
        description: "Makes consecutive attacks against a single enemy that deal large physical damage.",
        cost: 2,
        strength: 2,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Cleave
    cleave: {
        name: "Cleave",
        description: "Attacks a single enemy and hits adjacent enemies for 75% damage.",
        cost: 3,
        strength: 3,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Stab
    stab: {
        name: "Stab",
        description: "Attacks one enemy for physical damage and causes Bleed.",
        cost: 2,
        strength: 1,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Reckless Strike
    recklessStrike: {
        name: "Reckless Strike",
        description: "Deals massive physical damage to a single enemy while lowering its defences for 1 turn.",
        cost: 0,
        strength: 3,
        isUltimate: true,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Dropkick
    woodsmanDropkick: {
        name: "Dropkick",
        description: "A basic physical attack with a shield.",
        cost: 0,
        strength: 1,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Charge
    charge: {
        name: "Charge",
        description: "Charges a single enemy, hits adjacent enemies for 50% damage, and stuns the main target.",
        cost: 2,
        strength: 2,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Counter
    counter: {
        name: "Counter",
        description: "Readies a defensive stance for 1 turn and deals increased physical damage next turn based on attacks received.",
        cost: 2,
        strength: 3,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Taunt
    taunt: {
        name: "Taunt",
        description: "Taunts a single enemy and reduces all damage taken for 2 turns.",
        cost: 1,
        strength: 1,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Battle Cry
    battleCry: {
        name: "Battle Cry",
        description: "Taunts all enemies while reducing enemy damage.",
        cost: 0,
        strength: 3,
        isUltimate: true,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Magic Bolt
    magicBolt: {
        name: "Magic Bolt",
        description: "A basic magic attack with a grimoire.",
        cost: 0,
        strength: 1,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Fire Ball
    fireBall: {
        name: "Fire Ball",
        description: "Shoots a fireball at a single enemy for magic damage and causes Burn.",
        cost: 2,
        strength: 2,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Lightning Bolt
    lightningBolt: {
        name: "Lightning Bolt",
        description: "Fires a lightning bolt at a single enemy that deals massive magic damage.",
        cost: 3,
        strength: 3,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Spell Charge
    spellCharge: {
        name: "Charge",
        description: "Prepares a spell and increases its damage.",
        cost: 1,
        strength: 1,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Quake
    quake: {
        name: "Quake",
        description: "Splits the ground beneath enemies, dealing area-of-effect magic damage and stunning them.",
        cost: 0,
        strength: 3,
        isUltimate: true,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Punch
    punch: {
        name: "Punch",
        description: "A basic physical attack.",
        cost: 0,
        strength: 1,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Heal
    heal: {
        name: "Heal",
        description: "Heals a single ally.",
        cost: 2,
        strength: 2,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Curse
    curse: {
        name: "Curse",
        description: "Silences a single target and reduces its defences for 1 turn.",
        cost: 2,
        strength: 2,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Enhance
    enhance: {
        name: "Enhance",
        description: "Buffs a single ally's damage for 2 turns.",
        cost: 2,
        strength: 2,
        sprite: spr_placeholderAbilitySpecific
    },
    /// @doc-abilities-ability Vigorate
    vigorate: {
        name: "Vigorate",
        description: "Heals all allies while the Cleric loses 70% of its health.",
        cost: 0,
        strength: 3,
        isUltimate: true,
        sprite: spr_placeholderAbilitySpecific
    },
}

/// @doc-characters
characters = {
    /// @doc-characters-character Apprentice
    seeker: {
        name: "Apprentice",
        className: "Apprentice",
        description: "A sword-wielding apprentice.",
        attack: 50,
        defense: 50,
        magicAttack: 0,
        magicDefense: 25,
        myHealth: 100,
        isPlaceholder: true,
        weapon: "Sword",
        basicAttack: abilities.seekerSlash,
        abilities: [abilities.flurry, abilities.cleave, abilities.stab],
        ultimate: abilities.recklessStrike,
		sprite: spr_placeholderCharacter,
        headshot: spr_placeholderSpecificHeadshot
    },
    /// @doc-characters-character Woodsman
    woodsman: {
        name: "The Woodsman",
        className: "Woodsman",
        description: "A shield-bearing woodsman.",
        attack: 50,
        defense: 50,
        magicAttack: 0,
        magicDefense: 25,
        myHealth: 100,
        isPlaceholder: true,
        weapon: "Big Ass Shield",
        basicAttack: abilities.woodsmanDropkick,
        abilities: [abilities.charge, abilities.counter, abilities.taunt],
        ultimate: abilities.battleCry,
		sprite: spr_placeholderCharacter,
        headshot: spr_placeholderSpecificHeadshot
    },
    /// @doc-characters-character Mage
    mage: {
        name: "Mage",
        className: "Mage",
        description: "A spellcaster wielding a grimoire.",
        attack: 50,
        defense: 50,
        magicAttack: 50,
        magicDefense: 25,
        myHealth: 100,
        isPlaceholder: true,
        weapon: "Grimoire",
        basicAttack: abilities.magicBolt,
        abilities: [abilities.fireBall, abilities.lightningBolt, abilities.spellCharge],
        ultimate: abilities.quake,
        sprite: spr_placeholderCharacter,
        headshot: spr_placeholderSpecificHeadshot
    },
    /// @doc-characters-character Cleric
    cleric: {
        name: "Cleric",
        className: "Cleric",
        description: "A support character who empowers and heals allies.",
        attack: 50,
        defense: 50,
        magicAttack: 25,
        magicDefense: 25,
        myHealth: 100,
        isPlaceholder: true,
        weapon: "Book",
        basicAttack: abilities.punch,
        abilities: [abilities.heal, abilities.curse, abilities.enhance],
        ultimate: abilities.vigorate,
        sprite: spr_placeholderCharacter,
        headshot: spr_placeholderSpecificHeadshot
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
        abilities: [abilities.magicBolt],
        sprite: spr_placeholderCharacter,
        headshot: spr_placeholderSpecificHeadshot
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
        abilities: [abilities.magicBolt],
        sprite: spr_placeholderCharacter,
        headshot: spr_placeholderSpecificHeadshot
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
        abilities: [abilities.magicBolt],
        sprite: spr_placeholderCharacter,
        headshot: spr_placeholderSpecificHeadshot
    }
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