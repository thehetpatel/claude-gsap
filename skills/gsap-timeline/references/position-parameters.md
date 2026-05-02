# GSAP Timeline Position Parameters

Complete reference for timeline positioning and sequencing.

## Position Parameter Overview

The position parameter is the **third argument** in timeline methods:

```javascript
tl.to(target, vars, position)
tl.from(target, vars, position)
tl.fromTo(target, fromVars, toVars, position)
tl.add(animation, position)
tl.addLabel(label, position)
```

## Position Types

### 1. Absolute Time (Number)
Place animation at exact time in seconds.

```javascript
tl.to(".el", { x: 100 }, 0)      // Start at 0 seconds
tl.to(".el", { x: 100 }, 1)      // Start at 1 second
tl.to(".el", { x: 100 }, 2.5)    // Start at 2.5 seconds
```

**Visual:**
```
Time:  0    1    2    3
       |──A──|
            |──B──|
                  |──C──|
```

### 2. Relative to End of Timeline (String with += or -=)
Position relative to where timeline currently ends.

```javascript
tl.to(".el", { x: 100 }, "+=0")     // Start at end (default)
tl.to(".el", { x: 100 }, "+=0.5")   // 0.5s gap after end
tl.to(".el", { x: 100 }, "-=0.5")   // 0.5s overlap with end
```

**Visual (sequential - default `"+=0"`):**
```
Timeline: |──A──|──B──|──C──|
          0    1    2    3
```

**Visual (with gap `"+=0.5"`):**
```
Timeline: |──A──|   |──B──|
          0    1 1.5  2
```

**Visual (with overlap `"-=0.5"`):**
```
Timeline: |──A──|
              |──B──|
          0    0.5  1.5
```

### 3. Relative to Previous Animation Start (<)
Align with when the previous animation **started**.

```javascript
tl.to(".a", { x: 100, duration: 1 })
  .to(".b", { x: 100 }, "<")      // Same time as .a starts

tl.to(".a", { x: 100, duration: 1 })
  .to(".b", { x: 100 }, "<0.5")   // 0.5s after .a starts

tl.to(".a", { x: 100, duration: 1 })
  .to(".b", { x: 100 }, "<-0.5")  // 0.5s before .a starts
```

**Visual (`"<"` - simultaneous start):**
```
Timeline: |──A──|
          |──B──|
          0    1
```

**Visual (`"<0.5"` - offset from start):**
```
Timeline: |──A──|
             |──B──|
          0  0.5  1.5
```

### 4. Relative to Previous Animation End (>)
Align with when the previous animation **ended**.

```javascript
tl.to(".a", { x: 100, duration: 1 })
  .to(".b", { x: 100 }, ">")       // When .a ends (same as default)

tl.to(".a", { x: 100, duration: 1 })
  .to(".b", { x: 100 }, ">-0.5")   // 0.5s before .a ends

tl.to(".a", { x: 100, duration: 1 })
  .to(".b", { x: 100 }, ">0.5")    // 0.5s after .a ends
```

**Visual (`">"` - after end):**
```
Timeline: |──A──|──B──|
          0    1    2
```

**Visual (`">-0.5"` - overlap with end):**
```
Timeline: |──A──|
              |──B──|
          0  0.5  1.5
```

### 5. Labels (String)
Jump to a named position in the timeline.

```javascript
tl.addLabel("section1", 0)
  .to(".a", { x: 100 })
  .addLabel("section2")
  .to(".b", { x: 100 }, "section1")     // At section1 label
  .to(".c", { x: 100 }, "section2+=0.5") // 0.5s after section2
```

## Comparison Table

| Position | Meaning |
|----------|---------|
| `0` | At time 0 |
| `1` | At time 1 second |
| `"+=0"` | End of timeline (default) |
| `"+=1"` | 1s after end of timeline |
| `"-=0.5"` | 0.5s before end of timeline |
| `"<"` | When previous starts |
| `"<0.5"` | 0.5s after previous starts |
| `"<-0.3"` | 0.3s before previous starts |
| `">"` | When previous ends |
| `">0.5"` | 0.5s after previous ends |
| `">-0.3"` | 0.3s before previous ends |
| `"myLabel"` | At label position |
| `"myLabel+=0.5"` | 0.5s after label |

## Common Patterns

### Sequential (Default)
```javascript
tl.to(".a", { x: 100 })     // Starts at 0
  .to(".b", { x: 100 })     // Starts when A ends
  .to(".c", { x: 100 });    // Starts when B ends
```

### Simultaneous
```javascript
tl.to(".a", { x: 100 })
  .to(".b", { y: 100 }, "<")   // Same time as A
  .to(".c", { scale: 2 }, "<"); // Same time as A
```

### Staggered Start
```javascript
tl.to(".a", { x: 100 })
  .to(".b", { y: 100 }, "<0.2")  // 0.2s after A starts
  .to(".c", { scale: 2 }, "<0.2"); // 0.2s after B starts
```

### Overlap Previous
```javascript
tl.to(".a", { x: 100, duration: 1 })
  .to(".b", { y: 100, duration: 1 }, "-=0.3")   // Overlaps A by 0.3s
  .to(".c", { scale: 2, duration: 1 }, "-=0.3"); // Overlaps B by 0.3s
```

### Multiple at Same Time
```javascript
// All start at time 0
tl.to(".a", { x: 100 }, 0)
  .to(".b", { y: 100 }, 0)
  .to(".c", { rotation: 180 }, 0);

// Or using <
tl.to(".a", { x: 100 })
  .to(".b", { y: 100 }, "<")
  .to(".c", { rotation: 180 }, "<");
```

### Complex Sequence
```javascript
const tl = gsap.timeline();

// Phase 1: Background and header together
tl.from(".bg", { scale: 1.2, duration: 1 })
  .from(".header", { y: -100, autoAlpha: 0 }, "<");

// Phase 2: Content staggered, overlapping with Phase 1
tl.from(".title", { y: 50, autoAlpha: 0 }, "-=0.5")
  .from(".subtitle", { y: 30, autoAlpha: 0 }, "-=0.3");

// Phase 3: CTA button after content
tl.from(".cta", {
  scale: 0,
  autoAlpha: 0,
  ease: "back.out(1.7)"
}, "-=0.2");
```

## Using Labels

### Basic Labels
```javascript
tl.addLabel("intro")
  .from(".logo", { autoAlpha: 0 })
  .from(".tagline", { y: 20, autoAlpha: 0 })
  .addLabel("content")
  .from(".card", { y: 50, autoAlpha: 0, stagger: 0.1 })
  .addLabel("outro")
  .from(".footer", { autoAlpha: 0 });

// Jump to sections
tl.play("content");
tl.seek("outro");
```

### Labels with Position
```javascript
tl.addLabel("start", 0)
  .addLabel("middle", 2)
  .addLabel("end", 4);

tl.to(".a", { x: 100 }, "start")
  .to(".b", { x: 100 }, "middle")
  .to(".c", { x: 100 }, "end");
```

### Relative to Labels
```javascript
tl.addLabel("reveal")
  .to(".item1", { autoAlpha: 1 }, "reveal")
  .to(".item2", { autoAlpha: 1 }, "reveal+=0.1")
  .to(".item3", { autoAlpha: 1 }, "reveal+=0.2")
  .to(".item4", { autoAlpha: 1 }, "reveal+=0.3");
```

## Tips & Best Practices

### 1. Use Variables for Reusable Offsets
```javascript
const overlap = 0.3;
const stagger = 0.1;

tl.from(".a", { y: 50 })
  .from(".b", { y: 50 }, `-=${overlap}`)
  .from(".c", { y: 50 }, `-=${overlap}`);
```

### 2. Comment Complex Sequences
```javascript
tl
  // Header reveals first
  .from(".header", { y: -100 })

  // Hero content follows immediately
  .from(".hero-content", { autoAlpha: 0 }, "-=0.3")

  // Cards stagger in
  .from(".card", { y: 50, stagger: 0.1 }, "-=0.2");
```

### 3. Use < for Parallel Animations
```javascript
// These all animate together
tl.to(".box", { x: 100 })
  .to(".box", { rotation: 180 }, "<")   // Clearer intent
  .to(".box", { backgroundColor: "red" }, "<");
```

### 4. Test with Slower Duration
```javascript
// For debugging, slow down entire timeline
tl.timeScale(0.5);

// Or add markers at key points
tl.addLabel("debug-point-1")
  .call(() => console.log("Reached point 1"));
```

### 5. Handle Dynamic Durations
```javascript
tl.to(".a", { x: 100, duration: 1 })
  .to(".b", { y: 100 }, "-=0.3") // Fixed overlap

// vs percentage-based (use onComplete)
tl.to(".a", { x: 100, duration: 1 })
  .to(".b", { y: 100 }, "<0.7"); // 70% through A's duration
```

## Debugging Positions

### Log Timeline State
```javascript
tl.eventCallback("onUpdate", () => {
  console.log("Progress:", tl.progress());
  console.log("Time:", tl.time());
  console.log("Duration:", tl.duration());
});
```

### Get Child Positions
```javascript
tl.getChildren().forEach((child, i) => {
  console.log(`Animation ${i}: starts at ${child.startTime()}`);
});
```

### Visual Debug
```javascript
// Add GSDevTools for visual debugging
GSDevTools.create({ animation: tl });
```
