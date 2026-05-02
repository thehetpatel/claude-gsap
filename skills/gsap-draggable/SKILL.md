---
name: gsap-draggable
description: Create draggable elements with Draggable and Inertia plugins
version: 1.0.0
argument-hint: "[draggable interaction description]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP Draggable & Inertia Generator

Create drag, swipe, throw, and spin interactions.

## Quick Setup

```javascript
import { gsap } from "gsap";
import { Draggable } from "gsap/Draggable";
import { InertiaPlugin } from "gsap/InertiaPlugin";

gsap.registerPlugin(Draggable, InertiaPlugin);
```

## Basic Usage

### Simple Draggable
```javascript
Draggable.create(".box", {
  type: "x,y"  // Drag in both directions
});
```

### Draggable Types
| Type | Description |
|------|-------------|
| `"x,y"` | Drag in both X and Y directions |
| `"x"` | Horizontal only |
| `"y"` | Vertical only |
| `"rotation"` | Rotate around center |
| `"scroll"` | Scroll content |
| `"scrollTop"` | Vertical scroll only |
| `"scrollLeft"` | Horizontal scroll only |

## Natural Language Mapping

| User Says | Implementation |
|-----------|---------------|
| "drag and drop" | Draggable with bounds |
| "swipe cards" | Draggable x with inertia |
| "throw/toss" | Draggable with inertia |
| "spin wheel" | Draggable rotation with inertia |
| "slider" | Draggable x with snap |
| "carousel drag" | Draggable with snap points |
| "sortable list" | Draggable with hitTest |
| "resize handle" | Draggable with livesnap |

## Common Patterns

### Bounded Dragging
```javascript
Draggable.create(".box", {
  type: "x,y",
  bounds: ".container",       // Constrain to parent
  edgeResistance: 0.65,       // Resistance at edges
  inertia: true               // Enable throw/momentum
});
```

### Horizontal Swipe Cards
```javascript
Draggable.create(".card", {
  type: "x",
  bounds: { minX: -300, maxX: 300 },
  inertia: true,
  snap: {
    x: function(endValue) {
      // Snap to nearest position
      return Math.round(endValue / 300) * 300;
    }
  },
  onDragEnd: function() {
    if (this.x < -200) {
      // Swiped left - dismiss
      gsap.to(this.target, { x: -500, autoAlpha: 0 });
    } else if (this.x > 200) {
      // Swiped right - like
      gsap.to(this.target, { x: 500, autoAlpha: 0 });
    } else {
      // Return to center
      gsap.to(this.target, { x: 0 });
    }
  }
});
```

### Throw with Momentum
```javascript
Draggable.create(".throwable", {
  type: "x,y",
  inertia: true,
  bounds: window,
  onThrowUpdate: function() {
    console.log("velocity:", this.getVelocity("x"));
  },
  onThrowComplete: function() {
    console.log("Stopped at:", this.x, this.y);
  }
});
```

### Spin Wheel/Dial
```javascript
Draggable.create(".wheel", {
  type: "rotation",
  inertia: true,
  snap: function(endValue) {
    // Snap to nearest 30-degree increment
    return Math.round(endValue / 30) * 30;
  },
  onDrag: function() {
    // Update value display based on rotation
    const value = Math.round(this.rotation / 30) % 12;
    display.textContent = value;
  }
});
```

### Slider with Snap Points
```javascript
const snapPoints = [0, 100, 200, 300, 400];

Draggable.create(".slider-handle", {
  type: "x",
  bounds: ".slider-track",
  inertia: true,
  snap: {
    x: function(endValue) {
      return gsap.utils.snap(snapPoints, endValue);
    }
  },
  onDrag: function() {
    updateSliderValue(this.x);
  }
});
```

### Sortable List
```javascript
const items = gsap.utils.toArray(".sortable-item");

items.forEach(item => {
  Draggable.create(item, {
    type: "y",
    bounds: ".list-container",
    onDrag: function() {
      // Check overlap with other items
      items.forEach(otherItem => {
        if (otherItem !== item && this.hitTest(otherItem, "50%")) {
          // Swap positions
          swapItems(item, otherItem);
        }
      });
    }
  });
});

function swapItems(a, b) {
  const aRect = a.getBoundingClientRect();
  const bRect = b.getBoundingClientRect();

  if (aRect.top < bRect.top) {
    b.parentNode.insertBefore(a, b);
  } else {
    b.parentNode.insertBefore(a, b.nextSibling);
  }
}
```

### Carousel with Snap
```javascript
const slides = gsap.utils.toArray(".slide");
const slideWidth = slides[0].offsetWidth;
const snapPoints = slides.map((_, i) => -i * slideWidth);

Draggable.create(".carousel-track", {
  type: "x",
  bounds: {
    minX: -(slides.length - 1) * slideWidth,
    maxX: 0
  },
  inertia: true,
  snap: {
    x: function(endValue) {
      return gsap.utils.snap(snapPoints, endValue);
    }
  },
  onDragEnd: function() {
    const currentSlide = Math.round(-this.x / slideWidth);
    updateDots(currentSlide);
  }
});
```

### Resize Handle
```javascript
Draggable.create(".resize-handle", {
  type: "x,y",
  onDrag: function() {
    const box = document.querySelector(".resizable-box");
    gsap.set(box, {
      width: this.x + 20,
      height: this.y + 20
    });
  },
  liveSnap: {
    x: function(value) {
      return Math.round(value / 10) * 10;  // Snap to 10px grid
    },
    y: function(value) {
      return Math.round(value / 10) * 10;
    }
  }
});
```

### Knob/Dial Control
```javascript
Draggable.create(".knob", {
  type: "rotation",
  bounds: { minRotation: 0, maxRotation: 270 },
  onDrag: function() {
    const value = gsap.utils.mapRange(0, 270, 0, 100, this.rotation);
    output.textContent = Math.round(value);
  }
});
```

## Draggable Options

```javascript
Draggable.create(".element", {
  // Type
  type: "x,y",              // "x", "y", "x,y", "rotation", "scroll"

  // Bounds
  bounds: ".container",     // Element, selector, or object
  bounds: { minX: 0, maxX: 500, minY: 0, maxY: 300 },
  bounds: window,
  edgeResistance: 0.5,      // 0-1, resistance at bounds

  // Inertia (requires InertiaPlugin)
  inertia: true,
  throwResistance: 1000,    // Higher = stops faster
  maxDuration: 3,           // Max throw duration
  minDuration: 0.2,         // Min throw duration
  overshootTolerance: 0.5,  // Allow overshoot

  // Snapping
  snap: { x: 50, y: 50 },   // Snap to grid
  snap: [0, 100, 200],      // Snap to values
  snap: function(endValue) { return Math.round(endValue / 100) * 100; },
  liveSnap: true,           // Snap while dragging

  // Cursor
  cursor: "grab",
  activeCursor: "grabbing",

  // Triggers
  trigger: ".handle",       // Only drag from this element
  dragClickables: false,    // Don't drag when clicking buttons/links

  // Axis locking
  lockAxis: true,           // Lock to axis after initial move
  allowEventDefault: false,

  // Callbacks
  onPress: function() {},
  onDragStart: function() {},
  onDrag: function() {},
  onDragEnd: function() {},
  onRelease: function() {},
  onThrowUpdate: function() {},
  onThrowComplete: function() {},
  onClick: function() {},

  // Hit testing
  onDrag: function() {
    if (this.hitTest(".dropzone", "50%")) {
      // Over drop zone
    }
  }
});
```

## Inertia Options

```javascript
// InertiaPlugin for smooth momentum
gsap.to(".element", {
  inertia: {
    x: 500,           // End value
    y: "auto",        // Calculate based on velocity
    rotation: 360
  },
  // Or with velocity tracking
  inertia: {
    x: { velocity: "auto", min: 0, max: 1000 },
    y: { velocity: 500, end: [0, 100, 200, 300] }  // Snap points
  }
});
```

## Methods

```javascript
const draggable = Draggable.create(".box")[0];

// Control
draggable.enable();
draggable.disable();
draggable.kill();

// State
draggable.isDragging;
draggable.isPressed;
draggable.x;
draggable.y;
draggable.rotation;

// Velocity (during drag)
draggable.getVelocity("x");
draggable.getVelocity("y");
draggable.getVelocity("rotation");

// Position
draggable.update();         // Recalculate bounds
draggable.applyBounds();    // Apply bounds immediately

// Hit testing
draggable.hitTest(".other-element", "50%");
draggable.hitTest(".zone", 100);  // 100px threshold
```

## Inertia Standalone

```javascript
// Track velocity manually
const tracker = InertiaPlugin.track(".element", "x,y");

// Get velocity
const vx = InertiaPlugin.getVelocity(".element", "x");

// Animate with inertia
gsap.to(".element", {
  inertia: {
    x: { velocity: vx, end: [0, 100, 200] },
    resistance: 200
  }
});
```

## Framework Integration

### React
```jsx
import { useRef, useEffect } from "react";
import { gsap } from "gsap";
import { Draggable } from "gsap/Draggable";

gsap.registerPlugin(Draggable);

function DraggableBox() {
  const boxRef = useRef();
  const draggableRef = useRef();

  useEffect(() => {
    draggableRef.current = Draggable.create(boxRef.current, {
      type: "x,y",
      bounds: "body",
      inertia: true
    })[0];

    return () => draggableRef.current?.kill();
  }, []);

  return <div ref={boxRef} className="box">Drag me</div>;
}
```

### Vue
```vue
<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import gsap from 'gsap';
import { Draggable } from 'gsap/Draggable';

gsap.registerPlugin(Draggable);

const boxRef = ref(null);
let draggable;

onMounted(() => {
  draggable = Draggable.create(boxRef.value, {
    type: 'x,y',
    bounds: 'body',
    inertia: true
  })[0];
});

onUnmounted(() => draggable?.kill());
</script>

<template>
  <div ref="boxRef" class="box">Drag me</div>
</template>
```

## Tips

1. **Always set bounds** for better UX
2. **Use inertia** for natural feel
3. **Add visual feedback** on drag start/end
4. **Test touch events** on mobile
5. **Use `trigger`** for complex draggable components
6. **Clean up** with `kill()` in frameworks
