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
	if (hoveredClickable != noone && (!hoveredClickable.clickable || !hoveredClickable.visible)){
		// create a list of all instances under the mouse cursor
		var hitList = ds_list_create();

		// Get all instances of obj_clickable under the mouse cursor
		var hitCount = collision_point_list(
        	mouse_x, mouse_y, obj_clickable, true, true, hitList, false
		);
		
		// Set hoveredClickable to noone initially. If we find a valid clickable obj then we will set it to that instance.
		hoveredClickable = noone;

		for (var i = 0; i < hitCount; i++) {
			// Just indexing into the list to get the current clickable object under the mouse cursor. ds_lists use this indexing syntax to differentiate itself from regular lists
			var candidate = hitList[| i];

			if (candidate.visible && candidate.clickable) {
				hoveredClickable = candidate;
				break;
			}
		}

		ds_list_destroy(hitList);
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
			obj_headshotImage.sprite_index = obj_gameInfo.headshotSprites.nonSpecific;
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

		// Make sure AI turn handling is only handled once per turn
		if (aiTurnStarted == true){
			return;
		}
		aiTurnStarted = true;

		var selectedCharacter = obj_battleController.characterSelected;

		// Get rid of all the selected variables from the player turn
		if (!is_undefined(obj_battleController.characterSelected)){
			if (!is_undefined(obj_battleController.abilitySelected)
			&& instance_exists(obj_battleController.abilitySelected.instance)){
				obj_battleController.abilitySelected.instance.selected = false;
			}
			obj_battleController.abilitySelected = undefined;
			if (instance_exists(obj_battleController.characterSelected.instance)){
				obj_battleController.characterSelected.instance.selected = false;
			}
			obj_battleController.characterSelected = undefined;
			toggleHighlightTeam(obj_battleController.village.team, false);
			handleSelection();
		}
		
		// Call the battle controllers alarm 0 for character selection.
		if (obj_battleController.alarm[0] < 0){
			obj_battleController.alarm[0] = room_speed / 6;
		}
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
	}
}

function handleAutoCharacterSelection(){
	var playerCount = array_length(obj_battleController.playerTeam.members);

    if (playerCount <= 0) {
        obj_battleController.isPlayerTurn = false;
        obj_battleController.alarm[0] = -1;
        obj_battleController.alarm[1] = -1;
        return;
    }

    obj_battleController.playerTurnSlot = clamp(
        obj_battleController.playerTurnSlot,
        0,
        playerCount - 1
    );

    var characterInstance = obj_battleController.playerTeam.members[obj_battleController.playerTurnSlot].instance;

    selectCharacter(characterInstance);
}

function preparePlayerTurn(){
	handleSelection();
	handleAutoCharacterSelection();
}

function handleWin(){
	// Handle win condition
	
}

function handleLose(){
	// Handle lose condition
	
}

function playGame(){
	if (obj_battleController.hasWon != undefined){
		show_debug_message("Game has ended. Restart the game to play again.");
		toggleHighlightTeam(obj_battleController.playerTeam.members, false);
		toggleHighlightTeam(obj_battleController.village.team, false);
		if (obj_battleController.hasWon){
			// Win condition
			handleWin();
		}
		else{
			// Lose condition
			handleLose();
		}
		handleSelection();
		return;
	}
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