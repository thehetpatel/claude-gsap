---
name: gsap-utils
description: Master GSAP utility methods for advanced animations
version: 1.0.0
argument-hint: "[utility function name or use case]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP Utilities Reference

Master the powerful utility methods in `gsap.utils`.

## Array & Selection

### toArray()
Convert selectors, NodeLists, or single elements to arrays.
```javascript
const boxes = gsap.utils.toArray(".box");
const items = gsap.utils.toArray(document.querySelectorAll("li"));
const single = gsap.utils.toArray(myElement);  // Wraps in array
```

### selector()
Create a scoped selector function.
```javascript
const q = gsap.utils.selector(".container");
gsap.to(q(".box"), { x: 100 });  // Only .box inside .container

// React usage
const ref = useRef();
const q = gsap.utils.selector(ref);
gsap.to(q(".item"), { opacity: 0 });
```

### shuffle()
Randomly shuffle an array (in place).
```javascript
const items = gsap.utils.toArray(".card");
gsap.utils.shuffle(items);
items.forEach(item => container.appendChild(item));
```

## Value Manipulation

### clamp()
Constrain a value within a range.
```javascript
const clampedValue = gsap.utils.clamp(0, 100, value);
// If value < 0, returns 0
// If value > 100, returns 100
// Otherwise returns value

// Create reusable clamp function
const clampProgress = gsap.utils.clamp(0, 1);
clampProgress(1.5);  // Returns 1
clampProgress(-0.2); // Returns 0
```

### snap()
Snap values to nearest increment or array value.
```javascript
// Snap to increment
gsap.utils.snap(10, 23);   // Returns 20
gsap.utils.snap(5, 17);    // Returns 15

// Snap to array values
gsap.utils.snap([0, 25, 50, 75, 100], 37);  // Returns 25

// Create reusable snap function
const snapToTen = gsap.utils.snap(10);
snapToTen(47);  // Returns 50

// Snap with radius (only if within distance)
gsap.utils.snap({ values: [0, 100, 200], radius: 20 }, 95);  // Returns 100
gsap.utils.snap({ values: [0, 100, 200], radius: 20 }, 50);  // Returns 50 (no snap)
```

### wrap()
Wrap a value within a range.
```javascript
gsap.utils.wrap(0, 100, 105);   // Returns 5
gsap.utils.wrap(0, 100, -10);   // Returns 90

// Wrap array indices
const colors = ["red", "green", "blue"];
gsap.utils.wrap(colors, 4);     // Returns "green" (index 4 % 3 = 1)

// Create reusable wrap function
const wrapIndex = gsap.utils.wrap(0, 5);
wrapIndex(7);  // Returns 2
```

### wrapYoyo()
Like wrap, but bounces back and forth.
```javascript
gsap.utils.wrapYoyo(0, 100, 130);  // Returns 70 (bounced)
gsap.utils.wrapYoyo(0, 100, 250);  // Returns 50

// Useful for ping-pong animations
const progress = gsap.utils.wrapYoyo(0, 1);
progress(1.3);  // Returns 0.7
```

## Interpolation & Mapping

### interpolate()
Blend between values based on progress (0-1).
```javascript
// Numbers
gsap.utils.interpolate(0, 100, 0.5);  // Returns 50

// Colors
gsap.utils.interpolate("red", "blue", 0.5);  // Returns blended color

// Objects
gsap.utils.interpolate(
  { x: 0, y: 0 },
  { x: 100, y: 200 },
  0.5
);  // Returns { x: 50, y: 100 }

// Arrays
gsap.utils.interpolate([0, 50, 100], 0.5);  // Returns 50 (middle)
gsap.utils.interpolate(["red", "green", "blue"], 0.75);  // Blends green→blue

// Create reusable interpolator
const blend = gsap.utils.interpolate(0, 100);
blend(0.25);  // Returns 25
```

### mapRange()
Map a value from one range to another.
```javascript
// Map scroll (0-1000) to opacity (0-1)
gsap.utils.mapRange(0, 1000, 0, 1, 500);  // Returns 0.5

// Create reusable mapper
const scrollToOpacity = gsap.utils.mapRange(0, 1000, 0, 1);
scrollToOpacity(250);  // Returns 0.25

// Map with clamping
const scrollToRotation = gsap.utils.mapRange(0, 500, 0, 360);
scrollToRotation(750);  // Returns 540 (not clamped)
```

### normalize()
Convert a value to 0-1 based on range.
```javascript
gsap.utils.normalize(0, 100, 50);  // Returns 0.5
gsap.utils.normalize(200, 600, 400);  // Returns 0.5

// Create reusable normalizer
const normalizeScroll = gsap.utils.normalize(0, document.body.scrollHeight);
normalizeScroll(window.scrollY);  // Returns 0-1 progress
```

## Random Values

### random()
Generate random numbers or select from arrays.
```javascript
// Random between min and max
gsap.utils.random(1, 10);        // 1-10 (float)
gsap.utils.random(1, 10, 1);     // 1-10 (integer - snap to 1)
gsap.utils.random(0, 100, 5);    // 0, 5, 10, 15...100

// Random from array
gsap.utils.random(["red", "green", "blue"]);

// Create reusable random function
const randomX = gsap.utils.random(-100, 100, 10, true);
randomX();  // Returns random value each call

// For stagger animations
gsap.to(".box", {
  x: gsap.utils.random(-100, 100, true),  // Different for each
  y: gsap.utils.random(-50, 50, true)
});
```

## Advanced Utilities

### distribute()
Distribute values across elements in various ways.
```javascript
// Linear distribution
gsap.to(".box", {
  y: gsap.utils.distribute({
    base: 0,
    amount: 200,   // Total range
    from: "start"  // or "end", "center", "edges", "random", or index
  })
});

// With ease
gsap.to(".box", {
  x: gsap.utils.distribute({
    base: 0,
    amount: 500,
    from: "center",
    ease: "power2"
  })
});

// Grid distribution
gsap.to(".box", {
  scale: gsap.utils.distribute({
    base: 0.5,
    amount: 1,
    from: "center",
    grid: "auto",   // or [rows, cols]
    axis: "both"    // or "x", "y"
  })
});
```

### pipe()
Chain multiple functions together.
```javascript
const transform = gsap.utils.pipe(
  gsap.utils.clamp(0, 100),
  gsap.utils.snap(10),
  value => value * 2
);

transform(47);  // Clamps, snaps to 50, doubles to 100

// Common use case
const scrollProgress = gsap.utils.pipe(
  gsap.utils.normalize(0, document.body.scrollHeight),
  gsap.utils.clamp(0, 1)
);
```

### unitize()
Add a unit to a value.
```javascript
const addPx = gsap.utils.unitize(gsap.utils.clamp(0, 100));
addPx(50);   // "50px"
addPx(150);  // "100px" (clamped)

// With interpolation
const widthCalc = gsap.utils.unitize(
  gsap.utils.interpolate(100, 500),
  "px"
);
widthCalc(0.5);  // "300px"
```

### splitColor()
Parse colors into RGB/RGBA components.
```javascript
gsap.utils.splitColor("red");           // [255, 0, 0]
gsap.utils.splitColor("#ff0000");        // [255, 0, 0]
gsap.utils.splitColor("rgb(255,0,0)");   // [255, 0, 0]
gsap.utils.splitColor("rgba(255,0,0,0.5)"); // [255, 0, 0, 0.5]

// Get HSL
gsap.utils.splitColor("red", true);  // Returns HSL values
```

### getUnit()
Extract the unit from a value.
```javascript
gsap.utils.getUnit("100px");   // "px"
gsap.utils.getUnit("50%");     // "%"
gsap.utils.getUnit("2rem");    // "rem"
gsap.utils.getUnit(100);       // "" (no unit)
```

### checkPrefix()
Get vendor-prefixed CSS property name.
```javascript
gsap.utils.checkPrefix("transform");     // "transform" or "-webkit-transform"
gsap.utils.checkPrefix("clipPath");      // Browser-specific version
```

## Common Use Cases

### Scroll Progress Mapping
```javascript
ScrollTrigger.create({
  onUpdate: self => {
    const rotation = gsap.utils.mapRange(0, 1, 0, 360, self.progress);
    const scale = gsap.utils.interpolate(1, 2, self.progress);
    gsap.set(".element", { rotation, scale });
  }
});
```

### Mouse-Following with Constraints
```javascript
document.addEventListener("mousemove", e => {
  const x = gsap.utils.clamp(0, window.innerWidth, e.clientX);
  const y = gsap.utils.clamp(0, window.innerHeight, e.clientY);

  gsap.to(".follower", { x, y, duration: 0.3 });
});
```

### Staggered Random Values
```javascript
gsap.to(".particle", {
  x: gsap.utils.random(-200, 200, true),
  y: gsap.utils.random(-200, 200, true),
  rotation: gsap.utils.random(-180, 180, true),
  scale: gsap.utils.random(0.5, 1.5, true),
  duration: gsap.utils.random(1, 2, true),
  stagger: {
    amount: 1,
    from: "random"
  }
});
```

### Carousel Index Wrapping
```javascript
const slides = gsap.utils.toArray(".slide");
let current = 0;

function goToSlide(direction) {
  current = gsap.utils.wrap(0, slides.length, current + direction);
  // ... animation logic
}
```

### Grid Animation Distribution
```javascript
gsap.from(".grid-item", {
  scale: 0,
  opacity: 0,
  duration: 0.5,
  stagger: {
    amount: 1,
    grid: "auto",
    from: "center",
    ease: "power2"
  }
});
```

## Quick Reference Table

| Utility | Purpose | Example |
|---------|---------|---------|
| `toArray()` | Convert to array | `toArray(".box")` |
| `selector()` | Scoped selector | `selector(ref)(".item")` |
| `shuffle()` | Randomize array | `shuffle(items)` |
| `clamp()` | Constrain value | `clamp(0, 100, value)` |
| `snap()` | Snap to increment | `snap(10, 47)` → 50 |
| `wrap()` | Wrap around | `wrap(0, 10, 12)` → 2 |
| `wrapYoyo()` | Bounce wrap | `wrapYoyo(0, 10, 12)` → 8 |
| `interpolate()` | Blend values | `interpolate(0, 100, 0.5)` → 50 |
| `mapRange()` | Map ranges | `mapRange(0, 100, 0, 1, 50)` → 0.5 |
| `normalize()` | Get 0-1 progress | `normalize(0, 100, 50)` → 0.5 |
| `random()` | Random value | `random(1, 10)` |
| `distribute()` | Spread values | `distribute({ amount: 100 })` |
| `pipe()` | Chain functions | `pipe(clamp, snap)` |
| `unitize()` | Add unit | `unitize(fn, "px")` |
| `splitColor()` | Parse color | `splitColor("#ff0000")` |
| `getUnit()` | Extract unit | `getUnit("100px")` → "px" |
