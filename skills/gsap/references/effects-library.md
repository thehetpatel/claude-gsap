# GSAP Effects Library

Quick-reference library of common animation effects.

## Entrance Effects

### Fade In
```javascript
gsap.from(el, {
  autoAlpha: 0,
  duration: 0.6,
  ease: "power2.out"
});
```

### Fade Up
```javascript
gsap.from(el, {
  y: 50,
  autoAlpha: 0,
  duration: 0.8,
  ease: "power3.out"
});
```

### Slide In Left
```javascript
gsap.from(el, {
  x: -100,
  autoAlpha: 0,
  duration: 0.6,
  ease: "power3.out"
});
```

### Slide In Right
```javascript
gsap.from(el, {
  x: 100,
  autoAlpha: 0,
  duration: 0.6,
  ease: "power3.out"
});
```

### Scale In
```javascript
gsap.from(el, {
  scale: 0,
  autoAlpha: 0,
  duration: 0.5,
  ease: "back.out(1.7)"
});
```

### Pop In (Elastic)
```javascript
gsap.from(el, {
  scale: 0,
  autoAlpha: 0,
  duration: 0.8,
  ease: "elastic.out(1, 0.5)"
});
```

### Bounce In
```javascript
gsap.from(el, {
  y: -100,
  autoAlpha: 0,
  duration: 1,
  ease: "bounce.out"
});
```

### Rotate In
```javascript
gsap.from(el, {
  rotation: -180,
  scale: 0,
  autoAlpha: 0,
  duration: 0.8,
  ease: "back.out(1.7)"
});
```

### Flip In (3D)
```javascript
gsap.from(el, {
  rotationY: 90,
  autoAlpha: 0,
  duration: 0.8,
  ease: "power3.out",
  transformPerspective: 1000
});
```

### Blur In
```javascript
gsap.from(el, {
  autoAlpha: 0,
  filter: "blur(20px)",
  duration: 0.8,
  ease: "power2.out"
});
```

## Exit Effects

### Fade Out
```javascript
gsap.to(el, {
  autoAlpha: 0,
  duration: 0.4,
  ease: "power2.in"
});
```

### Slide Out Left
```javascript
gsap.to(el, {
  x: -100,
  autoAlpha: 0,
  duration: 0.4,
  ease: "power2.in"
});
```

### Scale Out
```javascript
gsap.to(el, {
  scale: 0,
  autoAlpha: 0,
  duration: 0.4,
  ease: "power2.in"
});
```

### Fly Out
```javascript
gsap.to(el, {
  y: -200,
  autoAlpha: 0,
  duration: 0.6,
  ease: "power3.in"
});
```

## Attention Effects

### Pulse
```javascript
gsap.to(el, {
  scale: 1.1,
  duration: 0.3,
  repeat: 2,
  yoyo: true,
  ease: "power2.inOut"
});
```

### Heartbeat
```javascript
gsap.timeline({ repeat: -1 })
  .to(el, { scale: 1.15, duration: 0.15, ease: "power2.out" })
  .to(el, { scale: 1, duration: 0.15, ease: "power2.in" })
  .to(el, { scale: 1.1, duration: 0.15, ease: "power2.out" })
  .to(el, { scale: 1, duration: 0.5, ease: "power2.in" });
```

### Shake
```javascript
gsap.to(el, {
  x: 10,
  duration: 0.05,
  repeat: 5,
  yoyo: true,
  ease: "power1.inOut"
});
```

### Wobble
```javascript
gsap.to(el, {
  rotation: 15,
  duration: 0.15,
  repeat: 5,
  yoyo: true,
  ease: "sine.inOut"
});
```

### Jello
```javascript
gsap.timeline()
  .to(el, { skewX: 12, skewY: 12, duration: 0.1 })
  .to(el, { skewX: -10, skewY: -10, duration: 0.1 })
  .to(el, { skewX: 6, skewY: 6, duration: 0.1 })
  .to(el, { skewX: -4, skewY: -4, duration: 0.1 })
  .to(el, { skewX: 0, skewY: 0, duration: 0.1 });
```

### Flash
```javascript
gsap.to(el, {
  autoAlpha: 0,
  duration: 0.1,
  repeat: 3,
  yoyo: true
});
```

### Rubber Band
```javascript
gsap.timeline()
  .to(el, { scaleX: 1.25, scaleY: 0.75, duration: 0.1 })
  .to(el, { scaleX: 0.75, scaleY: 1.25, duration: 0.1 })
  .to(el, { scaleX: 1.15, scaleY: 0.85, duration: 0.1 })
  .to(el, { scaleX: 0.95, scaleY: 1.05, duration: 0.1 })
  .to(el, { scaleX: 1, scaleY: 1, duration: 0.1 });
```

### Swing
```javascript
gsap.to(el, {
  rotation: 15,
  transformOrigin: "top center",
  duration: 0.4,
  ease: "power2.inOut",
  repeat: 3,
  yoyo: true
});
```

### Tada
```javascript
gsap.timeline()
  .to(el, { scale: 0.9, rotation: -3, duration: 0.1 })
  .to(el, { scale: 1.1, rotation: 3, duration: 0.1 })
  .to(el, { rotation: -3, duration: 0.1 })
  .to(el, { rotation: 3, duration: 0.1 })
  .to(el, { rotation: -3, duration: 0.1 })
  .to(el, { scale: 1, rotation: 0, duration: 0.1 });
```

## Hover Effects

### Lift
```javascript
// On hover
gsap.to(el, {
  y: -10,
  boxShadow: "0 20px 40px rgba(0,0,0,0.2)",
  duration: 0.3,
  ease: "power2.out"
});

// On leave
gsap.to(el, {
  y: 0,
  boxShadow: "0 5px 15px rgba(0,0,0,0.1)",
  duration: 0.3,
  ease: "power2.out"
});
```

### Scale Hover
```javascript
gsap.to(el, {
  scale: 1.05,
  duration: 0.3,
  ease: "power2.out"
});
```

### Tilt (3D)
```javascript
el.addEventListener("mousemove", (e) => {
  const rect = el.getBoundingClientRect();
  const x = e.clientX - rect.left - rect.width / 2;
  const y = e.clientY - rect.top - rect.height / 2;

  gsap.to(el, {
    rotationY: x / 10,
    rotationX: -y / 10,
    transformPerspective: 500,
    duration: 0.5,
    ease: "power2.out"
  });
});
```

### Magnetic
```javascript
el.addEventListener("mousemove", (e) => {
  const rect = el.getBoundingClientRect();
  const x = e.clientX - rect.left - rect.width / 2;
  const y = e.clientY - rect.top - rect.height / 2;

  gsap.to(el, {
    x: x * 0.3,
    y: y * 0.3,
    duration: 0.5,
    ease: "power2.out"
  });
});
```

## Stagger Effects

### Cascade
```javascript
gsap.from(".item", {
  y: 100,
  autoAlpha: 0,
  duration: 0.6,
  stagger: 0.1,
  ease: "power3.out"
});
```

### Grid Reveal
```javascript
gsap.from(".grid-item", {
  scale: 0,
  autoAlpha: 0,
  duration: 0.5,
  stagger: {
    grid: "auto",
    from: "center",
    amount: 1
  },
  ease: "back.out(1.7)"
});
```

### Wave
```javascript
gsap.from(".item", {
  y: 30,
  autoAlpha: 0,
  duration: 0.5,
  stagger: {
    each: 0.1,
    from: "start",
    ease: "sine.inOut"
  }
});
```

### Random
```javascript
gsap.from(".item", {
  y: 50,
  autoAlpha: 0,
  duration: 0.5,
  stagger: {
    each: 0.1,
    from: "random"
  }
});
```

## Background Effects

### Color Transition
```javascript
gsap.to(el, {
  backgroundColor: "#ff0000",
  duration: 0.5,
  ease: "power2.out"
});
```

### Gradient Shift
```javascript
// Using CSS custom properties
gsap.to(el, {
  "--gradient-start": "#ff0000",
  "--gradient-end": "#00ff00",
  duration: 1
});
```

## Loading Effects

### Spinner
```javascript
gsap.to(".spinner", {
  rotation: 360,
  duration: 1,
  repeat: -1,
  ease: "none"
});
```

### Progress Bar
```javascript
gsap.to(".progress-bar", {
  scaleX: 1,
  transformOrigin: "left",
  duration: 2,
  ease: "power2.out"
});
```

### Dots Loading
```javascript
gsap.to(".dot", {
  y: -20,
  duration: 0.4,
  stagger: {
    each: 0.15,
    repeat: -1,
    yoyo: true
  },
  ease: "power2.inOut"
});
```

## Utility Functions

### Register Custom Effects
```javascript
gsap.registerEffect({
  name: "fadeSlideUp",
  effect: (targets, config) => {
    return gsap.from(targets, {
      duration: config.duration,
      y: config.distance,
      autoAlpha: 0,
      ease: "power3.out"
    });
  },
  defaults: { duration: 0.8, distance: 100 },
  extendTimeline: true
});

// Usage
gsap.effects.fadeSlideUp(".element");
```

### Quick Setter
```javascript
const xSetter = gsap.quickSetter(".element", "x", "px");
const ySetter = gsap.quickSetter(".element", "y", "px");

window.addEventListener("mousemove", (e) => {
  xSetter(e.clientX);
  ySetter(e.clientY);
});
```
