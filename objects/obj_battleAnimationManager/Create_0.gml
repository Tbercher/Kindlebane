// Tracks whether an ability splash animation is currently active.
isPlayingSplash = false;

// Tracks progression through the splash animation.
animationTimer = 0;

// Controls the darkness of the screen overlay.
overlayAlpha = 0;

// Horizontal position of the splash image.
splashX = 0;

// Data associated with the current animation.
character = undefined;
ability = undefined;

// Sprite displayed during the animation.
splashSprite = undefined;

// Current splash position.
splashX = 0;

// Final destination position.
splashTargetX = 0;

// Anything below this line will not display splash artwork.
uiCutoffY = 615;

// places a UI overlay ontop of the image to create a smooth image.
spr_UIoverlayTop = spr_UIBase