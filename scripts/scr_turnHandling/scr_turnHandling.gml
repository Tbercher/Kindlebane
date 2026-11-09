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
			// Highlight characters
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
	if (hoveredClickable != noone && hoveredClickable.clickable){
	    window_set_cursor(cr_handpoint);
	    mouse_check_button_pressed(mb_left) {
	        // Set the clickable's selected state to true, handle the click event in the clickable object. 
	        hoveredClickable.selected = true;
	    }
	}
	else{
		window_set_cursor(cr_default);
	}
}

function handleTurn(){

}