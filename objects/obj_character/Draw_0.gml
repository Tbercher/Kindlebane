if (clickable && !hovered){
    draw_self();

    var pulse = 0.15 + ((sin(current_time / 400) + 1) * 0.5) * 0.35;

    gpu_set_blendmode(bm_add);

	draw_sprite_ext(
    sprite_index, 
    image_index,  
    x,            
    y,            
    image_xscale,  
    image_yscale, 
    image_angle,   
    c_white,      // Color tint
    pulse         // Alpha/opacity: 1 = fully visible
	);

    gpu_set_blendmode(bm_normal);
}
else{
	draw_self()	
}

if (selected && isEnemy
    && !is_undefined(obj_battleController.abilitySelected)
    && !is_undefined(obj_battleController.enemySelected)
    && !is_undefined(obj_battleController.characterSelected)
    ){
    gpu_set_blendmode(bm_subtract);

	draw_sprite_ext(
    sprite_index, 
    image_index,  
    x,            
    y,            
    image_xscale,  
    image_yscale, 
    image_angle,   
    make_color_rgb(0, 255, 255),      // subtract aqua create red tint
    .15       // Alpha/opacity: 1 = fully visible
	);

    gpu_set_blendmode(bm_normal);
    var ability = obj_battleController.abilitySelected;
	var enemy = obj_battleController.enemySelected;
    var damage = calculateDamage(ability, enemy, character);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(x, y - 120, "Damage: " + string(damage));

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// Draw Health Bar
var bar_width = 80;
var bar_height = 8;

var bar_x = x - bar_width / 2;
var bar_y = y - 100;

var health_percent = clamp((newHealth / character.myHealth) * 100, 0, 100);

draw_healthbar(
    bar_x,
    bar_y,
    bar_x + bar_width,
    bar_y + bar_height,
    health_percent,
    c_black,
    c_red,
    c_lime,
    0,
    true,
    true
);