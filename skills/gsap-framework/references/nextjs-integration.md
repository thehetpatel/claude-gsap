# Next.js GSAP Integration Guide

Complete reference for using GSAP with Next.js (App Router & Pages Router).

## Installation

```bash
npm install gsap @gsap/react
# or
yarn add gsap @gsap/react
```

## App Router (Next.js 13+)

### Client Component Setup
```tsx
// components/AnimatedSection.tsx
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
      duration: 1,
      ease: "power3.out"
    });
  }, { scope: containerRef });

  return (
    <div ref={containerRef}>
      <div className="box">Animated Content</div>
    </div>
  );
}
```

### Server Component with Client Animation
```tsx
// app/page.tsx (Server Component)
import AnimatedSection from "@/components/AnimatedSection";

export default function Page() {
  return (
    <main>
      <h1>Welcome</h1>
      <AnimatedSection /> {/* Client component with animations */}
    </main>
  );
}
```

### Register Plugins (App Router)
```tsx
// lib/gsap.ts
"use client";

import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { SplitText } from "gsap/SplitText";

// Only register on client
if (typeof window !== "undefined") {
  gsap.registerPlugin(ScrollTrigger, SplitText);
}

export { gsap, ScrollTrigger, SplitText };
```

```tsx
// Usage in component
"use client";

import { gsap, ScrollTrigger } from "@/lib/gsap";
import { useGSAP } from "@gsap/react";
```

## Pages Router

### Basic Setup
```tsx
// pages/index.tsx
import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";

export default function Home() {
  const containerRef = useRef<HTMLDivElement>(null);

  useGSAP(() => {
    gsap.from(".hero-text", {
      y: 50,
      autoAlpha: 0,
      duration: 1
    });
  }, { scope: containerRef });

  return (
    <main ref={containerRef}>
      <h1 className="hero-text">Welcome</h1>
    </main>
  );
}
```

### Register Plugins (Pages Router)
```tsx
// pages/_app.tsx
import type { AppProps } from "next/app";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";
import { useIsomorphicLayoutEffect } from "@/hooks/useIsomorphicLayoutEffect";

export default function App({ Component, pageProps }: AppProps) {
  useIsomorphicLayoutEffect(() => {
    gsap.registerPlugin(ScrollTrigger);
  }, []);

  return <Component {...pageProps} />;
}
```

## ScrollTrigger Integration

### With App Router
```tsx
"use client";

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

// Register plugin
if (typeof window !== "undefined") {
  gsap.registerPlugin(ScrollTrigger);
}

export default function ScrollSection() {
  const sectionRef = useRef<HTMLElement>(null);

  useGSAP(() => {
    gsap.from(".reveal-item", {
      y: 100,
      autoAlpha: 0,
      stagger: 0.2,
      scrollTrigger: {
        trigger: sectionRef.current,
        start: "top 80%",
        toggleActions: "play none none reverse"
      }
    });
  }, { scope: sectionRef });

  return (
    <section ref={sectionRef}>
      <div className="reveal-item">Item 1</div>
      <div className="reveal-item">Item 2</div>
      <div className="reveal-item">Item 3</div>
    </section>
  );
}
```

### Parallax Effect
```tsx
"use client";

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

if (typeof window !== "undefined") {
  gsap.registerPlugin(ScrollTrigger);
}

export default function ParallaxHero() {
  const heroRef = useRef<HTMLDivElement>(null);

  useGSAP(() => {
    gsap.to(".hero-bg", {
      y: "30%",
      ease: "none",
      scrollTrigger: {
        trigger: heroRef.current,
        start: "top top",
        end: "bottom top",
        scrub: true
      }
    });

    gsap.to(".hero-content", {
      y: "50%",
      autoAlpha: 0,
      ease: "none",
      scrollTrigger: {
        trigger: heroRef.current,
        start: "top top",
        end: "center top",
        scrub: true
      }
    });
  }, { scope: heroRef });

  return (
    <div ref={heroRef} className="hero">
      <div className="hero-bg" />
      <div className="hero-content">
        <h1>Welcome</h1>
      </div>
    </div>
  );
}
```

## Page Transitions

### Layout with Transitions
```tsx
// components/PageTransition.tsx
"use client";

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";

interface Props {
  children: React.ReactNode;
}

export default function PageTransition({ children }: Props) {
  const containerRef = useRef<HTMLDivElement>(null);

  useGSAP(() => {
    gsap.from(containerRef.current, {
      autoAlpha: 0,
      y: 20,
      duration: 0.5,
      ease: "power3.out"
    });
  }, { scope: containerRef });

  return <div ref={containerRef}>{children}</div>;
}
```

```tsx
// app/layout.tsx
import PageTransition from "@/components/PageTransition";

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html>
      <body>
        <PageTransition>{children}</PageTransition>
      </body>
    </html>
  );
}
```

## Dynamic Imports

### Heavy Animations (Code Splitting)
```tsx
// components/HeavyAnimation.tsx
"use client";

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";
import { SplitText } from "gsap/SplitText";

gsap.registerPlugin(SplitText);

export default function HeavyAnimation() {
  const textRef = useRef<HTMLHeadingElement>(null);

  useGSAP(() => {
    const split = new SplitText(textRef.current, { type: "chars" });

    gsap.from(split.chars, {
      y: 100,
      autoAlpha: 0,
      stagger: 0.02,
      ease: "back.out(1.7)"
    });

    return () => split.revert();
  });

  return <h1 ref={textRef}>Animated Heading</h1>;
}
```

```tsx
// app/page.tsx
import dynamic from "next/dynamic";

const HeavyAnimation = dynamic(
  () => import("@/components/HeavyAnimation"),
  { ssr: false } // Disable SSR for GSAP component
);

export default function Page() {
  return (
    <main>
      <HeavyAnimation />
    </main>
  );
}
```

## Hooks

### useIsomorphicLayoutEffect
```tsx
// hooks/useIsomorphicLayoutEffect.ts
import { useEffect, useLayoutEffect } from "react";

export const useIsomorphicLayoutEffect =
  typeof window !== "undefined" ? useLayoutEffect : useEffect;
```

### useGSAPContext
```tsx
// hooks/useGSAPContext.ts
"use client";

import { useRef, useEffect } from "react";
import gsap from "gsap";

export function useGSAPContext() {
  const ctx = useRef<gsap.Context | null>(null);

  useEffect(() => {
    ctx.current = gsap.context(() => {});

    return () => {
      ctx.current?.revert();
    };
  }, []);

  return ctx;
}
```

## Common Patterns

### Animated Navigation
```tsx
"use client";

import { useRef, useState } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";

export default function Navigation() {
  const navRef = useRef<HTMLElement>(null);
  const [isOpen, setIsOpen] = useState(false);
  const tlRef = useRef<gsap.core.Timeline | null>(null);

  useGSAP(() => {
    tlRef.current = gsap.timeline({ paused: true })
      .to(".nav-menu", {
        x: 0,
        duration: 0.4,
        ease: "power3.inOut"
      })
      .from(".nav-link", {
        x: -30,
        autoAlpha: 0,
        stagger: 0.1,
        duration: 0.3
      }, "-=0.2");
  }, { scope: navRef });

  const toggleMenu = () => {
    setIsOpen(!isOpen);
    isOpen ? tlRef.current?.reverse() : tlRef.current?.play();
  };

  return (
    <nav ref={navRef}>
      <button onClick={toggleMenu}>Menu</button>
      <div className="nav-menu" style={{ transform: "translateX(-100%)" }}>
        <a className="nav-link" href="/">Home</a>
        <a className="nav-link" href="/about">About</a>
        <a className="nav-link" href="/contact">Contact</a>
      </div>
    </nav>
  );
}
```

### Infinite Scroll Animation
```tsx
"use client";

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";

export default function MarqueeText() {
  const containerRef = useRef<HTMLDivElement>(null);

  useGSAP(() => {
    const items = gsap.utils.toArray<HTMLElement>(".marquee-item");
    const totalWidth = items.reduce((acc, el) => acc + el.offsetWidth, 0);

    gsap.to(items, {
      x: -totalWidth,
      duration: 20,
      ease: "none",
      repeat: -1,
      modifiers: {
        x: (x) => `${parseFloat(x) % totalWidth}px`
      }
    });
  }, { scope: containerRef });

  return (
    <div ref={containerRef} className="marquee">
      <span className="marquee-item">GSAP </span>
      <span className="marquee-item">Next.js </span>
      <span className="marquee-item">Animation </span>
      <span className="marquee-item">GSAP </span>
      <span className="marquee-item">Next.js </span>
      <span className="marquee-item">Animation </span>
    </div>
  );
}
```

### Scroll Progress Indicator
```tsx
"use client";

import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

if (typeof window !== "undefined") {
  gsap.registerPlugin(ScrollTrigger);
}

export default function ScrollProgress() {
  const progressRef = useRef<HTMLDivElement>(null);

  useGSAP(() => {
    gsap.to(progressRef.current, {
      scaleX: 1,
      ease: "none",
      scrollTrigger: {
        trigger: document.body,
        start: "top top",
        end: "bottom bottom",
        scrub: 0.3
      }
    });
  });

  return (
    <div
      ref={progressRef}
      className="fixed top-0 left-0 h-1 bg-blue-500 origin-left"
      style={{ transform: "scaleX(0)", width: "100%" }}
    />
  );
}
```

## TypeScript Types

```tsx
// types/gsap.d.ts
import { gsap } from "gsap";

declare module "gsap" {
  interface TweenVars {
    scrollTrigger?: ScrollTrigger.Vars | string;
  }
}
```

## Best Practices

1. **Use "use client"** - Required for any component using GSAP
2. **Check window** - `typeof window !== "undefined"` before registering plugins
3. **Use useGSAP** - From @gsap/react for automatic cleanup
4. **Scope animations** - Use the scope option
5. **Dynamic imports** - Use for heavy plugins like SplitText
6. **SSR consideration** - Disable SSR for animation-heavy components
7. **Register once** - Register plugins at module level or in _app
