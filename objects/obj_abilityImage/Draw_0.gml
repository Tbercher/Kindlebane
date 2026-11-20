draw_self()

if (hovered && !is_undefined(ability)){
    var padding = 12;
    var box_width = sprite_width;
    var box_height = sprite_height;
    var box_x = x - box_width / 2;
    var box_y = y - box_height / 2;
    var text =  "Attack: " + string(ability.attack) + "\nMagic Attack: " + string(ability.magicAttack);

    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle(
        box_x,
        box_y,
        box_x + box_width,
        box_y + box_height,
        false
    );

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

	draw_text_ext_transformed(
	    box_x + padding,
	    box_y + padding,
	    text,
	    -1,
	    box_width - padding * 2,
	    0.6,
	    0.6,
	    0
	);

<<<<<<< Updated upstream
=======
    if (isUltimate) {
        var headerScale = 1.35;
        var headerX = box_x + box_width / 2;
        var headerY = box_y + box_height - padding - string_height(bottomText) * headerScale;
        var headerWidth = box_width - padding * 2;
        var headerHeight = string_height(bottomText) * headerScale;
        var costText = "Cost: " + string(ability.cost);
        var costY = headerY - string_height(costText) + 6;

        draw_set_halign(fa_center);

        draw_set_color(make_color_rgb(230, 202, 151));
        draw_set_alpha(1);
        draw_text_ext(headerX, costY, costText, -1, headerWidth);

        draw_set_color(make_color_rgb(255, 176, 48));
        draw_set_alpha(0.3);
        draw_text_ext_transformed(headerX - 1, headerY, bottomText, -1, headerWidth, headerScale, headerScale, 0);
        draw_text_ext_transformed(headerX + 1, headerY, bottomText, -1, headerWidth, headerScale, headerScale, 0);
        draw_text_ext_transformed(headerX, headerY - 1, bottomText, -1, headerWidth, headerScale, headerScale, 0);
        draw_text_ext_transformed(headerX, headerY + 1, bottomText, -1, headerWidth, headerScale, headerScale, 0);

        draw_set_color(make_color_rgb(72, 35, 18));
        draw_set_alpha(1);
        draw_text_ext_transformed(headerX + 1, headerY + 2, bottomText, -1, headerWidth, headerScale, headerScale, 0);

        draw_set_color(make_color_rgb(255, 225, 155));
        draw_text_ext_transformed(headerX, headerY, bottomText, -1, headerWidth, headerScale, headerScale, 0);
        draw_text_ext_transformed(headerX + 0.5, headerY, bottomText, -1, headerWidth, headerScale, headerScale, 0);

        draw_set_color(make_color_rgb(197, 145, 71));
		draw_text_ext_transformed(
		    box_x + padding,
		    box_y + padding,
		    text,
		    -1,
		    box_width - padding * 2,
		    0.8,
		    0.8,
		    0
		)
    }

>>>>>>> Stashed changes
    draw_set_color(c_white);
}