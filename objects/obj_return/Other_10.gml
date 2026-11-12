if (room_previous != -1 && room_exists(room_previous)) {
    room_goto(room_previous);
}
else{
    game_end();
}