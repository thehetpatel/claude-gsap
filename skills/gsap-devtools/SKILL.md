---
name: gsap-devtools
description: Debug and visualize GSAP animations with GSDevTools
version: 1.0.0
argument-hint: "[debugging scenario]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSDevTools - Animation Debugging

Visual UI for debugging, slowing down, and inspecting GSAP animations.

## Setup

```javascript
import { gsap } from "gsap";
import { GSDevTools } from "gsap/GSDevTools";

gsap.registerPlugin(GSDevTools);
```

## Basic Usage

```javascript
// Create dev tools panel
GSDevTools.create();
```

## Options

```javascript
GSDevTools.create({
  // Appearance
  animation: myTimeline,       // Specific animation to control
  container: "#devtools",      // Container element
  css: "top: 0; left: 50px;",  // Custom positioning
  minimal: false,              // Minimal mode for small screens

  // Behavior
  globalSync: true,            // Sync with global timeline
  hideGlobalTimeline: false,   // Hide global timeline option
  keyboard: true,              // Enable keyboard shortcuts
  loop: false,                 // Loop playback
  paused: false,               // Start paused
  persist: true,               // Remember settings
  timeScale: 1,                // Initial timescale
  visibility: "auto"           // "auto", "visible", "hidden"
});
```

## Targeting Specific Animations

```javascript
// Create timeline with ID
const tl = gsap.timeline({ id: "mainAnimation" });
tl.to(".box", { x: 100 })
  .to(".box", { y: 100 });

// DevTools shows this in dropdown
GSDevTools.create({
  animation: tl  // or animation: "mainAnimation"
});
```

## Multiple Animations

```javascript
// Give each animation an ID
const intro = gsap.timeline({ id: "intro" });
const main = gsap.timeline({ id: "main" });
const outro = gsap.timeline({ id: "outro" });

// DevTools dropdown shows all IDs
GSDevTools.create();
```

## In/Out Points

```javascript
// Set playback range
GSDevTools.create({
  inTime: 1,      // Start at 1 second
  outTime: 3      // End at 3 seconds
});
```

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| Space | Play/Pause |
| L | Toggle Loop |
| M | Toggle Minimal Mode |
| I | Set In Point |
| O | Set Out Point |
| ← | Jump Back 0.5s |
| → | Jump Forward 0.5s |
| Shift + ← | Previous Label |
| Shift + → | Next Label |

## Timeline Labels

```javascript
// Labels appear in DevTools scrubber
const tl = gsap.timeline({ id: "animation" });
tl.addLabel("start")
  .to(".hero", { opacity: 1 }, "start")
  .addLabel("middle")
  .to(".content", { y: 0 }, "middle")
  .addLabel("end")
  .to(".cta", { scale: 1 }, "end");

GSDevTools.create({ animation: tl });
// Click labels to jump to them
```

## Slow Motion Debugging

```javascript
// Use the slider to slow down animations
// Or set programmatically:
const devTools = GSDevTools.create();

// Set to 0.25x speed for debugging
devTools.find("timeline").timeScale(0.25);
```

## Minimal Mode

```javascript
// For smaller screens
GSDevTools.create({
  minimal: true
});
```

## Custom Container

```javascript
GSDevTools.create({
  container: "#my-debug-panel",
  css: "position: relative; width: 100%;"
});
```

## Development Only

```javascript
// Only load in development
if (process.env.NODE_ENV === "development") {
  import("gsap/GSDevTools").then(({ GSDevTools }) => {
    gsap.registerPlugin(GSDevTools);
    GSDevTools.create();
  });
}
```

## React Integration

```jsx
import { useEffect } from "react";
import { gsap } from "gsap";

// Conditional import
const loadDevTools = async () => {
  if (process.env.NODE_ENV === "development") {
    const { GSDevTools } = await import("gsap/GSDevTools");
    gsap.registerPlugin(GSDevTools);
    return GSDevTools;
  }
  return null;
};

function App() {
  useEffect(() => {
    let devTools;

    loadDevTools().then(GSDevTools => {
      if (GSDevTools) {
        devTools = GSDevTools.create();
      }
    });

    return () => {
      if (devTools) devTools.kill();
    };
  }, []);

  return <div>...</div>;
}
```

## Common Debug Scenarios

### Animation Not Playing
```javascript
// Check if animation exists in DevTools dropdown
GSDevTools.create({ globalSync: true });

// Verify animation is not paused
console.log(tl.paused());  // Should be false
console.log(tl.progress()); // Check progress
```

### Timing Issues
```javascript
// Slow down to inspect timing
GSDevTools.create({ timeScale: 0.1 });

// Or use the slider to scrub through manually
```

### Finding Overlap Issues
```javascript
// Add labels at key points
tl.addLabel("overlap-check", 2);
tl.addLabel("issue-area", 2.5);

GSDevTools.create({ animation: tl });
// Use keyboard shortcuts to jump between labels
```

### ScrollTrigger Debugging
```javascript
// Note: GSDevTools doesn't control ScrollTrigger scrub
// Use ScrollTrigger markers instead
ScrollTrigger.create({
  trigger: ".section",
  markers: true,  // Visual markers
  onUpdate: (self) => console.log(self.progress)
});
```

## Alternative: Timeline Viewer

For lightweight debugging without GSDevTools:

```javascript
// Console-based debugging
const tl = gsap.timeline({
  onUpdate: () => console.log("Progress:", tl.progress().toFixed(2)),
  onComplete: () => console.log("Complete!")
});
```

## Performance Note

GSDevTools monitors the root timeline, which has a slight performance cost. Only use during development:

```javascript
// Production build should not include GSDevTools
// Use dynamic imports and environment checks
```

## Methods

```javascript
const devTools = GSDevTools.create();

// Control programmatically
devTools.minimal(true);    // Toggle minimal mode
devTools.kill();           // Remove DevTools
```

## Natural Language Mapping

| User Says | Implementation |
|-----------|---------------|
| "debug animation" | GSDevTools.create() |
| "slow motion" | timeScale slider |
| "pause at frame" | Set in/out points |
| "inspect timeline" | GSDevTools with animation ID |
| "jump to label" | Shift + arrow keys |
| "loop section" | Set in/out + loop toggle |
