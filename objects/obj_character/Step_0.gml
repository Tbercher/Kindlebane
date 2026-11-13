if (newHealth <= 0){
    instance_destroy();
}

if (selected &&!renderedAbilities && (!obj_battleController.isHovering || obj_battleController.hoveredInfo == info)){
    if (!isEnemy && obj_battleController.isPlayerTurn){
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
    else if (!isEnemy && !obj_battleController.isPlayerTurn){
        obj_headshotImage.sprite_index = obj_gameInfo.headshotSprites.nonSpecific;
        obj_battleController.hoveredStats = undefined;
        obj_battleController.hoveredInfo = undefined;
    }
    else{
        obj_battleController.enemySelected = character;
    }
}
else{
    renderedAbilities = false;
}

if (selected){
    if (!isEnemy){
        obj_battleController.characterSelected = character;	
        hasNeighborSelected = false;
    }
}
// If the character is not selected, check if it has a neighboring enemy selected.
else {
    if (!is_undefined(obj_battleController.enemySelected) && areNeighbors(self, obj_battleController.enemySelected.instance)){
        hasNeighborSelected = true;
    }
    else{
        hasNeighborSelected = false;
    }
}

if (remainingLingeringEffectTurns > 0){
    if (!array_contains(obj_battleController.charactersWithLingeringEffects, id)){
        array_push(obj_battleController.charactersWithLingeringEffects, id);
    }
}

if (slot.number == 1 && isEnemy){
    show_debug_message(string(loweredDefenseTurns));
}