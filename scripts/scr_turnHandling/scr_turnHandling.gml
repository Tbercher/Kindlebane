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

function handleTurn(){

}