# GSAP Official Plugin Master List

**Single source of truth for all GSAP plugins.**

> 🎉 **ALL GSAP PLUGINS ARE NOW 100% FREE!**
> In 2024, Webflow acquired GSAP and made the entire library free for everyone, including commercial use. No paid tiers, no subscriptions needed.

---

## 🧩 CORE PLUGINS (Auto-included)

These are built into GSAP core - no registration needed:

| Plugin | Purpose |
|--------|---------|
| CSSPlugin | Animate CSS properties |
| AttrPlugin | Animate HTML/SVG attributes |
| EndArrayPlugin | Animate arrays of values |
| ModifiersPlugin | Transform values on-the-fly |
| SnapPlugin | Snap to values/increments |
| RoundPropsPlugin | Round to integers |

---

## 🌀 SCROLL PLUGINS

| Plugin | Purpose | Registration |
|--------|---------|--------------|
| ScrollTrigger | Scroll-based animations | `gsap.registerPlugin(ScrollTrigger)` |
| ScrollToPlugin | Smooth scroll to element | `gsap.registerPlugin(ScrollToPlugin)` |
| ScrollSmoother | Smooth scrolling + parallax | `gsap.registerPlugin(ScrollSmoother)` |
| Observer | Unified wheel/touch/pointer events | `gsap.registerPlugin(Observer)` |

---

## 🔤 TEXT PLUGINS

| Plugin | Purpose | Registration |
|--------|---------|--------------|
| TextPlugin | Typewriter text replacement | `gsap.registerPlugin(TextPlugin)` |
| SplitText | Split text into chars/words/lines | `gsap.registerPlugin(SplitText)` |
| ScrambleTextPlugin | Decoder/hacker text effect | `gsap.registerPlugin(ScrambleTextPlugin)` |

---

## 🎨 SVG & MOTION PLUGINS

| Plugin | Purpose | Registration |
|--------|---------|--------------|
| MotionPathPlugin | Animate along SVG paths | `gsap.registerPlugin(MotionPathPlugin)` |
| MotionPathHelper | Interactive path editor | `gsap.registerPlugin(MotionPathHelper)` |
| MorphSVGPlugin | Morph between SVG shapes | `gsap.registerPlugin(MorphSVGPlugin)` |
| DrawSVGPlugin | Animate SVG stroke drawing | `gsap.registerPlugin(DrawSVGPlugin)` |

---

## 🧩 LAYOUT PLUGINS

| Plugin | Purpose | Registration |
|--------|---------|--------------|
| Flip | FLIP layout animations | `gsap.registerPlugin(Flip)` |

---

## 🎮 INTERACTION & PHYSICS PLUGINS

| Plugin | Purpose | Registration |
|--------|---------|--------------|
| Draggable | Drag interactions | `gsap.registerPlugin(Draggable)` |
| InertiaPlugin | Momentum/throw physics | `gsap.registerPlugin(InertiaPlugin)` |
| Physics2DPlugin | 2D physics (gravity, velocity) | `gsap.registerPlugin(Physics2DPlugin)` |
| PhysicsPropsPlugin | Physics on any property | `gsap.registerPlugin(PhysicsPropsPlugin)` |

---

## 🎚️ EASING PLUGINS

| Plugin | Purpose | Registration |
|--------|---------|--------------|
| EasePack | SlowMo, RoughEase, ExpoScaleEase | `gsap.registerPlugin(EasePack)` |
| CustomEase | Create custom easing curves | `gsap.registerPlugin(CustomEase)` |
| CustomBounce | Custom bounce with squash | `gsap.registerPlugin(CustomBounce)` |
| CustomWiggle | Custom wiggle/shake easing | `gsap.registerPlugin(CustomWiggle)` |

**EasePack includes:**
- `SlowMo` - Slow motion in middle of animation
- `RoughEase` - Jittery/rough movement
- `ExpoScaleEase` - Exponential scaling for zoom

---

## 🎮 RENDERING PLUGINS

| Plugin | Purpose | For |
|--------|---------|-----|
| PixiPlugin | Animate PixiJS objects | WebGL/Canvas games |
| EaselPlugin | Animate CreateJS/EaselJS | Adobe Animate exports |

---

## 🛠️ DEVELOPMENT PLUGINS

| Plugin | Purpose | Registration |
|--------|---------|--------------|
| GSDevTools | Visual timeline debugger | `gsap.registerPlugin(GSDevTools)` |
| CSSRulePlugin | Animate CSS rules (::before, ::after) | `gsap.registerPlugin(CSSRulePlugin)` |

---

## ⚠️ LEGACY/DEPRECATED PLUGINS

| Old Plugin | Replaced By | Notes |
|------------|-------------|-------|
| ThrowPropsPlugin | InertiaPlugin | Same functionality, new name |
| BezierPlugin | MotionPathPlugin | Path-based animation |

**Do not use legacy plugins in new projects.**

---

## ❌ NOT PLUGINS (Common Confusion)

These are **NOT plugins** - they are core GSAP features:

| Item | What It Is |
|------|-----------|
| gsap.utils | Utility methods (toArray, clamp, etc.) |
| gsap.context() | Scoped cleanup for frameworks |
| gsap.matchMedia() | Responsive breakpoints |
| gsap.ticker | Animation loop access |
| gsap.registerEffect() | Custom effect registration |
| Timeline | Animation sequencing (core) |
| Eases (bounce, elastic) | Built-in easing functions |
| Staggers | Built-in stagger feature |

---

## 📊 PLUGIN COUNT SUMMARY

| Category | Count |
|----------|-------|
| Core (auto-included) | 6 |
| Scroll | 4 |
| Text | 3 |
| SVG & Motion | 4 |
| Layout | 1 |
| Interaction & Physics | 4 |
| Easing | 4 |
| Rendering | 2 |
| Development | 2 |
| Legacy (deprecated) | 2 |
| **Total Official Plugins** | **32** |

> 💡 All plugins are **100% FREE** since Webflow's acquisition in 2024.

---

## 🧩 PLUGINS BY CATEGORY

### Core (6) - Auto-included
CSSPlugin, AttrPlugin, EndArrayPlugin, ModifiersPlugin, SnapPlugin, RoundPropsPlugin

### Scroll (4)
ScrollTrigger, ScrollToPlugin, ScrollSmoother, Observer

### Text (3)
TextPlugin, SplitText, ScrambleTextPlugin

### SVG & Motion (4)
MotionPathPlugin, MotionPathHelper, MorphSVGPlugin, DrawSVGPlugin

### Layout (1)
Flip

### Interaction & Physics (4)
Draggable, InertiaPlugin, Physics2DPlugin, PhysicsPropsPlugin

### Easing (4)
EasePack, CustomEase, CustomBounce, CustomWiggle

### Rendering (2)
PixiPlugin, EaselPlugin

### Development (2)
GSDevTools, CSSRulePlugin

### Legacy (2) - Deprecated
ThrowPropsPlugin, BezierPlugin

---

## ✅ Quick Import Reference

```javascript
// Free plugins
import { gsap } from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { ScrollToPlugin } from "gsap/ScrollToPlugin";
import { TextPlugin } from "gsap/TextPlugin";
import { MotionPathPlugin } from "gsap/MotionPathPlugin";
import { Observer } from "gsap/Observer";
import { EasePack } from "gsap/EasePack";
import { CSSRulePlugin } from "gsap/CSSRulePlugin";

// Paid/Club plugins
import { Flip } from "gsap/Flip";
import { ScrollSmoother } from "gsap/ScrollSmoother";
import { Draggable } from "gsap/Draggable";
import { InertiaPlugin } from "gsap/InertiaPlugin";
import { SplitText } from "gsap/SplitText";
import { ScrambleTextPlugin } from "gsap/ScrambleTextPlugin";
import { MorphSVGPlugin } from "gsap/MorphSVGPlugin";
import { DrawSVGPlugin } from "gsap/DrawSVGPlugin";
import { MotionPathHelper } from "gsap/MotionPathHelper";
import { Physics2DPlugin } from "gsap/Physics2DPlugin";
import { PhysicsPropsPlugin } from "gsap/PhysicsPropsPlugin";
import { CustomEase } from "gsap/CustomEase";
import { CustomBounce } from "gsap/CustomBounce";
import { CustomWiggle } from "gsap/CustomWiggle";
import { GSDevTools } from "gsap/GSDevTools";

// Special plugins
import { PixiPlugin } from "gsap/PixiPlugin";
import { EaselPlugin } from "gsap/EaselPlugin";

// Register all
gsap.registerPlugin(
  ScrollTrigger, ScrollToPlugin, TextPlugin, MotionPathPlugin,
  Observer, EasePack, CSSRulePlugin, Flip, ScrollSmoother,
  Draggable, InertiaPlugin, SplitText, ScrambleTextPlugin,
  MorphSVGPlugin, DrawSVGPlugin, MotionPathHelper,
  Physics2DPlugin, PhysicsPropsPlugin, CustomEase,
  CustomBounce, CustomWiggle, GSDevTools, PixiPlugin, EaselPlugin
);
```
