---
name: gsap-timeline
description: Build GSAP animation sequences from natural language
version: 1.0.0
argument-hint: "[sequence description]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP Timeline Generator

Create complex animation sequences with proper timing and position parameters.

## Quick Reference

### Creating a Timeline
```javascript
const tl = gsap.timeline();

tl.to(".el1", { x: 100, duration: 1 })
  .to(".el2", { y: 50, duration: 0.5 })
  .to(".el3", { rotation: 360, duration: 1 });
```

### Timeline with Defaults
```javascript
const tl = gsap.timeline({
  defaults: {
    duration: 0.5,
    ease: "power3.out"
  }
});
```

## Position Parameter (Key Concept)

The position parameter controls WHEN animations start in the timeline.

### Position Syntax
| Value | Meaning |
|-------|---------|
| `0` | At absolute time 0 |
| `1` | At 1 second into timeline |
| `"+=0.5"` | 0.5s after previous ends |
| `"-=0.5"` | 0.5s before previous ends (overlap) |
| `"<"` | When previous starts |
| `"<0.5"` | 0.5s after previous starts |
| `">"` | When previous ends (default) |
| `">-0.2"` | 0.2s before previous ends |
| `"myLabel"` | At label position |
| `"myLabel+=0.5"` | 0.5s after label |

### Visual Timeline

```
Timeline:  |--A--|--B--|--C--|
           0    1    2    3

Position examples:
.to(el, {}, 0)        → Starts at 0
.to(el, {}, 1)        → Starts at 1
.to(el, {}, "+=0")    → After previous (default)
.to(el, {}, "-=0.5")  → Overlaps previous by 0.5s
.to(el, {}, "<")      → Same time as previous
```

## Natural Language Mapping

### Sequence Words
| User Says | Position Parameter |
|-----------|-------------------|
| "then" | `"+=0"` (default - sequential) |
| "after" | `"+=0"` or `"+=0.5"` |
| "at the same time" | `"<"` |
| "simultaneously" | `"<"` |
| "together" | `"<"` |
| "with" | `"<"` |
| "slightly before ends" | `"-=0.3"` |
| "overlapping" | `"-=0.5"` |
| "at X seconds" | `X` (number) |
| "halfway through" | Previous duration / 2 |

### Example Translations

**"Fade in logo, then slide in menu, finally reveal button"**
```javascript
const tl = gsap.timeline();

tl.from(".logo", { autoAlpha: 0, duration: 0.6 })
  .from(".menu", { x: -50, autoAlpha: 0, duration: 0.5 })
  .from(".button", { scale: 0.8, autoAlpha: 0, duration: 0.4 });
```

**"Fade in header and subtitle at the same time"**
```javascript
tl.from(".header", { autoAlpha: 0, duration: 0.6 })
  .from(".subtitle", { autoAlpha: 0, duration: 0.6 }, "<");
```

**"Stagger cards then reveal CTA with slight overlap"**
```javascript
tl.from(".card", { y: 50, autoAlpha: 0, stagger: 0.15 })
  .from(".cta", { scale: 0, autoAlpha: 0 }, "-=0.3");
```

## Common Patterns

### Hero Animation Sequence
```javascript
const heroTl = gsap.timeline({
  defaults: { ease: "power3.out" }
});

heroTl
  .from(".hero-bg", { scale: 1.2, duration: 1.5 })
  .from(".hero-title", { y: 100, autoAlpha: 0, duration: 1 }, "-=1")
  .from(".hero-subtitle", { y: 50, autoAlpha: 0, duration: 0.8 }, "-=0.6")
  .from(".hero-cta", { scale: 0, autoAlpha: 0, duration: 0.5, ease: "back.out(1.7)" }, "-=0.3");
```

### Page Load Animation
```javascript
const loadTl = gsap.timeline();

loadTl
  .to(".loader", { autoAlpha: 0, duration: 0.5 })
  .from(".nav", { y: -100, autoAlpha: 0, duration: 0.6 })
  .from(".content > *", {
    y: 50,
    autoAlpha: 0,
    stagger: 0.1,
    duration: 0.5
  }, "-=0.3");
```

### Modal Open Animation
```javascript
const modalTl = gsap.timeline({ paused: true });

modalTl
  .to(".overlay", { autoAlpha: 1, duration: 0.3 })
  .from(".modal", {
    y: 50,
    scale: 0.9,
    autoAlpha: 0,
    duration: 0.4,
    ease: "back.out(1.7)"
  }, "-=0.1")
  .from(".modal-content", { y: 20, autoAlpha: 0, duration: 0.3 }, "-=0.1");

// Open modal
modalTl.play();

// Close modal
modalTl.reverse();
```

### Navigation Menu Animation
```javascript
const menuTl = gsap.timeline({ paused: true });

menuTl
  .to(".menu-panel", { x: 0, duration: 0.4, ease: "power3.inOut" })
  .from(".menu-item", {
    x: -30,
    autoAlpha: 0,
    stagger: 0.08,
    duration: 0.4
  }, "-=0.2")
  .from(".menu-footer", { autoAlpha: 0, duration: 0.3 }, "-=0.1");
```

### Card Hover Animation
```javascript
function createCardTimeline(card) {
  const tl = gsap.timeline({ paused: true });

  tl.to(card, { y: -10, boxShadow: "0 20px 40px rgba(0,0,0,0.2)", duration: 0.3 })
    .to(card.querySelector(".card-icon"), { scale: 1.1, rotation: 10, duration: 0.3 }, 0)
    .to(card.querySelector(".card-arrow"), { x: 10, duration: 0.3 }, 0);

  card.addEventListener("mouseenter", () => tl.play());
  card.addEventListener("mouseleave", () => tl.reverse());
}

document.querySelectorAll(".card").forEach(createCardTimeline);
```

## Timeline Controls

### Control Methods
```javascript
const tl = gsap.timeline();

tl.play();          // Play forward
tl.pause();         // Pause
tl.resume();        // Resume from paused
tl.reverse();       // Play backwards
tl.restart();       // Go to start and play
tl.seek(1);         // Jump to 1 second
tl.progress(0.5);   // Jump to 50%
tl.timeScale(2);    // Play at 2x speed
tl.kill();          // Destroy timeline
```

### Initial States
```javascript
// Start paused
const tl = gsap.timeline({ paused: true });

// Reversed (for exit animations)
const tl = gsap.timeline({ reversed: true });
```

### Repeat Options
```javascript
const tl = gsap.timeline({
  repeat: -1,         // Infinite repeat
  repeatDelay: 0.5,   // Wait between repeats
  yoyo: true          // Alternate direction
});
```

## Labels

### Adding Labels
```javascript
const tl = gsap.timeline();

tl.from(".item1", { autoAlpha: 0 })
  .addLabel("afterItem1")
  .from(".item2", { autoAlpha: 0 })
  .from(".item3", { autoAlpha: 0, delay: 0.5 }, "afterItem1")
  // item3 starts at the label, not after item2
```

### Jump to Labels
```javascript
tl.play("afterItem1");
tl.seek("afterItem1");
```

## Timeline Callbacks

```javascript
const tl = gsap.timeline({
  onStart: () => console.log("Started"),
  onUpdate: () => console.log("Updating"),
  onComplete: () => console.log("Complete"),
  onRepeat: () => console.log("Repeating"),
  onReverseComplete: () => console.log("Reversed to start")
});
```

### Per-Tween Callbacks
```javascript
tl.to(el, {
  x: 100,
  onStart: () => console.log("This tween started"),
  onComplete: () => console.log("This tween complete")
});
```

## Nested Timelines

### Modular Approach
```javascript
function createIntro() {
  const tl = gsap.timeline();
  tl.from(".logo", { autoAlpha: 0 })
    .from(".tagline", { autoAlpha: 0 });
  return tl;
}

function createContent() {
  const tl = gsap.timeline();
  tl.from(".card", { y: 50, autoAlpha: 0, stagger: 0.1 });
  return tl;
}

// Main timeline
const main = gsap.timeline();
main
  .add(createIntro())
  .add(createContent(), "-=0.3");
```

### Position with Nested
```javascript
main.add(createIntro(), 0);          // At time 0
main.add(createContent(), "+=0.5");  // After intro + 0.5s
main.add(createOutro(), "<");        // Same time as content
```

## Best Practices

### 1. Use Defaults
```javascript
const tl = gsap.timeline({
  defaults: {
    duration: 0.6,
    ease: "power3.out",
    autoAlpha: 0
  }
});

// Now these inherit defaults
tl.from(".el1", { y: 50 })
  .from(".el2", { x: -50 })
  .from(".el3", { scale: 0 });
```

### 2. Use Variables for Timing
```javascript
const fadeIn = 0.6;
const staggerDelay = 0.1;
const overlap = 0.3;

tl.from(".items", { duration: fadeIn, stagger: staggerDelay })
  .from(".cta", { duration: fadeIn }, `-=${overlap}`);
```

### 3. Keep Timelines Modular
```javascript
// Separate concerns
const headerTl = createHeaderAnimation();
const heroTl = createHeroAnimation();
const footerTl = createFooterAnimation();

// Compose master
const masterTl = gsap.timeline()
  .add(headerTl)
  .add(heroTl, "-=0.5")
  .add(footerTl);
```

### 4. Clear and Readable Structure
```javascript
const tl = gsap.timeline();

// Phase 1: Initial reveal
tl.from(".header", { y: -100, autoAlpha: 0 })
  .from(".nav-item", { y: -20, autoAlpha: 0, stagger: 0.05 }, "-=0.3");

// Phase 2: Content
tl.from(".hero-title", { y: 100, autoAlpha: 0 }, "-=0.2")
  .from(".hero-text", { y: 50, autoAlpha: 0 }, "-=0.4");

// Phase 3: CTA
tl.from(".cta-button", { scale: 0, autoAlpha: 0, ease: "back.out(1.7)" }, "-=0.2");
```

## Framework Integration

### React
```javascript
const containerRef = useRef();
const tlRef = useRef();

useGSAP(() => {
  tlRef.current = gsap.timeline()
    .from(".item", { autoAlpha: 0, stagger: 0.1 });
}, { scope: containerRef });

// Control from events
const playTimeline = () => tlRef.current.play();
const reverseTimeline = () => tlRef.current.reverse();
```

### Vue
```javascript
const tl = ref(null);

onMounted(() => {
  tl.value = gsap.timeline({ paused: true })
    .from(".item", { autoAlpha: 0, stagger: 0.1 });
});

const play = () => tl.value.play();
const reverse = () => tl.value.reverse();

onUnmounted(() => tl.value?.kill());
```
