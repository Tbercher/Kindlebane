//resize portrait to scale.
var target_w = 128;
var target_h = 128;

if (sprite_index != -1)
{
    var spr_w = sprite_get_width(sprite_index);
    var spr_h = sprite_get_height(sprite_index);

    var scale = min(
        target_w / spr_w,
        target_h / spr_h
    );

    image_xscale = scale;
    image_yscale = scale;
}