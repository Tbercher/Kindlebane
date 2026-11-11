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

    draw_text_ext(
        box_x + padding,
        box_y + padding,
        text,
        -1,
        box_width - padding * 2
    );

    draw_set_color(c_white);
}