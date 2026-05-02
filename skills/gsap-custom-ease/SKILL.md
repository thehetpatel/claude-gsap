---
name: gsap-custom-ease
description: Create custom easing curves with CustomEase, EasePack, CustomWiggle, CustomBounce
version: 1.0.0
argument-hint: "[custom easing description]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP Custom Easing Generator

Create unique easing curves beyond the built-in options.

## Easing Plugins Overview

| Plugin | Purpose | Contains |
|--------|---------|----------|
| **EasePack** | Special easing bundle | SlowMo, RoughEase, ExpoScaleEase |
| **CustomEase** | SVG path-based curves | Create any curve |
| **CustomWiggle** | Wiggle/shake easing | Configurable wiggles |
| **CustomBounce** | Bounce with squash | Realistic bounce |

## Quick Setup

```javascript
import { gsap } from "gsap";
import { CustomEase } from "gsap/CustomEase";
import { CustomWiggle } from "gsap/CustomWiggle";
import { CustomBounce } from "gsap/CustomBounce";
import { EasePack } from "gsap/EasePack"; // SlowMo, RoughEase, ExpoScaleEase

gsap.registerPlugin(CustomEase, CustomWiggle, CustomBounce, EasePack);
```

## CustomEase

### Create from SVG Path
```javascript
CustomEase.create("myEase", "M0,0 C0.25,0.1 0.25,1 1,1");

gsap.to(".box", {
  x: 100,
  ease: "myEase"
});
```

### Create from Cubic Bezier
```javascript
// Same as CSS cubic-bezier(0.68, -0.55, 0.265, 1.55)
CustomEase.create("backInOut", "M0,0 C0.68,-0.55 0.265,1.55 1,1");
```

### Get Ease Value
```javascript
const ease = CustomEase.create("test", "M0,0 C0.5,0 0.5,1 1,1");
const value = ease.getRatio(0.5);  // Get value at 50%
```

## EasePack Eases

The EasePack adds these special eases:

### RoughEase
```javascript
import { RoughEase } from "gsap/EasePack";

gsap.to(".box", {
  x: 100,
  ease: "rough({ strength: 1, points: 20, template: none, taper: none, randomize: true })"
});

// Or configure directly
RoughEase.ease.config({
  strength: 2,        // How far values deviate (0-5)
  points: 50,         // Number of random points
  template: "power2", // Base ease to apply roughness to
  taper: "both",      // "in", "out", "both", or "none"
  randomize: true,    // Randomize or keep consistent
  clamp: false        // Keep values in 0-1 range
});
```

### SlowMo
```javascript
import { SlowMo } from "gsap/EasePack";

gsap.to(".box", {
  x: 100,
  ease: "slow(0.7, 0.7, false)"
  // slow(linearRatio, power, yoyoMode)
});

// linearRatio: 0-1, how much of middle is linear
// power: strength of easing at ends
// yoyoMode: if true, it mirrors (in-out style)
```

### ExpoScaleEase
```javascript
import { ExpoScaleEase } from "gsap/EasePack";

// Good for zooming/scaling animations
gsap.to(".box", {
  scale: 10,
  ease: "expoScale(1, 10)"  // From scale 1 to 10
});
```

## CustomWiggle

Create wiggle/shake animations with precise control.

```javascript
CustomWiggle.create("myWiggle", {
  wiggles: 10,        // Number of wiggles
  type: "easeOut",    // "easeOut", "easeInOut", "uniform", "random"
  amplitudeEase: "power2"  // Ease for amplitude changes
});

gsap.to(".box", {
  rotation: 30,       // Max rotation
  ease: "myWiggle"
});
```

### Wiggle Types
| Type | Description |
|------|-------------|
| `"uniform"` | All wiggles same size |
| `"easeOut"` | Big wiggles then smaller |
| `"easeInOut"` | Small, big, small |
| `"random"` | Random amplitudes |

### Wiggle Examples
```javascript
// Shake effect
CustomWiggle.create("shake", { wiggles: 8, type: "easeOut" });
gsap.to(".error", { x: 10, ease: "shake" });

// Wobble effect
CustomWiggle.create("wobble", { wiggles: 5, type: "easeInOut" });
gsap.to(".jelly", { scaleX: 1.2, scaleY: 0.8, ease: "wobble" });

// Vibration
CustomWiggle.create("vibrate", { wiggles: 20, type: "uniform" });
gsap.to(".phone", { x: 2, ease: "vibrate", duration: 0.5 });
```

## CustomBounce

Create custom bounce effects.

```javascript
CustomBounce.create("myBounce", {
  strength: 0.6,      // Height of first bounce (0-1)
  endAtStart: false,  // End at original position
  squash: 0,          // Squash amount (0-1)
  squashID: "squash"  // ID for squash ease
});

gsap.to(".ball", {
  y: 300,
  ease: "myBounce",
  duration: 2
});
```

### Bounce with Squash
```javascript
CustomBounce.create("dropBounce", {
  strength: 0.7,
  squash: 3,
  squashID: "dropSquash"
});

// Apply bounce to y
gsap.to(".ball", {
  y: 300,
  ease: "dropBounce",
  duration: 2
});

// Apply squash to scaleX/scaleY
gsap.to(".ball", {
  scaleX: 1.3,
  scaleY: 0.7,
  ease: "dropSquash",
  duration: 2,
  transformOrigin: "center bottom"
});
```

## Natural Language Mapping

| User Says | Implementation |
|-----------|---------------|
| "custom curve" | CustomEase with SVG path |
| "rough/jittery" | RoughEase |
| "slow motion middle" | SlowMo |
| "wiggle/shake" | CustomWiggle |
| "custom bounce" | CustomBounce |
| "squash and stretch" | CustomBounce with squash |

## Common Patterns

### Smooth Steps
```javascript
// Smooth stepped animation
CustomEase.create("smoothSteps", `
  M0,0
  C0.1,0 0.1,0.2 0.2,0.2
  C0.3,0.2 0.3,0.4 0.4,0.4
  C0.5,0.4 0.5,0.6 0.6,0.6
  C0.7,0.6 0.7,0.8 0.8,0.8
  C0.9,0.8 0.9,1 1,1
`);
```

### Anticipation
```javascript
// Pull back then shoot forward
CustomEase.create("anticipate", "M0,0 C0.2,-0.2 0.3,-0.1 0.5,0.5 0.7,1.2 0.8,1 1,1");
```

### Overshoot & Settle
```javascript
// Go past target then settle back
CustomEase.create("overshoot", "M0,0 C0.4,0 0.5,1.3 0.7,1.1 0.85,0.95 1,1");
```

### Elastic Snap
```javascript
CustomEase.create("elasticSnap", `
  M0,0
  C0.2,0 0.3,1.2 0.4,1
  0.5,0.9 0.55,1.05 0.6,1
  0.65,0.98 0.7,1.01 0.75,1
  0.8,1 1,1 1,1
`);
```

### Heartbeat
```javascript
CustomEase.create("heartbeat", `
  M0,0
  C0.1,0 0.1,0.3 0.15,0.5
  0.2,0.7 0.2,0.2 0.3,0.2
  0.35,0.2 0.35,0.8 0.4,1
  0.45,1.2 0.45,0.4 0.55,0.4
  0.6,0.4 0.6,0.9 0.65,1
  0.7,1.1 0.75,1 1,1
`);
```

## Using with Animations

### Timeline with Custom Ease
```javascript
CustomEase.create("superBounce", "M0,0 C0.3,0 0.3,1.6 0.5,1 0.65,0.6 0.75,1.15 0.85,1 0.9,0.95 1,1 1,1");

const tl = gsap.timeline();
tl.to(".box", {
  y: 200,
  ease: "superBounce",
  duration: 1
});
```

### Attention Animation
```javascript
CustomWiggle.create("attention", {
  wiggles: 6,
  type: "easeOut"
});

function grabAttention(element) {
  gsap.fromTo(element,
    { rotation: 0 },
    { rotation: 20, ease: "attention", duration: 0.5 }
  );
}
```

### Drop Animation
```javascript
CustomBounce.create("drop", {
  strength: 0.5,
  squash: 2,
  squashID: "dropSquash"
});

function dropElement(element) {
  const tl = gsap.timeline();

  tl.from(element, {
      y: -200,
      ease: "drop",
      duration: 1
    })
    .from(element, {
      scaleX: 1.2,
      scaleY: 0.8,
      ease: "dropSquash",
      duration: 1,
      transformOrigin: "bottom center"
    }, 0);

  return tl;
}
```

## Visual Editor

GSAP provides a visual ease editor at:
https://gsap.com/docs/v3/Eases/CustomEase/

You can:
1. Draw curves visually
2. Copy the SVG path data
3. Use it in CustomEase.create()

## Tips

1. **Test your eases** - Use GSDevTools to slow down and inspect
2. **Keep paths simple** - Complex paths = larger file size
3. **Name meaningfully** - "bounce" not "ease1"
4. **Reuse eases** - Create once, use everywhere
5. **Consider timing** - Some eases look better with longer/shorter durations

## Exporting/Importing

```javascript
// Get the SVG path of a custom ease
const pathData = CustomEase.getSVGData("myEase");

// Create from existing ease
CustomEase.create("reversePower2", CustomEase.getSVGData("power2.in"));
```
