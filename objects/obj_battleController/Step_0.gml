// Perform initialization once other objects have loaded
if (is_undefined(info) && instance_exists(obj_gameInfo)) {
    info = variable_clone(obj_gameInfo);
    playerTeam = variable_clone(obj_gameInfo.playerTeam);
	village = variable_clone(info.villages[$obj_gameInfo.currentVillage]);
	spawnCharacters()
}

if (!is_undefined(info)){
    playGame();
}


