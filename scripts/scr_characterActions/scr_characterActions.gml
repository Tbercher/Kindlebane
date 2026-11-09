function spawnCharacters(){
    if (!instance_exists(obj_slotNumber)){
		return; 
	}
    var count = instance_number(obj_slotNumber);
    for (var i = 0; i < count; i++){
        var slot = instance_find(obj_slotNumber, i);
        var slotNumber = slot.number
        var isEnemy = slot.isEnemy;

        // Find the character corresponding to the slot number
        if (!isEnemy){
            if (slotNumber > array_length(obj_battleController.playerTeam.members)) {
                continue; // Skip if the slot number exceeds the number of player team members
            }
            var character = obj_battleController.playerTeam.members[slotNumber - 1];
        } else {
            //continue; //TEMPORARY: Disable enemy spawning for now
            if (slotNumber > array_length(obj_battleController.village.team)) {
                continue; // Skip if the slot number exceeds the number of enemies in the current village
            }
            var character = obj_battleController.village.team[slotNumber - 1];
        }
        var targetHeight = 160;
        var scale = targetHeight / sprite_get_height(character.sprite);
        // Spawn a character at the slot's position
        var characterInstance = instance_create_layer(slot.x, slot.y - ((sprite_get_height(character.sprite) * scale) / 2), "Instances", obj_character, {
            character: character,
        });
        characterInstance.image_xscale = scale;
        characterInstance.image_yscale = scale;
        character.instance = characterInstance;
    }
}