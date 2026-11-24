//Add animations and adjust their xy and scale in gameinfo.

/// Starts a battle splash animation sequence for the provided character.
function playAbilitySplash(character, ability) {

    if (!instance_exists(obj_battleAnimationManager)) {
        return;
    }

    if (is_undefined(character)
    || is_undefined(ability)) {
        return;
    }

    var animationManager = obj_battleAnimationManager;

    animationManager.isPlayingSplash = true;
    animationManager.animationTimer = 0;

    animationManager.overlayAlpha = 0;

    animationManager.character = character;
    animationManager.ability = ability;

    animationManager.splashSprite = ability.splashSprite;


	animationManager.splashX =
	    -sprite_get_width(ability.splashSprite)
	    * ability.splashScale;

	animationManager.splashTargetX =
	    ability.splashX;
}

/// Updates the ability splash animation each frame.
/// Handles fade-in, hold time, and fade-out.
function updateAbilitySplash() {

    if (!instance_exists(obj_battleAnimationManager)) {
        return;
    }

    var animationManager = obj_battleAnimationManager;

    if (!animationManager.isPlayingSplash) {
        return;
    }

    animationManager.animationTimer += 1;

    // Fade in.
    if (animationManager.animationTimer <= 20) {

        animationManager.overlayAlpha =
            min(
                animationManager.overlayAlpha + 0.04,
                0.75
            );

        animationManager.splashX = lerp(
            animationManager.splashX,
            animationManager.splashTargetX,
            0.15
        );
    }

    // Hold for about 1 second.
    else if (animationManager.animationTimer <= 80) {

        animationManager.overlayAlpha = 0.75;
    }

    // Fade out.
    else {

        animationManager.overlayAlpha =
            max(
			// Fade out speed.
                animationManager.overlayAlpha - 0.1,
                0
            );

        // Slide slightly back out.
        animationManager.splashX -= 20;

        if (animationManager.overlayAlpha <= 0) {

            animationManager.isPlayingSplash = false;

            animationManager.animationTimer = 0;

            animationManager.character = undefined;
            animationManager.ability = undefined;
            animationManager.splashSprite = undefined;
        }
    }
}

/// Draws the battle overlay and ability splash artwork.
function drawAbilitySplash() {

    if (!instance_exists(obj_battleAnimationManager)) {
        return;
    }

    var animationManager = obj_battleAnimationManager;

    if (!animationManager.isPlayingSplash) {
        return;
    }

	var guiWidth = display_get_gui_width();
	var guiHeight = display_get_gui_height();

	var uiCutoffY = animationManager.uiCutoffY;

    // Darken the gameplay area.
    draw_set_color(c_black);
    draw_set_alpha(animationManager.overlayAlpha);

    draw_rectangle(
        0,
        0,
        guiWidth,
        uiCutoffY,
        false
    );

    draw_set_alpha(1);
    draw_set_color(c_white);

    // Begin clipping.
    gpu_set_scissor(
        0,
        0,
        guiWidth,
        uiCutoffY
    );

    // Draw splash artwork.
    if (!is_undefined(animationManager.splashSprite)
    && !is_undefined(animationManager.ability)) {

        draw_sprite_ext(
            animationManager.splashSprite,
            0,
            animationManager.splashX,
            animationManager.ability.splashY,
            animationManager.ability.splashScale,
            animationManager.ability.splashScale,
            0,
            c_white,
            1
        );
		
    }

    // End clipping.
    gpu_set_scissor(
        0,
        0,
        guiWidth,
        guiHeight
    );
	
	// Draw UI overlay AFTER clipping has been disabled.
	draw_sprite_ext(
	    spr_UIoverlayTop,
	    0,
	    945.5,
	    203,
	    .9048,
	    .801,
	    0,
	    c_white,
	    1
	);
	
}