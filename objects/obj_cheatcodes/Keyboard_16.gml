// Toggle lowered defense for all enemies
if (keyboard_check_pressed(ord("E"))){
    for (var i = 0; i < array_length(obj_battleController.village.team); i++){
        var enemy = obj_battleController.village.team[i];
        if (enemy != undefined){
            if (enemy.instance.loweredDefenseTurns > 0){
                enemy.instance.loweredDefenseTurns = 0;
            }
            else{
                enemy.instance.loweredDefenseTurns = 100;
            }
        }
    }
}

// Deliver fatal damage to one random enemy
if (keyboard_check_pressed(ord("D"))){
    var enemies = obj_battleController.village.team;
    var validEnemies = [];
    for (var i = 0; i < array_length(enemies); i++){
        if (enemies[i] != undefined){
            array_push(validEnemies, enemies[i]);
        }
    }
    if (array_length(validEnemies) > 0){
        var randomEnemy = validEnemies[irandom(array_length(validEnemies) - 1)];
        if (randomEnemy != undefined){
            randomEnemy.instance.newHealth = 0;
        }
    }
}

// Skip a player turn
if (keyboard_check_pressed(ord("S"))){
    if (obj_battleController.isPlayerTurn){
        recklesslyHandleSkippedTurn();
    }
}

// Toggle immediate AI turns
if (keyboard_check_pressed(ord("A"))){
    obj_battleController.aiTurnSelectionTimer = (obj_battleController.aiTurnSelectionTimer == 1) ? obj_battleController.historicalAITurnSelectionTimer : 1;
    obj_battleController.aiTurnDecisionTimer = (obj_battleController.aiTurnDecisionTimer == 1) ? obj_battleController.historicalAITurnDecisionTimer : 1;
}

if (keyboard_check_pressed(ord("R"))){
    room_restart();
}

// Enable invincibility for player characters
if (keyboard_check_pressed(ord("I"))){
    for (var i = 0; i < array_length(obj_battleController.playerTeam.members); i++){
        var player = obj_battleController.playerTeam.members[i];
        if (player != undefined){
            player.instance.defense = 9999;
            player.instance.magicDefense = 9999;
            player.instance.historicalDefense = 9999;
            player.instance.historicalMagicDefense = 9999;
        }
    }
}

// Enable invincibility for enemy characters
if (keyboard_check_pressed(ord("N"))){
    for (var i = 0; i < array_length(obj_battleController.village.team); i++){
        var enemy = obj_battleController.village.team[i];
        if (enemy != undefined){
            enemy.instance.defense = 9999;
            enemy.instance.magicDefense = 9999;
            enemy.instance.historicalDefense = 9999;
            enemy.instance.historicalMagicDefense = 9999;
        }
    }
}
