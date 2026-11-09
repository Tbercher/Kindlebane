function playGame(){
	var playerTurn;
	if (random(1) < .5){
		playerTurn = true	
	}
	while(!gameover){
		chooseTurn(!playerTurn);
	}
}

function highlightCharacters(playerTurn){
	var team;
	if (playerTurn){
		team = obj_battleController.playerTeam.members;
	} else {
		team = obj_battleController.village.team;
	}
	for (var characterIndex = 0; characterIndex < array_length(team); characterIndex++){
			team[characterIndex].instance.clickable = true;
	}
}

function chooseCharacter(playerTurn){
	var team;
	if (playerTurn){
			
	}
	for (var characterIndex = 0; characterIndex < array_length(team.squad); characterIndex++){
			continue;
			// Highlight characters
	}
	// Ungray UI selectors
			
	// Listen for character and move selection.
	
	// Once move selected call handleTurn
	handleTurn()
}

function handleSelection(){
	/* Selection and Click Handling */
	// Check if the cursor is currently in contact with a hoverable.
	var hoveredClickable = collision_point(mouse_x, mouse_y, obj_clickable, true, true);
	if (hoveredClickable != noone && object_is_ancestor(hoveredClickable.object_index, obj_clickable)) {
		obj_battleController.hoveredInfo = hoveredClickable.info
		if (hoveredClickable.object_index == obj_character) {
			obj_battleController.hoveredStats = hoveredClickable.stats
			obj_headshotImage.sprite_index = hoveredClickable.character.headshot;
		}
		obj_battleController.isHovering = true;

		if (hoveredClickable.clickable){
			window_set_cursor(cr_handpoint);
			if (mouse_check_button_pressed(mb_left)) {
				// Set the clickable's selected state to true, handle the click event in the clickable object. 
				hoveredClickable.selected = true;
				if (hoveredClickable.object_index == obj_abilityImage){
					obj_battleController.abilitySelected = hoveredClickable.ability;
				}
				else{
					obj_battleController.abilitySelected = undefined;
				}
	    	}
		}
	}
	else{
		window_set_cursor(cr_default);
		obj_battleController.isHovering = false;
		if (obj_battleController.hoveredStats != undefined && is_undefined(obj_battleController.characterSelected)){
			obj_battleController.hoveredStats = undefined;
			obj_battleController.hoveredInfo = undefined;
		}
		if (is_undefined(obj_battleController.characterSelected)){
			obj_headshotImage.sprite_index = spr_placeholderHeadshot;
		}
	}
}

function handleTurn(isUserTurn, ability){
	if (!isUserTurn){
		// AI Turn Handling
	}
	

}