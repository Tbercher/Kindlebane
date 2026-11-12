// Change to actual display condition
var displayCondition = !is_undefined(obj_battleController.hasWon);

if (displayCondition){
    visible = true;
    sprite_index = obj_battleController.hasWon
        ? obj_gameInfo.dynamicUISprites.winner
        : obj_gameInfo.dynamicUISprites.loser;
}
else{
    visible = false;
}