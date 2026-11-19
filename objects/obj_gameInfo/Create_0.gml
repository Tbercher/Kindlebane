kindling = 60;

// General Game Information
dynamicUISprites = {
    winner: spr_placeholderWinner,
    loser: spr_placeholderLoser
};

abilitySprites = {
    nonSpecific: spr_placeholderAbility,
    apprenticeSlash: spr_placeholderAbilitySpecific,
    flurry: spr_placeholderAbilitySpecific,
    cleave: spr_placeholderAbilitySpecific,
    stab: spr_placeholderAbilitySpecific,
    recklessStrike: spr_placeholderAbilitySpecific,
    woodsmanDropkick: spr_placeholderAbilitySpecific,
    charge: spr_placeholderAbilitySpecific,
    counter: spr_placeholderAbilitySpecific,
    taunt: spr_placeholderAbilitySpecific,
    battleCry: spr_placeholderAbilitySpecific,
    magicBolt: spr_placeholderAbilitySpecific,
    fireBall: spr_placeholderAbilitySpecific,
    lightningBolt: spr_placeholderAbilitySpecific,
    spellCharge: spr_placeholderAbilitySpecific,
    quake: spr_placeholderAbilitySpecific,
    punch: spr_placeholderAbilitySpecific,
    heal: spr_placeholderAbilitySpecific,
    curse: spr_placeholderAbilitySpecific,
    enhance: spr_placeholderAbilitySpecific,
    vigorate: spr_placeholderAbilitySpecific
};

// Attack values for abilities with spray so that spray value can be calculated arithmetically
var _cleaveAttack = 150;
var _chargeAttack = 100;
var _quakeAttack = 150;
var _quakeMagicAttack = 150;

/// @doc-abilities
abilities = {
    /// @doc-abilities-ability Slash
    apprenticeSlash: {
        name: "Slash",
        description: "A basic physical attack with a sword.",
        cost: 0,
        attack: 50,
        magicAttack: 0,
        spray: 0,
        sprite: abilitySprites.apprenticeSlash
    },
    /// @doc-abilities-ability Flurry
    flurry: {
        name: "Flurry",
        description: "Makes consecutive attacks against a single enemy that deal large physical damage.",
        cost: 0,
        attack: 100,
        magicAttack: 0,
        spray: 0,
        sprite: abilitySprites.flurry
    },
    /// @doc-abilities-ability Cleave
    cleave: {
        name: "Cleave",
        description: "Attacks a single enemy and hits adjacent enemies for 75% damage.",
        cost: 0,
        attack: _cleaveAttack,
        magicAttack: 0,
        spray: floor(_cleaveAttack * 0.75),
        sprite: abilitySprites.cleave
    },
    /// @doc-abilities-ability Stab
    stab: {
        name: "Stab",
        description: "Attacks one enemy for physical damage and causes Bleed.",
        cost: 0,
        attack: 50,
        magicAttack: 0,
        spray: 0,
        sprite: abilitySprites.stab,
        lingeringEffectDamage: 20,
        effectType: "bleed"
    },
    /// @doc-abilities-ability Reckless Strike
    recklessStrike: {
        name: "Reckless Strike",
        description: "Deals massive physical damage to a single enemy while lowering its defences for 1 turn.",
        cost: 50,
        isUltimate: true,
        attack: 300,
        magicAttack: 0,
        spray: 0,
        sprite: abilitySprites.recklessStrike,
        lowersDefense: true
    },
    /// @doc-abilities-ability Dropkick
    woodsmanDropkick: {
        name: "Dropkick",
        description: "A basic physical attack with a shield.",
        cost: 0,
        attack: 50,
        magicAttack: 0,
        spray: 0,
        sprite: abilitySprites.woodsmanDropkick
    },
    /// @doc-abilities-ability Charge
    charge: {
        name: "Charge",
        description: "Charges a single enemy, hits adjacent enemies for 50% damage, and stuns the main target.",
        cost: 0,
        attack: _chargeAttack,
        magicAttack: 0,
        spray: _chargeAttack * 0.5,
        sprite: abilitySprites.charge,
        stuns: true
    },
    /// @doc-abilities-ability Counter
    counter: {
        name: "Counter",
        description: "Readies a defensive stance for 1 turn and deals increased physical damage next turn based on attacks received.",
        cost: 0,
        attack: 0,
        magicAttack: 0,
        spray: 0,
        sprite: abilitySprites.counter,
        isCounter: true
    },
    /// @doc-abilities-ability Taunt
    taunt: {
        name: "Taunt",
        description: "Taunts a single enemy and reduces all damage taken for 2 turns.",
        cost: 0,
        attack: 0,
        magicAttack: 0,
        spray: 0,
        sprite: abilitySprites.taunt,
        taunts: true
    },
    /// @doc-abilities-ability Battle Cry
    battleCry: {
        name: "Battle Cry",
        description: "Taunts all enemies while reducing enemy damage.",
        cost: 50,
        isUltimate: true,
        attack: 0,
        magicAttack: 0,
        spray: 0,
        sprite: abilitySprites.battleCry,
        tauntsAll: true
    },
    /// @doc-abilities-ability Magic Bolt
    magicBolt: {
        name: "Magic Bolt",
        description: "A basic magic attack with a grimoire.",
        cost: 0,
        attack: 0,
        magicAttack: 50,
        spray: 0,
        sprite: abilitySprites.magicBolt
    },
    /// @doc-abilities-ability Fire Ball
    fireBall: {
        name: "Fire Ball",
        description: "Shoots a fireball at a single enemy for magic damage and causes Burn.",
        cost: 0,
        attack: 0,
        magicAttack: 100,
        spray: 0,
        sprite: abilitySprites.fireBall,
        lingeringEffectDamage: 30,
        effectType: "burn"
    },
    /// @doc-abilities-ability Lightning Bolt
    lightningBolt: {
        name: "Lightning Bolt",
        description: "Fires a lightning bolt at a single enemy that deals massive magic damage.",
        cost: 0,
        attack: 0,
        magicAttack: 150,
        spray: 0,
        sprite: abilitySprites.lightningBolt
    },
    /// @doc-abilities-ability Spell Charge
    spellCharge: {
        name: "Charge",
        description: "Prepares a spell and increases its damage.",
        cost: 0,
        attack: 0,
        magicAttack: 0,
        spray: 0,
        sprite: abilitySprites.spellCharge,
        spellCharge: true
    },
    /// @doc-abilities-ability Quake
    quake: {
        name: "Quake",
        description: "Splits the ground beneath enemies, dealing area-of-effect magic damage and stunning them.",
        cost: 50,
        isUltimate: true,
        attack: 0,
        spray: floor(_quakeAttack * 0.75),
        magicAttack: _quakeMagicAttack,
        sprite: abilitySprites.quake,
        stuns: true
    },
    /// @doc-abilities-ability Punch
    punch: {
        name: "Punch",
        description: "A basic physical attack.",
        cost: 0,
        attack: 50,
        magicAttack: 0,
        spray: 0,
        sprite: abilitySprites.punch
    },
    /// @doc-abilities-ability Heal
    heal: {
        name: "Heal",
        description: "Heals a single ally.",
        cost: 0,
        attack: 0,
        magicAttack: 100,
        spray: 0,
        healAmount: 150,
        isHeal: true,
        sprite: abilitySprites.heal
    },
    /// @doc-abilities-ability Curse
    curse: {
        name: "Curse",
        description: "Silences a single target and reduces its defences for 1 turn.",
        cost: 0,
        attack: 0,
        magicAttack: 100,
        spray: 0,
        isCurse: true,
        sprite: abilitySprites.curse
    },
    /// @doc-abilities-ability Enhance
    enhance: {
        name: "Enhance",
        description: "Buffs a single ally's damage for 2 turns.",
        cost: 0,
        attack: 0,
        magicAttack: 100,
        spray: 0,
        isEnhance: true,
        sprite: abilitySprites.enhance
    },
    /// @doc-abilities-ability Vigorate
    vigorate: {
        name: "Vigorate",
        description: "Heals all allies while the Cleric loses 70% of its health.",
        cost: 50,
        isUltimate: true,
        attack: 0,
        magicAttack: 150,
        spray: 0,
        isVigorate: true,
        healAmount: 100,
        sprite: abilitySprites.vigorate
    },
}

characterSprites = {
    woodsman: spr_woodsmanIdle,
    mage: spr_placeholderCharacter,
    cleric: spr_placeholderCharacter,
    apprentice: spr_apprenticeIdle,
    condemned: spr_condemnedIdle,
    lamplighter: spr_lamplighterIdle
};

headshotSprites = {
    nonSpecific: spr_placeholderHeadshot,
    woodsman: spr_woodsmanPortrait,
    mage: spr_placeholderSpecificHeadshot,
    cleric: spr_placeholderSpecificHeadshot,
    apprentice: spr_apprenticePortrait,
    condemned: spr_condemnedPortrait,
    lamplighter: spr_lamplighterPortrait
};

// PLEASE NOTE THAT ATTACK VALUES ARE MULTIPLIERS, NOT FLAT DAMAGE VALUES
/// @doc-characters
characters = {
    /// @doc-characters-character Apprentice
    apprentice: {
        name: "Apprentice",
        className: "Apprentice",
        description: "A sword-wielding apprentice.",
        attack: 1,
        defense: 50,
        magicAttack: 1, // Testing magic attack
        // magicAttack: 0, // Actual magic attack
        magicDefense: 50,
        myHealth: 500,
        isPlaceholder: true,
        weapon: "Sword",
        basicAttack: abilities.apprenticeSlash,
        //abilities: [abilities.enhance, abilities.vigorate, abilities.cleave, abilities.cleave], // test abilities
        abilities: [abilities.flurry, abilities.cleave, abilities.stab, abilities.fireBall], // Original abilities
        ultimate: abilities.recklessStrike,
		sprite: characterSprites.apprentice,
        headshot: headshotSprites.apprentice
    },
    /// @doc-characters-character Woodsman
    woodsman: {
        name: "The Woodsman",
        className: "Woodsman",
        description: "A shield-bearing woodsman.",
        attack: 1,
        defense: 50,
        magicAttack: 0,
        magicDefense: 25,
        myHealth: 500,
        isPlaceholder: true,
        weapon: "Big Ass Shield",
        basicAttack: abilities.woodsmanDropkick,
        //abilities: [abilities.cleave], //fake abilities for testing
        abilities: [abilities.charge, abilities.counter, abilities.taunt], // Original abilities
        ultimate: abilities.battleCry,
		sprite: characterSprites.woodsman,
        headshot: headshotSprites.woodsman
    },
    /// @doc-characters-character Mage
    mage: {
        name: "Mage",
        className: "Mage",
        description: "A spellcaster wielding a grimoire.",
        attack: 1,
        defense: 50,
        magicAttack: 1,
        magicDefense: 25,
        myHealth: 500,
        isPlaceholder: true,
        weapon: "Grimoire",
        basicAttack: abilities.magicBolt,
        abilities: [abilities.fireBall, abilities.lightningBolt, abilities.spellCharge],
        ultimate: abilities.quake,
        sprite: characterSprites.mage,
        headshot: headshotSprites.mage
    },
    /// @doc-characters-character Cleric
    cleric: {
        name: "Cleric",
        className: "Cleric",
        description: "A support character who empowers and heals allies.",
        attack: 1,
        defense: 50,
        magicAttack: 0.5,
        magicDefense: 25,
        myHealth: 500,
        isPlaceholder: true,
        weapon: "Book",
        basicAttack: abilities.punch,
        abilities: [abilities.heal, abilities.curse, abilities.enhance],
        ultimate: abilities.vigorate,
        sprite: characterSprites.cleric,
        headshot: headshotSprites.cleric
    },
    /// @doc-characters-character Condemned
    condemned: {
        name: "Condemned",
        village: "Lawhold",
        className: "Condemned",
        description: "A Condemned survivor from Lawhold.",
        attack: 1,
        defense: 50,
        magicAttack: 0,
        magicDefense: 25,
        myHealth: 500,
        isPlaceholder: true,
        abilities: [abilities.magicBolt],
        sprite: characterSprites.condemned,
        headshot: headshotSprites.condemned
    },
    /// @doc-characters-character Lamplighter
    lamplighter: {
        name: "Lamplighter",
        village: "Lumenhall",
        className: "Lamplighter",
        description: "A Lamplighter from Lumenhall.",
        attack: 1,
        defense: 50,
        magicAttack: 0,
        magicDefense: 25,
        myHealth: 500,
        isPlaceholder: true,
        abilities: [abilities.magicBolt],
        sprite: characterSprites.lamplighter,
        headshot: headshotSprites.lamplighter
    }
};



/// @doc-villages
villages = {
    /// @doc-villages-village Loamvale
    loamvale: {
        name: "Loamvale",
        conquered: false,
        team: [
            characters.apprentice,
            characters.apprentice,
            characters.apprentice,
            characters.apprentice
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

// Game Save Info
playerTeam = {
        members: [characters.woodsman, characters.apprentice, characters.condemned, characters.lamplighter]
};

// Should start as undefined and be changed when you select a village in the menu
currentVillage = "loamvale";