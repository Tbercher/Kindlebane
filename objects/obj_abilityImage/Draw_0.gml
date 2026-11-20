draw_self()

if (!is_undefined(ability) && hasLockShowing) {
    var lockX = x + sprite_width * 0.32;
    var lockY = y - sprite_height * 0.32;

    draw_set_color(c_black);
    draw_set_alpha(0.75);
    draw_rectangle(
        x - sprite_width / 2,
        y - sprite_height / 2,
        x + sprite_width / 2,
        y + sprite_height / 2,
        false
    );

    draw_set_alpha(1);
    draw_set_color(make_color_rgb(42, 27, 19));
    draw_circle(lockX, lockY, 12, false);
    draw_set_color(make_color_rgb(201, 155, 83));
    draw_circle(lockX, lockY, 12, true);

    draw_set_color(make_color_rgb(225, 183, 104));
    draw_roundrect(lockX - 4, lockY - 7, lockX + 4, lockY + 4, true);
    draw_set_color(make_color_rgb(174, 118, 54));
    draw_roundrect(lockX - 5, lockY - 2, lockX + 5, lockY + 7, false);
    draw_set_color(make_color_rgb(245, 207, 129));
    draw_roundrect(lockX - 4, lockY - 1, lockX + 4, lockY + 1, false);
    draw_set_color(make_color_rgb(65, 39, 23));
    draw_circle(lockX, lockY + 2, 1.5, false);
    draw_line(lockX, lockY + 3, lockX, lockY + 5);

    draw_set_color(c_white);
    draw_set_alpha(1);
}

if (hovered && !is_undefined(ability)){
    var padding = 12;
    var box_width = sprite_width;
    var box_height = sprite_height;
    var box_x = x - box_width / 2;
    var box_y = y - box_height / 2;
    var text =  "Attack: " + string(ability.attack) + "\nMagic Attack: " + string(ability.magicAttack);
    var isUltimate = variable_struct_exists(ability, "isUltimate") && ability.isUltimate;
    var bottomText = "ULTIMATE";

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
		);

        draw_line(
            box_x + padding + 4,
            headerY + headerHeight + 2,
            box_x + box_width - padding - 4,
            headerY + headerHeight + 2
        );
    }

    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}