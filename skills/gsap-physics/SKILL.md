---
name: gsap-physics
description: Create physics-based animations with Physics2D and PhysicsProps
version: 1.0.0
argument-hint: "[physics animation description]"
allowed-tools: Read Write Edit Bash Grep Glob
---

# GSAP Physics Animation Generator

Create realistic physics simulations with velocity, gravity, and friction.

## Quick Setup

```javascript
import { gsap } from "gsap";
import { Physics2DPlugin } from "gsap/Physics2DPlugin";
import { PhysicsPropsPlugin } from "gsap/PhysicsPropsPlugin";

gsap.registerPlugin(Physics2DPlugin, PhysicsPropsPlugin);
```

## Physics2DPlugin

Simulate 2D physics with velocity, angle, gravity, and friction.

### Basic Usage
```javascript
gsap.to(".ball", {
  physics2D: {
    velocity: 300,      // Initial velocity (pixels/second)
    angle: -60,         // Direction in degrees (0 = right, -90 = up)
    gravity: 400        // Gravity force (pixels/second²)
  },
  duration: 3
});
```

### All Options
```javascript
gsap.to(".object", {
  physics2D: {
    velocity: 500,        // Initial speed
    angle: 45,            // Direction (-90 = up, 0 = right, 90 = down)
    gravity: 980,         // Gravity (Earth ≈ 980)
    friction: 0.1,        // Air resistance (0-1)
    velocityX: 100,       // Override X velocity
    velocityY: -200,      // Override Y velocity
    accelerationX: 0,     // Constant X acceleration
    accelerationY: 50     // Constant Y acceleration
  },
  duration: 5
});
```

## PhysicsPropsPlugin

Apply physics to any property with velocity and acceleration.

### Basic Usage
```javascript
gsap.to(".element", {
  physicsProps: {
    x: { velocity: 200, friction: 0.1 },
    rotation: { velocity: 360, friction: 0.05 }
  },
  duration: 3
});
```

### All Options
```javascript
gsap.to(".element", {
  physicsProps: {
    x: {
      velocity: 100,        // Initial velocity
      acceleration: -50,    // Constant acceleration
      friction: 0.1         // Friction coefficient
    },
    scale: {
      velocity: 0.5,
      friction: 0.2
    },
    rotation: {
      velocity: 180,
      acceleration: 0,
      friction: 0.08
    }
  },
  duration: 5
});
```

## Natural Language Mapping

| User Says | Implementation |
|-----------|---------------|
| "throw" | velocity + angle + gravity |
| "bounce" | Physics2D with collision detection |
| "falling" | gravity only |
| "floating" | low gravity, friction |
| "explode/burst" | multiple objects, random velocities |
| "orbit" | continuous acceleration toward center |
| "friction/slow down" | friction property |

## Common Patterns

### Throw Object
```javascript
function throwObject(element, power = 500, angle = -45) {
  gsap.to(element, {
    physics2D: {
      velocity: power,
      angle: angle,
      gravity: 500
    },
    duration: 3,
    onUpdate: function() {
      // Check if hit ground
      const y = gsap.getProperty(element, "y");
      if (y > window.innerHeight) {
        this.kill();
      }
    }
  });
}
```

### Bouncing Ball
```javascript
function bouncingBall(ball, container) {
  const bounds = container.getBoundingClientRect();

  gsap.to(ball, {
    physics2D: {
      velocity: 400,
      angle: -45,
      gravity: 600,
      friction: 0.02
    },
    duration: 10,
    onUpdate: function() {
      const x = gsap.getProperty(ball, "x");
      const y = gsap.getProperty(ball, "y");

      // Bounce off walls
      if (x <= 0 || x >= bounds.width) {
        // Reverse X velocity
        this.vars.physics2D.velocityX *= -0.8;
      }

      // Bounce off floor
      if (y >= bounds.height) {
        gsap.set(ball, { y: bounds.height });
        this.vars.physics2D.velocityY *= -0.7;  // Energy loss
      }
    }
  });
}
```

### Particle Explosion
```javascript
function explode(x, y, particleCount = 20) {
  const particles = [];

  for (let i = 0; i < particleCount; i++) {
    const particle = document.createElement("div");
    particle.className = "particle";
    document.body.appendChild(particle);
    gsap.set(particle, { x, y });
    particles.push(particle);

    gsap.to(particle, {
      physics2D: {
        velocity: gsap.utils.random(200, 500),
        angle: gsap.utils.random(0, 360),
        gravity: gsap.utils.random(300, 500),
        friction: 0.05
      },
      autoAlpha: 0,
      scale: 0,
      duration: gsap.utils.random(1, 2),
      onComplete: () => particle.remove()
    });
  }
}
```

### Floating/Drifting
```javascript
function floatElement(element) {
  gsap.to(element, {
    physics2D: {
      velocity: 50,
      angle: gsap.utils.random(-90, -180),
      gravity: 10,   // Very light gravity
      friction: 0.02
    },
    duration: 10,
    repeat: -1,
    onRepeat: function() {
      // Random new direction
      this.vars.physics2D.angle = gsap.utils.random(-90, -180);
    }
  });
}
```

### Magnetic Pull
```javascript
function magneticPull(element, targetX, targetY, strength = 1000) {
  const tween = gsap.to(element, {
    physicsProps: {
      x: { velocity: 0, acceleration: 0 },
      y: { velocity: 0, acceleration: 0 }
    },
    duration: 5,
    onUpdate: function() {
      const x = gsap.getProperty(element, "x");
      const y = gsap.getProperty(element, "y");

      // Calculate direction to target
      const dx = targetX - x;
      const dy = targetY - y;
      const distance = Math.sqrt(dx * dx + dy * dy);

      // Apply acceleration toward target (inverse square)
      const force = strength / (distance + 1);
      this.vars.physicsProps.x.acceleration = (dx / distance) * force;
      this.vars.physicsProps.y.acceleration = (dy / distance) * force;
    }
  });
}
```

### Pendulum Swing
```javascript
function pendulum(element, pivotX, pivotY, length = 200) {
  let angle = Math.PI / 4;  // Start angle
  let velocity = 0;
  const gravity = 0.5;
  const damping = 0.995;

  gsap.ticker.add(() => {
    // Physics calculation
    const acceleration = -gravity * Math.sin(angle);
    velocity += acceleration;
    velocity *= damping;
    angle += velocity * 0.05;

    // Update position
    const x = pivotX + Math.sin(angle) * length;
    const y = pivotY + Math.cos(angle) * length;

    gsap.set(element, { x, y, rotation: angle * (180 / Math.PI) });
  });
}
```

### Spinning with Friction
```javascript
function spinWithFriction(element, initialSpeed = 720) {
  gsap.to(element, {
    physicsProps: {
      rotation: {
        velocity: initialSpeed,
        friction: 0.03
      }
    },
    duration: 10,
    onComplete: function() {
      // Snap to nearest 45 degrees
      const rotation = gsap.getProperty(element, "rotation");
      const snapped = Math.round(rotation / 45) * 45;
      gsap.to(element, { rotation: snapped, duration: 0.3 });
    }
  });
}
```

### Follow with Lag
```javascript
function followWithPhysics(follower, leader) {
  gsap.ticker.add(() => {
    const leaderX = gsap.getProperty(leader, "x");
    const leaderY = gsap.getProperty(leader, "y");

    gsap.to(follower, {
      physicsProps: {
        x: {
          velocity: (leaderX - gsap.getProperty(follower, "x")) * 5,
          friction: 0.3
        },
        y: {
          velocity: (leaderY - gsap.getProperty(follower, "y")) * 5,
          friction: 0.3
        }
      },
      duration: 0.5,
      overwrite: "auto"
    });
  });
}
```

## Physics Constants

```javascript
// Realistic gravity values (pixels/second²)
const GRAVITY = {
  earth: 980,
  moon: 162,
  mars: 371,
  jupiter: 2479,
  gentle: 200,
  heavy: 1500
};

// Common angles
const ANGLES = {
  up: -90,
  down: 90,
  left: 180,
  right: 0,
  upRight: -45,
  upLeft: -135,
  downRight: 45,
  downLeft: 135
};
```

## Combining with Other Plugins

### Physics + ScrollTrigger
```javascript
ScrollTrigger.create({
  trigger: ".section",
  onEnter: () => {
    gsap.to(".ball", {
      physics2D: {
        velocity: 300,
        angle: -60,
        gravity: 500
      },
      duration: 3
    });
  }
});
```

### Physics + Flip
```javascript
function launchAndLand(element, target) {
  const state = Flip.getState(element);

  gsap.to(element, {
    physics2D: {
      velocity: 400,
      angle: -75,
      gravity: 500
    },
    duration: 1,
    onComplete: () => {
      target.appendChild(element);
      Flip.from(state, { duration: 0.3 });
    }
  });
}
```

## Tips

1. **Start simple** - Add complexity gradually
2. **Adjust gravity** - Different values for different feels
3. **Use friction** - Makes things feel more natural
4. **Combine properties** - velocity + friction + gravity
5. **Test durations** - Physics needs time to play out
6. **Add collision detection** - Use onUpdate for boundaries
