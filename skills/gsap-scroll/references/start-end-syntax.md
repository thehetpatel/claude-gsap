# ScrollTrigger Start/End Syntax Guide

Comprehensive reference for ScrollTrigger positioning.

## Basic Syntax

```javascript
start: "[trigger position] [viewport position]"
end: "[trigger position] [viewport position]"
```

Both positions use the same keywords and can be mixed.

## Position Keywords

### For Trigger Element
| Keyword | Position |
|---------|----------|
| `top` | Top edge of trigger element |
| `center` | Center of trigger element |
| `bottom` | Bottom edge of trigger element |
| `left` | Left edge (for horizontal) |
| `right` | Right edge (for horizontal) |

### For Viewport (Scroller)
| Keyword | Position |
|---------|----------|
| `top` | Top of viewport |
| `center` | Center of viewport |
| `bottom` | Bottom of viewport |
| Percentage | Distance from top (e.g., `80%`) |
| Pixels | Absolute position (e.g., `100px`) |

## Common Combinations

### Entry Animations
| Start Value | When Triggers |
|-------------|---------------|
| `"top bottom"` | Element enters from bottom |
| `"top 80%"` | Element is 80% up the viewport |
| `"top center"` | Element reaches viewport center |
| `"top 90%"` | Almost immediately visible |
| `"center center"` | Element centered in viewport |

### Exit Points
| End Value | When Ends |
|-----------|-----------|
| `"bottom top"` | Element fully scrolled past |
| `"bottom center"` | Element bottom reaches center |
| `"bottom bottom"` | Element bottom reaches viewport bottom |
| `"+=500"` | 500px after start position |
| `"+=100%"` | One viewport height after start |

## Visual Reference

```
Viewport                    Trigger Element
┌─────────────┐            ┌─────────────┐
│   top       │            │   top       │
│             │            │             │
│   center    │            │   center    │
│             │            │             │
│   bottom    │            │   bottom    │
└─────────────┘            └─────────────┘
```

### Example: `start: "top center"`
```
          Viewport
          ┌─────────────┐
          │             │
          │   center ←──┼── trigger's top
          │             │
          └─────────────┘
```

### Example: `start: "top 80%"`
```
          Viewport
          ┌─────────────┐ ← top (0%)
          │             │
          │             │
          │   80% ──────┼── trigger's top enters here
          │             │
          └─────────────┘ ← bottom (100%)
```

## Offset Syntax

### Adding Pixels
```javascript
start: "top+=100 center"    // 100px below element's top
start: "top center+=50"     // 50px below viewport center
end: "bottom-=100 top"      // 100px above element's bottom
```

### Adding Percentages
```javascript
start: "top+=10% center"    // 10% of element height below top
end: "bottom top+=10%"      // 10% of viewport below top
```

### Relative End (Most Common)
```javascript
start: "top center"
end: "+=300"                // 300px scroll after start
end: "+=100%"               // One viewport height of scroll
end: "+=200%"               // Two viewport heights
```

## Function-Based Values

### Dynamic Calculations
```javascript
start: () => {
  const header = document.querySelector("header");
  return `top top+=${header.offsetHeight}`;
},

end: () => {
  return `+=${window.innerHeight * 2}`;
}
```

### Responsive Values
```javascript
start: () => window.innerWidth > 768 ? "top center" : "top 80%"
```

## Pin-Specific Patterns

### Pin at Top
```javascript
scrollTrigger: {
  pin: true,
  start: "top top",
  end: "+=500"
}
```

### Pin Until Next Section
```javascript
scrollTrigger: {
  trigger: ".section-1",
  pin: true,
  start: "top top",
  end: () => {
    const nextSection = document.querySelector(".section-2");
    return `+=${nextSection.offsetTop - trigger.offsetTop - window.innerHeight}`;
  }
}
```

### Pin with Offset (for Fixed Header)
```javascript
scrollTrigger: {
  pin: true,
  start: "top top+=80",  // 80px header height
  end: "+=500"
}
```

## Parallax Patterns

### Full Section Parallax
```javascript
// Background moves slower than scroll
gsap.to(".bg", {
  y: "-30%",
  ease: "none",
  scrollTrigger: {
    trigger: ".section",
    start: "top bottom",  // Start when section enters
    end: "bottom top",    // End when section leaves
    scrub: true
  }
});
```

### Hero Parallax
```javascript
gsap.to(".hero-bg", {
  y: "50%",
  ease: "none",
  scrollTrigger: {
    trigger: ".hero",
    start: "top top",
    end: "bottom top",
    scrub: true
  }
});
```

## Scrub Animation Patterns

### Full Progress Animation
```javascript
// Animation plays 0-100% as you scroll through section
gsap.to(".element", {
  x: 500,
  rotation: 360,
  scrollTrigger: {
    trigger: ".section",
    start: "top top",
    end: "bottom bottom",
    scrub: true
  }
});
```

### Partial Progress
```javascript
// Animation completes when element is at center
gsap.to(".element", {
  scale: 1.5,
  scrollTrigger: {
    trigger: ".element",
    start: "top bottom",
    end: "center center",
    scrub: 1
  }
});
```

## Horizontal Scrolling

### Start/End for Horizontal
```javascript
scrollTrigger: {
  trigger: ".horizontal-section",
  start: "left left",     // Horizontal positioning
  end: "right right",
  horizontal: true,       // Enable horizontal mode
  scrub: true
}
```

## Container Scrolling

### Custom Scroller
```javascript
scrollTrigger: {
  trigger: ".item",
  scroller: ".scrollable-container",
  start: "top center",
  end: "bottom center"
}
```

## Debugging Start/End

### Visual Markers
```javascript
scrollTrigger: {
  markers: true,  // Shows green (start) and red (end) markers
}

// Custom marker colors
scrollTrigger: {
  markers: {
    startColor: "blue",
    endColor: "purple",
    fontSize: "14px",
    fontWeight: "bold",
    indent: 20
  }
}
```

### Log Positions
```javascript
scrollTrigger: {
  onUpdate: (self) => {
    console.log("start:", self.start);
    console.log("end:", self.end);
    console.log("progress:", self.progress);
  }
}
```

## Common Mistakes

### Wrong Order
```javascript
// WRONG - trigger position comes first
start: "center top"  // This means trigger's center hits viewport's top

// If you want trigger's top to hit center:
start: "top center"
```

### Forgetting Units
```javascript
// WRONG
start: "top 100"      // Ambiguous

// CORRECT
start: "top 100px"    // Explicit pixels
start: "top center"   // Use keywords
```

### Negative Values
```javascript
// Use -= for negative offsets
start: "top-=100 center"  // 100px above top

// NOT
start: "top -100 center"  // This won't work
```
