# Tutorial 3 — Dynamic Response, Frequency Analysis & Compensation

> **Source**: Tutorial 3_Solutions.pdf
> **Instructor**: Qilong Zhong, MSc, GTIIT
> **Corresponds to**: Lecture 3 (Chapter 4 of Bentley)

---

## 1. Step Response of First-Order Systems

### 1.1 Engineering Background

Used for systems without mass/inertia: thermocouples, liquid-level systems, RC low-pass filter circuits.
These systems only exhibit "resistance" and "capacitance" characteristics.

### 1.2 Core Parameter: Time Constant $\tau$

| Domain | $\tau$ Formula | 
|--------|---------------|
| **Thermal** | $\tau = \dfrac{MC}{UA}$ |
| **Electrical** | $\tau = RC$ |

> ✅ Physical meaning: The **smaller** $\tau$, the **faster** the sensor tracks the true signal.

### 1.3 Mathematical Model — Step Response

When subjected to a step input of height $\Delta I$:

$$\boxed{\Delta O(t) = K \cdot \Delta I \cdot \left(1 - e^{-t/\tau}\right)}$$

| Time | Output Reaches |
|------|---------------|
| $t = \tau$ | **63.2%** of final value |
| $t = 3\tau$ | 95.0% |
| $t = 4\tau \sim 5\tau$ | **~99%** → essentially settled |

---

## 2. Step Response of Second-Order Systems

### 2.1 Engineering Background

Used for systems containing inertia: mechanical force sensors, accelerometers.
Due to mass ($m$), springs ($k$), and dampers ($\lambda$), these systems exhibit **overshoot and oscillation**.

### 2.2 Two Core Parameters

| Parameter | Formula | Physical Meaning |
|-----------|---------|-----------------|
| **Natural frequency** $\omega_n$ | $\omega_n = \sqrt{k/m}$ | Speed of inherent oscillation |
| **Damping ratio** $\xi$ | $\xi = \dfrac{\lambda}{2\sqrt{km}}$ | Ability to dissipate energy, suppress oscillation |

> ✅ Optimal engineering design: $\xi \approx 0.7$

### 2.3 Underdamped Step Response ($\xi < 1$)

$$\boxed{\Delta O(t) = K \cdot \Delta I \cdot \left[1 - e^{-\xi\omega_n t}\left(\cos\omega_d t + \frac{\xi}{\sqrt{1-\xi^2}}\sin\omega_d t\right)\right]}$$

where $\omega_d = \omega_n\sqrt{1 - \xi^2}$ is the **damped natural frequency**.

### 2.4 Key Points

| Feature | Determined By |
|---------|--------------|
| **Decay envelope** | $e^{-\xi\omega_n t}$ → Settling Time $T_s \approx \dfrac{5}{\xi\omega_n}$ |
| **Oscillation frequency** | Trigonometric terms → $\omega_d$ |

---

## 3. Handling Complex Periodic Signals — Fourier Series

### 3.1 The Superposition Principle

> **Fourier's insight**: Any complex **periodic** signal = superposition of sine waves of different frequencies (Fundamental + Higher Harmonics).

For a linear system: **Total Output = Sum of responses to each individual frequency component.**

### 3.2 General Sinusoidal Response Model

For input $I(t) = A_i \sin(\omega t)$, the steady-state output of a linear system is a sine wave of **the same frequency**:

$$\boxed{O(t) = A_i \cdot |G(j\omega)| \cdot \sin(\omega t + \phi)}$$

| Term | Meaning |
|------|---------|
| $\vert G(j\omega)\vert$ | **Amplitude ratio** — determines if signal is amplified or attenuated |
| $\phi$ | **Phase shift** — time lag/lead angle |

---

## 4. "Frequency Fingerprints" of First and Second-Order Systems

### 4.1 First-Order Systems (Thermocouples, RC filters)

| Characteristic | Formula |
|---------------|---------|
| **Amplitude Ratio** | $\displaystyle |G(j\omega)| = \frac{K}{\sqrt{1 + (\omega\tau)^2}}$ |
| **Phase Shift** | $\displaystyle \phi = -\arctan(\omega\tau)$ |

> ✅ **Natural Low-pass Filter**: Low frequencies pass with almost no loss ($|G| \approx 1$); high frequencies are severely attenuated.

### 4.2 Second-Order Systems (Force transducers, Accelerometers)

| Characteristic | Formula |
|---------------|---------|
| **Amplitude Ratio** | $\displaystyle |G(j\omega)| = \frac{K}{\sqrt{\left(1 - \frac{\omega^2}{\omega_n^2}\right)^2 + \left(2\xi\frac{\omega}{\omega_n}\right)^2}}$ |
| **Phase Shift** | $\displaystyle \phi = -\arctan\left(\frac{2\xi\frac{\omega}{\omega_n}}{1 - \frac{\omega^2}{\omega_n^2}}\right)$ |

> ⚠️ **Hidden Resonance Crisis**: When $\omega \approx \omega_n$ and $\xi$ is small, **destructive resonance amplification** occurs → severe measurement distortion.

---

## 5. Open-Loop Dynamic Compensation

### 5.1 Core Philosophy: Mathematical Cancellation

When physical sensor characteristics cannot be changed (e.g., $\tau$ too large → sluggish response), series-connect an electronic **compensation circuit** (lead-lag network) at the output.

### 5.2 Zero-Pole Cancellation

| Component | Transfer Function |
|-----------|------------------|
| Original Sensor | $G_s(s) = \dfrac{1}{1 + \tau_{slow}s}$ |
| Compensation Circuit | $G_c(s) = \dfrac{1 + \tau_{slow}s}{1 + \tau_{fast}s}$ |
| **Total** | $\boxed{G_{total}(s) = G_s(s) \cdot G_c(s) = \dfrac{1}{1 + \tau_{fast}s}}$ |

> ✅ **Result**: The slow pole is canceled; replaced by a **much faster** pole $\tau_{fast} \ll \tau_{slow}$.

### 5.3 Pros & Cons

| Pros | Cons |
|------|------|
| Low cost, simple to implement | **Fatal weakness**: Poor anti-interference |
| Significantly broadens flat bandwidth | If $\tau_{slow}$ drifts (temperature, aging) → cancellation fails completely |

---

## 6. Closed-Loop Negative Feedback Architecture

### 6.1 Core Philosophy: The Ultimate Revolution

> Stop letting the sensor "fight alone." Introduce a **feedback loop** that converts output back to input-domain quantity → compares with original input in real-time → system only responds to the **"net error."**

### 6.2 Force-Balanced Accelerometer Example

| Improvement | Mechanism |
|-------------|-----------|
| **Explosive bandwidth & speed** | $\omega_{n,c} \gg \omega_{n,open}$ (closed-loop has much higher natural frequency) |
| **Perfect damping** | By adjusting circuit gain, $\xi_c$ can be **locked at optimal 0.7** |
| **Ultimate robustness** | $K$ no longer depends on aging mechanical parameters (spring stiffness); depends on **highly stable electronic components** (precision resistors) and magnetic field strength |

> ✅ **The paradigm shift**: Mechanical precision → Electronic stability. Electrons don't wear out; springs do.

---

## 7. Summary Table — Dynamic Systems

| System Type | Key Parameter(s) | Step Response | Frequency Behavior |
|------------|-------------------|---------------|-------------------|
| **First-order** | $\tau$ (time constant) | Exponential approach $1 - e^{-t/\tau}$ | Low-pass: $|G| = 1/\sqrt{1 + (\omega\tau)^2}$ |
| **Second-order, underdamped** | $\omega_n, \xi < 1$ | Oscillatory decay | Resonance near $\omega_n$ |
| **Second-order, critically damped** | $\omega_n, \xi = 1$ | Fastest non-oscillatory | Smooth roll-off |
| **Second-order, overdamped** | $\omega_n, \xi > 1$ | Slow, no oscillation | Gradual attenuation |
| **Closed-loop** | $\omega_{n,c}, \xi_c$ | Tunable via feedback | Extended flat bandwidth |

---

> ✅ **Key Takeaway**: Open-loop dynamic compensation ($G_c(s)$ cancels $G_s(s)$ pole) is **cheap but fragile**. Closed-loop negative feedback is the **architectural revolution** — it replaces mechanical precision with electronic stability, delivering higher bandwidth, optimal damping, and robustness against aging.
