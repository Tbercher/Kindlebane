if (instance_exists(obj_battleController) && !is_undefined(obj_battleController.abilitySelected) && obj_battleController.abilitySelected.instance != id){
		selected = false;
	}
if (is_undefined(obj_battleController.characterSelected)){
	ability = undefined;
	info = undefined;
	sprite_index = obj_gameInfo.abilitySprites.nonSpecific;
	clickable = false;
}