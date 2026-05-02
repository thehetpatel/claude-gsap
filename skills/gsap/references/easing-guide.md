# GSAP Easing Guide

Complete reference for GSAP easing functions and when to use them.

## Easing Syntax

GSAP uses the format: `ease: "type.direction(config)"`

## Core Easing Types

### Power Easings (Most Common)
| Ease | Strength | Use Case |
|------|----------|----------|
| `power1` / `quad` | Subtle | Gentle transitions |
| `power2` / `cubic` | Moderate | General purpose (default-like) |
| `power3` / `quart` | Strong | Noticeable acceleration |
| `power4` / `quint` | Aggressive | Dramatic effect |

### Directions
| Direction | Description |
|-----------|-------------|
| `.in` | Start slow, end fast |
| `.out` | Start fast, end slow (most natural) |
| `.inOut` | Slow at both ends |

### Examples
```javascript
ease: "power2.out"    // Smooth deceleration (recommended default)
ease: "power3.inOut"  // Smooth start and end
ease: "power4.in"     // Dramatic acceleration
```

## Special Easings

### Bounce
Creates a bouncing effect at the end.
```javascript
ease: "bounce.out"     // Bounce at end
ease: "bounce.in"      // Bounce at start
ease: "bounce.inOut"   // Bounce at both ends
```
**Best for**: Playful UI, notifications, dropped items

### Elastic
Creates a spring-like overshoot effect.
```javascript
ease: "elastic.out(1, 0.3)"   // Standard elastic
ease: "elastic.out(1, 0.5)"   // Tighter spring
ease: "elastic.out(2, 0.3)"   // More amplitude
```
**Parameters**: `elastic.out(amplitude, period)`
- `amplitude`: How far past target (1 = normal, 2 = double)
- `period`: Spring tightness (0.3 = normal, lower = tighter)

**Best for**: Attention-grabbing elements, modals, tooltips

### Back
Overshoots then returns to target.
```javascript
ease: "back.out(1.7)"    // Standard overshoot
ease: "back.out(3)"      // Dramatic overshoot
ease: "back.in(1.7)"     // Pull back before moving
```
**Parameters**: `back.out(overshoot)`
- `overshoot`: How much to overshoot (1.7 = default)

**Best for**: Buttons, cards, playful interactions

### Expo
Extreme acceleration/deceleration (steeper than power4).
```javascript
ease: "expo.out"    // Very fast then slow
ease: "expo.inOut"  // Dramatic at both ends
```
**Best for**: Hero animations, dramatic reveals

### Circ
Circular motion feel (like a ball rolling).
```javascript
ease: "circ.out"
ease: "circ.inOut"
```
**Best for**: Natural motion, rolling effects

### Sine
Very gentle, subtle easing.
```javascript
ease: "sine.out"
ease: "sine.inOut"
```
**Best for**: Subtle transitions, background animations

## Linear (No Easing)
```javascript
ease: "none"    // or "linear"
```
**Best for**: Progress bars, continuous rotation, scrub animations

## Custom Easing

### Using steps()
```javascript
ease: "steps(5)"     // 5 discrete steps
ease: "steps(12)"    // 12 steps (like frames)
```
**Best for**: Sprite animations, typewriter effects

### Using slow()
```javascript
ease: "slow(0.7, 0.7, false)"
// Parameters: (linearRatio, power, yoyoMode)
```
**Best for**: Highlighting, emphasis

### Custom Bezier
```javascript
ease: "M0,0 C0.25,0.1 0.25,1 1,1"  // SVG path
```

## Easing Recommendations by Animation Type

### UI Elements
| Animation | Recommended Ease |
|-----------|------------------|
| Fade in/out | `power2.out` |
| Slide in | `power3.out` |
| Button hover | `power2.out` |
| Modal open | `back.out(1.7)` |
| Modal close | `power2.in` |
| Tooltip | `power3.out` |
| Dropdown | `power2.out` |

### Scroll Animations
| Animation | Recommended Ease |
|-----------|------------------|
| Scrub | `none` (linear) |
| Reveal | `power3.out` |
| Parallax | `none` |
| Pin snap | `power2.inOut` |

### Text Animations
| Animation | Recommended Ease |
|-----------|------------------|
| Typewriter | `steps(1)` or `none` |
| Wave | `sine.inOut` |
| Bounce letters | `back.out(1.7)` |
| Fade words | `power2.out` |

### Playful/Fun
| Animation | Recommended Ease |
|-----------|------------------|
| Bounce | `bounce.out` |
| Pop in | `elastic.out(1, 0.3)` |
| Wiggle | `elastic.out(1, 0.5)` |
| Drop | `bounce.out` |

### Professional/Corporate
| Animation | Recommended Ease |
|-----------|------------------|
| Any | `power2.out` or `power2.inOut` |
| Subtle | `sine.out` |
| Smooth | `circ.out` |

## Visual Reference

```
Linear:     ────────────────────
Power1.out: ═════════════───────
Power2.out: ══════════════──────
Power3.out: ═══════════════─────
Power4.out: ════════════════────
Expo.out:   ═════════════════───
Bounce.out: ════════╗╔═╗═──────
Elastic:    ══════╗══╝╔═╝────────
Back.out:   ═══════════╗────────
```

## Tips

1. **Default to `power2.out`** - It's the most natural feeling
2. **Match exit to entry** - If `.out` on enter, use `.in` on exit
3. **Use `.inOut` sparingly** - Good for longer animations
4. **Bounce/Elastic for attention** - But don't overuse
5. **Linear for scrub** - ScrollTrigger scrub should be linear
