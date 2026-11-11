// Draw info text in appropriate UI box. 
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

draw_text_ext_transformed(
    x,
    y,
    !is_undefined(obj_battleController.hoveredStats)
        ? obj_battleController.hoveredStats
        : "",
    -1,
    1000,
    0.8,
    0.8,
    0
);

draw_set_halign(fa_left);
draw_set_valign(fa_top);