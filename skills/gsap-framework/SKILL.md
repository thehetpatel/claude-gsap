---
name: gsap-framework
description: Convert GSAP animations to React, Vue, and Next.js
version: 1.0.0
argument-hint: "[framework: react|vue|nextjs]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP Framework Integration

Convert GSAP animations to work properly with React, Vue, and Next.js.

## Framework Selection

| Framework | Key Tool | Cleanup Method |
|-----------|----------|----------------|
| React | `useGSAP` hook | Automatic with scope |
| Vue 3 | `gsap.context()` | Manual in `onUnmounted` |
| Next.js | `useGSAP` + `"use client"` | Automatic with scope |

## React Integration

### Installation
```bash
npm install gsap @gsap/react
```

### Basic Setup
```jsx
import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";

function Component() {
  const containerRef = useRef();

  useGSAP(() => {
    // All GSAP code here
    gsap.from(".box", {
      x: -100,
      autoAlpha: 0,
      duration: 1
    });
  }, { scope: containerRef }); // Scope to container

  return (
    <div ref={containerRef}>
      <div className="box">Animated</div>
    </div>
  );
}
```

### With Dependencies
```jsx
function Component({ isActive }) {
  const containerRef = useRef();

  useGSAP(() => {
    gsap.to(".box", {
      x: isActive ? 100 : 0,
      duration: 0.5
    });
  }, {
    scope: containerRef,
    dependencies: [isActive]  // Re-run when isActive changes
  });

  return (
    <div ref={containerRef}>
      <div className="box">Box</div>
    </div>
  );
}
```

### Controlling Animations
```jsx
function Component() {
  const containerRef = useRef();
  const tlRef = useRef();

  useGSAP(() => {
    tlRef.current = gsap.timeline({ paused: true })
      .from(".item", { x: -50, autoAlpha: 0, stagger: 0.1 });
  }, { scope: containerRef });

  const playAnimation = () => tlRef.current.play();
  const reverseAnimation = () => tlRef.current.reverse();

  return (
    <div ref={containerRef}>
      <button onClick={playAnimation}>Play</button>
      <button onClick={reverseAnimation}>Reverse</button>
      <div className="item">Item 1</div>
      <div className="item">Item 2</div>
    </div>
  );
}
```

### With ScrollTrigger
```jsx
import { useGSAP } from "@gsap/react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

gsap.registerPlugin(ScrollTrigger);

function Component() {
  const containerRef = useRef();

  useGSAP(() => {
    gsap.from(".section", {
      y: 100,
      autoAlpha: 0,
      scrollTrigger: {
        trigger: ".section",
        start: "top 80%",
        toggleActions: "play none none reverse"
      }
    });
  }, { scope: containerRef });

  return (
    <div ref={containerRef}>
      <div className="section">Scroll-triggered section</div>
    </div>
  );
}
```

### Context API Pattern
```jsx
// gsap-context.js
import { createContext, useContext, useRef } from "react";
import gsap from "gsap";

const GSAPContext = createContext(null);

export function GSAPProvider({ children }) {
  const ctx = useRef(gsap.context(() => {}));

  return (
    <GSAPContext.Provider value={ctx.current}>
      {children}
    </GSAPContext.Provider>
  );
}

export function useGSAPContext() {
  return useContext(GSAPContext);
}
```

## Vue 3 Integration

### Installation
```bash
npm install gsap
```

### Basic Setup (Composition API)
```vue
<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import gsap from 'gsap';

const boxRef = ref(null);
let ctx;

onMounted(() => {
  ctx = gsap.context(() => {
    gsap.from(boxRef.value, {
      x: -100,
      autoAlpha: 0,
      duration: 1
    });
  });
});

onUnmounted(() => {
  ctx.revert(); // Cleanup
});
</script>

<template>
  <div ref="boxRef" class="box">Animated</div>
</template>
```

### With ScrollTrigger
```vue
<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import gsap from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

const sectionRef = ref(null);
let ctx;

onMounted(() => {
  ctx = gsap.context(() => {
    gsap.from(sectionRef.value, {
      y: 100,
      autoAlpha: 0,
      scrollTrigger: {
        trigger: sectionRef.value,
        start: 'top 80%',
        toggleActions: 'play none none reverse'
      }
    });
  });
});

onUnmounted(() => {
  ctx.revert();
});
</script>

<template>
  <div ref="sectionRef" class="section">Content</div>
</template>
```

### Controlling Timeline
```vue
<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import gsap from 'gsap';

const containerRef = ref(null);
const tl = ref(null);
let ctx;

onMounted(() => {
  ctx = gsap.context(() => {
    tl.value = gsap.timeline({ paused: true })
      .from('.item', { x: -50, autoAlpha: 0, stagger: 0.1 });
  }, containerRef.value);
});

onUnmounted(() => {
  ctx.revert();
});

const play = () => tl.value?.play();
const reverse = () => tl.value?.reverse();
</script>

<template>
  <div ref="containerRef">
    <button @click="play">Play</button>
    <button @click="reverse">Reverse</button>
    <div class="item">Item 1</div>
    <div class="item">Item 2</div>
  </div>
</template>
```

### Vue Composable
```javascript
// useGsap.js
import { onMounted, onUnmounted, ref } from 'vue';
import gsap from 'gsap';

export function useGsap(callback, deps = []) {
  const ctx = ref(null);

  onMounted(() => {
    ctx.value = gsap.context(callback);
  });

  onUnmounted(() => {
    ctx.value?.revert();
  });

  return ctx;
}

// Usage
import { useGsap } from './useGsap';

const containerRef = ref(null);

useGsap(() => {
  gsap.from('.box', { x: -100, autoAlpha: 0 });
});
```

## Next.js Integration

### Installation
```bash
npm install gsap @gsap/react
```

### App Router (Server Components)
```tsx
// app/page.tsx
import AnimatedSection from './AnimatedSection';

export default function Page() {
  return (
    <main>
      <AnimatedSection />
    </main>
  );
}
```

```tsx
// app/AnimatedSection.tsx
"use client"; // Required for GSAP

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";

export default function AnimatedSection() {
  const containerRef = useRef<HTMLDivElement>(null);

  useGSAP(() => {
    gsap.from(".box", {
      y: 100,
      autoAlpha: 0,
      duration: 1
    });
  }, { scope: containerRef });

  return (
    <div ref={containerRef}>
      <div className="box">Animated Content</div>
    </div>
  );
}
```

### With ScrollTrigger in Next.js
```tsx
"use client";

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

// Register once
if (typeof window !== "undefined") {
  gsap.registerPlugin(ScrollTrigger);
}

export default function ScrollSection() {
  const containerRef = useRef<HTMLDivElement>(null);

  useGSAP(() => {
    gsap.from(".reveal", {
      y: 100,
      autoAlpha: 0,
      stagger: 0.2,
      scrollTrigger: {
        trigger: containerRef.current,
        start: "top 80%",
        toggleActions: "play none none reverse"
      }
    });
  }, { scope: containerRef });

  return (
    <section ref={containerRef}>
      <div className="reveal">Item 1</div>
      <div className="reveal">Item 2</div>
      <div className="reveal">Item 3</div>
    </section>
  );
}
```

### Pages Router
```tsx
// pages/index.tsx
import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";

export default function Home() {
  const containerRef = useRef<HTMLDivElement>(null);

  useGSAP(() => {
    gsap.from(".hero", {
      y: 50,
      autoAlpha: 0,
      duration: 1
    });
  }, { scope: containerRef });

  return (
    <main ref={containerRef}>
      <div className="hero">Welcome</div>
    </main>
  );
}
```

### Dynamic Import (Code Splitting)
```tsx
// For heavy GSAP plugins
import dynamic from 'next/dynamic';

const HeavyAnimation = dynamic(
  () => import('./HeavyAnimation'),
  { ssr: false }
);

export default function Page() {
  return <HeavyAnimation />;
}
```

## Common Patterns

### Page Transition
```jsx
// React/Next.js
function PageTransition({ children }) {
  const containerRef = useRef();

  useGSAP(() => {
    gsap.from(containerRef.current, {
      autoAlpha: 0,
      y: 20,
      duration: 0.5
    });
  }, { scope: containerRef });

  return <div ref={containerRef}>{children}</div>;
}
```

### Reusable Animation Component
```jsx
function AnimateIn({ children, animation = "fadeUp" }) {
  const ref = useRef();

  useGSAP(() => {
    const animations = {
      fadeUp: { y: 50, autoAlpha: 0 },
      fadeLeft: { x: -50, autoAlpha: 0 },
      scale: { scale: 0, autoAlpha: 0 }
    };

    gsap.from(ref.current, {
      ...animations[animation],
      duration: 0.8,
      scrollTrigger: {
        trigger: ref.current,
        start: "top 85%"
      }
    });
  }, { scope: ref });

  return <div ref={ref}>{children}</div>;
}

// Usage
<AnimateIn animation="fadeUp">
  <Card />
</AnimateIn>
```

### Custom Hook with Options
```jsx
function useAnimation(options = {}) {
  const ref = useRef();
  const tl = useRef();

  useGSAP(() => {
    tl.current = gsap.timeline({ paused: true, ...options });
  }, { scope: ref });

  return { ref, timeline: tl };
}

// Usage
function Component() {
  const { ref, timeline } = useAnimation({ repeat: -1 });

  useGSAP(() => {
    timeline.current
      .from(".box", { x: -100 })
      .to(".box", { rotation: 360 });
  }, { scope: ref });

  return (
    <div ref={ref}>
      <button onClick={() => timeline.current.play()}>Start</button>
      <div className="box">Box</div>
    </div>
  );
}
```

## Best Practices

1. **Always use refs** - Don't query DOM directly
2. **Scope animations** - Use `scope` in `useGSAP`
3. **Register plugins once** - At module level or in useEffect
4. **Handle SSR** - Check `typeof window !== "undefined"`
5. **Clean up** - Let `useGSAP` handle it with scope
6. **Use `"use client"`** - Required for Next.js App Router

See references folder for detailed framework-specific patterns.
