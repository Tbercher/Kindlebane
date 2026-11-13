if (keyboard_check_pressed(ord("R"))){
    // Toggle lowered defense for all enemies
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