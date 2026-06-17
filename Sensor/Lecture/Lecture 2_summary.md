# 035033-Intro to Sensor-Integrated Systems — Lecture 2: Accuracy of Measurement Systems in the Steady State

> **Source**: Lecture 2.pdf (24 pages)
> **Textbook**: *Principles of Measurement Systems* by John P. Bentley, Chapter 3
> **Instructor**: Mingyi Liu, Ph.D., Associate Professor, Mechanical Engineering and Robotics, GTIIT
> **Date**: March 2026

---

## 1. Course Rules (Review & New)

| Rule | Detail |
|------|--------|
| **Final Answer Format** | Must be in a **red box** with **units** (e.g., "5 Ampere ✓" not "5 ✗") |
| **Copying** | Strictly forbidden — both giving and receiving; no photos, WeChat, email |
| **Discussion** | Allowed — discuss approach, check final answers |
| **Homework Weight** | Only 20% of final score (90% students get full marks anyway) |
| **Exam Weight** | 60% — no way to copy |

---

## 2. Review: Measurement System Structure

```
Process → [Sensing Element] → [Signal Conditioning] → [Signal Processing] → [Data Presentation] → Observer
```

**Concrete example** (photoresistor circuit):

| Stage | Element | Function |
|-------|---------|----------|
| Sensing | Photoresistor | Resistance changes with light |
| Signal Conditioning | Voltage divider (10 kΩ) | Converts ΔR → ΔV |
| Signal Processing | ADC (Arduino) | Analog → Digital |
| Data Presentation | Serial monitor | Display reading |

---

## 3. Review: Environmental Effects & Generalized Model

### 3.1 Generalized Model (Recap)

$$\boxed{O = KI + a + N(I) + K_M I_M I + K_I I_I}$$

Can be rewritten to highlight how environment alters the effective sensitivity and bias:

$$\boxed{O = (K + K_M I_M)I + (a + K_I I_I) + N(I)}$$

| Term | Physical Meaning |
|------|-----------------|
| $K + K_M I_M$ | **Effective sensitivity** — modified by environmental input $I_M$ |
| $a + K_I I_I$ | **Effective bias/offset** — shifted by interfering input $I_I$ |
| $N(I)$ | Residual non-linearity |

> ✅ **Intuition**: $I_M$ (modifying input, e.g., temperature) **scales the slope** — it multiplies the signal. $I_I$ (interfering input, e.g., supply voltage) **shifts the intercept** — it adds a constant offset independent of the signal.

### 3.2 Calibration Principle

Calibration means measuring $I$, $O$, $I_M$, $I_I$ simultaneously under controlled conditions to determine the unknown parameters $K, a, N(I), K_M, K_I$. The reference instruments used must be **more accurate** than the sensor being calibrated — these are called **standards**.

---

## 4. Preview Problem — Worked Solution

> **Problem**: An ideal displacement sensor is described by $V = KI + a = 0.012I + 0.2$ at 20 °C and supply voltage 5 V. $V$ in Volts, $I$ in meters. The general model is $O = KI + a + N(I) + K_M I_M I + K_I I_I$ (non-linearity $N(I)$ negligible). Given: $K_M = 0.0002 \text{ V/(m·°C)}$, $K_I = 0.01 \text{ V/V}$.

### Part (a): Sensitivity and Bias at 30 °C, 5.5 V

**Identify the environmental deviations**:
- $I_M = T - T_{\text{ref}} = 30 - 20 = 10$ °C
- $I_I = V_s - V_{s,\text{ref}} = 5.5 - 5 = 0.5$ V

**Effective sensitivity**:
$$K_{\text{eff}} = K + K_M I_M = 0.012 + 0.0002 \times 10 = 0.012 + 0.002 = \boxed{0.014 \text{ V/m}}$$

**Effective bias**:
$$a_{\text{eff}} = a + K_I I_I = 0.2 + 0.01 \times 0.5 = 0.2 + 0.005 = \boxed{0.205 \text{ V}}$$

### Part (b): Output for 40 cm Displacement

$I = 40 \text{ cm} = 0.4 \text{ m}$

**Ideal model** (reference conditions):
$$V_{\text{ideal}} = 0.012 \times 0.4 + 0.2 = 0.0048 + 0.2 = \boxed{0.2048 \text{ V}}$$

**Model with environmental effects** (at 30 °C, 5.5 V):
$$V_{\text{real}} = 0.014 \times 0.4 + 0.205 = 0.0056 + 0.205 = \boxed{0.2106 \text{ V}}$$

### Part (c): Error if Environment is Ignored

$$\text{Error} = V_{\text{real}} - V_{\text{ideal}} = 0.2106 - 0.2048 = 0.0058 \text{ V}$$

$$\text{Error \%} = \frac{0.0058}{0.2048} \times 100\% = \boxed{2.83\%}$$

> ⚠️ **Lesson**: A mere 10 °C and 0.5 V deviation from reference conditions produces ~3% error. In precision applications, ignoring environmental effects is unacceptable.

---

## 5. Measurement Error of a System of Ideal Elements

### 5.1 System Error

For a cascade of $n$ elements, each with gain $K_i$:

$$\boxed{E = O - I = I(K_1 K_2 \ldots K_n) - I = (K_1 K_2 \ldots K_n - 1)I}$$

- If $K_1 K_2 \ldots K_n = 1$: $\boxed{E = 0}$ — **perfectly accurate**
- In reality, every element has non-ideal characteristics (non-linearity, environmental effects, statistical variations)

> 📖 **Key**: Even a chain of "ideal" linear elements produces error if the product of gains ≠ 1.

---

## 6. Error Probability Density Function

### 6.1 Propagation of Means and Variances

For a cascade of $n$ elements, each following the generalized model:

$$\bar{O}_i = \bar{K}_i \bar{I}_i + \bar{a}_i + \bar{N}_i(\bar{I}_i) + \bar{K}_{M,i} \bar{I}_{M,i} \bar{I}_i + \bar{K}_{I,i} \bar{I}_{I,i}$$

$$\bar{E} = \bar{O}_n - \bar{I}_1 \quad \text{(system error mean)}$$

### 6.2 Worked Example: Pt100 RTD

Given a platinum resistance thermometer with:
- $R_T = R_0(1 + \alpha T + \beta T^2)$
- $R_0 = 100\ \Omega$, $\alpha = 3.909 \times 10^{-3} / K$, $\beta = -5.897 \times 10^{-7} / K^2$
- $T = 117$ °C

**Step 1 — Mean resistance**:

$$\bar{R}_T = \bar{R}_0(1 + \bar{\alpha}T + \bar{\beta}T^2) = 100 \times (1 + 3.909 \times 10^{-3} \times 117 - 5.897 \times 10^{-7} \times 117^2) = 144.9\ \Omega$$

**Step 2 — Sensitivity coefficient** (partial derivative):

$$\frac{\partial R_T}{\partial R_0} = 1 + \alpha T + \beta T^2 = 1 + 3.909 \times 10^{-3} \times 117 - 5.897 \times 10^{-7} \times 117^2 = 1.449$$

**Step 3 — Variance propagation**:

$$\boxed{\sigma_{R_T}^2 = \left(\frac{\partial R_T}{\partial R_0}\right)^2 \sigma_{R_0}^2 = 1.449^2 \times (4.33 \times 10^{-2})^2 = 0.00394}$$

$$\sigma_{R_T} = \sqrt{0.00394} = 0.0628\ \Omega$$

> ✅ **Key**: The variance propagation formula $\sigma_O^2 = \sum (\partial O/\partial x_i)^2 \sigma_{x_i}^2$ is the fundamental tool for predicting overall measurement uncertainty from individual element uncertainties.

---

## 7. Modelling Using Error Bands

When individual error sources are too small to decompose economically, manufacturers specify **error bands**:

- A single envelope that **bounds all errors** (non-linearity + hysteresis + resolution + environmental effects)
- The sensor output is guaranteed to lie within $\pm h$ of the nominal characteristic
- **Conservative but practical** approach for system-level error analysis

---

## 8. Error Reduction Techniques

### 8.1 Correcting Non-Linearity

> Introduce a **compensating non-linear element** whose non-linearity cancels the original.

**Principle**: If element A has $O_A = K_A I + N_A(I)$, insert element B with $O_B = K_B O_A + N_B(O_A)$ such that $N_B \approx -N_A$.

### 8.2 Isolation

> Physically isolate the transducer from environmental changes so that $I_M = I_I = 0$.

| Example | Method |
|---------|--------|
| Thermocouple reference junction | Placed in temperature-controlled enclosure |
| Vibration-sensitive transducer | Spring mountings to isolate from structure vibrations |

### 8.3 Zero Environmental Sensitivity

> Design the element to be **completely insensitive** to environmental inputs, i.e., $K_M = K_I = 0$.

**Example**: Metal alloy with zero temperature coefficients of expansion and resistance for strain gauges.

> ⚠️ **Practical limitation**: Such ideal materials are difficult to find. Real strain gauges are still slightly affected by ambient temperature.

### 8.4 Opposing Environmental Inputs

> Use a **differential configuration** where two identical elements are exposed to the same environment in opposite ways, so environmental effects cancel.

**Principle**: If element 1 sees $I_M$ and element 2 sees the same $I_M$, their outputs can be subtracted to eliminate the common $K_M I_M$ term.

### 8.5 High-Gain Negative Feedback

> Use **high-gain negative feedback** to compensate for modifying inputs and non-linearity.

$$\boxed{O = \frac{A}{1 + A\beta} I \approx \frac{1}{\beta} I \quad \text{for large } A}$$

- Forward path gain $A$ may be non-linear and environmentally sensitive
- The closed-loop gain $\approx 1/\beta$ depends only on the **feedback path** — which can be made stable and accurate
- This is the **fundamental principle** behind operational amplifiers and many precision instruments

> ✅ **Why it works**: As $A \to \infty$, the transfer function is dominated by $\beta$ (feedback network), not by $A$ (forward path with all its imperfections).

---

## 9. Direct vs. Inverse Equations

| Type | Form | Use Case |
|------|------|----------|
| **Direct** | $O = KI + a + N(I) + K_M I_M I + K_I I_I$ | Given input $I$, predict output $O$ |
| **Inverse** | $I = K'O + a' + N'(O) + K_M' I_M O + K_I' I_I$ | Given output $O$, estimate input $I$ |

> 📖 **Why both matter**: The **direct equation** models forward behavior; the **inverse equation** is used in **calibration** and **compensation** to reconstruct the true input from raw readings. For smart sensors with built-in microcontrollers, the inverse model is computed in real-time.

---

## 10. Compensation — Summary

> **Compensation**: The deliberate introduction of a **counteracting or modifying effect** into a measurement system to reduce or eliminate an undesired influence.

| Method | What it addresses | Key idea |
|--------|-------------------|----------|
| **Non-linear compensation** | $N(I)$ | Cascade with inverse non-linearity |
| **Isolation** | $I_M, I_I$ | Make environmental inputs zero |
| **Zero sensitivity** | $K_M, K_I$ | Choose materials insensitive to environment |
| **Opposing inputs** | $I_M, I_I$ | Differential cancellation |
| **High-gain feedback** | $K_M I_M, N(I)$ | Feedback makes system depend on $\beta$, not $A$ |
| **Inverse equation** | All errors | Mathematically reconstruct input from output |

---

## 11. Summary Table

| Concept | Formula / Method | Purpose |
|---------|-----------------|---------|
| Generalized model | $O = KI + a + N(I) + K_M I_M I + K_I I_I$ | Complete description of sensor behavior |
| Effective sensitivity | $K_{\text{eff}} = K + K_M I_M$ | Sensitivity at actual operating conditions |
| Effective bias | $a_{\text{eff}} = a + K_I I_I$ | Offset at actual operating conditions |
| System error | $E = (K_1 K_2 \ldots K_n - 1)I$ | Error from non-unity gain cascade |
| Variance propagation | $\sigma_O^2 = \sum (\partial O/\partial x_i)^2 \sigma_{x_i}^2$ | Predict overall uncertainty |
| Error bands | $\pm h$ envelope | Conservative total error bound |
| Feedback gain | $A/(1 + A\beta) \approx 1/\beta$ | Desensitize to forward-path imperfections |
| Inverse model | $I = K'O + a' + \ldots$ | Reconstruct true input |

---

> ✅ **Key Takeaway**: Steady-state accuracy depends on understanding and controlling **all terms** in the generalized model. The five error reduction techniques (compensation, isolation, zero-sensitivity, opposing-inputs, high-gain feedback) form the **toolkit** for precision measurement engineering. In practice, error band modeling and statistical variance propagation provide the quantitative framework for predicting system-level accuracy.
