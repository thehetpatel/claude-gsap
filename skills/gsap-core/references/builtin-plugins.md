# GSAP Built-in Plugins Reference

These plugins are automatically included in the GSAP core. You don't need to register them.

---

## CSSPlugin (Auto-included)

Animates CSS properties. This is the most used plugin - it's automatic.

```javascript
// CSSPlugin handles all CSS properties automatically
gsap.to(".box", {
  width: 200,
  height: 200,
  backgroundColor: "red",
  borderRadius: "50%",
  boxShadow: "0 0 20px black"
});
```

### Transform Shorthand
```javascript
// These are CSSPlugin conveniences
gsap.to(".box", {
  x: 100,           // translateX
  y: 50,            // translateY
  xPercent: 50,     // translateX in %
  yPercent: 50,     // translateY in %
  rotation: 45,     // rotate in degrees
  rotationX: 45,    // 3D rotateX
  rotationY: 45,    // 3D rotateY
  scale: 1.5,       // scaleX and scaleY
  scaleX: 2,
  scaleY: 0.5,
  skewX: 10,
  skewY: 10,
  transformOrigin: "center center"
});
```

---

## AttrPlugin

Animates HTML or SVG attributes (not CSS properties).

```javascript
// Animate SVG attributes
gsap.to("circle", {
  attr: {
    cx: 200,
    cy: 150,
    r: 50,
    fill: "#00ff00"
  },
  duration: 1
});

// Animate HTML attributes
gsap.to("input", {
  attr: {
    value: 100,
    placeholder: "New text"
  },
  duration: 1
});

// Animate data attributes
gsap.to(".element", {
  attr: {
    "data-progress": 100
  },
  duration: 2
});
```

### SVG Animation Examples
```javascript
// Rectangle
gsap.to("rect", {
  attr: { width: 200, height: 100, rx: 20 },
  duration: 1
});

// Path
gsap.to("path", {
  attr: { d: "M10 80 Q 95 10 180 80" },
  duration: 1
});

// Line
gsap.to("line", {
  attr: { x2: 200, y2: 200 },
  duration: 1
});

// Polygon points
gsap.to("polygon", {
  attr: { points: "100,10 40,198 190,78 10,78 160,198" },
  duration: 1
});
```

---

## EndArrayPlugin

Animates arrays of numbers (useful for complex data visualization).

```javascript
// Animate array values
const obj = { values: [0, 0, 0, 0] };

gsap.to(obj, {
  endArray: [100, 200, 300, 400],
  duration: 2,
  onUpdate: () => {
    console.log(obj.values); // Interpolated array
  }
});
```

### Chart Animation
```javascript
const chartData = { bars: [10, 20, 30, 40, 50] };

gsap.to(chartData, {
  endArray: [80, 60, 90, 40, 70],
  duration: 1.5,
  onUpdate: () => {
    updateChart(chartData.bars);
  }
});
```

### Multi-point Animation
```javascript
const path = { points: [0, 0, 100, 0, 100, 100, 0, 100] };

gsap.to(path, {
  endArray: [50, 50, 150, 50, 150, 150, 50, 150],
  duration: 2,
  onUpdate: () => {
    drawPath(path.points);
  }
});
```

---

## SnapPlugin

Built-in value snapping during animation.

```javascript
// Snap to nearest 10
gsap.to(".box", {
  x: 105,
  snap: { x: 10 }  // Will snap to 110
});

// Snap multiple properties
gsap.to(".box", {
  x: 247,
  y: 183,
  rotation: 47,
  snap: {
    x: 50,        // Snap x to nearest 50
    y: 25,        // Snap y to nearest 25
    rotation: 15  // Snap rotation to nearest 15
  }
});

// Snap to array of values
gsap.to(".slider", {
  x: 180,
  snap: { x: [0, 100, 200, 300] }  // Snaps to nearest value
});
```

### With innerText (Counter)
```javascript
gsap.to(".counter", {
  innerText: 1000,
  duration: 2,
  snap: { innerText: 1 }  // Whole numbers only
});
```

---

## RoundPropsPlugin

Rounds specified properties to integers during animation.

```javascript
// Round position values (no decimal pixels)
gsap.to(".box", {
  x: 100.7,
  y: 50.3,
  roundProps: "x,y"  // Both will be integers
});

// Round all numeric properties
gsap.to(".element", {
  x: 150,
  y: 75,
  width: 200,
  height: 100,
  roundProps: "x,y,width,height"
});
```

### Use Case: Pixel-Perfect Animation
```javascript
// Prevent blurry text/images from subpixel rendering
gsap.to(".text-element", {
  x: 100,
  y: 50,
  roundProps: "x,y"
});
```

---

## CSSRulePlugin

Animates CSS rules (stylesheet rules, not inline styles).

```javascript
import { CSSRulePlugin } from "gsap/CSSRulePlugin";
gsap.registerPlugin(CSSRulePlugin);

// Get the CSS rule
const rule = CSSRulePlugin.getRule(".myClass::before");

// Animate the pseudo-element
gsap.to(rule, {
  cssRule: {
    width: "200px",
    backgroundColor: "red"
  },
  duration: 1
});
```

### Animating Pseudo-elements
```javascript
// ::before pseudo-element
const beforeRule = CSSRulePlugin.getRule(".button::before");
gsap.to(beforeRule, {
  cssRule: { width: "100%" },
  duration: 0.5
});

// ::after pseudo-element
const afterRule = CSSRulePlugin.getRule(".tooltip::after");
gsap.to(afterRule, {
  cssRule: { opacity: 1, transform: "translateY(0)" },
  duration: 0.3
});
```

### When to Use
- Animating `::before` and `::after` pseudo-elements
- Animating CSS keyframe rules
- Changing global styles dynamically

### Limitations
- Cannot animate pseudo-elements with regular GSAP
- Only works in browsers (not SSR)
- Less performant than direct element animation

---

## Quick Reference

| Plugin | Purpose | Auto-included |
|--------|---------|---------------|
| CSSPlugin | CSS properties | ✅ Yes |
| AttrPlugin | HTML/SVG attributes | ✅ Yes |
| EndArrayPlugin | Array interpolation | ✅ Yes |
| SnapPlugin | Value snapping | ✅ Yes |
| RoundPropsPlugin | Integer rounding | ✅ Yes |
| CSSRulePlugin | CSS rule animation | ❌ No (import) |

---

## When to Use What

| Need | Plugin |
|------|--------|
| Animate CSS styles | CSSPlugin (automatic) |
| Animate SVG attributes | AttrPlugin |
| Animate data arrays | EndArrayPlugin |
| Snap to grid/values | SnapPlugin |
| Pixel-perfect positioning | RoundPropsPlugin |
| Animate ::before/::after | CSSRulePlugin |
