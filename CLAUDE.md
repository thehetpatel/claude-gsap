# Claude GSAP Animation Plugin

This plugin provides Claude Code with comprehensive GSAP animation generation capabilities, transforming natural language descriptions into production-ready animation code.

## Plugin Structure

### Skills (User-Invocable Commands)

| Skill | Command | Purpose |
|-------|---------|---------|
| gsap | `/gsap` | Main orchestrator - routes to appropriate sub-skill |
| gsap-scroll | `/gsap-scroll` | ScrollTrigger animations |
| gsap-timeline | `/gsap-timeline` | Timeline sequencing |
| gsap-text | `/gsap-text` | SplitText animations |
| gsap-svg | `/gsap-svg` | SVG animations (DrawSVG, MorphSVG, MotionPath) |
| gsap-3d | `/gsap-3d` | 3D transform animations |
| gsap-effects | `/gsap-effects` | 50+ effect presets |
| gsap-performance | `/gsap-optimize` | Performance analysis |
| gsap-framework | `/gsap-convert` | Framework integration |
| gsap-flip | `/gsap-flip` | Layout animations (FLIP technique) |
| gsap-draggable | `/gsap-draggable` | Drag, swipe, throw interactions |
| gsap-scroll-smoother | `/gsap-smooth` | Smooth scrolling & Observer |
| gsap-custom-ease | `/gsap-ease` | Custom easing curves |
| gsap-physics | `/gsap-physics` | Physics-based animations |
| gsap-utils | `/gsap-utils` | GSAP utility methods |
| gsap-canvas | `/gsap-canvas` | PixiJS & EaselJS animations |
| gsap-devtools | `/gsap-debug` | Animation debugging with GSDevTools |
| gsap-core | `/gsap-core` | Core features (context, matchMedia, staggers) |

### Agents (Background Specialists)

| Agent | Purpose |
|-------|---------|
| gsap-translator | Natural language → GSAP code translation |
| gsap-scroll-builder | ScrollTrigger configuration expert |
| gsap-timeline-composer | Complex sequence building |
| gsap-text-animator | Text animation specialist |
| gsap-optimizer | Performance analysis and optimization |
| gsap-debugger | Troubleshooting and debugging |

## Usage Patterns

### Basic Animation
```
/gsap fade in hero section from below
```

### ScrollTrigger
```
/gsap-scroll parallax background with 50% speed
```

### Timeline Sequence
```
/gsap-timeline stagger cards then reveal button
```

### Text Animation
```
/gsap-text typewriter effect on heading
```

### Framework Conversion
```
/gsap-convert react useGSAP hook
```

### Flip Layout Animation
```
/gsap-flip animate grid to list transition
```

### Draggable Interactions
```
/gsap-draggable swipe cards with throw momentum
```

### Smooth Scrolling
```
/gsap-smooth parallax with data-speed attributes
```

### Custom Easing
```
/gsap-ease create bounce with squash effect
```

### Physics Animation
```
/gsap-physics throw ball with gravity and bounce
```

### Utility Methods
```
/gsap-utils map scroll position to rotation
```

### Canvas Animation (PixiJS)
```
/gsap-canvas animate pixi sprite with tint and scale
```

### Debug Animations
```
/gsap-debug setup GSDevTools for timeline
```

### Core Features
```
/gsap-core setup matchMedia responsive animations
```

## Best Practices Enforced

1. **GPU-Accelerated Properties**: Always uses `x`, `y`, `rotation`, `scale` instead of `left`, `top`, `transform`
2. **autoAlpha**: Uses `autoAlpha` instead of `opacity` alone to handle visibility
3. **Cleanup**: Includes cleanup code for React/Vue components
4. **Plugin Registration**: Ensures proper `gsap.registerPlugin()` calls
5. **Accessibility**: Respects `prefers-reduced-motion` media query

## Reference Files

Each skill includes reference files with:
- Syntax guides
- Pattern libraries
- Best practices
- Common pitfalls

## Integration

This plugin integrates with Claude Code's skill system and can be invoked via slash commands or natural language requests for GSAP animation assistance.
