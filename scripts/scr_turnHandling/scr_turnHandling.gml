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

function getNeighbors(instance){
	var neighbors = [];
	var team = undefined;
	// Find the neighboring enemies for spray
	if (instance.isEnemy){
		team = obj_battleController.village.team;
		var currentIndex = instance.slot.number - 1; 
		if (currentIndex > 0 && team[currentIndex - 1] != undefined){
			array_push(neighbors, currentIndex - 1);
		}
		if (currentIndex < array_length(team) - 1 && team[currentIndex + 1] != undefined){
			array_push(neighbors, currentIndex + 1);
		}
	}
	else{
		team = obj_battleController.playerTeam.members;
		var currentIndex = instance.slot.number - 1;
		if (currentIndex > 0 && team[currentIndex - 1] != undefined){
			array_push(neighbors, currentIndex - 1);
		}
		if (currentIndex < array_length(team) - 1 && team[currentIndex + 1] != undefined){
			array_push(neighbors, currentIndex + 1);
		}
	}
	return neighbors;
}

function areNeighbors(instance1, instance2){
	var neighbors = getNeighbors(instance1);
	for (var i = 0; i < array_length(neighbors); i++){
		var neighbor = instance1.isEnemy ? obj_battleController.village.team[neighbors[i]] : obj_battleController.playerTeam.members[neighbors[i]];
		if (neighbor != undefined && neighbor.instance == instance2){
			return true;
		}
	}
	return false;
}

function calculateDamage(ability, defender, attacker){
	var physicalDamage = ability.attack * attacker.attack;
	var magicalDamage = ability.magicAttack * attacker.magicAttack;
	var totalDamage = physicalDamage + magicalDamage;
	var physicalRatio = 0;
	var magicalRatio = 0;
	if (totalDamage > 0){
		physicalRatio = physicalDamage / totalDamage;
		magicalRatio = magicalDamage / totalDamage;
	}
	var physicalSpray = ability.spray * physicalRatio;
	var magicalSpray = ability.spray * magicalRatio;
	var defenseNegator = defender.instance.loweredDefenseTurns > 0 ? 0 : 1;

	return {
		damage: max((physicalDamage - (defender.defense * defenseNegator)), 0) + max((magicalDamage - (defender.magicDefense * defenseNegator)), 0),
		spray: physicalSpray + magicalSpray,
		physicalRatio: physicalRatio,
		magicalRatio: magicalRatio
	};
}

function calculateSprayDamage(ability, attacker, defender){
	var normalizedPhysicalSpray = calculateDamage(ability, defender, attacker).spray * calculateDamage(ability, defender, attacker).physicalRatio;
	var normalizedMagicalSpray = calculateDamage(ability, defender, attacker).spray * calculateDamage(ability, defender, attacker).magicalRatio;
	var defenseNegator = defender.instance.loweredDefenseTurns > 0 ? 0 : 1;

	damage = (max(normalizedPhysicalSpray - (defender.defense * defenseNegator), 0)) + (max(normalizedMagicalSpray - (defender.magicDefense * defenseNegator), 0));

	return damage
}

function handleDamage(ability, attacker, defender){
	// Handle Special Abilities
	// Stab: Causes Bleed.
	if (variable_struct_exists(ability, "effectType") && ability.effectType == "bleed" && ability.lingeringEffectDamage > 0){
		defender.instance.isBleeding = true;
		defender.instance.lingeringEffectDamage = ability.lingeringEffectDamage * attacker.attack;
		defender.instance.remainingLingeringEffectTurns += 3;
		show_debug_message("Lingering effect applied to " + string(defender.instance) + " for " + string(defender.instance.remainingLingeringEffectTurns) + " turns.");
		if (!array_contains(obj_battleController.charactersWithLingeringEffects, defender.instance)) {
			array_push(obj_battleController.charactersWithLingeringEffects, defender.instance);
		}
	}


	// Reckless Strike: Deals massive physical damage to a single enemy while lowering its defences for 1 turn.
	if (variable_struct_exists(ability, "lowersDefense") && ability.lowersDefense){
		attacker.instance.loweredDefenseTurns = 1;
	}
	// Charge: Charges a single enemy, hits adjacent enemies for 50% damage, and stuns the main target.
	if (variable_struct_exists(ability, "stuns") && ability.stuns){
		defender.instance.stunnedTurns = 1;
	}
	// Counter: Readies a defensive stance for 1 turn and deals increased physical damage next turn based on attacks received.

	// Battle Cry: Taunts all enemies while reducing enemy damage.

	// Taunt: Taunts a single enemy and reduces all damage taken for 2 turns.

	// Fire Ball: Shoots a fireball at a single enemy for magic damage and causes Burn.
	if (variable_struct_exists(ability, "effectType") && ability.effectType == "burn" && ability.lingeringEffectDamage > 0){
		defender.instance.isBurning = true;
		defender.instance.lingeringEffectDamage = ability.lingeringEffectDamage * attacker.magicAttack;
		defender.instance.remainingLingeringEffectTurns += 3;
		show_debug_message("Lingering effect applied to " + string(defender.instance) + " for " + string(defender.instance.remainingLingeringEffectTurns) + " turns.");
		if (!array_contains(obj_battleController.charactersWithLingeringEffects, defender.instance)) {
			array_push(obj_battleController.charactersWithLingeringEffects, defender.instance);
		}
	}
	// Spell Charge: Prepares a spell and increases its damage.

	// Quake: Splits the ground beneath enemies, dealing area-of-effect magic damage and stunning them.

	// Heal: Heals a single ally.

	// Curse: Silences a single target and reduces its defences for 1 turn.

	// Enhance: Buffs a single ally's damage for 2 turns.

	// Vigorate: Heals all allies while the Cleric loses 70% of its health.


	// Actual damage handling
	
	// Defense is already negated for main defender. Just need to apply it to neighbors if necessary.
	var defenseNegator = defender.instance.loweredDefenseTurns > 0 ? 0 : 1;

	defender.instance.newHealth -= calculateDamage(ability, defender, attacker).damage;
	var neighbors = getNeighbors(defender.instance);
	for (var i = 0; i < array_length(neighbors); i++){
		var neighbor = defender.instance.isEnemy ? obj_battleController.village.team[neighbors[i]] : obj_battleController.playerTeam.members[neighbors[i]];

		var physicalSprayDamage = calculateDamage(ability, neighbor, attacker).spray * calculateDamage(ability, neighbor, attacker).physicalRatio;
		var magicalSprayDamage = calculateDamage(ability, neighbor, attacker).spray * calculateDamage(ability, neighbor, attacker).magicalRatio;

		if (neighbor != undefined){
			neighbor.instance.newHealth -= max(physicalSprayDamage - (neighbor.defense * defenseNegator), 0) + max(magicalSprayDamage - (neighbor.magicDefense * defenseNegator), 0);
		}
	}

}

function applyLingeringEffects(){
	if (array_length(obj_battleController.charactersWithLingeringEffects) != 0){
		for (var i = 0; i < array_length(obj_battleController.charactersWithLingeringEffects); i++){
			var characterInstance = obj_battleController.charactersWithLingeringEffects[i];
			characterInstance.newHealth -= characterInstance.lingeringEffectDamage;
			characterInstance.remainingLingeringEffectTurns -= 1;
			show_debug_message("Lingering effect damage applied to " + string(characterInstance) + ". Remaining turns: " + string(characterInstance.remainingLingeringEffectTurns));
			if (characterInstance.remainingLingeringEffectTurns <= 0){
				characterInstance.isBleeding = false;
				characterInstance.isBurning = false;
				characterInstance.lingeringEffectDamage = 0;
				array_delete(obj_battleController.charactersWithLingeringEffects, i, 1);
				i--;
				show_debug_message("Lingering effect ended for " + string(characterInstance));
			}
		}
	}
}

function getAllCharacters(){
	return array_union(obj_battleController.playerTeam.members, obj_battleController.village.team);
}

function handleSpecialAbilityCleanup(isBeforeAI){
	// Special Ability Cleanups
	// Lingering effects: Apply damage over multiple turns. (in the User section and in the AI alarm event)
	if (!isBeforeAI){
		applyLingeringEffects();
	}
	// Decrement any specialAbility durations for all characters
		for (var i = 0; i < array_length(getAllCharacters()); i++){
			var characterInstance = getAllCharacters()[i].instance;

			// Reckless Strike: Deals massive physical damage to one enemy and lowers its defences for 1 turn.
			if (!isBeforeAI){
				if (characterInstance.loweredDefenseTurns > 0){
					characterInstance.loweredDefenseTurns -= 1;
				}
			}
			
			if (isBeforeAI){
				// Charge: Hits one enemy and adjacent enemies, and stuns the main target.
				if (characterInstance.stunnedTurns > 0){
					characterInstance.stunnedTurns -= 1;
				}
			}
		}
	
	// Counter: Readies a defensive stance and increases next turn's physical damage based on attacks received.

	// Battle Cry: Taunts all enemies and reduces their damage.

	// Taunt: Taunts one enemy and reduces all damage taken for 2 turns.

	// Fire Ball: Deals magic damage to one enemy and causes Burn.

	// Spell Charge: Prepares a spell and increases its damage.

	// Quake: Deals area-of-effect magic damage to enemies and stuns them.

	// Heal: Heals one ally.

	// Curse: Silences one target and reduces its defences for 1 turn.

	// Enhance: Buffs one ally's damage for 2 turns.

	// Vigorate: Heals all allies while the Cleric loses 70% of its health.
}

function handleTurn(isUserTurn){
	if (!isUserTurn){
		// Make sure AI turn handling is only handled once per turn
		if (aiTurnStarted == true){
			return;
		}
	}

	if (!isUserTurn){
		// AI Turn Handling

		aiTurnStarted = true;

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
		handleSpecialAbilityCleanup();

		// Player Turn Handling
		var ability = obj_battleController.abilitySelected;
		var enemy = obj_battleController.enemySelected;
		var character = obj_battleController.characterSelected;

		// Use handleDamage to apply damage and spray effects
		handleDamage(ability, character, enemy);

		// Find neighboring enemies for spray abilities

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
		if (obj_battleController.characterSelected.instance.stunnedTurns > 0){
			// Handle stunned character (skip turn or show message)
			obj_battleController.isPlayerTurn = false;
			handleSpecialAbilityCleanup();
		}

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