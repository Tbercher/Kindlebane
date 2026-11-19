hasCharacterAndAbilitySelected = instance_exists(obj_battleController) && !is_undefined(obj_battleController.characterSelected) && !is_undefined(obj_battleController.abilitySelected) && !is_undefined(obj_battleController.enemySelected)
hasVigorateSelected = instance_exists(obj_battleController) && !is_undefined(obj_battleController.characterSelected) && !is_undefined(obj_battleController.abilitySelected) && (obj_battleController.abilitySelected.name == "Vigorate")

if (hasCharacterAndAbilitySelected || hasVigorateSelected){
    // If a character and ability are selected, show confirm box
    visible = true;
    clickable = true;
}

else{
    visible = false;
    clickable = false;
}