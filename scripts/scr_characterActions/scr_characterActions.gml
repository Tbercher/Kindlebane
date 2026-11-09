function spawnCharacters(){
    if (!instance_exists(obj_slotNumber)){
		return; 
	}
    var count = instance_number(obj_slotNumber);
    for (var i = 0; i < count; i++){
        var slot = instance_find(obj_slotNumber, i);
        // Spawn a character at the slot's position
        instance_create_layer(slot.x, slot.y, "instances", obj_character);
    }
}