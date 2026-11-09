if (selected &&!renderedAbilities && (!obj_battleController.isHovering || obj_battleController.hoveredInfo == info)){
    // Display all character abilities and make them clickable.
    var count = instance_number(obj_abilityImage);
    for (var i = 0; i < count; i++){
        if (i >= array_length(character.abilities)){
            break;
        }
        var abilityImage = instance_find(obj_abilityImage, i);
        abilityImage.clickable = true;
        abilityImage.sprite_index = character.abilities[i].sprite;
		abilityImage.ability = character.abilities[i];
		abilityImage.info = abilityImage.ability.description
        abilityImage.ability.instance = abilityImage;
		obj_headshotImage.sprite_index = character.headshot;
        obj_battleController.hoveredStats = stats;
        if (!is_undefined(obj_battleController.abilitySelected) && !obj_battleController.isHovering){
            obj_battleController.hoveredInfo = obj_battleController.abilitySelected.description;
        }
        else{
            obj_battleController.hoveredInfo = info;
        }
    }
    renderedAbilities = true;
}
else{
    renderedAbilities = false;
}
if (selected){
	obj_battleController.characterSelected = character;	
}