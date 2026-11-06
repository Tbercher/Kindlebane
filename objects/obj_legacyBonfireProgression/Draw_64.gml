var center_x = display_get_gui_width() / 2;
var center_y = display_get_gui_height() / 10
var radiusX = 300;
var radiusY = 25;

var tempProgress = 0.65; 

// Background ellipse
draw_set_color(c_gray);
draw_ellipse_colour(center_x - radiusX, center_y - radiusY,
         center_x + radiusX, center_y + radiusY,
         c_gray, c_orange, true);

// Progress arc
draw_set_color(c_orange);
draw_ellipse_colour(center_x - radiusX, center_y - radiusY,
         center_x + (radiusX * tempProgress), center_y + radiusY,
         c_orange, c_orange, false);

draw_set_color(c_white);
