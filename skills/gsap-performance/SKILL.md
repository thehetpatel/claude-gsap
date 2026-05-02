---
name: gsap-performance
description: Optimize GSAP animations for maximum performance
version: 1.0.0
argument-hint: "[code to optimize or 'analyze']"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP Performance Optimizer

Analyze and optimize GSAP animations for better performance.

## Quick Performance Checklist

- [ ] Using GPU-accelerated properties (`x`, `y`, `scale`, `rotation`)
- [ ] Using `autoAlpha` instead of `opacity` alone
- [ ] Cleaning up animations in React/Vue
- [ ] Not animating layout properties (`width`, `height`, `top`, `left`)
- [ ] Using `will-change` sparingly and correctly
- [ ] Debouncing resize handlers
- [ ] Using `ScrollTrigger.batch()` for multiple elements
- [ ] Killing unused animations and ScrollTriggers

## GPU-Accelerated Properties

### Use These (Fast)
```javascript
// Transforms - GPU accelerated
gsap.to(el, {
  x: 100,           // translateX
  y: 50,            // translateY
  z: 20,            // translateZ (3D)
  scale: 1.5,       // scale
  scaleX: 1.2,
  scaleY: 0.8,
  rotation: 45,     // rotate
  rotationX: 30,    // 3D rotate
  rotationY: 60,
  skewX: 10,
  skewY: 5,
  autoAlpha: 0.5    // opacity + visibility
});
```

### Avoid These (Slow)
```javascript
// Layout properties - trigger reflow
gsap.to(el, {
  // AVOID
  width: 200,       // Use scaleX instead
  height: 150,      // Use scaleY instead
  top: 100,         // Use y instead
  left: 50,         // Use x instead
  right: 20,        // Use x instead
  bottom: 30,       // Use y instead
  padding: 20,      // Triggers layout
  margin: 10,       // Triggers layout
  borderWidth: 2    // Triggers layout
});
```

### Conversion Examples
```javascript
// BAD
gsap.to(el, { left: "100px", top: "50px" });

// GOOD
gsap.to(el, { x: 100, y: 50 });

// BAD - animating width
gsap.to(el, { width: "200px" });

// GOOD - scale from original size
gsap.to(el, { scaleX: 2, transformOrigin: "left center" });
```

## autoAlpha vs opacity

### Why autoAlpha is Better
```javascript
// autoAlpha = opacity + visibility
gsap.to(el, { autoAlpha: 0 });
// When 0: sets visibility: hidden (removes from accessibility tree)
// When > 0: sets visibility: visible

// Just opacity
gsap.to(el, { opacity: 0 });
// Element is invisible but still interactive and in accessibility tree
```

### Use Cases
```javascript
// Fading out completely - use autoAlpha
gsap.to(".modal", { autoAlpha: 0 }); // Hidden from screen readers

// Fading but still interactive - use opacity
gsap.to(".hint", { opacity: 0.5 }); // Still clickable
```

## ScrollTrigger Optimization

### Batch Processing
```javascript
// BAD - individual ScrollTriggers
document.querySelectorAll(".item").forEach(item => {
  gsap.from(item, {
    y: 100,
    scrollTrigger: { trigger: item }  // Creates many ScrollTriggers
  });
});

// GOOD - batch processing
ScrollTrigger.batch(".item", {
  onEnter: (batch) => gsap.from(batch, { y: 100, stagger: 0.1 }),
  start: "top 80%"
});
```

### Lazy Initialization
```javascript
// Initialize ScrollTriggers only when needed
const triggers = [];

function initSection(section) {
  const st = ScrollTrigger.create({
    trigger: section,
    // ...
  });
  triggers.push(st);
}

// Observe sections coming into view
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      initSection(entry.target);
      observer.unobserve(entry.target);
    }
  });
});

document.querySelectorAll(".section").forEach(s => observer.observe(s));
```

### Refresh Debouncing
```javascript
// Debounce ScrollTrigger refresh on resize
let resizeTimer;
window.addEventListener("resize", () => {
  clearTimeout(resizeTimer);
  resizeTimer = setTimeout(() => {
    ScrollTrigger.refresh();
  }, 250);
});
```

### Disable on Mobile (if needed)
```javascript
ScrollTrigger.matchMedia({
  "(min-width: 768px)": function() {
    // Desktop animations
    gsap.to(".element", {
      scrollTrigger: { /* ... */ }
    });
  },
  "(max-width: 767px)": function() {
    // Simpler or no animations on mobile
  }
});
```

## Memory Management

### Killing Animations
```javascript
// Kill specific animation
const tween = gsap.to(el, { x: 100 });
tween.kill();

// Kill all animations on element
gsap.killTweensOf(el);

// Kill all animations on selector
gsap.killTweensOf(".animated");

// Kill ScrollTrigger
const st = ScrollTrigger.create({ /* ... */ });
st.kill();

// Kill all ScrollTriggers
ScrollTrigger.getAll().forEach(st => st.kill());
```

### React Cleanup
```javascript
// With useGSAP (recommended)
import { useGSAP } from "@gsap/react";

function Component() {
  const containerRef = useRef();

  useGSAP(() => {
    gsap.to(".element", { x: 100 });
  }, { scope: containerRef }); // Auto cleanup

  return <div ref={containerRef}>...</div>;
}

// Manual cleanup
function Component() {
  useEffect(() => {
    const ctx = gsap.context(() => {
      gsap.to(".element", { x: 100 });
    });

    return () => ctx.revert(); // Cleanup
  }, []);
}
```

### Vue Cleanup
```javascript
let ctx;

onMounted(() => {
  ctx = gsap.context(() => {
    gsap.to(".element", { x: 100 });
  });
});

onUnmounted(() => {
  ctx.revert(); // Cleanup
});
```

## Reducing Repaints

### Use will-change Wisely
```css
/* Only on elements that will animate */
.will-animate {
  will-change: transform, opacity;
}

/* Remove after animation */
.animation-complete {
  will-change: auto;
}
```

```javascript
// Set before animation
gsap.set(el, { willChange: "transform" });

// Animate
gsap.to(el, {
  x: 100,
  onComplete: () => {
    gsap.set(el, { willChange: "auto" });
  }
});
```

### Avoid Forced Synchronous Layout
```javascript
// BAD - forces layout between read and write
elements.forEach(el => {
  const width = el.offsetWidth;  // Read
  el.style.width = width + 10 + "px";  // Write (forces layout)
});

// GOOD - batch reads then writes
const widths = elements.map(el => el.offsetWidth);  // All reads
elements.forEach((el, i) => {
  gsap.set(el, { width: widths[i] + 10 });  // All writes
});
```

### Use gsap.quickSetter for Frequent Updates
```javascript
// For mousemove or scroll handlers
const xSetter = gsap.quickSetter(".element", "x", "px");
const ySetter = gsap.quickSetter(".element", "y", "px");

document.addEventListener("mousemove", (e) => {
  xSetter(e.clientX);
  ySetter(e.clientY);
});
```

## Timeline Optimization

### Use Defaults
```javascript
// Instead of repeating properties
const tl = gsap.timeline({
  defaults: {
    duration: 0.5,
    ease: "power3.out"
  }
});

tl.from(".a", { x: -100 })  // Inherits defaults
  .from(".b", { y: 100 })   // Inherits defaults
  .from(".c", { scale: 0 }); // Inherits defaults
```

### Avoid Creating Many Timelines
```javascript
// BAD - creates timeline for each item
items.forEach(item => {
  gsap.timeline()
    .from(item, { autoAlpha: 0 })
    .to(item, { x: 100 });
});

// GOOD - single timeline with stagger
gsap.timeline()
  .from(items, { autoAlpha: 0, stagger: 0.1 })
  .to(items, { x: 100, stagger: 0.1 }, "-=0.5");
```

## Accessibility Performance

### Respect Reduced Motion
```javascript
const prefersReducedMotion = window.matchMedia(
  "(prefers-reduced-motion: reduce)"
).matches;

if (prefersReducedMotion) {
  // Skip animations or make them instant
  gsap.globalTimeline.timeScale(1000);
  // or
  gsap.config({ nullTargetWarn: false });
  gsap.set(".animated", { clearProps: "all" });
}
```

### Reduce Animation on Low-End Devices
```javascript
// Detect low-end device
const isLowEnd = navigator.hardwareConcurrency <= 4 ||
                 navigator.deviceMemory <= 4;

if (isLowEnd) {
  // Simpler animations
  gsap.config({ force3D: false });
  // Skip complex effects
}
```

## Performance Monitoring

### Using GSDevTools
```javascript
// For development only
GSDevTools.create();
```

### Logging Animation Count
```javascript
console.log("Active tweens:", gsap.globalTimeline.getChildren().length);
console.log("ScrollTriggers:", ScrollTrigger.getAll().length);
```

### Performance Marks
```javascript
performance.mark("animation-start");

gsap.to(el, {
  x: 100,
  onComplete: () => {
    performance.mark("animation-end");
    performance.measure("animation", "animation-start", "animation-end");
    console.log(performance.getEntriesByName("animation"));
  }
});
```

## Quick Fixes

### Stuttering Scroll Animations
```javascript
// Add smoothing
gsap.to(el, {
  scrollTrigger: {
    scrub: 1  // Add smoothing (1 second lag)
  }
});
```

### Janky Hover Animations
```javascript
// Use quickTo for smooth hover
const xTo = gsap.quickTo(".element", "x", { duration: 0.5, ease: "power3.out" });
const yTo = gsap.quickTo(".element", "y", { duration: 0.5, ease: "power3.out" });

el.addEventListener("mousemove", e => {
  xTo(e.clientX);
  yTo(e.clientY);
});
```

### Flash of Unstyled Content
```javascript
// Hide elements until JS loads
gsap.set(".animated", { visibility: "hidden" });

// Then animate
gsap.from(".animated", {
  autoAlpha: 0,
  y: 50
});
```
