function findTauntors(team){
	tauntors = [];
	for (var characterIndex = 0; characterIndex < array_length(team); characterIndex++){
		if (team[characterIndex].instance.isTaunting){
			array_push(tauntors, team[characterIndex].instance);
		}
	}
	return tauntors;
}

function highlightCharacters(playerTurn){
	var team;
	if (playerTurn){
		team = obj_battleController.playerTeam.members;
	} else {
		team = obj_battleController.village.team;
	}
	highlightTeam(team, true);
}

function highlightTeam(team, enabled){
	var characterSelected = obj_battleController.characterSelected;
	var abilitySelected = obj_battleController.abilitySelected;

	if (!is_undefined(characterSelected) 
	&& !is_undefined(abilitySelected)
	&& abilitySelected.name == "Heal"
	){
		// Highlight only the allies that can be healed
		for (var characterIndex = 0; characterIndex < array_length(team); characterIndex++){
			var currentCharacter = team[characterIndex].instance;
			if (!currentCharacter.isEnemy && currentCharacter.newHealth < currentCharacter.character.myHealth){
				currentCharacter.clickable = enabled;
			} else {
				currentCharacter.clickable = false;
			}
		}
		return;
	}
	else if (!is_undefined(characterSelected) 
	&& !is_undefined(abilitySelected)
	&& abilitySelected.name == "Enhance"
	){
		// Highlight all allies
		for (var characterIndex = 0; characterIndex < array_length(team); characterIndex++){
			var currentCharacter = team[characterIndex].instance;
			if (!currentCharacter.isEnemy){
				currentCharacter.clickable = enabled;
			} else {
				currentCharacter.clickable = false;
			}
		}
		return;
	}

	else if (!is_undefined(characterSelected) 
	&& !is_undefined(abilitySelected)
	&& abilitySelected.name == "Vigorate"
	){
		// Highlight no one
		for (var characterIndex = 0; characterIndex < array_length(team); characterIndex++){
			team[characterIndex].instance.clickable = false;
		}
		return;
	}

	var isTaunted = false;
	if (!is_undefined(obj_battleController.characterSelected)){
		isTaunted = obj_battleController.characterSelected.instance.isTaunted;
	}
	if (isTaunted){
		for (var characterIndex = 0; characterIndex < array_length(team); characterIndex++){
			var currentCharacter = team[characterIndex].instance;
			if (!currentCharacter.isTaunting){
				currentCharacter.clickable = false;
			}
			else{
				currentCharacter.clickable = enabled;
			}
		}
	}
	else{
		for (var characterIndex = 0; characterIndex < array_length(team); characterIndex++){
			team[characterIndex].instance.clickable = enabled;
		}
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
						if (obj_battleController.abilitySelected.name == "Heal"
						|| obj_battleController.abilitySelected.name == "Enhance"
						|| obj_battleController.abilitySelected.name == "Vigorate"
						) {
							if (!is_undefined(obj_battleController.enemySelected)){
								obj_battleController.enemySelected.instance.selected = false;
								obj_battleController.enemySelected = undefined;
							}
							if (!is_undefined(obj_battleController.supportedCharacter)){
								obj_battleController.supportedCharacter.instance.selected = false;
								obj_battleController.supportedCharacter = undefined;
							}
							highlightTeam(obj_battleController.playerTeam.members, true);
						}
						else{
							if (!is_undefined(obj_battleController.enemySelected)){
								obj_battleController.enemySelected.instance.selected = false;
								obj_battleController.enemySelected = undefined;
							}
							if (!is_undefined(obj_battleController.supportedCharacter)){
								obj_battleController.supportedCharacter.instance.selected = false;
								obj_battleController.supportedCharacter = undefined;
							}
						}
					}
					// clickable is a player character object
					else if (hoveredClickable.object_index == obj_character
					&& !hoveredClickable.isEnemy && (is_undefined(obj_battleController.abilitySelected) || (obj_battleController.abilitySelected.name != "Heal" && obj_battleController.abilitySelected.name != "Enhance" && obj_battleController.abilitySelected.name != "Vigorate"))) {
					hoveredClickable.selected = true;

					// Unhighlight the enemy characters until an ability is selected
					highlightTeam(obj_battleController.village.team, false);

					// if there is an enemy selected while clicking on a player character
					if (!is_undefined(obj_battleController.enemySelected)) {
						obj_battleController.enemySelected.instance.selected = false;
					}

					obj_battleController.enemySelected = undefined;
					obj_battleController.abilitySelected = undefined;
				}
				else if (hoveredClickable.object_index == obj_character
					&& !hoveredClickable.isEnemy && !is_undefined(obj_battleController.abilitySelected)
					&& (obj_battleController.abilitySelected.name == "Heal" || obj_battleController.abilitySelected.name == "Enhance" || obj_battleController.abilitySelected.name == "Vigorate")) {
					obj_battleController.supportedCharacter = hoveredClickable.character;
					obj_battleController.enemySelected = obj_battleController.supportedCharacter
					highlightTeam(obj_battleController.playerTeam.members, false);
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
	var team = instance.isEnemy ? obj_battleController.village.team : obj_battleController.playerTeam.members;
	// Find the neighboring enemies for spray
	var currentIndex = -1
	for (var i = 0; i < array_length(team); i++) {
        if (team[i].instance == instance) {
            currentIndex = i;
            break;
        }
    }

	if (currentIndex == -1){
		return neighbors;
	}

	if (currentIndex > 0 && team[currentIndex - 1] != undefined){
		array_push(neighbors, currentIndex - 1);
	}
	if (currentIndex < array_length(team) - 1 && team[currentIndex + 1] != undefined){
		array_push(neighbors, currentIndex + 1);
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

function calculateDamage(ability, attacker, defender, multiplier){
	var physicalDamage = ability.attack * attacker.attack;
	var magicalDamage = ability.magicAttack * attacker.magicAttack;
	var totalDamage = physicalDamage + magicalDamage;
	var physicalRatio = 0;
	var magicalRatio = 0;
	if (totalDamage > 0){
		physicalRatio = physicalDamage / totalDamage;
		magicalRatio = magicalDamage / totalDamage;
	}
	var physicalSpray = ability.spray * physicalRatio * multiplier;
	var magicalSpray = ability.spray * magicalRatio * multiplier;
	var defenseNegator = defender.instance.loweredDefenseTurns > 0 ? 0 : 1;
	var clampedDamage = max(((physicalDamage * multiplier) - (defender.defense * defenseNegator)), 0) + max(((magicalDamage * multiplier) - (defender.magicDefense * defenseNegator)), 0)

	return {
		damage: clampedDamage,
		spray: (physicalSpray + magicalSpray),
		physicalRatio: physicalRatio,
		magicalRatio: magicalRatio
	};
}

function calculateSprayDamage(ability, attacker, defender){
	var normalizedPhysicalSpray = calculateDamage(ability, attacker, defender, attacker.instance.attackBuff).spray * calculateDamage(ability, attacker, defender, attacker.instance.attackBuff).physicalRatio;
	var normalizedMagicalSpray = calculateDamage(ability, attacker, defender, attacker.instance.attackBuff).spray * calculateDamage(ability, attacker, defender, attacker.instance.attackBuff).magicalRatio;
	var defenseNegator = defender.instance.loweredDefenseTurns > 0 ? 0 : 1;

	var damage = (max((normalizedPhysicalSpray * attacker.attack) - (defender.defense * defenseNegator), 0)) + (max((normalizedMagicalSpray * attacker.magicAttack) - (defender.magicDefense * defenseNegator), 0));

	return damage
}

function handleDamage(ability, attacker, defender){
	// Decrement kindling for ultimates
	if (variable_struct_exists(ability, "isUltimate") && ability.isUltimate){
		obj_gameInfo.kindling = max(0, obj_gameInfo.kindling - ability.cost);
	}

	// Handle Special Abilities

	// Heal
	if (variable_struct_exists(ability, "isHeal") && ability.isHeal){
		defender.instance.newHealth = min(defender.myHealth, defender.instance.newHealth + ability.healAmount);
		return;
	}

	// Vigorate
	if (variable_struct_exists(ability, "isVigorate") && ability.isVigorate){
		for (var i = 0; i < array_length(obj_battleController.playerTeam.members); i++){
			var ally = obj_battleController.playerTeam.members[i].instance;
			ally.newHealth = min(ally.character.myHealth, ally.newHealth + ability.healAmount);
		}
		// Reduce user's health by 70%
		attacker.instance.newHealth = max(0, attacker.instance.newHealth - floor(attacker.myHealth * 0.7));
		return;
	}
	
	// Enhance: Buffs a single ally's damage for 2 turns. // 1 means 2 in this situation since it doesn't get decremented at the end of the current turn
	if (variable_struct_exists(ability, "isEnhance") && ability.isEnhance){
		defender.instance.attackBuff = 2;
		defender.instance.attackBuffRounds = 1;
		return;
	}

	// CAUTION: Whatever you set here for turn counts will be cleaned up immediately after the turn so if you intend an effect to linger for say, 3 turns after this one, set the value to 4. Round based effects are not affected.

	// Stab: Causes Bleed.
	if (variable_struct_exists(ability, "effectType") && ability.effectType == "bleed" && ability.lingeringEffectDamage > 0){
		defender.instance.isBleeding = true;
		defender.instance.lingeringEffectDamage = ability.lingeringEffectDamage * attacker.attack;
		defender.instance.remainingLingeringEffectTurns += 3;
		defender.instance.delayedEffectTurns = 1;
		show_debug_message("Lingering effect applied to " + string(defender.instance) + " for " + string(defender.instance.remainingLingeringEffectTurns) + " turns.");
		if (!array_contains(obj_battleController.charactersWithLingeringEffects, defender.instance)) {
			array_push(obj_battleController.charactersWithLingeringEffects, defender.instance);
		}
	}


	// Reckless Strike: Deals massive physical damage to a single enemy while lowering its defences for 1 turn.
	if (variable_struct_exists(ability, "lowersDefense") && ability.lowersDefense){
		attacker.instance.loweredDefenseTurns = 2;
	}
	// Charge: Charges a single enemy, hits adjacent enemies for 50% damage, and stuns the main target.
	if (variable_struct_exists(ability, "stuns") && ability.stuns){
		defender.instance.stunnedRounds = 1;
	}
	// Counter: Readies a defensive stance for 1 turn and deals increased physical damage next turn based on attacks received.
	if (variable_struct_exists(ability, "isCounter") && ability.isCounter){
		attacker.instance.increasedDefenseRounds = 1 + 1;
		attacker.instance.attackBuff = 2;
		attacker.instance.attackBuffRounds = 1;
	}
	// Battle Cry: Taunts all enemies while reducing enemy damage.
	if (variable_struct_exists(ability, "tauntsAll") && ability.tauntsAll){
		// Apply taunt to all enemies
		for (var i = 0; i < array_length(obj_battleController.village.team); i++){
			var enemy = obj_battleController.village.team[i].instance;
			enemy.tauntedRounds = 2;
			enemy.isTaunted = true;
			enemy.tauntor = attacker.instance;
		}

		// Increase defense
		attacker.instance.increasedDefenseRounds = 1 + 1;

		// Flag tauntor
		attacker.instance.isTaunting = true;
		attacker.instance.tauntingRounds = 1 + 1;
	}

	// Taunt: Taunts a single enemy and reduces all damage taken for 2 turns.
	if (variable_struct_exists(ability, "taunts") && ability.taunts){
		defender.instance.tauntedRounds = 2;
		defender.instance.isTaunted = true;
		defender.instance.tauntor = attacker.instance;
		attacker.instance.isTaunting = true;
		attacker.instance.tauntingRounds = 2 + 1;
	}

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
	if (variable_struct_exists(ability, "spellCharge") && ability.spellCharge){
		attacker.instance.attackBuff = 2;
		attacker.instance.attackBuffRounds = 1;
	}

	// Quake: Splits the ground beneath enemies, dealing area-of-effect magic damage and stunning them.
	// Handled by spray, and the stun ability above
	// --------------------------------
	// Heal: Heals a single ally.
	// Has special circumstances so it's handled in handleSelection and at the top of this function
	// --------------------------------
	// Curse: Silences a single target and reduces its defences for 1 turn.
	if (variable_struct_exists(ability, "isCurse") && ability.isCurse){
		defender.instance.cursedRounds = 1;
	}
	// Enhance: Buffs a single ally's damage for 2 turns.
	// Has special circumstances so it's handled in handleSelection and at the top of this function
	// --------------------------------
	// Vigorate: Heals all allies while the user loses 70% of its health.
	// Has special circumstances so it's handled in handleSelection and at the top of this function
	// -------------------------------- END

	// Actual damage handling
	
	// Defense is already negated for main defender. Just need to apply it to neighbors if necessary.
	var defenseNegator = defender.instance.loweredDefenseTurns > 0 ? 0 : 1;

	defender.instance.newHealth -= calculateDamage(ability, attacker, defender, attacker.instance.attackBuff).damage;
	var neighbors = getNeighbors(defender.instance);
	for (var i = 0; i < array_length(neighbors); i++){
		var neighbor = defender.instance.isEnemy ? obj_battleController.village.team[neighbors[i]] : obj_battleController.playerTeam.members[neighbors[i]];

		if (neighbor != undefined){
			neighbor.instance.newHealth -= calculateSprayDamage(ability, attacker, neighbor);
		}
	}

}

function applyLingeringEffects(){
	if (array_length(obj_battleController.charactersWithLingeringEffects) != 0){
		for (var i = 0; i < array_length(obj_battleController.charactersWithLingeringEffects); i++){
			var characterInstance = obj_battleController.charactersWithLingeringEffects[i];
			if (characterInstance.delayedEffectTurns > 0){
				characterInstance.delayedEffectTurns -= 1;
				continue;
			}
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

function handleSpecialAbilityCleanup(){
	// Special Ability Cleanups
	// Lingering effects: Apply damage over multiple turns. (in the User section and in the AI alarm event)
	applyLingeringEffects();

	// Decrement any turn based (not round based) specialAbility durations for all characters
		for (var i = 0; i < array_length(getAllCharacters()); i++){
			var characterInstance = getAllCharacters()[i].instance;

			// Reckless Strike: Deals massive physical damage to one enemy and lowers its defences for 1 turn.
			if (characterInstance.loweredDefenseTurns > 0){
				characterInstance.loweredDefenseTurns -= 1;
			}

		}
	
	// Round based cleanup
	// Counter: Readies a defensive stance and increases next turn's physical damage based on attacks received.

	var attacker = obj_battleController.characterSelected
	var defender = obj_battleController.enemySelected;

	if (attacker.instance.increasedDefenseRounds > 0){
		attacker.instance.increasedDefenseRounds -= 1;
	}

	// Attack buff is actually used in the handleDamage calculation while I took a better approach for defense. We instead increase the defense in the character struct based on increasedDefenseRounds.
	if (attacker.instance.attackBuffRounds > 0){
		attacker.instance.attackBuffRounds -= 1;
	}

	else {
		attacker.instance.attackBuff = 1
	}
	

	// Battle Cry: Taunts all enemies and reduces their damage.
	// The portion of this ability that uses taunt effects has its cleanup handled in the taunt portion. Defense cleanup handled in counter portion
	// -----------------------

	// Taunt: Taunts one enemy and reduces all damage taken for 2 turns.
	if (attacker.instance.isTaunted && attacker.instance.tauntedRounds > 0){
		attacker.instance.tauntedRounds -= 1;
	}

	if (!is_undefined(defender) && instance_exists(defender.instance)
    && defender.instance.isTaunting && defender.instance.tauntingRounds > 0){
		defender.instance.tauntingRounds -= 1;
	}

	// Fire Ball: Deals magic damage to one enemy and causes Burn.
	// Handled by lingering effects
	// -----------------------------
	// Spell Charge: Prepares a spell and increases its damage.
	// Handled by attack buff
	// -----------------------------
	// Quake: Deals area-of-effect magic damage to enemies and stuns them.
	// Handled by spray and charge 
	// -----------------------------
	// Heal: Heals one ally.
	// Does not have a cleanup
	// -----------------------------
	// Curse: Silences one target and reduces its defences for 1 turn.
	// Handled with stun handling
	// -----------------------------
	// Enhance: Buffs one ally's damage for 2 turns.
	// Handled by attack buff
	// -----------------------------
	// Vigorate: Heals all allies while the Cleric loses 70% of its health.
	// Does not have a cleanup 
	// -----------------------------
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
			highlightTeam(obj_battleController.village.team, false);
			handleSelection();
		}
		
		// Call the battle controllers alarm 0 for character selection.
		if (obj_battleController.alarm[0] < 0){
			obj_battleController.alarm[0] = aiTurnSelectionTimer;
		}
	}
	else{
		// Player Turn Handling
		var ability = obj_battleController.abilitySelected;
		var enemy = obj_battleController.enemySelected;
		var character = obj_battleController.characterSelected;

		// Use handleDamage to apply damage and spray effects
		handleDamage(ability, character, enemy);
		
		//temp
		playAbilitySplash(character, ability);
		handleDamage(ability, character, enemy);
		//temp
	
		handleSpecialAbilityCleanup();

		obj_battleController.supportedCharacter = undefined;
		if (!is_undefined(obj_battleController.enemySelected) && instance_exists(obj_battleController.enemySelected.instance)){
			obj_battleController.enemySelected.instance.selected = false;
		}
		obj_battleController.enemySelected = undefined;
		if (!is_undefined(obj_battleController.abilitySelected) && instance_exists(obj_battleController.abilitySelected.instance)){
			obj_battleController.abilitySelected.instance.selected = false;
		}
		obj_battleController.abilitySelected = undefined;
		if (!is_undefined(obj_battleController.characterSelected) && instance_exists(obj_battleController.characterSelected.instance)){
			obj_battleController.characterSelected.instance.selected = false;
		}
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

function handleSkippedTurn(characterInstance){
	if (is_undefined(characterInstance) || !instance_exists(characterInstance)){
		return false;
	}

	if (characterInstance.stunnedRounds > 0 || characterInstance.cursedRounds > 0){
		obj_battleController.isPlayerTurn = !obj_battleController.isPlayerTurn;

		if (characterInstance.cursedRounds > 0){
			characterInstance.cursedRounds -= 1;
		}

		if (characterInstance.stunnedRounds > 0){
			characterInstance.stunnedRounds -= 1;
		}
		return true;
	}


	return false;
}

function recklesslyHandleSkippedTurn(){
	obj_battleController.isPlayerTurn = !obj_battleController.isPlayerTurn;
	return true;
}

function playGame(){
	// Game Over Handling
	if (obj_battleController.hasWon != undefined){
		show_debug_message("Game has ended. Restart the game to play again.");
		highlightTeam(obj_battleController.playerTeam.members, false);
		highlightTeam(obj_battleController.village.team, false);
		if (!is_undefined(obj_battleController.characterSelected)){
			obj_battleController.characterSelected.instance.selected = false;
			obj_battleController.characterSelected = undefined;
		}
		if (!is_undefined(obj_battleController.abilitySelected)){
			obj_battleController.abilitySelected.instance.selected = false;
			obj_battleController.abilitySelected = undefined;
		}
		if (!is_undefined(obj_battleController.enemySelected)){
			obj_battleController.enemySelected.instance.selected = false;
			obj_battleController.enemySelected = undefined;
		}
		

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
		// Handle cleanup that should run before user turn
		preparePlayerTurn();
		if (!is_undefined(obj_battleController.characterSelected)){
			handleSkippedTurn(obj_battleController.characterSelected.instance);
		}

		// If the player has selected an ability but not an enemy, highlight the enemies and unhighlight the player characters
		if (is_undefined(obj_battleController.enemySelected) && !is_undefined(obj_battleController.abilitySelected)){
			highlightTeam(obj_battleController.village.team, true);
			//highlightTeam(obj_battleController.playerTeam.members, false);
		}
		// If the player has selected an enemy, tell the enemy instance that it's selected.
		else if (!is_undefined(obj_battleController.enemySelected)){
			//highlightTeam(obj_battleController.village.team, false);
			highlightTeam(obj_battleController.playerTeam.members, false);
			obj_battleController.enemySelected.instance.selected = true;
		}
	}
	else{
		// Call handleTurn for AI turn
		handleTurn(false);
	}
}