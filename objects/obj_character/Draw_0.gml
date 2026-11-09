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