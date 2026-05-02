---
name: gsap-scroll
description: Create ScrollTrigger animations from natural language
version: 1.0.0
argument-hint: "[scroll animation description]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP ScrollTrigger Generator

Create scroll-based animations with proper ScrollTrigger configuration.

## Quick Setup

```javascript
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

gsap.registerPlugin(ScrollTrigger);
```

## Basic Syntax

### Simple ScrollTrigger
```javascript
gsap.to(".element", {
  y: 100,
  scrollTrigger: ".element" // Triggers when element enters viewport
});
```

### Full Configuration
```javascript
gsap.to(".element", {
  y: 100,
  scrollTrigger: {
    trigger: ".element",
    start: "top center",
    end: "bottom center",
    toggleActions: "play none none reverse",
    markers: true // Remove in production
  }
});
```

## Start/End Position Syntax

### Format
```
start: "[trigger position] [viewport position]"
end: "[trigger position] [viewport position]"
```

### Position Keywords
| Keyword | Meaning |
|---------|---------|
| `top` | Top of element/viewport |
| `center` | Center of element/viewport |
| `bottom` | Bottom of element/viewport |

### Position Values
| Value | Meaning |
|-------|---------|
| `"top top"` | Trigger's top hits viewport's top |
| `"top center"` | Trigger's top hits viewport's center |
| `"top 80%"` | Trigger's top hits 80% from viewport top |
| `"top bottom"` | Trigger's top hits viewport's bottom |
| `"center center"` | Both centers align |
| `"bottom top"` | Trigger's bottom hits viewport's top |
| `"top+=100 center"` | 100px below trigger's top hits center |

### Offset Examples
```javascript
start: "top+=100 center"    // 100px below trigger top
start: "top-=50 center"     // 50px above trigger top
start: "top center+=100"    // 100px below viewport center
end: "+=500"                // 500px after start
```

## toggleActions

### Format
```
toggleActions: "onEnter onLeave onEnterBack onLeaveBack"
```

### Action Values
| Value | Effect |
|-------|--------|
| `play` | Play animation forward |
| `pause` | Pause animation |
| `resume` | Resume from paused state |
| `reset` | Reset to beginning |
| `restart` | Reset and play |
| `complete` | Jump to end |
| `reverse` | Play backwards |
| `none` | Do nothing |

### Common Patterns
```javascript
// Play once
toggleActions: "play none none none"

// Play/reverse on scroll
toggleActions: "play none none reverse"

// Restart every time
toggleActions: "restart none none reverse"

// Play and complete
toggleActions: "play complete none none"
```

## Natural Language Mapping

### Scroll Reveal Phrases
| User Says | ScrollTrigger Config |
|-----------|---------------------|
| "reveal on scroll" | `start: "top 80%", toggleActions: "play none none none"` |
| "animate when visible" | `start: "top center", toggleActions: "play none none none"` |
| "animate on enter" | `start: "top 90%"` |
| "fade in on scroll" | `from()` with `autoAlpha: 0` |

### Pin Phrases
| User Says | ScrollTrigger Config |
|-----------|---------------------|
| "pin" / "sticky" | `pin: true` |
| "pin while scrolling" | `pin: true, start: "top top"` |
| "pin for X pixels" | `pin: true, end: "+=Xpx"` |
| "pin until next section" | `pin: true, end: "bottom top"` |

### Parallax Phrases
| User Says | ScrollTrigger Config |
|-----------|---------------------|
| "parallax" | `scrub: true` with y movement |
| "parallax 50%" | `scrub: true`, `y: "-50%"` |
| "slow parallax" | `scrub: 2` (2 second smoothing) |
| "smooth parallax" | `scrub: 1` |

### Scrub Phrases
| User Says | ScrollTrigger Config |
|-----------|---------------------|
| "scrub" | `scrub: true` (instant) |
| "smooth scrub" | `scrub: 1` (1 second smoothing) |
| "on scroll progress" | `scrub: true` |

## Common Patterns

### Fade Up on Scroll
```javascript
gsap.from(".element", {
  y: 100,
  autoAlpha: 0,
  duration: 1,
  scrollTrigger: {
    trigger: ".element",
    start: "top 80%",
    toggleActions: "play none none reverse"
  }
});
```

### Parallax Background
```javascript
gsap.to(".background", {
  y: "-30%",
  ease: "none",
  scrollTrigger: {
    trigger: ".section",
    start: "top bottom",
    end: "bottom top",
    scrub: true
  }
});
```

### Pin Section
```javascript
gsap.to(".pinned-content", {
  x: "-100%",
  ease: "none",
  scrollTrigger: {
    trigger: ".pinned-section",
    start: "top top",
    end: "+=2000",
    pin: true,
    scrub: 1
  }
});
```

### Horizontal Scroll
```javascript
const sections = gsap.utils.toArray(".panel");

gsap.to(sections, {
  xPercent: -100 * (sections.length - 1),
  ease: "none",
  scrollTrigger: {
    trigger: ".container",
    pin: true,
    scrub: 1,
    snap: 1 / (sections.length - 1),
    end: () => "+=" + document.querySelector(".container").offsetWidth
  }
});
```

### Stagger Elements on Scroll
```javascript
gsap.from(".card", {
  y: 100,
  autoAlpha: 0,
  stagger: 0.2,
  scrollTrigger: {
    trigger: ".cards-container",
    start: "top 80%"
  }
});
```

### Progress Bar
```javascript
gsap.to(".progress-bar", {
  scaleX: 1,
  ease: "none",
  transformOrigin: "left center",
  scrollTrigger: {
    trigger: "body",
    start: "top top",
    end: "bottom bottom",
    scrub: true
  }
});
```

### Batch Animation
```javascript
ScrollTrigger.batch(".item", {
  onEnter: (batch) => gsap.from(batch, {
    y: 100,
    autoAlpha: 0,
    stagger: 0.1
  }),
  start: "top 80%"
});
```

## Advanced Options

### Snap Points
```javascript
scrollTrigger: {
  snap: {
    snapTo: 1 / 4,           // Snap to 25% increments
    duration: { min: 0.2, max: 0.6 },
    ease: "power1.inOut"
  }
}
```

### Callbacks
```javascript
scrollTrigger: {
  onEnter: () => console.log("entered"),
  onLeave: () => console.log("left"),
  onEnterBack: () => console.log("entered from bottom"),
  onLeaveBack: () => console.log("left from top"),
  onUpdate: (self) => console.log("progress:", self.progress),
  onToggle: (self) => console.log("active:", self.isActive)
}
```

### Container Scrolling
```javascript
scrollTrigger: {
  trigger: ".element",
  scroller: ".custom-scroller", // Custom scroll container
  start: "top center"
}
```

### Responsive ScrollTrigger
```javascript
ScrollTrigger.matchMedia({
  "(min-width: 768px)": function() {
    gsap.to(".element", {
      x: 500,
      scrollTrigger: { trigger: ".element" }
    });
  },
  "(max-width: 767px)": function() {
    gsap.to(".element", {
      x: 100,
      scrollTrigger: { trigger: ".element" }
    });
  }
});
```

## Cleanup (Important for React/Vue)

### React
```javascript
useGSAP(() => {
  gsap.to(".element", {
    scrollTrigger: {
      trigger: ".element",
      // ...
    }
  });
}, { scope: containerRef });
// Cleanup handled automatically
```

### Vue
```javascript
let ctx;

onMounted(() => {
  ctx = gsap.context(() => {
    gsap.to(".element", {
      scrollTrigger: { trigger: ".element" }
    });
  });
});

onUnmounted(() => {
  ctx.revert(); // Kills all ScrollTriggers in context
});
```

### Manual Cleanup
```javascript
const st = ScrollTrigger.create({
  trigger: ".element",
  // ...
});

// Later
st.kill();

// Or kill all
ScrollTrigger.getAll().forEach(st => st.kill());
```

## Debugging

### Enable Markers
```javascript
scrollTrigger: {
  markers: true // Shows start/end positions
}
```

### Debug Info
```javascript
scrollTrigger: {
  markers: {
    startColor: "green",
    endColor: "red",
    fontSize: "12px"
  }
}
```

## Performance Tips

1. **Use `once: true`** for one-time animations
2. **Debounce refresh** on resize
3. **Use `fastScrollEnd: true`** for better mobile performance
4. **Limit pinned elements** - they're expensive
5. **Use `will-change: transform`** on animated elements
