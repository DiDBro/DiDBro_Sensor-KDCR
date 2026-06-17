# 035033-Intro to Sensor-Integrated Systems — Lecture 3: Dynamic Characteristics of Measurement Systems

> **Source**: Lecture 3.pdf (29 pages)
> **Textbook**: *Principles of Measurement Systems* by John P. Bentley, Chapter 4
> **Instructor**: Mingyi Liu, Ph.D., Associate Professor, Mechanical Engineering and Robotics, GTIIT
> **Date**: March 2026

---

## 1. Why Dynamic Characteristics Matter

> **Dynamic characteristics** describe how an element responds to **sudden input changes**.

- **Static characteristics** (Lectures 1–2): accuracy, precision, linearity, etc. — for constant or slowly-varying inputs
- **Dynamic characteristics**: bandwidth, time constant, damping, natural frequency — for time-varying inputs

### Quick Review of Relevant Features

| Feature | Definition |
|---------|------------|
| **Noise floor** | Output variation with constant input (limits smallest usable signal) |
| **Bandwidth / Update rate** | Frequency range the sensor can track *to specification* (e.g., 1/300 s = 0.003 Hz) |
| **Drift** | Output change over time with constant input (e.g., 0.001 °C/day) |
| **Linearity** | Max deviation from straight-line I/O relation (%FS) |
| **Cross-sensitivity** | Unwanted response to "other" inputs (axes, temperature, EM fields) |

> 📖 The key question of this lecture: **How fast can a sensor respond?**

---

## 2. First-Order Systems

### 2.1 Thermal Sensor Example

Consider a thermometer initially at $T_{INIT}$ immersed in fluid at $T_F$.

**Energy balance**: _Energy accumulation = In-flow − Out-flow_

| Symbol | Meaning | Unit |
|--------|---------|------|
| $T$ | Real-time sensor temperature | °C |
| $T_F$ | Fluid (environment) temperature | °C |
| $T_{INIT}$ | Initial sensor temperature | °C |
| $U$ | Heat transfer coefficient (fluid ↔ sensor) | W/(m²·°C) |
| $A$ | Effective heat transfer area | m² |
| $M$ | Sensor mass | kg |
| $C$ | Specific heat of sensor material | J/(kg·°C) |

**Derivation**:

- Heat inflow: $W = UA(T_F - T)$ [Watts]
- Energy accumulation: $MC(T - T_{INIT})$ [Joules]
- Rate of energy accumulation: $\frac{d}{dt}[MC(T - T_{INIT})] = MC\frac{dT}{dt}$ [Watts] (since $M, C, T_{INIT}$ are constants)

$$\boxed{MC\frac{dT}{dt} = UA(T_F - T)}$$

Rearranging to standard form:

$$\boxed{\frac{MC}{UA} \dot{T} + T = T_F}$$

**Solution**:
- Homogeneous: $T_h(t) = K_1 e^{-\frac{UA}{MC}t}$
- Particular: $T_p(t) = T_F$ (steady-state)
- Complete (with initial condition $T(0) = T_{INIT}$):

$$\boxed{T(t) = (T_{INIT} - T_F) e^{-\frac{UA}{MC}t} + T_F}$$

### 2.2 Time Constant $\tau$

$$\boxed{\tau = \frac{MC}{UA}}$$

The first-order response simplifies to:

$$\boxed{T(t) = (T_{INIT} - T_F) e^{-t/\tau} + T_F}$$

> ✅ **Physical meaning of $\tau$**: The time needed to reach **63%** ($1 - e^{-1}$) of the full transition. After $5\tau$, the system is ~99.3% settled.

### 2.3 RC Circuit — First-Order Electrical Analog

Apply KVL to an RC circuit with initial voltage $v(0) = 5\text{ V}$ and $v_T(t) = 0$:

$$v_T(t) - R_T C \dot{v}(t) - v(t) = 0 \quad \Rightarrow \quad R_T C \dot{v}(t) + v(t) = v_T(t)$$

- Homogeneous solution: $v(t) = A e^{-t/(R_T C)}$
- Complete: $\boxed{v(t) = 5 e^{-t/\tau}}$ with $\tau = R_T C$

### 2.4 Analogous First-Order Elements

Systems in **different physical domains** share the **same mathematical form**:

| Domain | Equation | Time Constant |
|--------|----------|---------------|
| **Thermal** | $\frac{MC}{UA}\dot{T} + T = T_F$ | $\tau = \frac{MC}{UA}$ |
| **Electrical (RC)** | $RC\dot{V} + V = V_{IN}$ | $\tau = RC$ |
| **Fluid** | $A_F R_F \rho g \dot{h} + h = h_{IN}$ | $\tau = A_F R_F \rho g$ |
| **Thermal conductivity** | $\frac{\lambda}{k}\dot{F} + F = F_{IN}$ | $\tau = \lambda/k$ |

> ✅ **General first-order canonical form**: $\boxed{\lambda \dot{x} + kx = 0}$ where $\tau = \lambda/k$.

---

## 3. Time Constant — Intuitive Understanding

| $\tau$ Value | System Behavior | Sensor Implication |
|-------------|-----------------|-------------------|
| **Small** (e.g., 2 h) | Fast response, reaches 37 °C quickly | **Better** — tracks rapid changes |
| **Large** (e.g., 63 h) | Slow response, takes days to stabilize | **Worse** — misses fast transients |

> ✅ **For sensors, the smaller the time constant, the better.**

### 3.1 Bandwidth from Time Constant

**Example**: An infrared thermal camera with $\tau < 5\text{ ms}$.

- Rising time constant: $\tau = 5\text{ ms}$
- Falling time constant: $\tau = 70\text{ ms}$ (dominant, more limiting)

**Usable bandwidth** (rule of thumb for first-order systems):

$$f_{\text{max}} \approx \frac{1}{2\tau_{\text{max}}} = \frac{1}{2 \times 70 \times 10^{-3}} \approx \boxed{7 \text{ Hz}}$$

> ⚠️ At frequencies above $f_{\text{max}}$, the system **cannot track** the signal — the output is attenuated and phase-shifted beyond acceptable limits. A 1000 Hz signal would be essentially invisible.

---

## 4. Second-Order Systems

### 4.1 Mechanical: Spring-Mass-Damper

$$\boxed{m\ddot{x} + c\dot{x} + kx = F}$$

### 4.2 Electrical: RLC Circuit

$$\boxed{L\ddot{q} + R\dot{q} + \frac{1}{C}q = V}$$

### 4.3 Non-Dimensionalized Canonical Form

$$\boxed{\ddot{x} + 2\omega_n \zeta \dot{x} + \omega_n^2 x = \frac{F}{m}}$$

| Parameter | Mechanical | Electrical (Series RLC) |
|-----------|-----------|-------------------------|
| **Natural frequency** $\omega_n$ | $\omega_n = \sqrt{\frac{k}{m}}$ | $\omega_n = \sqrt{\frac{1}{LC}}$ |
| **Damping ratio** $\zeta$ | $\zeta = \frac{c}{2m\omega_n}$ | $\zeta = \frac{R}{2L\omega_n}$ |

> ✅ **$\omega_n$** determines how fast the system can respond. **$\zeta$** determines whether it oscillates.

---

## 5. Second-Order Step Response

Characteristic equation: $r^2 + 2\omega_n \zeta r + \omega_n^2 = 0$

$$r = -\omega_n\zeta \pm \omega_n\sqrt{\zeta^2 - 1}$$

### 5.1 Three Damping Cases

| Case | $\zeta$ Value | Solution Form | Behavior |
|------|--------------|---------------|----------|
| **Under-damped** | $0 < \zeta < 1$ | $x = A e^{-\omega_n\zeta t} \sin\left(\sqrt{1-\zeta^2}\,\omega_n t + \phi\right)$ | Oscillates, decaying envelope |
| **Critically-damped** | $\zeta = 1$ | $x = (A + Bt) e^{-\omega_n\zeta t}$ | Fastest return to equilibrium **without** oscillation |
| **Over-damped** | $\zeta > 1$ | $x = A e^{-(\omega_n\zeta + \omega_n\sqrt{\zeta^2-1})t} + B e^{-(\omega_n\zeta - \omega_n\sqrt{\zeta^2-1})t}$ | Slow, no oscillation |

### 5.2 With Initial Condition $x(0) = x_{INIT}$, $\dot{x}(0) = 0$

| $\zeta$ | Complete Step Response |
|---------|----------------------|
| $0 < \zeta < 1$ | $\displaystyle x = x_{INIT}\, e^{-\omega_n\zeta t} \sin\left(\sqrt{1-\zeta^2}\,\omega_n t + \phi\right)$ |
| $\zeta = 1$ | $\displaystyle x = x_{INIT}(1 + \omega_n\zeta t) e^{-\omega_n\zeta t}$ |
| $\zeta > 1$ | $\displaystyle x = \frac{\zeta + \sqrt{\zeta^2-1}}{2\sqrt{\zeta^2-1}} x_{INIT}\, e^{-(\omega_n\zeta + \omega_n\sqrt{\zeta^2-1})t} + \frac{\sqrt{\zeta^2-1} - \zeta}{2\sqrt{\zeta^2-1}} x_{INIT}\, e^{-(\omega_n\zeta - \omega_n\sqrt{\zeta^2-1})t}$ |

---

## 6. IMU Example — Second-Order System in Practice

### 6.1 IMU (Inertial Measurement Unit)

An IMU measures **6 degrees of freedom**:

| Sensor | Measures | Variable |
|--------|----------|----------|
| **Magnetometer** | Orientation | $\theta_{roll}, \theta_{pitch}, \theta_{yaw}$ |
| **Gyroscope** | Angular velocity | $\dot{\theta}_{roll}, \dot{\theta}_{pitch}, \dot{\theta}_{yaw}$ |
| **Accelerometer** | Linear acceleration | $\ddot{x}, \ddot{y}, \ddot{z}$ |

### 6.2 Design Principle

> An IMU is fundamentally a **spring-mass-damper system**.

- **Enough damping** to kill oscillation, but not too much: $\boxed{0.1 < \zeta < 1}$
- **Large enough $\omega_n = \sqrt{k/m}$** to ensure fast response
- Trade-off: higher $\omega_n$ → faster but may increase noise sensitivity

> ✅ **Rule of thumb for sensor design**: $\zeta \approx 0.6\text{–}0.7$ gives the best compromise between rise time and overshoot.

---

## 7. Laplace Transform Method

### 7.1 Definition

$$\boxed{\mathcal{L}\{f(t)\} = F(s) = \int_0^{\infty} f(t) e^{-st} dt}$$

**Step input**: $f(t) = 1 \Rightarrow F(s) = \int_0^{\infty} 1 \cdot e^{-st} dt = \frac{1}{s}$

### 7.2 Transfer Function — First-Order

For the thermal system $\frac{MC}{UA}\dot{T} + T = T_F$:

$$\boxed{G(s) = \frac{T(s)}{T_F(s)} = \frac{1}{\frac{MC}{UA}s + 1} = \frac{1}{1 + \tau s}}$$

### 7.3 Step Response via Laplace

$$T(s) = G(s) \cdot \frac{1}{s} = \frac{1}{1 + \tau s} \cdot \frac{1}{s} = \frac{1}{s} - \frac{\tau}{\tau s + 1}$$

Inverse Laplace transform:

$$T(t) = \mathcal{L}^{-1}\{T(s)\} = A - B e^{-t/\tau}$$

Applying initial ($T(0) = T_{INIT}$) and final ($T(\infty) = T_F$) conditions:

$$\boxed{T(t) = T_F - (T_{INIT} - T_F) e^{-t/\tau}}$$

> ✅ The Laplace method gives **the same result** as the time-domain ODE approach, but is more systematic for complex systems.

---

## 8. Second-Order Transfer Function and Frequency Response

### 8.1 Transfer Function

From $\ddot{x} + 2\omega_n \zeta \dot{x} + \omega_n^2 x = F/m$:

$$\boxed{G(s) = \frac{x(s)}{F(s)} = \frac{1/m}{s^2 + 2\omega_n\zeta s + \omega_n^2}}$$

### 8.2 Frequency Response (Sinusoidal Steady State)

Substituting $s = j\omega$:

$$\boxed{|G(j\omega)| = \frac{1/m}{\sqrt{\left(1 - \frac{\omega^2}{\omega_n^2}\right)^2 + 4\zeta^2 \frac{\omega^2}{\omega_n^2}}}}$$

$$\boxed{\angle G(j\omega) = -\tan^{-1}\left(\frac{2\zeta\frac{\omega}{\omega_n}}{1 - \frac{\omega^2}{\omega_n^2}}\right)}$$

### 8.3 Key Frequency Response Behavior

| $\omega/\omega_n$ | Behavior |
|-------------------|----------|
| $\omega \ll \omega_n$ | $|G| \approx 1/(m\omega_n^2) = 1/k$ — quasi-static, stiffness-dominated |
| $\omega \ll \omega_n$ | $\angle G \approx 0°$ — negligible phase lag |
| $\omega = \omega_n$ | **Resonance** — amplitude peaks (especially for low $\zeta$) |
| $\omega = \omega_n$ | $\angle G = -90°$ |
| $\omega \gg \omega_n$ | $|G| \to 0$ — mass-dominated, severe attenuation |
| $\omega \gg \omega_n$ | $\angle G \to -180°$ |

> ⚠️ **Critical insight**: For a sensor to faithfully reproduce a signal, the signal's highest frequency component must be well **below** $\omega_n$. The **usable bandwidth** is typically $\omega \lesssim 0.1\,\omega_n$ to $0.5\,\omega_n$, depending on acceptable amplitude and phase errors.

---

## 9. Preview Problem for Lecture 4

> **Problem**: A moving square-shaped coil indicator is connected to a Thévenin signal source of resistance 12 Ω. Use the data given to answer:
> a) What is the sensitivity of the coil indicator?
> b) What is the natural frequency and damping ratio for the system?
> c) What is the working frequency range of the system?

*(Data to be provided from textbook tables — this is the preview problem for Lecture 4 on Loading Effects.)*

---

## 10. Summary Table

| Concept | First-Order | Second-Order |
|---------|-------------|--------------|
| **Canonical form** | $\tau \dot{y} + y = u$ | $\ddot{y} + 2\zeta\omega_n\dot{y} + \omega_n^2 y = (\omega_n^2/k)u$ |
| **Key parameter 1** | $\tau$ (time constant) | $\omega_n$ (natural frequency) |
| **Key parameter 2** | — | $\zeta$ (damping ratio) |
| **Step response** | Exponential approach | Decaying oscillation / exponential |
| **Transfer function** | $\frac{1}{1 + \tau s}$ | $\frac{\omega_n^2/k}{s^2 + 2\zeta\omega_n s + \omega_n^2}$ |
| **Usable bandwidth** | $f_{\text{max}} \approx \frac{1}{2\tau}$ | $f_{\text{max}} \sim 0.1\,\omega_n$ to $0.5\,\omega_n$ |
| **Design target** | Minimize $\tau$ | $\zeta \approx 0.6\text{–}0.7$, maximize $\omega_n$ |
| **Physical examples** | Thermometer, RC circuit, fluid tank | IMU, accelerometer, RLC circuit, galvanometer |

---

## 11. Key Equations Reference

| Equation | Formula |
|----------|---------|
| First-order response | $y(t) = y_{\infty} + (y_0 - y_{\infty}) e^{-t/\tau}$ |
| 63% settling | $t = \tau$ |
| 99.3% settling | $t = 5\tau$ |
| Second-order damped natural frequency | $\omega_d = \omega_n\sqrt{1 - \zeta^2}$ |
| Peak overshoot | $M_p = \exp\left(-\frac{\pi\zeta}{\sqrt{1-\zeta^2}}\right)$ |
| Settling time (2%) | $t_s \approx \frac{4}{\zeta\omega_n}$ |
| Resonance frequency | $\omega_r = \omega_n\sqrt{1 - 2\zeta^2}$ |

---

> ✅ **Key Takeaway**: Dynamic characteristics determine **how fast** a sensor can track changing signals. First-order systems are characterized by the **time constant** $\tau$ (smaller = faster). Second-order systems are characterized by **natural frequency** $\omega_n$ (larger = faster) and **damping ratio** $\zeta$ (0.6–0.7 is optimal). The Laplace transform and transfer function framework provide a systematic method for analyzing dynamic response across all physical domains.
