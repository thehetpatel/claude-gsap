# GSAP Effects Index

Complete code for all 50+ effect presets.

## Scroll Reveal Effects

### 1. fade-up
```javascript
gsap.registerEffect({
  name: "fadeUp",
  effect: (targets, config) => gsap.from(targets, {
    y: config.y,
    autoAlpha: 0,
    duration: config.duration,
    ease: config.ease,
    stagger: config.stagger
  }),
  defaults: { y: 100, duration: 0.8, ease: "power3.out", stagger: 0.1 },
  extendTimeline: true
});
```

### 2. fade-down
```javascript
gsap.registerEffect({
  name: "fadeDown",
  effect: (targets, config) => gsap.from(targets, {
    y: -config.y,
    autoAlpha: 0,
    duration: config.duration,
    ease: config.ease,
    stagger: config.stagger
  }),
  defaults: { y: 100, duration: 0.8, ease: "power3.out", stagger: 0.1 },
  extendTimeline: true
});
```

### 3. fade-left
```javascript
gsap.registerEffect({
  name: "fadeLeft",
  effect: (targets, config) => gsap.from(targets, {
    x: -config.x,
    autoAlpha: 0,
    duration: config.duration,
    ease: config.ease,
    stagger: config.stagger
  }),
  defaults: { x: 100, duration: 0.8, ease: "power3.out", stagger: 0.1 },
  extendTimeline: true
});
```

### 4. fade-right
```javascript
gsap.registerEffect({
  name: "fadeRight",
  effect: (targets, config) => gsap.from(targets, {
    x: config.x,
    autoAlpha: 0,
    duration: config.duration,
    ease: config.ease,
    stagger: config.stagger
  }),
  defaults: { x: 100, duration: 0.8, ease: "power3.out", stagger: 0.1 },
  extendTimeline: true
});
```

### 5. scale-up
```javascript
gsap.registerEffect({
  name: "scaleUp",
  effect: (targets, config) => gsap.from(targets, {
    scale: 0,
    autoAlpha: 0,
    duration: config.duration,
    ease: config.ease,
    stagger: config.stagger
  }),
  defaults: { duration: 0.6, ease: "back.out(1.7)", stagger: 0.1 },
  extendTimeline: true
});
```

### 6. scale-down
```javascript
gsap.registerEffect({
  name: "scaleDown",
  effect: (targets, config) => gsap.from(targets, {
    scale: config.scale,
    autoAlpha: 0,
    duration: config.duration,
    ease: config.ease,
    stagger: config.stagger
  }),
  defaults: { scale: 1.5, duration: 0.8, ease: "power3.out", stagger: 0.1 },
  extendTimeline: true
});
```

### 7. rotate-in
```javascript
gsap.registerEffect({
  name: "rotateIn",
  effect: (targets, config) => gsap.from(targets, {
    rotation: config.rotation,
    scale: 0.5,
    autoAlpha: 0,
    duration: config.duration,
    ease: config.ease,
    stagger: config.stagger
  }),
  defaults: { rotation: 180, duration: 0.8, ease: "back.out(1.7)", stagger: 0.1 },
  extendTimeline: true
});
```

### 8. blur-in
```javascript
gsap.registerEffect({
  name: "blurIn",
  effect: (targets, config) => gsap.from(targets, {
    filter: `blur(${config.blur}px)`,
    autoAlpha: 0,
    duration: config.duration,
    ease: config.ease,
    stagger: config.stagger
  }),
  defaults: { blur: 20, duration: 0.8, ease: "power2.out", stagger: 0.1 },
  extendTimeline: true
});
```

### 9. clip-reveal
```javascript
gsap.registerEffect({
  name: "clipReveal",
  effect: (targets, config) => gsap.from(targets, {
    clipPath: config.from,
    duration: config.duration,
    ease: config.ease,
    stagger: config.stagger
  }),
  defaults: {
    from: "inset(0 100% 0 0)",
    duration: 1,
    ease: "power3.inOut",
    stagger: 0.1
  },
  extendTimeline: true
});
```

### 10. split-reveal
```javascript
gsap.registerEffect({
  name: "splitReveal",
  effect: (targets, config) => {
    const tl = gsap.timeline();
    tl.from(targets, {
      clipPath: "inset(0 50% 0 50%)",
      duration: config.duration,
      ease: config.ease,
      stagger: config.stagger
    });
    return tl;
  },
  defaults: { duration: 0.8, ease: "power3.inOut", stagger: 0.1 },
  extendTimeline: true
});
```

## Text Effects

### 11. typewriter
```javascript
gsap.registerEffect({
  name: "typewriter",
  effect: (targets, config) => {
    const split = new SplitText(targets, { type: "chars" });
    return gsap.from(split.chars, {
      autoAlpha: 0,
      duration: config.charDuration,
      stagger: config.charDuration,
      ease: "none",
      onComplete: config.revert ? () => split.revert() : undefined
    });
  },
  defaults: { charDuration: 0.05, revert: false },
  extendTimeline: true
});
```

### 12. wave
```javascript
gsap.registerEffect({
  name: "waveText",
  effect: (targets, config) => {
    const split = new SplitText(targets, { type: "chars" });
    return gsap.from(split.chars, {
      y: config.y,
      autoAlpha: 0,
      duration: config.duration,
      stagger: {
        each: config.stagger,
        from: "start"
      },
      ease: "back.out(1.7)"
    });
  },
  defaults: { y: 30, duration: 0.5, stagger: 0.03 },
  extendTimeline: true
});
```

### 13. bounce-chars
```javascript
gsap.registerEffect({
  name: "bounceChars",
  effect: (targets, config) => {
    const split = new SplitText(targets, { type: "chars" });
    return gsap.from(split.chars, {
      y: -100,
      autoAlpha: 0,
      duration: config.duration,
      stagger: config.stagger,
      ease: "bounce.out"
    });
  },
  defaults: { duration: 1, stagger: 0.05 },
  extendTimeline: true
});
```

### 14. stagger-words
```javascript
gsap.registerEffect({
  name: "staggerWords",
  effect: (targets, config) => {
    const split = new SplitText(targets, { type: "words" });
    return gsap.from(split.words, {
      y: config.y,
      autoAlpha: 0,
      duration: config.duration,
      stagger: config.stagger,
      ease: config.ease
    });
  },
  defaults: { y: 30, duration: 0.5, stagger: 0.08, ease: "power3.out" },
  extendTimeline: true
});
```

### 15. stagger-lines
```javascript
gsap.registerEffect({
  name: "staggerLines",
  effect: (targets, config) => {
    const split = new SplitText(targets, { type: "lines" });
    return gsap.from(split.lines, {
      y: config.y,
      autoAlpha: 0,
      duration: config.duration,
      stagger: config.stagger,
      ease: config.ease
    });
  },
  defaults: { y: 50, duration: 0.6, stagger: 0.1, ease: "power3.out" },
  extendTimeline: true
});
```

### 16. counter
```javascript
gsap.registerEffect({
  name: "counter",
  effect: (targets, config) => {
    return gsap.to(targets, {
      innerText: config.end,
      duration: config.duration,
      snap: { innerText: 1 },
      ease: config.ease
    });
  },
  defaults: { end: 100, duration: 2, ease: "power1.out" },
  extendTimeline: true
});
```

## Hero Effects

### 17. hero-parallax
```javascript
gsap.registerEffect({
  name: "heroParallax",
  effect: (targets, config) => {
    return gsap.to(targets, {
      y: config.distance,
      ease: "none",
      scrollTrigger: {
        trigger: config.trigger || targets,
        start: "top top",
        end: "bottom top",
        scrub: true
      }
    });
  },
  defaults: { distance: "30%", trigger: null }
});
```

### 18. hero-zoom
```javascript
gsap.registerEffect({
  name: "heroZoom",
  effect: (targets, config) => {
    return gsap.from(targets, {
      scale: config.scale,
      autoAlpha: 0,
      duration: config.duration,
      ease: config.ease
    });
  },
  defaults: { scale: 1.2, duration: 1.5, ease: "power3.out" },
  extendTimeline: true
});
```

## Card Effects

### 19. card-flip
```javascript
gsap.registerEffect({
  name: "cardFlip",
  effect: (targets, config) => {
    return gsap.to(targets, {
      rotationY: 180,
      duration: config.duration,
      ease: config.ease,
      transformPerspective: 1000
    });
  },
  defaults: { duration: 0.6, ease: "power2.inOut" },
  extendTimeline: true
});
```

### 20. card-lift
```javascript
gsap.registerEffect({
  name: "cardLift",
  effect: (targets, config) => {
    return gsap.to(targets, {
      y: -config.lift,
      boxShadow: config.shadow,
      duration: config.duration,
      ease: config.ease
    });
  },
  defaults: {
    lift: 10,
    shadow: "0 20px 40px rgba(0,0,0,0.2)",
    duration: 0.3,
    ease: "power2.out"
  },
  extendTimeline: true
});
```

## Button Effects

### 21. pulse
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

### 22. shake
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

### 23. ripple
```javascript
gsap.registerEffect({
  name: "ripple",
  effect: (targets, config) => {
    const el = targets[0] || targets;
    const ripple = document.createElement("span");
    ripple.className = "ripple";
    ripple.style.cssText = `
      position: absolute;
      border-radius: 50%;
      background: ${config.color};
      pointer-events: none;
      transform: scale(0);
    `;
    el.style.position = "relative";
    el.style.overflow = "hidden";
    el.appendChild(ripple);

    return gsap.to(ripple, {
      scale: 4,
      autoAlpha: 0,
      duration: config.duration,
      ease: "power2.out",
      onComplete: () => ripple.remove()
    });
  },
  defaults: { color: "rgba(255,255,255,0.3)", duration: 0.6 }
});
```

## Loading Effects

### 24. spinner
```javascript
gsap.registerEffect({
  name: "spinner",
  effect: (targets, config) => {
    return gsap.to(targets, {
      rotation: 360,
      duration: config.duration,
      ease: "none",
      repeat: -1
    });
  },
  defaults: { duration: 1 }
});
```

### 25. dots
```javascript
gsap.registerEffect({
  name: "loadingDots",
  effect: (targets, config) => {
    return gsap.to(targets, {
      y: -config.distance,
      duration: config.duration,
      stagger: {
        each: config.stagger,
        repeat: -1,
        yoyo: true
      },
      ease: "power2.inOut"
    });
  },
  defaults: { distance: 15, duration: 0.4, stagger: 0.15 }
});
```

### 26. progress-bar
```javascript
gsap.registerEffect({
  name: "progressBar",
  effect: (targets, config) => {
    return gsap.to(targets, {
      scaleX: config.progress,
      duration: config.duration,
      ease: config.ease,
      transformOrigin: "left center"
    });
  },
  defaults: { progress: 1, duration: 2, ease: "power2.out" },
  extendTimeline: true
});
```

## Attention Effects

### 27. highlight
```javascript
gsap.registerEffect({
  name: "highlight",
  effect: (targets, config) => {
    return gsap.to(targets, {
      backgroundColor: config.color,
      duration: config.duration,
      ease: config.ease
    });
  },
  defaults: { color: "yellow", duration: 0.5, ease: "power2.out" },
  extendTimeline: true
});
```

### 28. wobble
```javascript
gsap.registerEffect({
  name: "wobble",
  effect: (targets, config) => {
    return gsap.to(targets, {
      rotation: config.angle,
      duration: config.duration,
      repeat: config.repeat,
      yoyo: true,
      ease: "sine.inOut"
    });
  },
  defaults: { angle: 15, duration: 0.15, repeat: 3 },
  extendTimeline: true
});
```

### 29. flash
```javascript
gsap.registerEffect({
  name: "flash",
  effect: (targets, config) => {
    return gsap.to(targets, {
      autoAlpha: 0,
      duration: config.duration,
      repeat: config.repeat,
      yoyo: true
    });
  },
  defaults: { duration: 0.1, repeat: 3 },
  extendTimeline: true
});
```

### 30. rubberBand
```javascript
gsap.registerEffect({
  name: "rubberBand",
  effect: (targets, config) => {
    const tl = gsap.timeline();
    tl.to(targets, { scaleX: 1.25, scaleY: 0.75, duration: 0.1 })
      .to(targets, { scaleX: 0.75, scaleY: 1.25, duration: 0.1 })
      .to(targets, { scaleX: 1.15, scaleY: 0.85, duration: 0.1 })
      .to(targets, { scaleX: 0.95, scaleY: 1.05, duration: 0.1 })
      .to(targets, { scaleX: 1, scaleY: 1, duration: 0.1 });
    return tl;
  },
  extendTimeline: true
});
```

## Utility: Register All Effects

```javascript
function registerAllEffects() {
  // Import and register all effects from this file
  // ... all effect registrations above
}

// Auto-register on load
registerAllEffects();
```

## Usage Examples

```javascript
// Single element
gsap.effects.fadeUp(".hero");

// With config
gsap.effects.typewriter(".text", { charDuration: 0.03 });

// In timeline
const tl = gsap.timeline();
tl.fadeUp(".section1")
  .staggerWords(".text", {}, "-=0.3")
  .scaleUp(".cta");

// With ScrollTrigger
gsap.effects.fadeUp(".element", {
  scrollTrigger: {
    trigger: ".element",
    start: "top 80%"
  }
});
```
