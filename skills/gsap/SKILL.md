---
name: gsap
description: Generate GSAP animations from natural language descriptions
version: 1.0.0
argument-hint: "[animation description]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP Animation Generator

Transform natural language descriptions into production-ready GSAP animation code.

## Plugin Ecosystem

> 🎉 **ALL GSAP PLUGINS ARE 100% FREE** (since Webflow's 2024 acquisition)

**See `references/plugin-master-list.md` for the complete official plugin list.**

### Quick Plugin Count
| Category | Count |
|----------|-------|
| Core (auto-included) | 6 |
| Scroll | 4 |
| Text | 3 |
| SVG & Motion | 4 |
| Layout | 1 |
| Interaction & Physics | 4 |
| Easing | 4 |
| Rendering | 2 |
| Development | 2 |
| **Total Active Plugins** | **30** |

### Plugin Categories
- **Core**: CSSPlugin, AttrPlugin, ModifiersPlugin, SnapPlugin, RoundPropsPlugin, EndArrayPlugin
- **Scroll**: ScrollTrigger, ScrollToPlugin, ScrollSmoother, Observer
- **Text**: TextPlugin, SplitText, ScrambleTextPlugin
- **SVG**: MotionPathPlugin, MorphSVGPlugin, DrawSVGPlugin, MotionPathHelper
- **Layout**: Flip
- **Physics**: Draggable, InertiaPlugin, Physics2DPlugin, PhysicsPropsPlugin
- **Easing**: EasePack (SlowMo, RoughEase, ExpoScaleEase), CustomEase, CustomBounce, CustomWiggle
- **Rendering**: PixiPlugin, EaselPlugin
- **Dev**: GSDevTools, CSSRulePlugin

## Quick Reference

### Basic Methods
| Method | Use Case |
|--------|----------|
| `gsap.to()` | Animate TO specified values |
| `gsap.from()` | Animate FROM specified values |
| `gsap.fromTo()` | Animate FROM one set TO another |
| `gsap.set()` | Instantly set values (no animation) |

### Essential Properties
| Property | Description | GPU-Accelerated |
|----------|-------------|-----------------|
| `x`, `y` | Translation | Yes |
| `rotation` | Rotate in degrees | Yes |
| `scale`, `scaleX`, `scaleY` | Scaling | Yes |
| `autoAlpha` | Opacity + visibility | Yes |
| `duration` | Animation length (seconds) | - |
| `delay` | Wait before starting | - |
| `ease` | Easing function | - |
| `stagger` | Delay between elements | - |

## Natural Language Mapping

### Direction Words
| User Says | GSAP Property |
|-----------|---------------|
| "from left" / "from the left" | `x: -100` (with `from()`) |
| "from right" | `x: 100` (with `from()`) |
| "from above" / "from top" | `y: -100` (with `from()`) |
| "from below" / "from bottom" | `y: 100` (with `from()`) |
| "to the left" | `x: -100` (with `to()`) |
| "to the right" | `x: 100` (with `to()`) |

### Effect Words
| User Says | GSAP Code |
|-----------|-----------|
| "fade in" | `autoAlpha: 0` (with `from()`) |
| "fade out" | `autoAlpha: 0` (with `to()`) |
| "slide in" | Direction + `autoAlpha: 0` |
| "zoom in" / "scale up" | `scale: 0` (with `from()`) |
| "zoom out" / "scale down" | `scale: 0` (with `to()`) |
| "spin" / "rotate" | `rotation: 360` |
| "bounce" | `ease: "bounce.out"` |
| "elastic" | `ease: "elastic.out(1, 0.3)"` |
| "smooth" | `ease: "power2.out"` |
| "snap" / "quick" | `ease: "power4.out"` |

### Timing Words
| User Says | GSAP Property |
|-----------|---------------|
| "slowly" / "slow" | `duration: 1.5` |
| "quickly" / "fast" | `duration: 0.3` |
| "instantly" | `duration: 0` |
| "after X seconds" | `delay: X` |
| "stagger" / "one by one" | `stagger: 0.1` |

### Scroll Words (routes to /gsap-scroll)
| User Says | Action |
|-----------|--------|
| "on scroll" / "when scrolling" | Use ScrollTrigger |
| "parallax" | ScrollTrigger with scrub |
| "pin" / "sticky" | ScrollTrigger with pin |
| "reveal on scroll" | ScrollTrigger with toggleActions |

### Text Words (routes to /gsap-text)
| User Says | Action |
|-----------|--------|
| "typewriter" | SplitText + stagger |
| "letter by letter" | SplitText chars |
| "word by word" | SplitText words |
| "line by line" | SplitText lines |

## Code Generation Guidelines

### 1. Always Use GPU-Accelerated Properties
```javascript
// CORRECT
gsap.to(el, { x: 100, y: 50, rotation: 45 });

// AVOID
gsap.to(el, { left: "100px", top: "50px", transform: "rotate(45deg)" });
```

### 2. Use autoAlpha for Fades
```javascript
// CORRECT - handles visibility automatically
gsap.from(el, { autoAlpha: 0 });

// AVOID - element still takes up space when invisible
gsap.from(el, { opacity: 0 });
```

### 3. Register Plugins
```javascript
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

gsap.registerPlugin(ScrollTrigger);
```

### 4. Include Cleanup for Frameworks
```javascript
// React with useGSAP
useGSAP(() => {
  gsap.from(".element", { autoAlpha: 0 });
}, { scope: containerRef });

// Vue with context
onMounted(() => {
  ctx = gsap.context(() => {
    gsap.from(".element", { autoAlpha: 0 });
  });
});
onUnmounted(() => ctx.revert());
```

## Sub-Skill Routing

Route to specialized skills based on keywords:

| Keywords | Route To |
|----------|----------|
| scroll, pin, parallax, scrub | `/gsap-scroll` |
| timeline, sequence, then, after | `/gsap-timeline` |
| text, typewriter, letter, word, split | `/gsap-text` |
| svg, path, draw, morph | `/gsap-svg` |
| 3d, flip, perspective, rotate3d | `/gsap-3d` |
| effect, preset, template | `/gsap-effects` |
| optimize, performance, improve | `/gsap-optimize` |
| react, vue, nextjs, convert | `/gsap-convert` |

## Example Outputs

### "Fade in hero section from below"
```javascript
gsap.from(".hero", {
  y: 100,
  autoAlpha: 0,
  duration: 1,
  ease: "power3.out"
});
```

### "Bounce in cards one by one"
```javascript
gsap.from(".card", {
  scale: 0,
  autoAlpha: 0,
  duration: 0.6,
  ease: "back.out(1.7)",
  stagger: 0.15
});
```

### "Rotate logo 360 degrees smoothly"
```javascript
gsap.to(".logo", {
  rotation: 360,
  duration: 2,
  ease: "power2.inOut"
});
```

## Accessibility

When generating animations, consider adding reduced motion support:

```javascript
const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

if (!prefersReducedMotion) {
  gsap.from(".element", {
    y: 100,
    autoAlpha: 0,
    duration: 1
  });
} else {
  gsap.set(".element", { autoAlpha: 1 });
}
```
