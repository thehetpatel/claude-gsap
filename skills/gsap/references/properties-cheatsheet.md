# GSAP Properties Cheatsheet

Complete reference for all animatable GSAP properties.

## Transform Properties (GPU-Accelerated)

### Translation
| Property | Description | Default Unit |
|----------|-------------|--------------|
| `x` | Horizontal position | pixels |
| `y` | Vertical position | pixels |
| `z` | Depth (3D) | pixels |
| `xPercent` | Horizontal % of element width | percent |
| `yPercent` | Vertical % of element height | percent |

```javascript
gsap.to(el, { x: 100 });           // 100px right
gsap.to(el, { x: "50%" });         // 50% of parent
gsap.to(el, { xPercent: -50 });    // -50% of own width
```

### Rotation
| Property | Description | Default Unit |
|----------|-------------|--------------|
| `rotation` | 2D rotation | degrees |
| `rotationX` | 3D X-axis rotation | degrees |
| `rotationY` | 3D Y-axis rotation | degrees |
| `rotationZ` | Same as rotation | degrees |

```javascript
gsap.to(el, { rotation: 360 });       // Full spin
gsap.to(el, { rotationY: 180 });      // 3D flip
gsap.to(el, { rotation: "+=90" });    // Add 90 degrees
```

### Scale
| Property | Description | Default |
|----------|-------------|---------|
| `scale` | Uniform scale | 1 |
| `scaleX` | Horizontal scale | 1 |
| `scaleY` | Vertical scale | 1 |
| `scaleZ` | Depth scale (3D) | 1 |

```javascript
gsap.to(el, { scale: 1.5 });         // 150% size
gsap.from(el, { scale: 0 });         // Scale from 0
gsap.to(el, { scaleX: 0.5 });        // Squish horizontally
```

### Skew
| Property | Description | Default Unit |
|----------|-------------|--------------|
| `skewX` | Horizontal skew | degrees |
| `skewY` | Vertical skew | degrees |

```javascript
gsap.to(el, { skewX: 20 });          // Slant right
gsap.to(el, { skewY: -15 });         // Slant up
```

### Transform Origin
| Property | Description | Default |
|----------|-------------|---------|
| `transformOrigin` | Origin point | "50% 50%" |
| `svgOrigin` | SVG-specific origin | center |

```javascript
gsap.to(el, { rotation: 45, transformOrigin: "top left" });
gsap.to(el, { rotation: 45, transformOrigin: "0% 0%" });
gsap.to(el, { rotation: 45, transformOrigin: "100px 50px" });
```

### Perspective (3D)
| Property | Description | Default |
|----------|-------------|---------|
| `transformPerspective` | Element perspective | none |

```javascript
gsap.to(el, {
  rotationY: 45,
  transformPerspective: 500
});
```

## Opacity & Visibility

| Property | Description | Values |
|----------|-------------|--------|
| `opacity` | Transparency | 0 to 1 |
| `autoAlpha` | Opacity + visibility | 0 to 1 |
| `visibility` | CSS visibility | "visible"/"hidden" |

```javascript
// autoAlpha is preferred - handles visibility automatically
gsap.to(el, { autoAlpha: 0 });  // Fades out AND sets visibility:hidden

// When autoAlpha reaches 0, it sets visibility:hidden
// When autoAlpha > 0, it sets visibility:visible
```

## Color Properties

| Property | Description |
|----------|-------------|
| `color` | Text color |
| `backgroundColor` | Background color |
| `borderColor` | Border color |
| `fill` | SVG fill |
| `stroke` | SVG stroke |

```javascript
gsap.to(el, {
  backgroundColor: "#ff0000",
  color: "rgb(255, 255, 255)",
  borderColor: "hsl(200, 50%, 50%)"
});
```

## Dimension Properties

| Property | Description |
|----------|-------------|
| `width` | Element width |
| `height` | Element height |
| `minWidth`, `maxWidth` | Min/max width |
| `minHeight`, `maxHeight` | Min/max height |

```javascript
gsap.to(el, { width: 200, height: 100 });
gsap.to(el, { width: "50%" });
gsap.to(el, { width: "+=100" });  // Add 100px
```

**Note**: Animating width/height causes layout reflow. Prefer `scale` when possible.

## Spacing Properties

| Property | Description |
|----------|-------------|
| `padding` | All padding |
| `paddingTop/Right/Bottom/Left` | Individual padding |
| `margin` | All margins |
| `marginTop/Right/Bottom/Left` | Individual margins |

```javascript
gsap.to(el, { padding: 20 });
gsap.to(el, { paddingLeft: "2rem" });
```

## Position Properties

| Property | Description |
|----------|-------------|
| `top`, `right`, `bottom`, `left` | Positioned element offset |

**Note**: These cause layout reflow. Prefer `x` and `y` transforms.

## Border Properties

| Property | Description |
|----------|-------------|
| `borderWidth` | Border thickness |
| `borderRadius` | Corner rounding |
| `outline` | Outline style |
| `outlineWidth` | Outline thickness |

```javascript
gsap.to(el, { borderRadius: "50%" });  // Circle
gsap.to(el, { borderRadius: 20 });     // 20px radius
```

## Text Properties

| Property | Description |
|----------|-------------|
| `fontSize` | Text size |
| `fontWeight` | Text weight |
| `letterSpacing` | Letter spacing |
| `lineHeight` | Line height |
| `textIndent` | First line indent |

```javascript
gsap.to(el, { fontSize: 24, letterSpacing: "0.1em" });
```

## SVG-Specific Properties

| Property | Description |
|----------|-------------|
| `attr:*` | Any SVG attribute |
| `strokeWidth` | Stroke thickness |
| `strokeDasharray` | Dash pattern |
| `strokeDashoffset` | Dash offset |

```javascript
gsap.to("path", {
  attr: { d: "M0,0 L100,100" },
  strokeDashoffset: 0
});
```

## Special Properties

### drawSVG (Plugin)
```javascript
gsap.from("path", { drawSVG: 0 });        // Draw from 0%
gsap.to("path", { drawSVG: "50% 100%" }); // Draw middle portion
```

### morphSVG (Plugin)
```javascript
gsap.to("#shape1", { morphSVG: "#shape2" });
```

### motionPath (Plugin)
```javascript
gsap.to(el, {
  motionPath: {
    path: "#myPath",
    align: "#myPath",
    autoRotate: true
  }
});
```

## Relative Values

| Syntax | Description |
|--------|-------------|
| `"+=100"` | Add 100 to current value |
| `"-=50"` | Subtract 50 from current value |
| `"*=2"` | Multiply by 2 |
| `"/=2"` | Divide by 2 |

```javascript
gsap.to(el, { x: "+=100" });      // Move 100px more
gsap.to(el, { rotation: "+=360" }); // Add full rotation
gsap.to(el, { scale: "*=1.5" });  // Scale up by 50%
```

## Function-Based Values

```javascript
gsap.to(".box", {
  x: (index, target) => index * 100,
  rotation: () => gsap.utils.random(-45, 45),
  duration: (i) => 0.5 + i * 0.1
});
```

## Units

| Syntax | Description |
|--------|-------------|
| `100` | Default unit (usually px) |
| `"100px"` | Pixels |
| `"50%"` | Percentage |
| `"10vw"` | Viewport width |
| `"10vh"` | Viewport height |
| `"2rem"` | Root em |
| `"1em"` | Element em |

## Common Patterns

### Centering an Element
```javascript
gsap.set(el, { xPercent: -50, yPercent: -50, left: "50%", top: "50%" });
```

### GPU-Accelerated Movement
```javascript
// GOOD - GPU accelerated
gsap.to(el, { x: 100, y: 50 });

// AVOID - triggers layout
gsap.to(el, { left: 100, top: 50 });
```

### Smooth Fade
```javascript
// GOOD - handles visibility
gsap.to(el, { autoAlpha: 0 });

// OK but element stays in layout
gsap.to(el, { opacity: 0 });
```
