# Natural Language to GSAP Mapping

Comprehensive mapping of natural language phrases to GSAP code.

## Movement Phrases

### From Directions
| Phrase | GSAP Code |
|--------|-----------|
| "from left" | `gsap.from(el, { x: -100, autoAlpha: 0 })` |
| "from the left" | `gsap.from(el, { x: -100, autoAlpha: 0 })` |
| "from right" | `gsap.from(el, { x: 100, autoAlpha: 0 })` |
| "from the right" | `gsap.from(el, { x: 100, autoAlpha: 0 })` |
| "from above" | `gsap.from(el, { y: -100, autoAlpha: 0 })` |
| "from top" | `gsap.from(el, { y: -100, autoAlpha: 0 })` |
| "from below" | `gsap.from(el, { y: 100, autoAlpha: 0 })` |
| "from bottom" | `gsap.from(el, { y: 100, autoAlpha: 0 })` |
| "from center" | `gsap.from(el, { scale: 0, autoAlpha: 0 })` |

### To Directions
| Phrase | GSAP Code |
|--------|-----------|
| "to the left" | `gsap.to(el, { x: -100 })` |
| "to the right" | `gsap.to(el, { x: 100 })` |
| "upward" / "up" | `gsap.to(el, { y: -100 })` |
| "downward" / "down" | `gsap.to(el, { y: 100 })` |
| "off screen left" | `gsap.to(el, { x: "-100vw" })` |
| "off screen right" | `gsap.to(el, { x: "100vw" })` |
| "off screen top" | `gsap.to(el, { y: "-100vh" })` |
| "off screen bottom" | `gsap.to(el, { y: "100vh" })` |

## Visibility Phrases

### Fade Effects
| Phrase | GSAP Code |
|--------|-----------|
| "fade in" | `gsap.from(el, { autoAlpha: 0 })` |
| "fade out" | `gsap.to(el, { autoAlpha: 0 })` |
| "appear" | `gsap.from(el, { autoAlpha: 0 })` |
| "disappear" | `gsap.to(el, { autoAlpha: 0 })` |
| "reveal" | `gsap.from(el, { autoAlpha: 0, y: 30 })` |
| "hide" | `gsap.to(el, { autoAlpha: 0 })` |
| "show" | `gsap.to(el, { autoAlpha: 1 })` |

### Combined Fade + Direction
| Phrase | GSAP Code |
|--------|-----------|
| "fade in from left" | `gsap.from(el, { x: -100, autoAlpha: 0, ease: "power3.out" })` |
| "fade in from right" | `gsap.from(el, { x: 100, autoAlpha: 0, ease: "power3.out" })` |
| "fade in from below" | `gsap.from(el, { y: 100, autoAlpha: 0, ease: "power3.out" })` |
| "fade in from above" | `gsap.from(el, { y: -100, autoAlpha: 0, ease: "power3.out" })` |
| "slide in from left" | `gsap.from(el, { x: -100, autoAlpha: 0, ease: "power3.out" })` |
| "slide in from right" | `gsap.from(el, { x: 100, autoAlpha: 0, ease: "power3.out" })` |
| "slide up" | `gsap.from(el, { y: 100, autoAlpha: 0, ease: "power3.out" })` |
| "slide down" | `gsap.from(el, { y: -100, autoAlpha: 0, ease: "power3.out" })` |

## Scale Phrases

| Phrase | GSAP Code |
|--------|-----------|
| "zoom in" | `gsap.from(el, { scale: 0, autoAlpha: 0 })` |
| "zoom out" | `gsap.to(el, { scale: 0, autoAlpha: 0 })` |
| "scale up" | `gsap.from(el, { scale: 0 })` |
| "scale down" | `gsap.to(el, { scale: 0 })` |
| "grow" | `gsap.from(el, { scale: 0.5 })` |
| "shrink" | `gsap.to(el, { scale: 0.5 })` |
| "pop in" | `gsap.from(el, { scale: 0, ease: "back.out(1.7)" })` |
| "pop out" | `gsap.to(el, { scale: 0, ease: "back.in(1.7)" })` |
| "pulse" | `gsap.to(el, { scale: 1.1, repeat: -1, yoyo: true })` |
| "heartbeat" | `gsap.to(el, { scale: 1.2, duration: 0.2, repeat: -1, yoyo: true })` |

## Rotation Phrases

| Phrase | GSAP Code |
|--------|-----------|
| "rotate" | `gsap.to(el, { rotation: 360 })` |
| "spin" | `gsap.to(el, { rotation: 360, repeat: -1, ease: "none" })` |
| "spin clockwise" | `gsap.to(el, { rotation: 360 })` |
| "spin counter-clockwise" | `gsap.to(el, { rotation: -360 })` |
| "rotate 90 degrees" | `gsap.to(el, { rotation: 90 })` |
| "rotate 180 degrees" | `gsap.to(el, { rotation: 180 })` |
| "flip" | `gsap.to(el, { rotationY: 180 })` |
| "flip horizontal" | `gsap.to(el, { rotationY: 180 })` |
| "flip vertical" | `gsap.to(el, { rotationX: 180 })` |
| "wobble" | `gsap.to(el, { rotation: 15, repeat: 5, yoyo: true, ease: "sine.inOut" })` |
| "shake" | `gsap.to(el, { x: 10, repeat: 5, yoyo: true, duration: 0.05 })` |

## Easing Phrases

| Phrase | GSAP Ease |
|--------|-----------|
| "smoothly" | `ease: "power2.out"` |
| "with bounce" | `ease: "bounce.out"` |
| "bounce in" | `ease: "bounce.out"` (with `from()`) |
| "elastic" | `ease: "elastic.out(1, 0.3)"` |
| "with overshoot" | `ease: "back.out(1.7)"` |
| "snappy" | `ease: "power4.out"` |
| "gentle" | `ease: "power1.out"` |
| "dramatic" | `ease: "expo.out"` |
| "linear" | `ease: "none"` |
| "ease in" | `ease: "power2.in"` |
| "ease out" | `ease: "power2.out"` |
| "ease in out" | `ease: "power2.inOut"` |

## Timing Phrases

| Phrase | GSAP Property |
|--------|---------------|
| "slowly" | `duration: 1.5` |
| "slow" | `duration: 1.2` |
| "quickly" | `duration: 0.3` |
| "fast" | `duration: 0.4` |
| "instantly" | `duration: 0` |
| "over 2 seconds" | `duration: 2` |
| "in 500ms" | `duration: 0.5` |
| "after 1 second" | `delay: 1` |
| "with delay" | `delay: 0.5` |
| "delayed by X" | `delay: X` |

## Stagger Phrases

| Phrase | GSAP Code |
|--------|-----------|
| "one by one" | `stagger: 0.1` |
| "stagger" | `stagger: 0.1` |
| "staggered" | `stagger: 0.1` |
| "with stagger" | `stagger: 0.1` |
| "from start" | `stagger: { each: 0.1, from: "start" }` |
| "from end" | `stagger: { each: 0.1, from: "end" }` |
| "from center" | `stagger: { each: 0.1, from: "center" }` |
| "random order" | `stagger: { each: 0.1, from: "random" }` |
| "grid" | `stagger: { grid: "auto", from: "center", amount: 1 }` |

## Loop Phrases

| Phrase | GSAP Property |
|--------|---------------|
| "loop" | `repeat: -1` |
| "infinite" | `repeat: -1` |
| "forever" | `repeat: -1` |
| "repeat X times" | `repeat: X` |
| "back and forth" | `repeat: -1, yoyo: true` |
| "yoyo" | `yoyo: true` |
| "alternate" | `yoyo: true` |

## Scroll Phrases (Route to /gsap-scroll)

| Phrase | Triggers |
|--------|----------|
| "on scroll" | ScrollTrigger |
| "when scrolling" | ScrollTrigger |
| "scroll triggered" | ScrollTrigger |
| "reveal on scroll" | ScrollTrigger with toggleActions |
| "parallax" | ScrollTrigger with scrub |
| "pin" / "sticky" | ScrollTrigger with pin |
| "scroll progress" | ScrollTrigger with scrub |

## Text Phrases (Route to /gsap-text)

| Phrase | Triggers |
|--------|----------|
| "typewriter" | SplitText + stagger |
| "type effect" | SplitText + stagger |
| "letter by letter" | SplitText chars |
| "character by character" | SplitText chars |
| "word by word" | SplitText words |
| "line by line" | SplitText lines |
| "text reveal" | SplitText + mask |
| "wave text" | SplitText + wave stagger |

## SVG Phrases (Route to /gsap-svg)

| Phrase | Triggers |
|--------|----------|
| "draw" | DrawSVG |
| "draw path" | DrawSVG |
| "morph" | MorphSVG |
| "morph shape" | MorphSVG |
| "follow path" | MotionPath |
| "along path" | MotionPath |

## 3D Phrases (Route to /gsap-3d)

| Phrase | Triggers |
|--------|----------|
| "3d flip" | rotationY/X + perspective |
| "card flip" | rotationY + backface |
| "cube" | 3D rotation |
| "perspective" | transformPerspective |
| "depth" | z + perspective |

## Combined Examples

| Natural Language | Full GSAP Code |
|------------------|----------------|
| "fade in hero from below with bounce" | `gsap.from(".hero", { y: 100, autoAlpha: 0, duration: 1, ease: "bounce.out" })` |
| "stagger cards from left one by one" | `gsap.from(".card", { x: -100, autoAlpha: 0, stagger: 0.15 })` |
| "spin logo infinitely" | `gsap.to(".logo", { rotation: 360, repeat: -1, ease: "none", duration: 2 })` |
| "pop in buttons with delay" | `gsap.from(".btn", { scale: 0, autoAlpha: 0, ease: "back.out(1.7)", delay: 0.5, stagger: 0.1 })` |
| "shake error message" | `gsap.to(".error", { x: 10, repeat: 5, yoyo: true, duration: 0.05 })` |
