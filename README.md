# Claude GSAP Animation Skill

Transform natural language animation descriptions into production-ready GSAP code.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GSAP](https://img.shields.io/badge/GSAP-3.12+-88CE02.svg)](https://greensock.com/gsap/)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Skill-blueviolet.svg)](https://claude.ai)
[![Plugins](https://img.shields.io/badge/Plugins-30%2B-green.svg)](https://gsap.com)

---

## 🎯 What is This?

This is a **Claude Code Skill** - a knowledge package that teaches Claude AI how to generate professional GSAP animations from simple natural language descriptions.

> 🎉 **All GSAP plugins are 100% FREE** since Webflow's 2024 acquisition!

### Before This Skill
```
User: "I need a scroll animation for my hero section"
Claude: *gives generic, possibly incorrect GSAP code*
```

### After This Skill
```
User: /gsap-scroll parallax hero with pinned navigation
Claude: *generates production-ready ScrollTrigger code with proper setup, cleanup, and best practices*
```

---

## 🚀 For Prompt Engineers

### Why Use This Skill?

| Problem | Solution |
|---------|----------|
| GSAP has complex syntax | Natural language → perfect code |
| ScrollTrigger start/end confusion | Pre-built patterns with explanations |
| Timeline position parameters | Visual examples and syntax guide |
| Framework cleanup issues | Auto-includes React/Vue cleanup |
| Performance pitfalls | GPU-accelerated code by default |
| Plugin registration errors | Always includes proper imports |

### How It Helps You

1. **Skip the Learning Curve**: Don't memorize GSAP syntax - describe what you want
2. **Production-Ready Code**: Output includes imports, registration, and cleanup
3. **Best Practices Built-In**: GPU acceleration, autoAlpha, proper easing
4. **Framework Support**: React, Vue, Next.js patterns included
5. **30 Plugin Coverage**: Every GSAP plugin documented and accessible

### Natural Language Examples

Just describe what you want:

```
"fade in cards from below with stagger"
"parallax background at half speed"
"typewriter effect on the heading"
"drag cards left/right like Tinder"
"bounce logo when page loads"
"draw SVG logo path on scroll"
"smooth scroll with parallax sections"
"3D card flip on hover"
"physics-based throw animation"
"scramble text like hacker effect"
```

---

## 📦 Installation

### Quick Install (Unix/macOS)

```bash
curl -fsSL https://raw.githubusercontent.com/thehetpatel/claude-gsap/main/install.sh | bash
```

### Manual Install

```bash
git clone https://github.com/thehetpatel/claude-gsap.git
cd claude-gsap
./install.sh
```

### Windows

```powershell
irm https://raw.githubusercontent.com/thehetpatel/claude-gsap/main/install.ps1 | iex
```

### Verify Installation

Commands are installed to: `~/.claude/commands/`

After installation, restart Claude Code and test with:
```
/gsap fade in hero section
```

---

## 💡 How to Use

### Basic Pattern

```
/[command] [natural language description]
```

### Examples by Command

#### `/gsap` - General Animations
```
/gsap fade in hero section from below
/gsap bounce in cards with stagger
/gsap rotate logo 360 degrees smoothly
/gsap scale up button on hover
```

#### `/gsap-scroll` - ScrollTrigger
```
/gsap-scroll reveal sections on scroll
/gsap-scroll parallax background at 50% speed
/gsap-scroll pin navigation during hero scroll
/gsap-scroll horizontal scroll gallery
```

#### `/gsap-timeline` - Sequences
```
/gsap-timeline fade logo then slide menu then reveal CTA
/gsap-timeline stagger cards from center then bounce button
/gsap-timeline intro animation with 3 stages
```

#### `/gsap-text` - Text Effects
```
/gsap-text typewriter effect on headline
/gsap-text wave animation on title letters
/gsap-text scramble decode effect
/gsap-text split words and fade up
```

#### `/gsap-flip` - Layout Animations
```
/gsap-flip grid to list transition
/gsap-flip filter gallery items
/gsap-flip accordion expand animation
```

#### `/gsap-draggable` - Interactions
```
/gsap-draggable swipe cards like Tinder
/gsap-draggable sortable list
/gsap-draggable spin wheel with momentum
```

---

## 📋 All Commands

| Command | Purpose | Example |
|---------|---------|---------|
| `/gsap` | General animations | `/gsap fade in cards from below` |
| `/gsap-scroll` | ScrollTrigger | `/gsap-scroll parallax hero` |
| `/gsap-timeline` | Sequences | `/gsap-timeline stagger then reveal` |
| `/gsap-text` | Text animations | `/gsap-text typewriter heading` |
| `/gsap-svg` | SVG animations | `/gsap-svg draw logo path` |
| `/gsap-3d` | 3D transforms | `/gsap-3d flip card on hover` |
| `/gsap-effects` | Effect presets | `/gsap-effects list scroll-reveals` |
| `/gsap-flip` | Layout animations | `/gsap-flip grid to list` |
| `/gsap-draggable` | Drag interactions | `/gsap-draggable swipe cards` |
| `/gsap-smooth` | Smooth scrolling | `/gsap-smooth parallax page` |
| `/gsap-ease` | Custom easing | `/gsap-ease bounce with squash` |
| `/gsap-physics` | Physics animations | `/gsap-physics throw with gravity` |
| `/gsap-utils` | Utility methods | `/gsap-utils clamp value` |
| `/gsap-canvas` | PixiJS/Easel | `/gsap-canvas sprite animation` |
| `/gsap-debug` | Debugging | `/gsap-debug timeline inspector` |
| `/gsap-core` | Core features | `/gsap-core matchMedia responsive` |
| `/gsap-optimize` | Performance | `/gsap-optimize [code]` |
| `/gsap-convert` | Framework conversion | `/gsap-convert react` |

---

## 🎬 Output Examples

### Input
```
/gsap fade in hero section from below with bounce
```

### Output
```javascript
gsap.from(".hero", {
  y: 100,
  autoAlpha: 0,
  duration: 1,
  ease: "back.out(1.7)"
});
```

---

### Input
```
/gsap-scroll pin header while scrolling through sections
```

### Output
```javascript
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

gsap.registerPlugin(ScrollTrigger);

ScrollTrigger.create({
  trigger: ".sections",
  start: "top top",
  end: "bottom bottom",
  pin: ".header",
  pinSpacing: false
});
```

---

### Input
```
/gsap-text typewriter effect on heading
```

### Output
```javascript
import { gsap } from "gsap";
import { TextPlugin } from "gsap/TextPlugin";

gsap.registerPlugin(TextPlugin);

gsap.to(".heading", {
  text: "Your text here",
  duration: 2,
  ease: "none"
});
```

---

### Input
```
/gsap-convert react
```

### Output
```jsx
import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";

function AnimatedComponent() {
  const containerRef = useRef();

  useGSAP(() => {
    gsap.from(".element", {
      y: 50,
      autoAlpha: 0,
      duration: 1
    });
  }, { scope: containerRef });

  return (
    <div ref={containerRef}>
      <div className="element">Content</div>
    </div>
  );
}
```

---

## 🧩 Plugin Coverage

This skill covers **ALL 30 official GSAP plugins**:

### Core (Auto-included)
CSSPlugin, AttrPlugin, EndArrayPlugin, ModifiersPlugin, SnapPlugin, RoundPropsPlugin

### Scroll
ScrollTrigger, ScrollToPlugin, ScrollSmoother, Observer

### Text
TextPlugin, SplitText, ScrambleTextPlugin

### SVG & Motion
MotionPathPlugin, MotionPathHelper, MorphSVGPlugin, DrawSVGPlugin

### Layout & Interaction
Flip, Draggable, InertiaPlugin

### Physics
Physics2DPlugin, PhysicsPropsPlugin

### Easing
EasePack (SlowMo, RoughEase, ExpoScaleEase), CustomEase, CustomBounce, CustomWiggle

### Rendering
PixiPlugin, EaselPlugin

### Development
GSDevTools, CSSRulePlugin

---

## 🎨 Effect Presets

### Scroll Reveals
`fade-up`, `fade-down`, `fade-left`, `fade-right`, `scale-in`, `rotate-in`, `blur-in`, `clip-reveal`

### Text Effects
`typewriter`, `wave`, `bounce-in`, `scramble`, `highlight`, `split-lines`

### Hero Animations
`parallax`, `split-reveal`, `mask-wipe`, `zoom-out`, `stagger-up`

### Card Effects
`flip-3d`, `tilt-hover`, `stack-cards`, `magnetic`, `swipe`

### SVG Effects
`draw-path`, `morph-shape`, `follow-path`, `dash-animate`

---

## 🔧 Framework Integration

### React (useGSAP hook)
```jsx
import { useGSAP } from "@gsap/react";

function Component() {
  const container = useRef();

  useGSAP(() => {
    gsap.from(".box", { y: 100, autoAlpha: 0 });
  }, { scope: container });

  return <div ref={container}>...</div>;
}
```

### Vue 3
```vue
<script setup>
import { onMounted, onUnmounted } from 'vue';
import gsap from 'gsap';

let ctx;
onMounted(() => {
  ctx = gsap.context(() => {
    gsap.from(".box", { y: 100, autoAlpha: 0 });
  });
});
onUnmounted(() => ctx.revert());
</script>
```

### Next.js
```tsx
"use client";
import { useGSAP } from "@gsap/react";

export default function Page() {
  useGSAP(() => {
    gsap.from(".box", { y: 100, autoAlpha: 0 });
  }, []);

  return <div className="box">...</div>;
}
```

---

## ✅ Best Practices (Auto-Applied)

This skill automatically applies GSAP best practices:

| Practice | What It Does |
|----------|--------------|
| GPU Acceleration | Uses `x`, `y` instead of `left`, `top` |
| Visibility | Uses `autoAlpha` instead of `opacity` |
| Cleanup | Includes framework cleanup code |
| Registration | Adds `gsap.registerPlugin()` calls |
| Performance | Avoids layout thrashing |
| Accessibility | Supports `prefers-reduced-motion` |

---

## 📁 Skill Structure

```
claude-gsap/
├── skills/
│   ├── gsap/                    # Main skill + references
│   ├── gsap-scroll/             # ScrollTrigger
│   ├── gsap-timeline/           # Timeline sequencing
│   ├── gsap-text/               # Text animations
│   ├── gsap-svg/                # SVG animations
│   ├── gsap-3d/                 # 3D transforms
│   ├── gsap-effects/            # 50+ presets
│   ├── gsap-flip/               # Layout animations
│   ├── gsap-draggable/          # Drag interactions
│   ├── gsap-scroll-smoother/    # Smooth scrolling
│   ├── gsap-custom-ease/        # Custom easing
│   ├── gsap-physics/            # Physics animations
│   ├── gsap-utils/              # Utility methods
│   ├── gsap-canvas/             # PixiJS/EaselJS
│   ├── gsap-devtools/           # Debugging
│   ├── gsap-core/               # Core features
│   ├── gsap-performance/        # Optimization
│   └── gsap-framework/          # Framework integration
├── agents/                       # 6 specialist agents
├── CLAUDE.md                     # Plugin overview
├── README.md                     # This file
└── marketplace.json              # Marketplace listing
```

---

## 🐛 Troubleshooting

### Animation not working?
- Ensure GSAP is installed: `npm install gsap`
- Check plugin registration before use
- Verify element selectors match your HTML

### ScrollTrigger issues?
- Register plugin: `gsap.registerPlugin(ScrollTrigger)`
- Check trigger element exists in DOM
- Use `markers: true` for debugging

### React cleanup issues?
- Use `useGSAP` from `@gsap/react`
- Or wrap in `gsap.context()` and call `revert()`

---

## 🤝 Contributing

Contributions welcome! This is an open-source project.

1. Fork the repository
2. Create your feature branch
3. Add/update skill documentation
4. Submit a pull request

---

## 📄 License

MIT License - Free for personal and commercial use.

---

## 🙏 Acknowledgments

- [GSAP/GreenSock](https://greensock.com/) - The animation platform
- [Webflow](https://webflow.com/) - For making GSAP free for everyone
- [Claude Code](https://claude.ai) - AI coding assistant
- GSAP community for patterns and best practices

---

## 📊 Stats

- **18 Skills** covering all GSAP features
- **30 Plugins** fully documented
- **50+ Effect Presets** ready to use
- **6 Specialist Agents** for complex tasks
- **3 Framework Integrations** (React, Vue, Next.js)
- **100% Free** - No paid features
