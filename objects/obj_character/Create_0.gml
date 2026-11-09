event_inherited()
/* Adding this to get the compiler to shut up about an unrecognized character variable */
if (!variable_instance_exists(id, "character")) {
    character = undefined;
}
newHealth = character.myHealth;
sprite_index = character.sprite;
selected = false;
renderedAbilities = false;
info = character.description
stats =
    "Name: " + character.name
    + "\nHealth: " + string(character.myHealth)
    + "\nAttack: " + string(character.attack)
    + "\nDefense: " + string(character.defense)
    + "\nMagic Attack: " + string(character.magicAttack)
    + "\nMagic Defense: " + string(character.magicDefense);