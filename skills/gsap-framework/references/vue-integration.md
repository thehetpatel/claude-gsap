# Vue 3 GSAP Integration Guide

Complete reference for using GSAP with Vue 3 Composition API.

## Installation

```bash
npm install gsap
# or
yarn add gsap
```

## Basic Setup

### Simple Animation
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
      duration: 1,
      ease: 'power3.out'
    });
  });
});

onUnmounted(() => {
  ctx.revert();
});
</script>

<template>
  <div ref="boxRef" class="box">Animated Box</div>
</template>
```

### Multiple Elements with Container
```vue
<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import gsap from 'gsap';

const containerRef = ref(null);
let ctx;

onMounted(() => {
  ctx = gsap.context(() => {
    gsap.from('.item', {
      y: 50,
      autoAlpha: 0,
      stagger: 0.1,
      ease: 'power3.out'
    });
  }, containerRef.value); // Scope to container
});

onUnmounted(() => {
  ctx.revert();
});
</script>

<template>
  <div ref="containerRef">
    <div class="item">Item 1</div>
    <div class="item">Item 2</div>
    <div class="item">Item 3</div>
  </div>
</template>
```

## Timeline Control

### Controlled Timeline
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
      .from('.header', { y: -50, autoAlpha: 0 })
      .from('.content', { y: 30, autoAlpha: 0 }, '-=0.3')
      .from('.footer', { y: 30, autoAlpha: 0 }, '-=0.3');
  }, containerRef.value);
});

onUnmounted(() => {
  ctx.revert();
});

const play = () => tl.value?.play();
const reverse = () => tl.value?.reverse();
const restart = () => tl.value?.restart();
</script>

<template>
  <div ref="containerRef">
    <div class="controls">
      <button @click="play">Play</button>
      <button @click="reverse">Reverse</button>
      <button @click="restart">Restart</button>
    </div>
    <div class="header">Header</div>
    <div class="content">Content</div>
    <div class="footer">Footer</div>
  </div>
</template>
```

### Reactive Animation
```vue
<script setup>
import { ref, watch, onMounted, onUnmounted } from 'vue';
import gsap from 'gsap';

const props = defineProps({
  isActive: Boolean
});

const boxRef = ref(null);
let ctx;

onMounted(() => {
  ctx = gsap.context(() => {});
});

watch(() => props.isActive, (newVal) => {
  ctx.add(() => {
    gsap.to(boxRef.value, {
      x: newVal ? 100 : 0,
      backgroundColor: newVal ? '#00ff00' : '#ff0000',
      duration: 0.5
    });
  });
}, { immediate: true });

onUnmounted(() => {
  ctx.revert();
});
</script>

<template>
  <div ref="boxRef" class="box">Toggle me</div>
</template>
```

## ScrollTrigger Integration

### Basic ScrollTrigger
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
    gsap.from('.reveal', {
      y: 100,
      autoAlpha: 0,
      duration: 1,
      stagger: 0.2,
      scrollTrigger: {
        trigger: sectionRef.value,
        start: 'top 80%',
        toggleActions: 'play none none reverse'
      }
    });
  }, sectionRef.value);
});

onUnmounted(() => {
  ctx.revert();
});
</script>

<template>
  <section ref="sectionRef">
    <div class="reveal">Item 1</div>
    <div class="reveal">Item 2</div>
    <div class="reveal">Item 3</div>
  </section>
</template>
```

### Pinned Section
```vue
<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import gsap from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

const containerRef = ref(null);
let ctx;

onMounted(() => {
  ctx = gsap.context(() => {
    gsap.to('.panels', {
      x: '-200vw',
      ease: 'none',
      scrollTrigger: {
        trigger: containerRef.value,
        pin: true,
        scrub: 1,
        end: '+=3000'
      }
    });
  }, containerRef.value);
});

onUnmounted(() => {
  ctx.revert();
});
</script>

<template>
  <div ref="containerRef" class="horizontal-container">
    <div class="panels">
      <div class="panel">Panel 1</div>
      <div class="panel">Panel 2</div>
      <div class="panel">Panel 3</div>
    </div>
  </div>
</template>
```

## Composables

### useGsap Composable
```javascript
// composables/useGsap.js
import { onMounted, onUnmounted, ref } from 'vue';
import gsap from 'gsap';

export function useGsap(callback) {
  const ctx = ref(null);

  onMounted(() => {
    ctx.value = gsap.context(callback);
  });

  onUnmounted(() => {
    ctx.value?.revert();
  });

  const add = (fn) => {
    ctx.value?.add(fn);
  };

  return { ctx, add };
}
```

```vue
<!-- Usage -->
<script setup>
import { ref } from 'vue';
import { useGsap } from '@/composables/useGsap';
import gsap from 'gsap';

const boxRef = ref(null);

useGsap(() => {
  gsap.from(boxRef.value, {
    y: 50,
    autoAlpha: 0,
    duration: 1
  });
});
</script>
```

### useTimeline Composable
```javascript
// composables/useTimeline.js
import { ref, onMounted, onUnmounted } from 'vue';
import gsap from 'gsap';

export function useTimeline(config = {}) {
  const timeline = ref(null);
  let ctx;

  onMounted(() => {
    ctx = gsap.context(() => {
      timeline.value = gsap.timeline(config);
    });
  });

  onUnmounted(() => {
    ctx?.revert();
  });

  return timeline;
}
```

```vue
<!-- Usage -->
<script setup>
import { useTimeline } from '@/composables/useTimeline';

const tl = useTimeline({ paused: true });

// Add animations in onMounted or watchers
</script>
```

### useScrollAnimation Composable
```javascript
// composables/useScrollAnimation.js
import { ref, onMounted, onUnmounted } from 'vue';
import gsap from 'gsap';
import { ScrollTrigger } from 'gsap/ScrollTrigger';

gsap.registerPlugin(ScrollTrigger);

export function useScrollAnimation(
  targetRef,
  animation = {},
  scrollConfig = {}
) {
  let ctx;

  onMounted(() => {
    ctx = gsap.context(() => {
      gsap.from(targetRef.value, {
        ...animation,
        scrollTrigger: {
          trigger: targetRef.value,
          start: 'top 80%',
          toggleActions: 'play none none reverse',
          ...scrollConfig
        }
      });
    });
  });

  onUnmounted(() => {
    ctx?.revert();
  });
}
```

```vue
<!-- Usage -->
<script setup>
import { ref } from 'vue';
import { useScrollAnimation } from '@/composables/useScrollAnimation';

const sectionRef = ref(null);

useScrollAnimation(
  sectionRef,
  { y: 100, autoAlpha: 0 },
  { start: 'top 70%' }
);
</script>

<template>
  <section ref="sectionRef">Content</section>
</template>
```

## Transitions with GSAP

### Custom Transition
```vue
<script setup>
import { ref } from 'vue';
import gsap from 'gsap';

const show = ref(true);

const onEnter = (el, done) => {
  gsap.from(el, {
    autoAlpha: 0,
    y: 30,
    duration: 0.5,
    ease: 'power3.out',
    onComplete: done
  });
};

const onLeave = (el, done) => {
  gsap.to(el, {
    autoAlpha: 0,
    y: -30,
    duration: 0.3,
    ease: 'power3.in',
    onComplete: done
  });
};
</script>

<template>
  <button @click="show = !show">Toggle</button>

  <Transition
    @enter="onEnter"
    @leave="onLeave"
    :css="false"
  >
    <div v-if="show" class="box">Content</div>
  </Transition>
</template>
```

### List Transitions
```vue
<script setup>
import { ref } from 'vue';
import gsap from 'gsap';

const items = ref([1, 2, 3]);

const onBeforeEnter = (el) => {
  gsap.set(el, { autoAlpha: 0, y: 30 });
};

const onEnter = (el, done) => {
  gsap.to(el, {
    autoAlpha: 1,
    y: 0,
    duration: 0.5,
    delay: el.dataset.index * 0.1,
    onComplete: done
  });
};

const onLeave = (el, done) => {
  gsap.to(el, {
    autoAlpha: 0,
    y: -30,
    duration: 0.3,
    onComplete: done
  });
};

const addItem = () => {
  items.value.push(items.value.length + 1);
};
</script>

<template>
  <button @click="addItem">Add Item</button>

  <TransitionGroup
    @before-enter="onBeforeEnter"
    @enter="onEnter"
    @leave="onLeave"
    :css="false"
    tag="ul"
  >
    <li
      v-for="(item, index) in items"
      :key="item"
      :data-index="index"
    >
      Item {{ item }}
    </li>
  </TransitionGroup>
</template>
```

## Event Handling

### Hover Animation
```vue
<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import gsap from 'gsap';

const cardRef = ref(null);
let ctx;

onMounted(() => {
  ctx = gsap.context(() => {});
});

onUnmounted(() => {
  ctx?.revert();
});

const onMouseEnter = () => {
  ctx.add(() => {
    gsap.to(cardRef.value, {
      y: -10,
      boxShadow: '0 20px 40px rgba(0,0,0,0.2)',
      duration: 0.3
    });
  });
};

const onMouseLeave = () => {
  ctx.add(() => {
    gsap.to(cardRef.value, {
      y: 0,
      boxShadow: '0 5px 15px rgba(0,0,0,0.1)',
      duration: 0.3
    });
  });
};
</script>

<template>
  <div
    ref="cardRef"
    class="card"
    @mouseenter="onMouseEnter"
    @mouseleave="onMouseLeave"
  >
    Hover me
  </div>
</template>
```

### Click Animation
```vue
<script setup>
import { ref, onMounted, onUnmounted } from 'vue';
import gsap from 'gsap';

const buttonRef = ref(null);
let ctx;

onMounted(() => {
  ctx = gsap.context(() => {});
});

onUnmounted(() => {
  ctx?.revert();
});

const onClick = () => {
  ctx.add(() => {
    gsap.to(buttonRef.value, {
      scale: 0.95,
      duration: 0.1,
      yoyo: true,
      repeat: 1
    });
  });
};
</script>

<template>
  <button ref="buttonRef" @click="onClick">
    Click me
  </button>
</template>
```

## TypeScript Support

```vue
<script setup lang="ts">
import { ref, onMounted, onUnmounted, Ref } from 'vue';
import gsap from 'gsap';

interface Props {
  duration?: number;
  delay?: number;
}

const props = withDefaults(defineProps<Props>(), {
  duration: 1,
  delay: 0
});

const containerRef: Ref<HTMLDivElement | null> = ref(null);
let ctx: gsap.Context;

onMounted(() => {
  if (!containerRef.value) return;

  ctx = gsap.context(() => {
    gsap.from('.element', {
      y: 50,
      autoAlpha: 0,
      duration: props.duration,
      delay: props.delay
    });
  }, containerRef.value);
});

onUnmounted(() => {
  ctx?.revert();
});
</script>

<template>
  <div ref="containerRef">
    <div class="element">Content</div>
  </div>
</template>
```

## Performance Tips

1. **Always use gsap.context()** - Ensures proper cleanup
2. **Scope selectors** - Pass container to context
3. **Clean up in onUnmounted** - Call `ctx.revert()`
4. **Use refs for single elements** - More performant
5. **Register plugins once** - At module level
6. **Use ctx.add() for dynamic animations** - Maintains cleanup scope
