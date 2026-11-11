var characterInstance = obj_battleController.village.team[obj_battleController.enemyTurnSlot].instance;


selectCharacter(characterInstance)
obj_battleController.characterSelected = characterInstance.character;

// Call the battle controllers alarm 1 for ability selection and execution.
if (obj_battleController.alarm[1] < 0) {
    obj_battleController.alarm[1] = room_speed;
}