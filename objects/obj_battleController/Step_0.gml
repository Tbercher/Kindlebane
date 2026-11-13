// Perform initialization once other objects have loaded
if (is_undefined(info) && instance_exists(obj_gameInfo)) {
    info = obj_gameInfo;
    playerTeam = {
        members: [info.characters.apprentice]
    };
	village = info.villages[$obj_gameInfo.currentVillage];
	spawnCharacters()
}

if (!is_undefined(info)){
    playGame();
}


