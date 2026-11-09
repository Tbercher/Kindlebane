if (selected &&!renderedAbilities){
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
    }
    renderedAbilities = true;
}
else{
    renderedAbilities = false;
}