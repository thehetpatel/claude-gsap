---
name: gsap-3d
description: Create 3D transform animations with GSAP
version: 1.0.0
argument-hint: "[3D animation description]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP 3D Animation Generator

Create stunning 3D transform animations using GSAP.

## 3D Transform Basics

### Enable 3D Context
```css
.parent {
  perspective: 1000px;  /* Enable 3D space */
  perspective-origin: center center;
}

.child {
  transform-style: preserve-3d;  /* Preserve 3D for children */
}
```

### GSAP 3D Properties
| Property | Description |
|----------|-------------|
| `rotationX` | Rotate around X-axis (tilt forward/back) |
| `rotationY` | Rotate around Y-axis (spin left/right) |
| `rotationZ` | Rotate around Z-axis (same as `rotation`) |
| `z` | Move toward/away from viewer |
| `transformPerspective` | Per-element perspective |

## Natural Language Mapping

| User Says | GSAP Code |
|-----------|-----------|
| "flip horizontally" | `rotationY: 180` |
| "flip vertically" | `rotationX: 180` |
| "card flip" | `rotationY: 180` with backface |
| "tilt" | `rotationX/Y` with small values |
| "spin 3d" | `rotation + rotationY` |
| "zoom in 3d" | `z: 100` + scale |
| "pop out" | `z: 50, scale: 1.1` |
| "depth" | Translate on z-axis |

## Common Patterns

### Card Flip
```javascript
// HTML structure
// <div class="card">
//   <div class="card-front">Front</div>
//   <div class="card-back">Back</div>
// </div>

// CSS required
.card {
  perspective: 1000px;
  width: 300px;
  height: 400px;
}

.card-front, .card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
}

.card-back {
  transform: rotationY(180deg);
}

// GSAP Animation
const flipTl = gsap.timeline({ paused: true });

flipTl.to(".card-front", {
    rotationY: -180,
    duration: 0.6,
    ease: "power2.inOut"
  })
  .to(".card-back", {
    rotationY: 0,
    duration: 0.6,
    ease: "power2.inOut"
  }, 0);

// Trigger
card.addEventListener("click", () => {
  flipTl.reversed() ? flipTl.play() : flipTl.reverse();
});
```

### Horizontal Flip
```javascript
gsap.to(".element", {
  rotationY: 180,
  duration: 0.8,
  ease: "power2.inOut",
  transformPerspective: 1000,
  transformOrigin: "center center"
});
```

### Vertical Flip
```javascript
gsap.to(".element", {
  rotationX: 180,
  duration: 0.8,
  ease: "power2.inOut",
  transformPerspective: 1000,
  transformOrigin: "center center"
});
```

### 3D Tilt on Hover
```javascript
const card = document.querySelector(".card");

card.addEventListener("mousemove", (e) => {
  const rect = card.getBoundingClientRect();
  const x = e.clientX - rect.left - rect.width / 2;
  const y = e.clientY - rect.top - rect.height / 2;

  gsap.to(card, {
    rotationY: x / 10,
    rotationX: -y / 10,
    transformPerspective: 500,
    duration: 0.5,
    ease: "power2.out"
  });
});

card.addEventListener("mouseleave", () => {
  gsap.to(card, {
    rotationY: 0,
    rotationX: 0,
    duration: 0.5,
    ease: "power2.out"
  });
});
```

### 3D Cube Rotation
```javascript
// CSS Structure
.cube-container {
  perspective: 1000px;
  width: 200px;
  height: 200px;
}

.cube {
  width: 100%;
  height: 100%;
  position: relative;
  transform-style: preserve-3d;
}

.face {
  position: absolute;
  width: 200px;
  height: 200px;
}

.front  { transform: translateZ(100px); }
.back   { transform: rotateY(180deg) translateZ(100px); }
.right  { transform: rotateY(90deg) translateZ(100px); }
.left   { transform: rotateY(-90deg) translateZ(100px); }
.top    { transform: rotateX(90deg) translateZ(100px); }
.bottom { transform: rotateX(-90deg) translateZ(100px); }

// GSAP Animation
gsap.to(".cube", {
  rotationY: 360,
  rotationX: 360,
  duration: 10,
  ease: "none",
  repeat: -1
});

// Or controlled rotation
function rotateTo(face) {
  const rotations = {
    front: { rotationX: 0, rotationY: 0 },
    back: { rotationX: 0, rotationY: 180 },
    right: { rotationX: 0, rotationY: -90 },
    left: { rotationX: 0, rotationY: 90 },
    top: { rotationX: -90, rotationY: 0 },
    bottom: { rotationX: 90, rotationY: 0 }
  };

  gsap.to(".cube", {
    ...rotations[face],
    duration: 0.8,
    ease: "power2.inOut"
  });
}
```

### 3D Carousel
```javascript
const items = gsap.utils.toArray(".carousel-item");
const numItems = items.length;
const angleStep = 360 / numItems;
const radius = 300;

// Position items in 3D circle
items.forEach((item, i) => {
  const angle = angleStep * i;
  gsap.set(item, {
    rotationY: angle,
    z: radius,
    transformOrigin: "center center -" + radius + "px"
  });
});

// Rotate carousel
let currentAngle = 0;

function rotateCarousel(direction) {
  currentAngle += direction * angleStep;

  gsap.to(".carousel", {
    rotationY: -currentAngle,
    duration: 0.8,
    ease: "power2.inOut"
  });
}

// Navigation
nextBtn.addEventListener("click", () => rotateCarousel(1));
prevBtn.addEventListener("click", () => rotateCarousel(-1));
```

### Pop Out Effect
```javascript
gsap.from(".element", {
  z: -200,
  autoAlpha: 0,
  scale: 0.5,
  duration: 0.8,
  ease: "back.out(1.7)",
  transformPerspective: 500
});
```

### Parallax 3D Layers
```javascript
const layers = gsap.utils.toArray(".parallax-layer");

layers.forEach((layer, i) => {
  const depth = (i + 1) * 50;

  gsap.to(layer, {
    z: depth,
    ease: "none",
    scrollTrigger: {
      trigger: ".parallax-container",
      start: "top bottom",
      end: "bottom top",
      scrub: true
    }
  });
});
```

### 3D Fold Animation
```javascript
// Split element into panels
const panels = gsap.utils.toArray(".fold-panel");

const foldTl = gsap.timeline({ paused: true });

panels.forEach((panel, i) => {
  foldTl.to(panel, {
    rotationX: i % 2 === 0 ? 90 : -90,
    transformOrigin: i % 2 === 0 ? "top center" : "bottom center",
    duration: 0.3
  }, i * 0.1);
});
```

### 3D Stack Cards
```javascript
const cards = gsap.utils.toArray(".stack-card");

cards.forEach((card, i) => {
  gsap.set(card, {
    z: -i * 20,
    y: -i * 5,
    scale: 1 - i * 0.05
  });
});

// Bring card to front
function bringToFront(index) {
  gsap.to(cards[index], {
    z: 50,
    y: -50,
    scale: 1.1,
    duration: 0.4,
    ease: "back.out(1.7)"
  });
}
```

## Scroll-Triggered 3D

### 3D Rotate on Scroll
```javascript
gsap.to(".element", {
  rotationY: 360,
  transformPerspective: 1000,
  ease: "none",
  scrollTrigger: {
    trigger: ".element",
    start: "top bottom",
    end: "bottom top",
    scrub: true
  }
});
```

### Flip Cards on Scroll
```javascript
gsap.utils.toArray(".flip-card").forEach(card => {
  gsap.to(card, {
    rotationY: 180,
    scrollTrigger: {
      trigger: card,
      start: "top 70%",
      end: "top 30%",
      scrub: true
    }
  });
});
```

## Performance Tips

1. **Use `will-change: transform`** on 3D elements
2. **Limit perspective** - Too low (<500px) can cause distortion
3. **Use `transform-style: preserve-3d`** for nested 3D
4. **Avoid animating** `perspective` directly
5. **Use `backface-visibility: hidden`** for flip animations
6. **Hardware acceleration** - 3D transforms are GPU-accelerated

## CSS Setup Template

```css
/* 3D Animation Container */
.scene-3d {
  perspective: 1000px;
  perspective-origin: center center;
}

/* 3D Element */
.object-3d {
  transform-style: preserve-3d;
  will-change: transform;
}

/* Hide backface for flip animations */
.flip-element {
  backface-visibility: hidden;
}
```

## Framework Integration

### React 3D Component
```jsx
function Card3D() {
  const cardRef = useRef();

  useGSAP(() => {
    const card = cardRef.current;

    const handleMove = (e) => {
      const rect = card.getBoundingClientRect();
      const x = e.clientX - rect.left - rect.width / 2;
      const y = e.clientY - rect.top - rect.height / 2;

      gsap.to(card, {
        rotationY: x / 10,
        rotationX: -y / 10,
        transformPerspective: 500,
        duration: 0.3
      });
    };

    const handleLeave = () => {
      gsap.to(card, { rotationY: 0, rotationX: 0, duration: 0.5 });
    };

    card.addEventListener("mousemove", handleMove);
    card.addEventListener("mouseleave", handleLeave);

    return () => {
      card.removeEventListener("mousemove", handleMove);
      card.removeEventListener("mouseleave", handleLeave);
    };
  }, { scope: cardRef });

  return <div ref={cardRef} className="card-3d">Content</div>;
}
```
