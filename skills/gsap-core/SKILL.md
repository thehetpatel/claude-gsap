---
name: gsap-core
description: Master GSAP core features - context, matchMedia, registerEffect, ticker, staggers, and built-in plugins
version: 1.0.0
argument-hint: "[core feature name or use case]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP Core Features

Advanced core functionality for professional GSAP usage.

## Built-in Plugins

These are auto-included in GSAP core (no registration needed):
- **CSSPlugin** - CSS property animation (automatic)
- **AttrPlugin** - HTML/SVG attribute animation
- **EndArrayPlugin** - Array value interpolation
- **SnapPlugin** - Value snapping
- **RoundPropsPlugin** - Integer rounding

See `references/builtin-plugins.md` for detailed usage.

## gsap.context() - Scoped Cleanup

Collect animations for easy cleanup, essential for React/Vue.

### Basic Usage
```javascript
const ctx = gsap.context(() => {
  gsap.to(".box", { x: 100 });
  gsap.to(".circle", { rotation: 360 });
});

// Later: revert all animations at once
ctx.revert();
```

### Scoped Selectors
```javascript
// Selectors only match descendants of scope
const ctx = gsap.context(() => {
  gsap.to(".box", { x: 100 });  // Only .box inside #container
}, "#container");

// Or with ref
const ctx = gsap.context(() => {
  gsap.to(".box", { x: 100 });
}, containerRef.current);
```

### React Pattern
```jsx
import { useGSAP } from "@gsap/react";

function Component() {
  const container = useRef();

  useGSAP(() => {
    gsap.to(".box", { x: 100 });
  }, { scope: container });

  return <div ref={container}>...</div>;
}
```

### Context Safe Functions
```javascript
const ctx = gsap.context(() => {
  // Initial animations...
});

// For event handlers, use contextSafe
const handleClick = ctx.add(() => {
  gsap.to(".box", { scale: 1.5 });
});

button.addEventListener("click", handleClick);
```

---

## gsap.matchMedia() - Responsive Animations

Different animations for different breakpoints.

### Basic Usage
```javascript
const mm = gsap.matchMedia();

mm.add("(min-width: 800px)", () => {
  // Desktop animations
  gsap.to(".hero", { x: 200 });

  return () => {
    // Cleanup when breakpoint no longer matches
  };
});

mm.add("(max-width: 799px)", () => {
  // Mobile animations
  gsap.to(".hero", { y: 100 });
});
```

### Named Conditions
```javascript
mm.add({
  isDesktop: "(min-width: 1024px)",
  isTablet: "(min-width: 768px) and (max-width: 1023px)",
  isMobile: "(max-width: 767px)",
  reduceMotion: "(prefers-reduced-motion: reduce)"
}, (context) => {
  const { isDesktop, isTablet, isMobile, reduceMotion } = context.conditions;

  if (reduceMotion) {
    // No animations for reduced motion
    return;
  }

  if (isDesktop) {
    gsap.to(".hero", { x: 200, rotation: 10 });
  } else if (isTablet) {
    gsap.to(".hero", { x: 100 });
  } else if (isMobile) {
    gsap.to(".hero", { y: 50 });
  }
});
```

### With ScrollTrigger
```javascript
mm.add("(min-width: 800px)", () => {
  gsap.to(".panel", {
    x: 500,
    scrollTrigger: {
      trigger: ".panel",
      start: "top center",
      scrub: true
    }
  });
  // ScrollTrigger auto-reverts when breakpoint changes
});
```

### Save Styles
```javascript
// Prevent inline style contamination between breakpoints
ScrollTrigger.saveStyles(".animated-element");

mm.add("(min-width: 800px)", () => {
  gsap.to(".animated-element", { x: 100 });
});
```

---

## gsap.registerEffect() - Reusable Effects

Create custom, reusable animation effects.

### Basic Effect
```javascript
gsap.registerEffect({
  name: "fade",
  effect: (targets, config) => {
    return gsap.to(targets, {
      opacity: config.opacity,
      duration: config.duration,
      stagger: config.stagger
    });
  },
  defaults: { duration: 1, opacity: 0, stagger: 0.1 }
});

// Use effect
gsap.effects.fade(".boxes");
gsap.effects.fade(".items", { duration: 2, opacity: 0.5 });
```

### Timeline-Chainable Effect
```javascript
gsap.registerEffect({
  name: "slideIn",
  effect: (targets, config) => {
    return gsap.from(targets, {
      x: config.direction === "left" ? -100 : 100,
      opacity: 0,
      duration: config.duration,
      stagger: config.stagger
    });
  },
  defaults: { duration: 0.5, stagger: 0.1, direction: "left" },
  extendTimeline: true  // Enables tl.slideIn()
});

// Use on timeline
const tl = gsap.timeline();
tl.slideIn(".cards")
  .slideIn(".buttons", { direction: "right" }, "-=0.3");
```

### Effect Library Pattern
```javascript
// effects/bounce.js
export const bounceEffect = {
  name: "bounce",
  effect: (targets, config) => {
    return gsap.from(targets, {
      y: -100,
      opacity: 0,
      ease: "bounce.out",
      duration: config.duration,
      stagger: config.stagger
    });
  },
  defaults: { duration: 1, stagger: 0.1 },
  extendTimeline: true
};

// effects/index.js
import { bounceEffect } from "./bounce";
import { fadeEffect } from "./fade";

export const registerAllEffects = () => {
  [bounceEffect, fadeEffect].forEach(effect => {
    gsap.registerEffect(effect);
  });
};
```

---

## gsap.ticker - Animation Loop

Access GSAP's internal requestAnimationFrame loop.

### Add Listener
```javascript
gsap.ticker.add((time, deltaTime, frame) => {
  // time: total elapsed time in seconds
  // deltaTime: ms since last tick
  // frame: frame number

  // Custom per-frame logic
  element.rotation += 0.1;
});
```

### Remove Listener
```javascript
const update = () => {
  // ...
};

gsap.ticker.add(update);
gsap.ticker.remove(update);
```

### Frame Rate Control
```javascript
// Limit to 30fps
gsap.ticker.fps(30);

// Reset to default (60fps/requestAnimationFrame)
gsap.ticker.fps(-1);
```

### Lag Smoothing
```javascript
// Adjust lag smoothing
gsap.ticker.lagSmoothing(500, 33);
// If > 500ms between ticks, jump 33ms instead of actual elapsed

// Disable lag smoothing
gsap.ticker.lagSmoothing(0);
```

### Delta Ratio
```javascript
gsap.ticker.add(() => {
  // Adjust for frame rate variations
  const speed = 5 * gsap.ticker.deltaRatio();
  object.x += speed;
});
```

### Manual Stepping
```javascript
// Disable auto-ticking (for testing/video export)
gsap.ticker.sleep();

// Manual tick
gsap.ticker.tick();

// Resume auto-ticking
gsap.ticker.wake();
```

---

## Advanced Staggers

Complex stagger configurations for stunning effects.

### Basic Stagger
```javascript
gsap.to(".box", {
  y: 100,
  stagger: 0.1  // 0.1s delay between each
});
```

### Stagger Object
```javascript
gsap.to(".box", {
  y: 100,
  stagger: {
    each: 0.1,           // Time between each
    // OR
    amount: 1,           // Total stagger time distributed

    from: "start",       // "start", "end", "center", "edges", "random"
    grid: "auto",        // Auto-detect grid or [rows, cols]
    axis: "x",           // "x", "y", or null (both)
    ease: "power2.in"    // Ease the stagger timing
  }
});
```

### Grid Stagger
```javascript
// 4x4 grid animation from center
gsap.from(".grid-item", {
  scale: 0,
  opacity: 0,
  stagger: {
    amount: 1,
    from: "center",
    grid: [4, 4],  // or "auto"
    ease: "power2"
  }
});
```

### Directional Staggers
```javascript
// From start (default)
stagger: { from: "start" }  // First to last

// From end
stagger: { from: "end" }    // Last to first

// From center
stagger: { from: "center" } // Center outward

// From edges
stagger: { from: "edges" }  // Outside to center

// Random
stagger: { from: "random" } // Random order

// From specific index
stagger: { from: 5 }        // From 6th element outward
```

### Stagger Function
```javascript
gsap.to(".box", {
  y: 100,
  stagger: (index, target, list) => {
    // Custom delay logic
    return index * 0.1 + Math.random() * 0.2;
  }
});
```

### Axis-Based Grid Stagger
```javascript
// Horizontal wave
gsap.to(".grid-item", {
  y: 20,
  stagger: {
    each: 0.05,
    from: "start",
    grid: "auto",
    axis: "x"  // Stagger by column only
  }
});

// Vertical cascade
gsap.to(".grid-item", {
  x: 20,
  stagger: {
    each: 0.05,
    from: "start",
    grid: "auto",
    axis: "y"  // Stagger by row only
  }
});
```

### Repeat with Stagger
```javascript
gsap.to(".box", {
  y: 50,
  duration: 0.3,
  stagger: {
    each: 0.1,
    repeat: -1,
    yoyo: true
  }
});
```

---

## ModifiersPlugin (Built-in)

Modify values before they're applied.

### Wrap Values
```javascript
gsap.to(".box", {
  x: 500,
  duration: 5,
  repeat: -1,
  ease: "none",
  modifiers: {
    x: gsap.utils.wrap(0, 300)  // Wrap x between 0-300
  }
});
```

### Snap Values
```javascript
gsap.to(".slider", {
  x: 1000,
  modifiers: {
    x: gsap.utils.snap(50)  // Snap to nearest 50
  }
});
```

### Custom Modifier
```javascript
gsap.to(".box", {
  x: 1000,
  modifiers: {
    x: (x) => {
      // Round to integers
      return Math.round(x) + "px";
    }
  }
});
```

### Circular Motion
```javascript
gsap.to(".planet", {
  rotation: 360,
  duration: 5,
  repeat: -1,
  ease: "none",
  modifiers: {
    x: (x, target) => Math.cos(target.rotation * Math.PI / 180) * 100,
    y: (y, target) => Math.sin(target.rotation * Math.PI / 180) * 100
  }
});
```

---

## Quick Reference

| Feature | Purpose |
|---------|---------|
| `gsap.context()` | Scope & cleanup animations |
| `gsap.matchMedia()` | Responsive breakpoints |
| `gsap.registerEffect()` | Custom reusable effects |
| `gsap.ticker` | Animation loop access |
| `stagger` | Sequential element animation |
| `modifiers` | Transform values on-the-fly |
