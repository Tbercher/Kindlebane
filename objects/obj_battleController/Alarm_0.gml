if (array_length(obj_battleController.village.team) <= 0) {
    obj_battleController.alarm[1] = -1;
    obj_battleController.isPlayerTurn = false;

    // Replace this with your battle-win handling.
    show_debug_message("Enemy team defeated.");
    exit;
}

var characterInstance = obj_battleController.village.team[obj_battleController.enemyTurnSlot].instance;


selectCharacter(characterInstance)
obj_battleController.characterSelected = characterInstance.character;

// Call the battle controllers alarm 1 for ability selection and execution.
if (obj_battleController.alarm[1] < 0) {
    obj_battleController.alarm[1] = room_speed;
}