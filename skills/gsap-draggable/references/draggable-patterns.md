# Draggable & Inertia Patterns

Ready-to-use drag interaction code snippets.

## Card Interactions

### Tinder-Style Swipe Cards
```javascript
const cards = gsap.utils.toArray(".swipe-card").reverse();
let currentCard = cards.length - 1;

cards.forEach((card, i) => {
  gsap.set(card, { zIndex: i });

  Draggable.create(card, {
    type: "x,y",
    bounds: { minY: -50, maxY: 50 },
    inertia: true,
    onDrag: function() {
      const rotation = this.x / 10;
      const opacity = 1 - Math.abs(this.x) / 300;

      gsap.set(card, { rotation });

      // Show like/nope indicator
      if (this.x > 50) {
        gsap.set(card.querySelector(".like"), { opacity: this.x / 150 });
      } else if (this.x < -50) {
        gsap.set(card.querySelector(".nope"), { opacity: -this.x / 150 });
      }
    },
    onDragEnd: function() {
      if (Math.abs(this.x) > 150) {
        // Card dismissed
        const direction = this.x > 0 ? 1 : -1;
        gsap.to(card, {
          x: direction * 500,
          rotation: direction * 30,
          opacity: 0,
          duration: 0.3,
          onComplete: () => {
            card.remove();
            currentCard--;
          }
        });
      } else {
        // Snap back
        gsap.to(card, {
          x: 0,
          y: 0,
          rotation: 0,
          duration: 0.4,
          ease: "back.out(1.5)"
        });
        gsap.to(card.querySelectorAll(".like, .nope"), { opacity: 0 });
      }
    }
  });
});
```

### Stack Cards with Throw
```javascript
const stack = document.querySelector(".card-stack");
const cards = gsap.utils.toArray(".card");

cards.forEach((card, i) => {
  gsap.set(card, {
    zIndex: cards.length - i,
    y: i * -5,
    scale: 1 - i * 0.03
  });

  if (i === 0) {
    Draggable.create(card, {
      type: "x",
      inertia: true,
      onDragEnd: function() {
        if (Math.abs(this.x) > 100) {
          throwCard(card, this.x > 0 ? 1 : -1);
        } else {
          gsap.to(card, { x: 0, duration: 0.3 });
        }
      }
    });
  }
});

function throwCard(card, direction) {
  gsap.to(card, {
    x: direction * 400,
    rotation: direction * 20,
    duration: 0.4,
    onComplete: () => {
      stack.appendChild(card);
      gsap.set(card, { x: 0, rotation: 0 });
      updateStackOrder();
    }
  });
}
```

## Sliders & Controls

### Range Slider
```javascript
function createRangeSlider(container, options = {}) {
  const { min = 0, max = 100, step = 1, value = 50, onChange } = options;

  const track = container.querySelector(".track");
  const handle = container.querySelector(".handle");
  const fill = container.querySelector(".fill");
  const trackWidth = track.offsetWidth - handle.offsetWidth;

  // Set initial position
  const initialX = gsap.utils.mapRange(min, max, 0, trackWidth, value);
  gsap.set(handle, { x: initialX });
  gsap.set(fill, { width: initialX });

  Draggable.create(handle, {
    type: "x",
    bounds: track,
    liveSnap: {
      x: function(endValue) {
        const stepSize = trackWidth / ((max - min) / step);
        return Math.round(endValue / stepSize) * stepSize;
      }
    },
    onDrag: function() {
      const value = gsap.utils.mapRange(0, trackWidth, min, max, this.x);
      gsap.set(fill, { width: this.x });
      onChange?.(Math.round(value / step) * step);
    }
  });
}
```

### Circular Knob
```javascript
function createKnob(element, options = {}) {
  const { min = 0, max = 100, onChange } = options;

  Draggable.create(element, {
    type: "rotation",
    bounds: { minRotation: -135, maxRotation: 135 },
    inertia: true,
    snap: function(endValue) {
      return Math.round(endValue / 2.7) * 2.7;  // Snap every 1 unit
    },
    onDrag: function() {
      const value = gsap.utils.mapRange(-135, 135, min, max, this.rotation);
      onChange?.(Math.round(value));
    }
  });
}
```

### Color Picker 2D
```javascript
function create2DPicker(container, onChange) {
  const picker = container.querySelector(".picker");
  const handle = container.querySelector(".handle");

  Draggable.create(handle, {
    type: "x,y",
    bounds: picker,
    onDrag: function() {
      const saturation = this.x / picker.offsetWidth * 100;
      const brightness = 100 - (this.y / picker.offsetHeight * 100);
      onChange?.({ saturation, brightness });
    }
  });
}
```

## Scroll & Navigation

### Custom Scrollbar
```javascript
function createCustomScrollbar(content, scrollbar) {
  const thumb = scrollbar.querySelector(".thumb");
  const contentHeight = content.scrollHeight;
  const viewHeight = content.offsetHeight;
  const scrollbarHeight = scrollbar.offsetHeight;
  const thumbHeight = (viewHeight / contentHeight) * scrollbarHeight;

  gsap.set(thumb, { height: thumbHeight });

  Draggable.create(thumb, {
    type: "y",
    bounds: scrollbar,
    onDrag: function() {
      const scrollRatio = this.y / (scrollbarHeight - thumbHeight);
      content.scrollTop = scrollRatio * (contentHeight - viewHeight);
    }
  });

  // Sync with native scroll
  content.addEventListener("scroll", () => {
    if (!Draggable.get(thumb).isDragging) {
      const scrollRatio = content.scrollTop / (contentHeight - viewHeight);
      gsap.set(thumb, { y: scrollRatio * (scrollbarHeight - thumbHeight) });
    }
  });
}
```

### Pull to Refresh
```javascript
function setupPullToRefresh(container, onRefresh) {
  const indicator = container.querySelector(".refresh-indicator");
  let refreshing = false;

  Draggable.create(container, {
    type: "y",
    bounds: { minY: 0, maxY: 100 },
    edgeResistance: 0.9,
    onDrag: function() {
      if (!refreshing && this.y > 0) {
        const progress = Math.min(this.y / 80, 1);
        gsap.set(indicator, {
          opacity: progress,
          rotation: progress * 360
        });
      }
    },
    onDragEnd: function() {
      if (this.y >= 80 && !refreshing) {
        refreshing = true;
        gsap.to(container, { y: 60, duration: 0.3 });

        onRefresh?.().finally(() => {
          refreshing = false;
          gsap.to(container, { y: 0, duration: 0.3 });
          gsap.to(indicator, { opacity: 0 });
        });
      } else {
        gsap.to(container, { y: 0, duration: 0.3 });
        gsap.to(indicator, { opacity: 0 });
      }
    }
  });
}
```

## Interactive Elements

### Draggable Window
```javascript
function createDraggableWindow(windowEl) {
  const titleBar = windowEl.querySelector(".title-bar");
  const resizeHandle = windowEl.querySelector(".resize-handle");

  // Draggable from title bar
  Draggable.create(windowEl, {
    type: "x,y",
    bounds: "body",
    trigger: titleBar,
    cursor: "default",
    activeCursor: "grabbing",
    onPress: () => bringToFront(windowEl)
  });

  // Resizable from corner
  Draggable.create(resizeHandle, {
    type: "x,y",
    onDrag: function() {
      gsap.set(windowEl, {
        width: "+=" + this.deltaX,
        height: "+=" + this.deltaY
      });
    },
    cursor: "nwse-resize"
  });
}

function bringToFront(windowEl) {
  const windows = document.querySelectorAll(".window");
  windows.forEach(w => w.style.zIndex = 1);
  windowEl.style.zIndex = 2;
}
```

### Jigsaw Puzzle Piece
```javascript
function setupPuzzlePiece(piece, targetX, targetY, threshold = 20) {
  Draggable.create(piece, {
    type: "x,y",
    inertia: true,
    onDragEnd: function() {
      const dx = Math.abs(this.x - targetX);
      const dy = Math.abs(this.y - targetY);

      if (dx < threshold && dy < threshold) {
        // Snap to correct position
        gsap.to(piece, {
          x: targetX,
          y: targetY,
          duration: 0.2,
          onComplete: () => {
            this.disable();
            piece.classList.add("placed");
          }
        });
      }
    }
  });
}
```

### Canvas Pan & Zoom
```javascript
function setupCanvasControls(canvas, content) {
  let scale = 1;

  Draggable.create(content, {
    type: "x,y",
    inertia: true,
    bounds: function() {
      return {
        minX: canvas.offsetWidth - content.offsetWidth * scale,
        maxX: 0,
        minY: canvas.offsetHeight - content.offsetHeight * scale,
        maxY: 0
      };
    }
  });

  canvas.addEventListener("wheel", e => {
    e.preventDefault();
    const delta = e.deltaY > 0 ? 0.9 : 1.1;
    scale = gsap.utils.clamp(0.5, 3, scale * delta);

    gsap.to(content, {
      scale,
      duration: 0.2,
      onUpdate: () => Draggable.get(content).applyBounds()
    });
  });
}
```

## Games & Fun

### Wheel of Fortune
```javascript
function createSpinWheel(wheel, segments) {
  const segmentAngle = 360 / segments.length;

  Draggable.create(wheel, {
    type: "rotation",
    inertia: true,
    snap: function(endValue) {
      // Snap to segment center
      return Math.round(endValue / segmentAngle) * segmentAngle;
    },
    onThrowComplete: function() {
      const rotation = this.rotation % 360;
      const segmentIndex = Math.floor(((360 - rotation) % 360) / segmentAngle);
      console.log("Winner:", segments[segmentIndex]);
    }
  });
}
```

### Ball Physics
```javascript
function createBouncingBall(ball, container) {
  Draggable.create(ball, {
    type: "x,y",
    bounds: container,
    inertia: true,
    edgeResistance: 0.5,
    throwResistance: 500,
    onThrowUpdate: function() {
      // Add bounce effect at edges
      const bounds = this.bounds;
      if (this.x <= bounds.minX || this.x >= bounds.maxX) {
        gsap.to(ball, { scaleX: 0.8, scaleY: 1.2, duration: 0.1, yoyo: true, repeat: 1 });
      }
      if (this.y <= bounds.minY || this.y >= bounds.maxY) {
        gsap.to(ball, { scaleX: 1.2, scaleY: 0.8, duration: 0.1, yoyo: true, repeat: 1 });
      }
    }
  });
}
```

## Utility Functions

### Create Draggable List
```javascript
function createSortableList(container) {
  const items = gsap.utils.toArray(container.children);

  items.forEach(item => {
    Draggable.create(item, {
      type: "y",
      bounds: container,
      onDrag: function() {
        items.forEach(other => {
          if (other !== item && this.hitTest(other, "50%")) {
            const itemRect = item.getBoundingClientRect();
            const otherRect = other.getBoundingClientRect();

            if (itemRect.top < otherRect.top) {
              container.insertBefore(item, other);
            } else {
              container.insertBefore(item, other.nextSibling);
            }
          }
        });
      },
      onDragEnd: function() {
        gsap.to(item, { y: 0, duration: 0.2 });
      }
    });
  });
}
```

### Magnetic Snap
```javascript
function createMagneticDraggable(element, targets, threshold = 50) {
  Draggable.create(element, {
    type: "x,y",
    inertia: true,
    onDrag: function() {
      targets.forEach(target => {
        const targetRect = target.getBoundingClientRect();
        const elemRect = element.getBoundingClientRect();

        const dx = targetRect.left - elemRect.left;
        const dy = targetRect.top - elemRect.top;
        const distance = Math.sqrt(dx * dx + dy * dy);

        if (distance < threshold) {
          gsap.to(element, {
            x: this.x + dx,
            y: this.y + dy,
            duration: 0.2
          });
        }
      });
    }
  });
}
```
