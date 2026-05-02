---
name: gsap-effects
description: Browse and apply 50+ GSAP effect presets
version: 1.0.0
argument-hint: "[effect category or name]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP Effects Library

Access 50+ ready-to-use animation effect presets.

## Effect Categories

1. **Scroll Reveals** - Entrance animations on scroll
2. **Text Effects** - Typography animations
3. **Hero Animations** - Landing page effects
4. **Card Effects** - Interactive card animations
5. **Button Effects** - CTA and hover animations
6. **Loading Effects** - Spinners and progress
7. **Transition Effects** - Page/section transitions
8. **Attention Effects** - Highlight and focus
9. **SVG Effects** - Path and shape animations
10. **3D Effects** - Perspective animations

## Usage

### Quick Apply
```
/gsap-effects fade-up
/gsap-effects typewriter
/gsap-effects card-flip
```

### List Effects
```
/gsap-effects list
/gsap-effects list scroll-reveals
/gsap-effects list text
```

## Registering Custom Effects

```javascript
gsap.registerEffect({
  name: "fadeUp",
  effect: (targets, config) => {
    return gsap.from(targets, {
      duration: config.duration,
      y: config.distance,
      autoAlpha: 0,
      ease: "power3.out",
      stagger: config.stagger
    });
  },
  defaults: { duration: 0.8, distance: 100, stagger: 0.1 },
  extendTimeline: true
});

// Usage
gsap.effects.fadeUp(".element");
gsap.effects.fadeUp(".element", { duration: 1.2, distance: 50 });

// In timeline
tl.fadeUp(".element", { duration: 0.8 }, "<");
```

## Effect Index

### Scroll Reveals (10)
| Effect | Description |
|--------|-------------|
| `fade-up` | Fade in from below |
| `fade-down` | Fade in from above |
| `fade-left` | Fade in from left |
| `fade-right` | Fade in from right |
| `scale-up` | Scale from 0 |
| `scale-down` | Scale from large |
| `rotate-in` | Rotate while fading |
| `blur-in` | Blur to clear |
| `clip-reveal` | Clip-path reveal |
| `split-reveal` | Split and reveal |

### Text Effects (10)
| Effect | Description |
|--------|-------------|
| `typewriter` | Character by character |
| `wave` | Wave animation |
| `bounce-chars` | Bouncy characters |
| `stagger-words` | Word by word |
| `stagger-lines` | Line by line |
| `scramble` | Text scramble |
| `highlight` | Background highlight |
| `underline-draw` | Draw underline |
| `gradient-text` | Color gradient |
| `counter` | Number counter |

### Hero Effects (8)
| Effect | Description |
|--------|-------------|
| `hero-parallax` | Parallax background |
| `hero-split` | Split screen reveal |
| `hero-zoom` | Zoom out reveal |
| `hero-mask` | Mask wipe |
| `hero-text-reveal` | Text reveal |
| `hero-stagger` | Staggered elements |
| `hero-3d` | 3D perspective |
| `hero-morph` | Shape morphing |

### Card Effects (8)
| Effect | Description |
|--------|-------------|
| `card-flip` | 3D flip |
| `card-tilt` | Tilt on hover |
| `card-lift` | Lift with shadow |
| `card-magnetic` | Magnetic follow |
| `card-stack` | Stacked cards |
| `card-expand` | Expand on click |
| `card-slide` | Slide reveal |
| `card-fold` | 3D fold |

### Button Effects (6)
| Effect | Description |
|--------|-------------|
| `btn-pulse` | Pulse animation |
| `btn-fill` | Fill on hover |
| `btn-slide` | Text slide |
| `btn-ripple` | Material ripple |
| `btn-shake` | Attention shake |
| `btn-glow` | Glow effect |

### Loading Effects (4)
| Effect | Description |
|--------|-------------|
| `loader-spinner` | Rotating spinner |
| `loader-dots` | Bouncing dots |
| `loader-bar` | Progress bar |
| `loader-pulse` | Pulsing circle |

### Transition Effects (4)
| Effect | Description |
|--------|-------------|
| `page-wipe` | Full page wipe |
| `page-fade` | Crossfade |
| `page-slide` | Slide transition |
| `page-zoom` | Zoom transition |

## Quick Effect Code

### fade-up
```javascript
gsap.registerEffect({
  name: "fadeUp",
  effect: (targets, config) => {
    return gsap.from(targets, {
      y: config.distance,
      autoAlpha: 0,
      duration: config.duration,
      ease: "power3.out",
      stagger: config.stagger
    });
  },
  defaults: { duration: 0.8, distance: 100, stagger: 0.1 },
  extendTimeline: true
});
```

### typewriter
```javascript
gsap.registerEffect({
  name: "typewriter",
  effect: (targets, config) => {
    const split = new SplitText(targets, { type: "chars" });
    return gsap.from(split.chars, {
      autoAlpha: 0,
      duration: config.speed,
      stagger: config.speed,
      ease: "none"
    });
  },
  defaults: { speed: 0.05 },
  extendTimeline: true
});
```

### card-flip
```javascript
gsap.registerEffect({
  name: "cardFlip",
  effect: (targets, config) => {
    return gsap.to(targets, {
      rotationY: 180,
      duration: config.duration,
      ease: "power2.inOut",
      transformPerspective: 1000
    });
  },
  defaults: { duration: 0.6 },
  extendTimeline: true
});
```

### pulse
```javascript
gsap.registerEffect({
  name: "pulse",
  effect: (targets, config) => {
    return gsap.to(targets, {
      scale: config.scale,
      duration: config.duration,
      repeat: config.repeat,
      yoyo: true,
      ease: "power2.inOut"
    });
  },
  defaults: { scale: 1.1, duration: 0.3, repeat: 2 },
  extendTimeline: true
});
```

### shake
```javascript
gsap.registerEffect({
  name: "shake",
  effect: (targets, config) => {
    return gsap.to(targets, {
      x: config.distance,
      duration: config.speed,
      repeat: config.repeat,
      yoyo: true,
      ease: "power1.inOut"
    });
  },
  defaults: { distance: 10, speed: 0.05, repeat: 5 },
  extendTimeline: true
});
```

## Using Effects with ScrollTrigger

```javascript
gsap.registerEffect({
  name: "scrollFadeUp",
  effect: (targets, config) => {
    return gsap.from(targets, {
      y: config.distance,
      autoAlpha: 0,
      duration: config.duration,
      ease: "power3.out",
      stagger: config.stagger,
      scrollTrigger: {
        trigger: targets,
        start: config.start,
        toggleActions: "play none none reverse"
      }
    });
  },
  defaults: {
    duration: 0.8,
    distance: 100,
    stagger: 0.1,
    start: "top 80%"
  }
});

// Usage
gsap.effects.scrollFadeUp(".card");
```

## Batch Effects

```javascript
// Apply same effect to multiple elements
function applyEffect(selector, effectName, config = {}) {
  const elements = gsap.utils.toArray(selector);
  elements.forEach(el => {
    gsap.effects[effectName](el, config);
  });
}

// Usage
applyEffect(".reveal", "fadeUp", { stagger: 0.15 });
```

## Effect Utilities

### Create Effect from Description
```javascript
function createRevealEffect(name, from) {
  gsap.registerEffect({
    name,
    effect: (targets, config) => {
      return gsap.from(targets, {
        ...from,
        duration: config.duration,
        ease: config.ease,
        stagger: config.stagger
      });
    },
    defaults: { duration: 0.8, ease: "power3.out", stagger: 0.1 },
    extendTimeline: true
  });
}

// Quick register
createRevealEffect("fadeLeft", { x: -100, autoAlpha: 0 });
createRevealEffect("fadeRight", { x: 100, autoAlpha: 0 });
createRevealEffect("scaleIn", { scale: 0, autoAlpha: 0 });
```

See `references/effects-index.md` for complete effect code.
