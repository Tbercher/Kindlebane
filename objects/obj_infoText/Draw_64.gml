// Draw info text in appropriate UI box. 
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

draw_text_ext(x, y, !is_undefined(obj_battleController.hoveredInfo) ? 
obj_battleController.hoveredInfo : 
"",
-1, //Default line spacing
 800 //Max width of text box
 
 );

draw_set_halign(fa_left);
draw_set_valign(fa_top);