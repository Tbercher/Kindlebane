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

function selectCharacter(characterInstance){
	characterInstance.selected = true;
	obj_battleController.characterSelected = characterInstance.character;
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
	//handleTurn()
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
				// Clickable is an enemy character
				if (hoveredClickable.object_index == obj_character
					&& hoveredClickable.isEnemy
					&& !is_undefined(obj_battleController.characterSelected)
    				&& !is_undefined(obj_battleController.abilitySelected)
					) {
					// If there is already an enemy selected, deselect it
					if (!is_undefined(obj_battleController.enemySelected)
						&& obj_battleController.enemySelected.instance != hoveredClickable) {
						obj_battleController.enemySelected.instance.selected = false;
					}

					hoveredClickable.selected = true;
					obj_battleController.enemySelected = hoveredClickable.character;
				}

				// Is either a player character a not a character at all like an ability image
				if (hoveredClickable.object_index != obj_character || !hoveredClickable.isEnemy){
					// clickable is an ability image object
					if (hoveredClickable.object_index == obj_abilityImage){
						obj_battleController.abilitySelected = hoveredClickable.ability;
					}
					// clickable is a player character object
					else if (hoveredClickable.object_index == obj_character
					&& !hoveredClickable.isEnemy) {
					hoveredClickable.selected = true;

					// Unhighlight the enemy characters until an ability is selected
					toggleHighlightTeam(obj_battleController.village.team, false);

					// if there is an enemy selected while clicking on a player character
					if (!is_undefined(obj_battleController.enemySelected)) {
						obj_battleController.enemySelected.instance.selected = false;
					}

					obj_battleController.enemySelected = undefined;
					obj_battleController.abilitySelected = undefined;
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
		if (!is_undefined(obj_battleController.characterSelected)){
			obj_battleController.characterSelected.instance.selected = false;
			obj_battleController.characterSelected = undefined;
			toggleHighlightTeam(obj_battleController.village.team, false);
			handleSelection();
		}
		// Get all possible damage values for each ability against each enemy
		show_debug_message("AI Turn: " + string(obj_battleController.characterSelected));
	}
	else{
		// Player Turn Handling
		var ability = obj_battleController.abilitySelected;
		var enemy = obj_battleController.enemySelected;
		var character = obj_battleController.characterSelected;

		enemy.instance.newHealth -= calculateDamage(ability, enemy, character);
		obj_battleController.enemySelected.instance.selected = false;
		obj_battleController.enemySelected = undefined;
		obj_battleController.abilitySelected.instance.selected = false
		obj_battleController.abilitySelected = undefined;
		obj_battleController.characterSelected.instance.selected = false;
		obj_battleController.characterSelected = undefined;
		obj_battleController.isPlayerTurn = false;
		show_debug_message(string(obj_battleController.characterSelected))
	}
}

function handleAutoCharacterSelection(){
	// Find the character for the current turn
	var characterInstance = obj_battleController.playerTeam.members[obj_battleController.turnSlot - 1].instance;
	selectCharacter(characterInstance)
}

function preparePlayerTurn(){
	handleSelection();
	handleAutoCharacterSelection();
}
function playGame(){
	if (obj_battleController.isPlayerTurn){
		preparePlayerTurn();

		// If the player has selected an ability but not an enemy, highlight the enemies and unhighlight the player characters
		if (is_undefined(obj_battleController.enemySelected) && !is_undefined(obj_battleController.abilitySelected)){
			toggleHighlightTeam(obj_battleController.village.team, true);
			//toggleHighlightTeam(obj_battleController.playerTeam.members, false);
		}
		// If the player has selected an enemy, tell the enemy instance that it's selected.
		else if (!is_undefined(obj_battleController.enemySelected)){
			//toggleHighlightTeam(obj_battleController.village.team, false);
			toggleHighlightTeam(obj_battleController.playerTeam.members, false);
			obj_battleController.enemySelected.instance.selected = true;
		}
	}
	else{
		// Call handleTurn for AI turn
		handleTurn(false);
	}
}