function save_game(){
    var game_data = {
        playerTeam: []
    }

    for (var i = 0; i < array_length(obj_battleController.playerTeam.members); i++) {
        var member = obj_battleController.playerTeam.members[i];
        array_push(game_data.playerTeam, string_lower(member.name));
    }
    
    var village_keys= variable_struct_get_names(obj_gameInfo.villages);

	for (var i = 0; i < array_length(village_keys); i++) {
        var village_key = village_keys[i];
        var village = variable_struct_get(obj_gameInfo.villages, village_key);
        game_data[$village_key] = village.conquered;
    }

    var json = json_stringify(game_data);

    var file = file_text_open_write("savegame.json");
    file_text_write_string(file, json);
    file_text_close(file);
}

function load_game(){
    if (!file_exists("savegame.json")) {
        show_message("No save game found.");
        return;
    }

    var file = file_text_open_read("savegame.json");
    var json = file_text_read_string(file);
    file_text_close(file);

    var game_data = json_parse(json);

    obj_battleController.playerTeam.members = [];
    for (var i = 0; i < array_length(game_data.playerTeam); i++) {
        var member_name = game_data.playerTeam[i];
        var member = variable_struct_get(obj_gameInfo.characters, member_name);
        array_push(obj_battleController.playerTeam.members, member);
    }

    var village_keys= variable_struct_get_names(obj_gameInfo.villages);
	for (var i = 0; i < array_length(village_keys); i++) {
        var village_key = village_keys[i];
        var village = variable_struct_get(obj_gameInfo.villages, village_key);
        village.conquered = game_data[$village_key];
    }
}