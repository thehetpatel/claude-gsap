# React GSAP Integration Guide

Complete reference for using GSAP with React.

## Installation

```bash
npm install gsap @gsap/react
# or
yarn add gsap @gsap/react
```

## The useGSAP Hook

### Basic Usage
```jsx
import { useRef } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";

function Component() {
  const containerRef = useRef();

  useGSAP(() => {
    // GSAP code runs after component mounts
    gsap.to(".box", { x: 100 });
  }, { scope: containerRef });

  return (
    <div ref={containerRef}>
      <div className="box">Box</div>
    </div>
  );
}
```

### Hook Options

```jsx
useGSAP(callback, {
  scope: containerRef,           // Scope selectors to this container
  dependencies: [],              // Re-run when these change
  revertOnUpdate: true          // Revert before re-running
});
```

## Common Patterns

### Entrance Animation
```jsx
function Card() {
  const cardRef = useRef();

  useGSAP(() => {
    gsap.from(cardRef.current, {
      y: 50,
      autoAlpha: 0,
      duration: 0.8,
      ease: "power3.out"
    });
  });

  return <div ref={cardRef} className="card">Content</div>;
}
```

### Multiple Elements
```jsx
function List() {
  const containerRef = useRef();

  useGSAP(() => {
    gsap.from(".item", {
      y: 30,
      autoAlpha: 0,
      stagger: 0.1,
      ease: "power3.out"
    });
  }, { scope: containerRef });

  return (
    <ul ref={containerRef}>
      <li className="item">Item 1</li>
      <li className="item">Item 2</li>
      <li className="item">Item 3</li>
    </ul>
  );
}
```

### Controlled Timeline
```jsx
function Modal({ isOpen }) {
  const modalRef = useRef();
  const tlRef = useRef();

  useGSAP(() => {
    tlRef.current = gsap.timeline({ paused: true })
      .to(".overlay", { autoAlpha: 1, duration: 0.3 })
      .from(".modal-content", {
        y: 50,
        autoAlpha: 0,
        duration: 0.4,
        ease: "back.out(1.7)"
      });
  }, { scope: modalRef });

  // Control based on prop
  useEffect(() => {
    if (isOpen) {
      tlRef.current.play();
    } else {
      tlRef.current.reverse();
    }
  }, [isOpen]);

  return (
    <div ref={modalRef}>
      <div className="overlay" />
      <div className="modal-content">Modal</div>
    </div>
  );
}
```

### With State Dependencies
```jsx
function Counter({ target }) {
  const countRef = useRef();

  useGSAP(() => {
    gsap.to(countRef.current, {
      innerText: target,
      duration: 2,
      snap: { innerText: 1 }
    });
  }, { dependencies: [target] }); // Re-run when target changes

  return <span ref={countRef}>0</span>;
}
```

### Hover Animation
```jsx
function HoverCard() {
  const cardRef = useRef();

  const { contextSafe } = useGSAP({ scope: cardRef });

  const onEnter = contextSafe(() => {
    gsap.to(".card", { y: -10, boxShadow: "0 20px 40px rgba(0,0,0,0.2)" });
  });

  const onLeave = contextSafe(() => {
    gsap.to(".card", { y: 0, boxShadow: "0 5px 15px rgba(0,0,0,0.1)" });
  });

  return (
    <div
      ref={cardRef}
      className="card"
      onMouseEnter={onEnter}
      onMouseLeave={onLeave}
    >
      Content
    </div>
  );
}
```

### Context-Safe Event Handlers
```jsx
function InteractiveElement() {
  const containerRef = useRef();

  const { contextSafe } = useGSAP({ scope: containerRef });

  // Wrap any event handler that uses GSAP
  const handleClick = contextSafe((e) => {
    gsap.to(e.currentTarget, {
      scale: 0.95,
      duration: 0.1,
      yoyo: true,
      repeat: 1
    });
  });

  return (
    <div ref={containerRef}>
      <button onClick={handleClick}>Click Me</button>
    </div>
  );
}
```

## ScrollTrigger Integration

### Basic ScrollTrigger
```jsx
import { useGSAP } from "@gsap/react";
import gsap from "gsap";
import { ScrollTrigger } from "gsap/ScrollTrigger";

gsap.registerPlugin(ScrollTrigger);

function ScrollSection() {
  const sectionRef = useRef();

  useGSAP(() => {
    gsap.from(".reveal", {
      y: 100,
      autoAlpha: 0,
      duration: 1,
      scrollTrigger: {
        trigger: sectionRef.current,
        start: "top 80%",
        toggleActions: "play none none reverse"
      }
    });
  }, { scope: sectionRef });

  return (
    <section ref={sectionRef}>
      <div className="reveal">Content</div>
    </section>
  );
}
```

### Pin Section
```jsx
function PinnedSection() {
  const containerRef = useRef();

  useGSAP(() => {
    gsap.to(".content", {
      x: "-300%",
      ease: "none",
      scrollTrigger: {
        trigger: containerRef.current,
        pin: true,
        scrub: 1,
        end: "+=3000"
      }
    });
  }, { scope: containerRef });

  return (
    <div ref={containerRef} className="pinned-container">
      <div className="content">
        <div className="panel">Panel 1</div>
        <div className="panel">Panel 2</div>
        <div className="panel">Panel 3</div>
        <div className="panel">Panel 4</div>
      </div>
    </div>
  );
}
```

## SplitText in React

```jsx
import { SplitText } from "gsap/SplitText";

gsap.registerPlugin(SplitText);

function AnimatedText() {
  const textRef = useRef();
  const splitRef = useRef();

  useGSAP(() => {
    splitRef.current = new SplitText(textRef.current, { type: "chars" });

    gsap.from(splitRef.current.chars, {
      y: 50,
      autoAlpha: 0,
      stagger: 0.03,
      ease: "back.out(1.7)"
    });

    // Cleanup
    return () => splitRef.current.revert();
  });

  return <h1 ref={textRef}>Animated Heading</h1>;
}
```

## Custom Hooks

### useTimeline
```jsx
function useTimeline(config = {}) {
  const tlRef = useRef();

  useGSAP(() => {
    tlRef.current = gsap.timeline(config);
  });

  return tlRef;
}

// Usage
function Component() {
  const tl = useTimeline({ paused: true });

  useGSAP(() => {
    tl.current
      .from(".item-1", { x: -100 })
      .from(".item-2", { y: 100 });
  });

  return (
    <div>
      <button onClick={() => tl.current.play()}>Play</button>
    </div>
  );
}
```

### useScrollTrigger
```jsx
function useScrollTrigger(animation, triggerConfig) {
  const triggerRef = useRef();
  const stRef = useRef();

  useGSAP(() => {
    stRef.current = ScrollTrigger.create({
      trigger: triggerRef.current,
      animation,
      ...triggerConfig
    });

    return () => stRef.current.kill();
  }, { scope: triggerRef });

  return triggerRef;
}
```

### useAnimation (Reusable)
```jsx
function useAnimation(animationType = "fadeUp") {
  const ref = useRef();

  const animations = {
    fadeUp: { y: 50, autoAlpha: 0 },
    fadeLeft: { x: -50, autoAlpha: 0 },
    scale: { scale: 0.8, autoAlpha: 0 }
  };

  useGSAP(() => {
    gsap.from(ref.current, {
      ...animations[animationType],
      duration: 0.8,
      ease: "power3.out"
    });
  });

  return ref;
}

// Usage
function Card() {
  const ref = useAnimation("fadeUp");
  return <div ref={ref}>Card</div>;
}
```

## Component Patterns

### AnimatePresence Alternative
```jsx
function AnimatedItem({ children, isVisible }) {
  const itemRef = useRef();

  useGSAP(() => {
    if (isVisible) {
      gsap.fromTo(itemRef.current,
        { autoAlpha: 0, y: 20 },
        { autoAlpha: 1, y: 0, duration: 0.4 }
      );
    } else {
      gsap.to(itemRef.current, {
        autoAlpha: 0,
        y: -20,
        duration: 0.3
      });
    }
  }, { dependencies: [isVisible] });

  return <div ref={itemRef}>{children}</div>;
}
```

### Stagger Children
```jsx
function StaggerContainer({ children }) {
  const containerRef = useRef();

  useGSAP(() => {
    gsap.from(".stagger-item", {
      y: 30,
      autoAlpha: 0,
      stagger: 0.1,
      ease: "power3.out"
    });
  }, { scope: containerRef });

  return (
    <div ref={containerRef}>
      {React.Children.map(children, child => (
        <div className="stagger-item">{child}</div>
      ))}
    </div>
  );
}
```

## TypeScript Support

```tsx
import { useRef, RefObject } from "react";
import { useGSAP } from "@gsap/react";
import gsap from "gsap";

interface AnimatedComponentProps {
  duration?: number;
  delay?: number;
}

function AnimatedComponent({ duration = 1, delay = 0 }: AnimatedComponentProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const tlRef = useRef<gsap.core.Timeline | null>(null);

  useGSAP(() => {
    tlRef.current = gsap.timeline({ delay })
      .from(".element", { y: 50, autoAlpha: 0, duration });
  }, { scope: containerRef, dependencies: [duration, delay] });

  return (
    <div ref={containerRef}>
      <div className="element">Content</div>
    </div>
  );
}
```

## Performance Tips

1. **Always use scope** - Limits selector queries
2. **Use refs for single elements** - More performant than class selectors
3. **Memoize callbacks** - Use `contextSafe` for event handlers
4. **Cleanup automatically** - `useGSAP` handles this with scope
5. **Register plugins once** - At module level, not in components
