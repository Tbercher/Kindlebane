if (instance_exists(obj_battleController) && !is_undefined(obj_battleController.characterSelected) && !is_undefined(obj_battleController.abilitySelected) && !is_undefined(obj_battleController.enemySelected)){
    // If a character and ability are selected, show confirm box
    visible = true;
    clickable = true;
}
else{
    visible = false;
    clickable = false;
}