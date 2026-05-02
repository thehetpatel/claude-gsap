---
name: gsap-canvas
description: Animate PixiJS and EaselJS/CreateJS canvas elements with GSAP
version: 1.0.0
argument-hint: "[canvas animation description]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP Canvas Animation (PixiPlugin & EaselPlugin)

Animate canvas-based graphics with PixiJS and EaselJS/CreateJS.

## PixiPlugin Setup

```javascript
import { gsap } from "gsap";
import { PixiPlugin } from "gsap/PixiPlugin";
import * as PIXI from "pixi.js";

gsap.registerPlugin(PixiPlugin);
PixiPlugin.registerPIXI(PIXI);
```

## EaselPlugin Setup

```javascript
import { gsap } from "gsap";
import { EaselPlugin } from "gsap/EaselPlugin";

gsap.registerPlugin(EaselPlugin);
```

---

# PixiPlugin

## Why Use PixiPlugin?

Without the plugin, PixiJS properties are buried in sub-objects:
- `sprite.position.x` instead of just `x`
- `sprite.scale.x` instead of `scaleX`
- Rotation is in radians, not degrees

PixiPlugin simplifies everything:

```javascript
// Without plugin (verbose)
gsap.to(sprite.position, { x: 100 });
gsap.to(sprite.scale, { x: 2, y: 2 });
gsap.to(sprite, { rotation: Math.PI }); // Radians!

// With PixiPlugin (clean)
gsap.to(sprite, {
  pixi: { x: 100, scaleX: 2, scaleY: 2, rotation: 180 } // Degrees!
});
```

## Basic Properties

```javascript
gsap.to(sprite, {
  pixi: {
    // Position
    x: 100,
    y: 200,

    // Scale
    scaleX: 2,
    scaleY: 2,
    scale: 1.5,        // Both scaleX and scaleY

    // Rotation (degrees, not radians!)
    rotation: 45,

    // Skew
    skewX: 10,
    skewY: 10,

    // Pivot point
    pivotX: 50,
    pivotY: 50,

    // Visibility
    alpha: 0.5,

    // Anchor (for sprites)
    anchorX: 0.5,
    anchorY: 0.5
  },
  duration: 1
});
```

## Color Properties

```javascript
gsap.to(sprite, {
  pixi: {
    // Tint color (any CSS format)
    tint: "red",
    tint: "#FF0000",
    tint: "rgb(255, 0, 0)",
    tint: 0xFF0000,

    // ColorMatrixFilter effects
    saturation: 0,       // 0 = grayscale, 1 = normal
    brightness: 2,       // 1 = normal
    contrast: 1.5,       // 1 = normal
    hue: 180,           // Shift hue (degrees)

    // Colorize (tint + amount)
    colorize: "red",
    colorizeAmount: 0.5  // 0-1
  },
  duration: 1
});
```

## Filter Animations

```javascript
// Blur filter
const blurFilter = new PIXI.filters.BlurFilter();
sprite.filters = [blurFilter];

gsap.to(blurFilter, {
  blur: 20,
  duration: 1
});

// Color matrix effects through pixi property
gsap.to(sprite, {
  pixi: {
    saturation: 0,    // Grayscale
    brightness: 1.5   // Brighten
  },
  duration: 1
});
```

## Common Patterns

### Sprite Animation
```javascript
const app = new PIXI.Application({ width: 800, height: 600 });
const sprite = PIXI.Sprite.from("image.png");
app.stage.addChild(sprite);

gsap.to(sprite, {
  pixi: { x: 400, y: 300, rotation: 360, scale: 2 },
  duration: 2,
  ease: "power2.inOut"
});
```

### Pulse Effect
```javascript
gsap.to(sprite, {
  pixi: { scale: 1.2, alpha: 0.8 },
  duration: 0.5,
  yoyo: true,
  repeat: -1,
  ease: "sine.inOut"
});
```

### Color Transition
```javascript
gsap.to(sprite, {
  pixi: { tint: "#00FF00" },
  duration: 1
});
```

### Grayscale to Color
```javascript
gsap.fromTo(sprite,
  { pixi: { saturation: 0 } },
  { pixi: { saturation: 1 }, duration: 2 }
);
```

---

# EaselPlugin

For Adobe Animate / CreateJS / EaselJS.

## Basic Properties

```javascript
gsap.to(displayObject, {
  easel: {
    // Transform
    x: 100,
    y: 100,
    scaleX: 2,
    scaleY: 2,
    rotation: 45,
    skewX: 10,
    skewY: 10,
    regX: 50,
    regY: 50,

    // Visibility
    alpha: 0.5,
    visible: false
  },
  duration: 1
});
```

## Color Transforms

```javascript
gsap.to(shape, {
  easel: {
    // Tint
    tint: "#FF0000",
    tintAmount: 0.5,

    // Brightness
    exposure: 2,        // 1 = normal

    // Saturation
    saturation: 0       // 0 = grayscale
  },
  duration: 1
});
```

## Adobe Animate Export

```javascript
// In Animate timeline or actions
var root = this;

gsap.to(root.myMovieClip, {
  easel: {
    x: 300,
    y: 200,
    rotation: 360
  },
  duration: 2
});
```

## Timeline Control

```javascript
// Control Animate MovieClip timeline
gsap.to(movieClip, {
  easel: { currentFrame: 30 },
  duration: 2,
  ease: "none"
});
```

---

## Natural Language Mapping

| User Says | Implementation |
|-----------|---------------|
| "pixi sprite animation" | PixiPlugin with pixi:{} |
| "canvas game animation" | PixiPlugin |
| "animate cc export" | EaselPlugin |
| "createjs animation" | EaselPlugin |
| "webgl graphics" | PixiPlugin |
| "sprite tint/color" | pixi: { tint, colorize } |
| "canvas grayscale" | pixi: { saturation: 0 } |

## Performance Tips

1. **Batch updates** - Animate multiple properties together
2. **Use ticker** - GSAP ticker syncs with PIXI/Easel render loop
3. **Limit filters** - ColorMatrix filters have GPU cost
4. **Pool sprites** - Reuse sprites instead of creating new ones
5. **Use pixi/easel property** - More efficient than separate tweens

## Complete Pixi Example

```javascript
import * as PIXI from "pixi.js";
import { gsap } from "gsap";
import { PixiPlugin } from "gsap/PixiPlugin";

gsap.registerPlugin(PixiPlugin);
PixiPlugin.registerPIXI(PIXI);

// Create app
const app = new PIXI.Application({
  width: 800,
  height: 600,
  backgroundColor: 0x1099bb
});
document.body.appendChild(app.view);

// Create sprite
const sprite = PIXI.Sprite.from("bunny.png");
sprite.anchor.set(0.5);
sprite.x = 400;
sprite.y = 300;
app.stage.addChild(sprite);

// Animate
gsap.to(sprite, {
  pixi: {
    x: 600,
    y: 400,
    rotation: 720,
    scale: 2,
    tint: "#FF6600"
  },
  duration: 3,
  ease: "elastic.out(1, 0.3)",
  repeat: -1,
  yoyo: true
});
```

## PIXI Properties Reference

| Property | Description | Range |
|----------|-------------|-------|
| x, y | Position | pixels |
| scaleX, scaleY, scale | Scale | 1 = 100% |
| rotation | Rotation | degrees |
| skewX, skewY | Skew | degrees |
| alpha | Opacity | 0-1 |
| tint | Color tint | CSS color |
| saturation | Color saturation | 0-1 |
| brightness | Brightness | 1 = normal |
| contrast | Contrast | 1 = normal |
| hue | Hue shift | degrees |
| colorize | Colorize tint | CSS color |
| colorizeAmount | Colorize strength | 0-1 |
