# ScrollTrigger Animation Patterns

Ready-to-use patterns for common scroll animations.

## Reveal Patterns

### Basic Fade Up
```javascript
gsap.from(".reveal-element", {
  y: 60,
  autoAlpha: 0,
  duration: 1,
  ease: "power3.out",
  scrollTrigger: {
    trigger: ".reveal-element",
    start: "top 85%",
    toggleActions: "play none none reverse"
  }
});
```

### Staggered Cards
```javascript
gsap.from(".card", {
  y: 100,
  autoAlpha: 0,
  duration: 0.8,
  stagger: 0.15,
  ease: "power3.out",
  scrollTrigger: {
    trigger: ".cards-container",
    start: "top 75%",
    toggleActions: "play none none reverse"
  }
});
```

### Batch Reveal (Performance Optimized)
```javascript
ScrollTrigger.batch(".batch-item", {
  onEnter: (batch) => {
    gsap.from(batch, {
      y: 80,
      autoAlpha: 0,
      duration: 0.6,
      stagger: 0.1,
      ease: "power2.out"
    });
  },
  start: "top 85%",
  once: true
});
```

### Split Reveal (Left/Right)
```javascript
gsap.from(".reveal-left", {
  x: -100,
  autoAlpha: 0,
  duration: 1,
  ease: "power3.out",
  scrollTrigger: {
    trigger: ".reveal-left",
    start: "top 80%"
  }
});

gsap.from(".reveal-right", {
  x: 100,
  autoAlpha: 0,
  duration: 1,
  ease: "power3.out",
  scrollTrigger: {
    trigger: ".reveal-right",
    start: "top 80%"
  }
});
```

### Scale Reveal
```javascript
gsap.from(".scale-reveal", {
  scale: 0.8,
  autoAlpha: 0,
  duration: 1,
  ease: "back.out(1.4)",
  scrollTrigger: {
    trigger: ".scale-reveal",
    start: "top 80%"
  }
});
```

### Clip Path Reveal
```javascript
gsap.from(".clip-reveal", {
  clipPath: "inset(0 100% 0 0)",
  duration: 1.2,
  ease: "power3.inOut",
  scrollTrigger: {
    trigger: ".clip-reveal",
    start: "top 75%"
  }
});
```

## Parallax Patterns

### Background Parallax (Slow)
```javascript
gsap.to(".parallax-bg", {
  y: "-25%",
  ease: "none",
  scrollTrigger: {
    trigger: ".parallax-section",
    start: "top bottom",
    end: "bottom top",
    scrub: true
  }
});
```

### Foreground Parallax (Fast)
```javascript
gsap.to(".parallax-fg", {
  y: "50%",
  ease: "none",
  scrollTrigger: {
    trigger: ".parallax-section",
    start: "top bottom",
    end: "bottom top",
    scrub: true
  }
});
```

### Multi-Layer Parallax
```javascript
const layers = [
  { selector: ".layer-1", speed: 0.2 },
  { selector: ".layer-2", speed: 0.4 },
  { selector: ".layer-3", speed: 0.6 },
  { selector: ".layer-4", speed: 0.8 }
];

layers.forEach(({ selector, speed }) => {
  gsap.to(selector, {
    y: () => window.innerHeight * speed,
    ease: "none",
    scrollTrigger: {
      trigger: ".parallax-container",
      start: "top top",
      end: "bottom top",
      scrub: true
    }
  });
});
```

### Hero Parallax with Fade
```javascript
const heroTl = gsap.timeline({
  scrollTrigger: {
    trigger: ".hero",
    start: "top top",
    end: "bottom top",
    scrub: true
  }
});

heroTl
  .to(".hero-bg", { y: "30%", scale: 1.1 }, 0)
  .to(".hero-content", { y: "50%", autoAlpha: 0 }, 0);
```

## Pin Patterns

### Simple Pin
```javascript
ScrollTrigger.create({
  trigger: ".pinned-section",
  start: "top top",
  end: "+=1000",
  pin: true,
  pinSpacing: true
});
```

### Pin with Animation
```javascript
gsap.to(".pinned-content", {
  scale: 1.5,
  rotation: 360,
  scrollTrigger: {
    trigger: ".pin-section",
    start: "top top",
    end: "+=800",
    pin: true,
    scrub: 1
  }
});
```

### Pin Without Spacing
```javascript
ScrollTrigger.create({
  trigger: ".sticky-element",
  start: "top 80px",
  end: "bottom top",
  pin: true,
  pinSpacing: false
});
```

### Sequential Pins
```javascript
const sections = gsap.utils.toArray(".pin-section");

sections.forEach((section, i) => {
  ScrollTrigger.create({
    trigger: section,
    start: "top top",
    end: i === sections.length - 1 ? "bottom bottom" : "bottom top",
    pin: true,
    pinSpacing: false
  });
});
```

## Horizontal Scroll Patterns

### Basic Horizontal Scroll
```javascript
const panels = gsap.utils.toArray(".panel");
const panelWidth = panels[0].offsetWidth;

gsap.to(panels, {
  x: () => -(panelWidth * (panels.length - 1)),
  ease: "none",
  scrollTrigger: {
    trigger: ".horizontal-container",
    pin: true,
    scrub: 1,
    end: () => "+=" + (panelWidth * (panels.length - 1))
  }
});
```

### Horizontal with Snap
```javascript
const panels = gsap.utils.toArray(".panel");

gsap.to(".panels-wrapper", {
  x: () => -(panels[0].offsetWidth * (panels.length - 1)),
  ease: "none",
  scrollTrigger: {
    trigger: ".horizontal-container",
    pin: true,
    scrub: 0.5,
    snap: 1 / (panels.length - 1),
    end: () => "+=" + (panels[0].offsetWidth * (panels.length - 1))
  }
});
```

### Horizontal Scroll with Progress
```javascript
const tl = gsap.timeline({
  scrollTrigger: {
    trigger: ".horizontal-section",
    pin: true,
    scrub: 1,
    end: "+=3000"
  }
});

tl.to(".panels", { x: "-300vw", ease: "none" })
  .to(".progress-bar", { scaleX: 1, ease: "none" }, 0);
```

## Progress Indicators

### Reading Progress Bar
```javascript
gsap.to(".progress-bar", {
  scaleX: 1,
  ease: "none",
  transformOrigin: "left center",
  scrollTrigger: {
    trigger: document.body,
    start: "top top",
    end: "bottom bottom",
    scrub: 0.3
  }
});
```

### Section Progress
```javascript
gsap.utils.toArray(".section").forEach((section, i) => {
  gsap.to(`.dot-${i}`, {
    backgroundColor: "#00ff00",
    scale: 1.5,
    scrollTrigger: {
      trigger: section,
      start: "top center",
      end: "bottom center",
      toggleActions: "play reverse play reverse"
    }
  });
});
```

### Number Counter
```javascript
gsap.to(".counter", {
  innerText: 100,
  snap: { innerText: 1 },
  scrollTrigger: {
    trigger: ".counter-section",
    start: "top center",
    end: "bottom center",
    scrub: true
  }
});
```

## Navigation Patterns

### Nav Background on Scroll
```javascript
ScrollTrigger.create({
  trigger: ".hero",
  start: "bottom top+=80",
  onEnter: () => gsap.to(".nav", { backgroundColor: "#000", duration: 0.3 }),
  onLeaveBack: () => gsap.to(".nav", { backgroundColor: "transparent", duration: 0.3 })
});
```

### Hide/Show Nav on Scroll
```javascript
let lastScroll = 0;

ScrollTrigger.create({
  onUpdate: (self) => {
    const scroll = self.scroll();
    if (scroll > lastScroll && scroll > 100) {
      gsap.to(".nav", { y: -100, duration: 0.3 });
    } else {
      gsap.to(".nav", { y: 0, duration: 0.3 });
    }
    lastScroll = scroll;
  }
});
```

### Active Section Highlighting
```javascript
gsap.utils.toArray(".section").forEach((section) => {
  const id = section.getAttribute("id");

  ScrollTrigger.create({
    trigger: section,
    start: "top center",
    end: "bottom center",
    onToggle: ({ isActive }) => {
      const link = document.querySelector(`a[href="#${id}"]`);
      link.classList.toggle("active", isActive);
    }
  });
});
```

## Animation Timeline Patterns

### Sequence on Scroll
```javascript
const tl = gsap.timeline({
  scrollTrigger: {
    trigger: ".sequence-section",
    start: "top center",
    end: "bottom center",
    scrub: 1
  }
});

tl.from(".item-1", { x: -100, autoAlpha: 0 })
  .from(".item-2", { y: 100, autoAlpha: 0 })
  .from(".item-3", { x: 100, autoAlpha: 0 })
  .from(".item-4", { scale: 0, autoAlpha: 0 });
```

### Pinned Story Sequence
```javascript
const tl = gsap.timeline({
  scrollTrigger: {
    trigger: ".story-section",
    start: "top top",
    end: "+=3000",
    pin: true,
    scrub: 1
  }
});

tl.to(".slide-1", { autoAlpha: 0 })
  .from(".slide-2", { autoAlpha: 0 })
  .to(".slide-2", { autoAlpha: 0 })
  .from(".slide-3", { autoAlpha: 0 });
```

## Performance Patterns

### Lazy Loading Animations
```javascript
ScrollTrigger.batch(".lazy-animate", {
  onEnter: (batch) => {
    batch.forEach(el => {
      el.classList.add("animate");
    });
  },
  start: "top 90%",
  once: true
});
```

### Throttled Updates
```javascript
let rafId;

ScrollTrigger.create({
  onUpdate: () => {
    if (rafId) return;
    rafId = requestAnimationFrame(() => {
      // Heavy operations here
      rafId = null;
    });
  }
});
```

### Media Query Handling
```javascript
ScrollTrigger.matchMedia({
  "(min-width: 1024px)": function() {
    // Desktop animations
    gsap.to(".element", {
      x: 500,
      scrollTrigger: { trigger: ".element" }
    });
  },
  "(max-width: 1023px)": function() {
    // Tablet/mobile animations
    gsap.to(".element", {
      x: 100,
      scrollTrigger: { trigger: ".element" }
    });
  }
});
```

## Refresh Handling

### Resize Handler
```javascript
let resizeTimer;

window.addEventListener("resize", () => {
  clearTimeout(resizeTimer);
  resizeTimer = setTimeout(() => {
    ScrollTrigger.refresh();
  }, 250);
});
```

### Dynamic Content
```javascript
// After adding new content
ScrollTrigger.refresh();

// Or sort all ScrollTriggers
ScrollTrigger.sort();
ScrollTrigger.refresh();
```
