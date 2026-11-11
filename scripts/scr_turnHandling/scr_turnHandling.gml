function toggleHighlightTeam(team, enabled){
	for (var characterIndex = 0; characterIndex < array_length(team); characterIndex++){
			team[characterIndex].instance.clickable = enabled;
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
	function handleHoverAndClick(hoveredClickable, clickFunction){
		if (hoveredClickable.clickable){
			hoveredClickable.hovered = true;
			window_set_cursor(cr_handpoint);
			clickFunction(hoveredClickable);
		}
		
	}
	function handleCharacterAndAbilityClick(hoveredClickable){
			if (mouse_check_button_pressed(mb_left)) {
				// Set the clickable's selected state to true, handle the click event in the clickable object. 
				hoveredClickable.selected = true;
				if (hoveredClickable.object_index != obj_character || !hoveredClickable.isEnemy){
					if (hoveredClickable.object_index == obj_abilityImage){
					obj_battleController.abilitySelected = hoveredClickable.ability;
				}
					else{
						obj_battleController.abilitySelected = undefined;
					}
				}	
	    }
	}
	function handleRawButtonClick(hoveredClickable){
		if (mouse_check_button_pressed(mb_left)) {
			with(hoveredClickable){
				event_user(0);
			}
		}
	}

	//Reset all clickables' hovered variable
	with (obj_clickable){
		hovered = false;
	}

	/* Selection and Click Handling */
	// Check if the cursor is currently in contact with a hoverable.
	var hoveredClickable = collision_point(mouse_x, mouse_y, obj_clickable, true, true);
	if (hoveredClickable != noone && !hoveredClickable.clickable){
		hoveredClickable = noone;
	}
	
	// If the object is a character or an ability
	if (hoveredClickable != noone && object_is_ancestor(hoveredClickable.object_index, obj_clickable) && variable_instance_exists(hoveredClickable, "info")) {
		obj_battleController.hoveredInfo = hoveredClickable.info
		if (hoveredClickable.object_index == obj_character && !hoveredClickable.isEnemy) {
			obj_battleController.hoveredStats = hoveredClickable.stats
			obj_headshotImage.sprite_index = hoveredClickable.character.headshot;
		}
		obj_battleController.isHovering = true;

		handleHoverAndClick(hoveredClickable, handleCharacterAndAbilityClick);
	}
	// If the object is a raw button
	else if (instance_exists(hoveredClickable) && hoveredClickable.isRawButton){
		handleHoverAndClick(hoveredClickable, handleRawButtonClick);
	}
	// If the cursor is not hovering over any clickable object
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

function calculateDamage(ability, enemy, character){
	var physicalDamage = ability.attack * character.attack;
	var magicalDamage = ability.magicAttack * character.magicAttack;

	return max((physicalDamage - enemy.defense), 0) + max((magicalDamage - enemy.magicDefense), 0);
}

function handleTurn(isUserTurn){
	if (!isUserTurn){
		// AI Turn Handling
	}
	var ability = obj_battleController.abilitySelected;
	var enemy = obj_battleController.enemySelected;
	var character = obj_battleController.characterSelected;

	enemy.instance.newHealth -= calculateDamage(ability, enemy, character);

}

function preparePlayerTurn(){
	highlightCharacters(true);
	handleSelection();
}
function playGame(){
	if (obj_battleController.isPlayerTurn){
		preparePlayerTurn();
		if (is_undefined(obj_battleController.enemySelected) && !is_undefined(obj_battleController.abilitySelected)){
			toggleHighlightTeam(obj_battleController.village.team, true);
			toggleHighlightTeam(obj_battleController.playerTeam.members, false);
		}
		else if (!is_undefined(obj_battleController.enemySelected)){
			toggleHighlightTeam(obj_battleController.village.team, false);
			toggleHighlightTeam(obj_battleController.playerTeam.members, false);
			obj_battleController.enemySelected.instance.selected = true;
		}
	}
	else{
		// Call handleTurn for AI turn
		handleTurn(false);
	}
}