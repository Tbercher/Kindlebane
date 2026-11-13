var characterInstance = obj_battleController.village.team[obj_battleController.enemyTurnSlot].instance;

// Get all possible damage values for each ability against each enemy
var highestDamage = 0;
var bestAbility = undefined;
var bestPlayerTarget = undefined;
var character = characterInstance.character;
for (var abilityIndex = 0; abilityIndex < array_length(character.abilities); abilityIndex++){
    var ability = character.abilities[abilityIndex];
    for (var enemyIndex = 0; enemyIndex < array_length(obj_battleController.playerTeam.members); enemyIndex++){
        var enemy = obj_battleController.playerTeam.members[enemyIndex];
        //var damage = calculateDamage(ability, enemy, character).damage;
        var damage = calculateDamage(ability, enemy, character).damage;
        if (damage > highestDamage){
            highestDamage = damage;
            bestAbility = ability;
            bestPlayerTarget = enemy;
        }
    }
}

// Execute the best ability against the best target
show_debug_message(string(obj_battleController.isPlayerTurn))
bestPlayerTarget.instance.newHealth -= highestDamage;
characterInstance.selected = false;
obj_battleController.characterSelected = undefined;
obj_battleController.abilitySelected = undefined;
obj_battleController.enemySelected = undefined;
obj_battleController.isPlayerTurn = true;
obj_battleController.aiTurnStarted = false;

// Handle turn slot incrementing. 
var playerTeamSize = array_length(obj_battleController.playerTeam.members);
var enemyTeamSize = array_length(obj_battleController.village.team);

if (obj_battleController.enemyTurnSlot >= enemyTeamSize - 1){
    obj_battleController.enemyTurnSlot = 0;
}
else{
    obj_battleController.enemyTurnSlot++;
}
if (obj_battleController.playerTurnSlot >= playerTeamSize - 1){
    obj_battleController.playerTurnSlot = 0;
}
else{
    obj_battleController.playerTurnSlot++;
}

if (playerTeamSize <= 0){
    obj_battleController.hasWon = false;
}

