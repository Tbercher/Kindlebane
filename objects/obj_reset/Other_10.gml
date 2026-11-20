if (!is_undefined(obj_battleController.enemySelected)){
	obj_battleController.enemySelected.instance.selected = false;
	obj_battleController.enemySelected = undefined;
}
obj_battleController.abilitySelected = undefined;
if (!is_undefined(obj_battleController.characterSelected)){
	obj_battleController.characterSelected.instance.selected = false;
	obj_battleController.characterSelected = undefined;
}