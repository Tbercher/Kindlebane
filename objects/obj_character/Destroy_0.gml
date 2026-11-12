selected = false;
hovered = false;

var team = isEnemy ? obj_battleController.village.team : obj_battleController.playerTeam.members;

var memberIndex = -1;

// Find the index of the destroyed member in the team array
for (var i = 0; i < array_length(team); i++) {
    if (team[i].instance == id) {
        memberIndex = i;
        break;
    }
}

// As long as the memberIndex is valid, remove the member from the team array
if (memberIndex != -1) {
    if (isEnemy) {
        var enemyCount = array_length(obj_battleController.village.team);

        if (memberIndex < obj_battleController.enemyTurnSlot) {
            obj_battleController.enemyTurnSlot -= 1;
        }
        obj_battleController.enemyTurnSlot = clamp(
            obj_battleController.enemyTurnSlot,
            0,
            enemyCount - 1
        );
    } else {
        var playerCount = array_length(obj_battleController.playerTeam.members);
        if (memberIndex < obj_battleController.playerTurnSlot) {
            obj_battleController.playerTurnSlot -= 1;
        }
        obj_battleController.playerTurnSlot = clamp(
            obj_battleController.playerTurnSlot,
            0,
            playerCount - 1
        );
    }
    show_debug_message("Destroyed member index: " + string(memberIndex));

    // If you intend to remove the member:
    array_delete(team, memberIndex, 1);
}

if (isEnemy && array_length(obj_battleController.village.team) <= 0) {
    obj_battleController.hasWon = true;
    obj_battleController.alarm[0] = -1;
    obj_battleController.alarm[1] = -1;
}

if (!isEnemy && array_length(obj_battleController.playerTeam.members) <= 0) {
    obj_battleController.hasWon = false;
    obj_battleController.alarm[0] = -1;
    obj_battleController.alarm[1] = -1;
}

obj_battleController.characterSelected = undefined;
if (!is_undefined(obj_battleController.abilitySelected)
&& instance_exists(obj_battleController.abilitySelected.instance)) {
    obj_battleController.abilitySelected.instance.selected = false;
}
obj_battleController.abilitySelected = undefined;