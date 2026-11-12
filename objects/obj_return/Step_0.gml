// Change to actual display condition
var displayCondition = !is_undefined(obj_battleController.hasWon);

if (displayCondition){
    // If a character and ability are selected, show confirm box
    visible = true;
    clickable = true;
}
else{
    visible = false;
    clickable = false;
}