selected = false;
hovered = false;

var team = isEnemy ? obj_battleController.village.team : obj_battleController.playerTeam.members;

var memberIndex = -1;

for (var i = 0; i < array_length(team); i++) {
    if (team[i].instance == id) {
        memberIndex = i;
        break;
    }
}

if (memberIndex != -1) {
    if (isEnemy) {
        if (memberIndex < obj_battleController.enemyTurnSlot) {
            obj_battleController.enemyTurnSlot -= 1;
        }
    } else {
        if (memberIndex < obj_battleController.playerTurnSlot) {
            obj_battleController.playerTurnSlot -= 1;
        }
    }
    show_debug_message("Destroyed member index: " + string(memberIndex));

    // If you intend to remove the member:
    array_delete(team, memberIndex, 1);
}

if (isEnemy && array_length(obj_battleController.village.team) <= 0) {
    obj_battleController.alarm[0] = -1;
    obj_battleController.alarm[1] = -1;
}