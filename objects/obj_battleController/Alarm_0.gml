var playerCount = array_length(obj_battleController.playerTeam.members);

if (playerCount <= 0) {
    alarm[0] = -1;
    alarm[1] = -1;
    isPlayerTurn = false;
    aiTurnStarted = false;

    //show_debug_message("Player team defeated.");
    exit;
}

var enemyCount = array_length(obj_battleController.village.team);

if (enemyCount <= 0) {
    alarm[1] = -1;
    exit;
}

enemyTurnSlot = clamp(enemyTurnSlot, 0, enemyCount - 1);

var characterInstance = village.team[enemyTurnSlot].instance;

selectCharacter(characterInstance)
obj_battleController.characterSelected = characterInstance.character;

// Call the battle controllers alarm 1 for ability selection and execution.
if (obj_battleController.alarm[1] < 0) {
    obj_battleController.alarm[1] = room_speed;
}