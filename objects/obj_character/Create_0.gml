event_inherited()
isEnemy = false;
/* Adding this to get the compiler to shut up about an unrecognized character variable */
if (!variable_instance_exists(id, "character")) {
    character = undefined;
    slot = undefined;
}
newHealth = character.myHealth;
sprite_index = character.sprite;
selected = false;
renderedAbilities = false;
info = character.description
stats =
    "Name: " + character.name
    + "\nHealth: " + string(character.myHealth)
    + "\nAttack Multiplier: " + string(character.attack)
    + "\nDefense: " + string(character.defense)
    + "\nMagic Attack Multiplier: " + string(character.magicAttack)
    + "\nMagic Defense: " + string(character.magicDefense);
hasNeighborSelected = false;
remainingLingeringEffectTurns = 0;
lingeringEffectDamage = 0;
loweredDefenseTurns = 0;
isBleeding = false; 
isBurning = false;
attackBuff = 1; // One is no buff because it is multiplied with the base attack value
attackBuffRounds = 0;
increasedDefenseRounds = 0;
historicalDefense = character.defense;
historicalMagicDefense = character.magicDefense;
increasedDefenseRatio = 2
stunnedRounds = 0;
delayedEffectTurns = 0;
isTaunted = false;
tauntedRounds = 0;
tauntor = undefined;
isTaunting = false;
tauntingRounds = 0;
cursedRounds = 0;