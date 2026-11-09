event_inherited()
/* Adding this to get the compiler to shut up about an unrecognized character variable */
if (!variable_instance_exists(id, "character")) {
    character = undefined;
}
newHealth = 1000;
sprite_index = character.sprite;
selected = false;
renderedAbilities = false;
info = character.description