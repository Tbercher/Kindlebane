// If the character is clickable and not being hovered over, draw a pulsing effect to indicate interactivity
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

// If the character is selected and it is an enemy, draw a red tint to indicate selection
if (selected){
    var ring_color = isEnemy ? c_red : c_yellow;
    var ring_y = y + 75;
    var pulse = 2 + sin(current_time / 180);

    draw_set_color(ring_color);
    draw_set_alpha(0.35);
    draw_ellipse(x - 70 - pulse, ring_y - 16, x + 70 + pulse, ring_y + 16, true);

    draw_set_alpha(0.8);
    draw_ellipse(x - 64, ring_y - 12, x + 64, ring_y + 12, true);

    draw_set_color(c_white);
    draw_set_alpha(1);

    gpu_set_blendmode(bm_normal);

    if (!is_undefined(obj_battleController.abilitySelected)
    && !is_undefined(obj_battleController.enemySelected)
    && !is_undefined(obj_battleController.characterSelected)){
        var ability = obj_battleController.abilitySelected;
        var enemy = obj_battleController.enemySelected;
        var damage = calculateDamage(ability, enemy, character);

        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        draw_text(x, y - 120, "Damage: " + string(damage));

        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }

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