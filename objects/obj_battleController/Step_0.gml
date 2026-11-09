// Perform initialization once other objects have loaded
if (is_undefined(info) && instance_exists(obj_gameInfo)) {
    info = obj_gameInfo;
    playerTeam = {
        members: [info.characters.apprentice]
    };
	village = info.villages[$obj_gameInfo.currentVillage];
	spawnCharacters()
	highlightCharacters(true);
	show_debug_message(obj_character.clickable)
}

// Check if the cursor is currently in contact with a hoverable.
var hoveredClickable = collision_point(mouse_x, mouse_y, obj_clickable, true, true);
if (hoveredClickable != noone && hoveredClickable.clickable){
    window_set_cursor(cr_handpoint);
}
else{
    window_set_cursor(cr_default);
}