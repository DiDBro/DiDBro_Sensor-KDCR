# Tutorial 2 — Systematic Error, Error Bands, Feedback & Statistical Analysis

> **Source**: Tutorial 2_Solutions.pdf
> **Instructor**: Qilong Zhong, MSc, GTIIT
> **Corresponds to**: Lecture 2 (Chapter 3 of Bentley)

---

## 1. Basic Systematic Error — Three Assumptions of Ideal Elements

### 1.1 Three Assumptions

| Assumption | Description |
|------------|-------------|
| **Perfectly linear** | Strictly proportional relationship between input and output |
| **Zero intercept** | When input = 0, output = 0 (i.e., $a = 0$) |
| **No environmental inputs** | Not affected by temperature, humidity, etc. |

### 1.2 Series System Error

For ideal elements: $O_i = K_i I_i$

The output of the previous element is the input for the next:

- Level 1: $O_1 = K_1 I$
- Level 2: $O_2 = K_2 O_1 = K_2 K_1 I$
- Level 3: $O_3 = K_3 O_2 = K_3 K_2 K_1 I$

$$\boxed{K_{sys} = K_1 \times K_2 \times \cdots \times K_n}$$

$$\boxed{E = O - I = (K_1 K_2 \cdots K_n - 1)I}$$

> ✅ When $K_{sys} = 1$, error = 0 — perfectly accurate.

---

## 2. Error Band Modeling and Propagation

### 2.1 What is an Error Band ($\pm h$)?

Manufacturers typically provide an "accuracy range" (e.g., $\pm 1\%$). This means the actual output is restricted within a band of total width $2h$ around the ideal linear path.

### 2.2 From "Range" to "Variance" — Uniform Distribution

> **Statistical assumption**: Error is equally likely at any point within $\pm h$ → **Rectangular (uniform) distribution**.

$$\boxed{\sigma^2 = \frac{h^2}{3}}$$

This transforms a manufacturer's $\pm h$ spec into a **variance** usable in error propagation.

### 2.3 Variance Propagation in Series Systems

Errors accumulate level by level and are **amplified by the sensitivity** $K$ of each subsequent element:

$$\boxed{\sigma_{out, i}^2 = (K_i \cdot \sigma_{in, i})^2 + \frac{h_i^2}{3}}$$

where $\sigma_{in, i} = \sigma_{out, i-1}$ (previous stage's variance becomes the next stage's input variance).

> ⚠️ **Key**: The initial input (true physical quantity) usually has **no random error**: $\sigma_{in,1}^2 = 0$.
>
> Also: Sensitivity $K_1$ of the first element **never amplifies its own error** — the output variance of the first stage is simply $h_1^2/3$.

---

## 3. High-Gain Negative Feedback & Error Reduction

### 3.1 The Pain Point of Open-Loop Systems

In a series (open-loop) system, **any** parameter drift in the forward path is directly amplified proportionally → massive measurement errors. Searching for "perfect elements" is prohibitively expensive.

### 3.2 The Solution: Negative Feedback

> **Core idea**: "Pull back" the actual output and compare it with the intended input through subtraction. Use the resulting "error signal" to drive the system to self-correct.

### 3.3 Closed-Loop Transfer Function

$$\boxed{\frac{O}{I} = \frac{K_{forward}}{1 + K_{forward} \cdot K_{feedback}}}$$

### 3.4 High-Gain Approximation (The "Magic")

When $K_{forward} \cdot K_{feedback} \gg 1$:

$$\boxed{\frac{O}{I} \approx \frac{1}{K_{feedback}}}$$

> ✅ **The "Leverage" Effect**: Overall accuracy becomes **decoupled** from the forward path (which can now use cheap, drift-prone components) and depends **solely** on the stability of the feedback element. This dramatically improves immunity to interference.

---

## 4. Comprehensive Statistical Error Analysis — The "Dual-Track" Algorithm

### 4.1 Real-World Complexity

Real measurement systems are **non-linear** (quadratic terms, exponential terms, etc.) and simultaneously affected by cross-interference from multiple random variables.

### 4.2 Track 1: Calculating Mean Error $\bar{E}$ (Systematic Bias)

> **Rule**: Ignore fluctuations, plug in **mean values**.

$$\boxed{\bar{E} = \bar{O} - \text{True Input } I}$$

Substitute all nominal mean values step-by-step into the non-linear equations to calculate the final measured mean $\bar{O}$.

### 4.3 Track 2: Calculating Error Standard Deviation $\sigma_E$ (Random Fluctuation)

> **Rule**: Use partial derivatives as **weights** for variance propagation.

For a multi-variable function $y = f(x_1, x_2, \ldots, x_n)$:

$$\boxed{\sigma_y^2 = \sum_{i=1}^{n} \left(\frac{\partial f}{\partial x_i}\right)^2 \sigma_{x_i}^2}$$

> ⚠️ **Critical pitfall**: Partial derivatives must be evaluated at the **mean values** from Track 1!

### 4.4 Engineering Diagnosis & Optimization

| Symptom | Cause | Fix |
|---------|-------|-----|
| $\bar{E}$ is **large** | Systematic bias / software algorithm error | Modify inverse calculation formula in microcontroller; upgrade to more precise polynomial or lookup table |
| $\sigma_E$ is **large** | Random fluctuation from environment | Identify largest variance term; add auxiliary sensors (temperature, pressure) for real-time **dynamic compensation** |

> ✅ **Example**: If fluid density $\rho$ is hard-coded as constant 1.2 but actually varies with temperature and pressure, install temperature + pressure sensors and use the ideal gas law $\rho = P/(RT)$ for **real-time density compensation**.

---

## 5. Key Formulas Reference

| Concept | Formula |
|---------|---------|
| Series system sensitivity | $K_{sys} = K_1 K_2 \cdots K_n$ |
| System error | $E = (K_{sys} - 1)I$ |
| Error band → variance | $\sigma^2 = h^2/3$ |
| Variance propagation (series) | $\sigma_{out,i}^2 = (K_i \sigma_{in,i})^2 + h_i^2/3$ |
| Closed-loop gain | $\frac{O}{I} = \frac{K_F}{1 + K_F K_B}$ |
| High-gain approx | $O/I \approx 1/K_B$ |
| Multi-variable variance | $\sigma_y^2 = \sum (\partial f/\partial x_i)^2 \sigma_{x_i}^2$ |

---

> ✅ **Key Takeaway**: The "Dual-Track" algorithm separates **systematic error** (mean shift → fix software/calibration) from **random error** (variance → fix hardware/dynamic compensation). High-gain negative feedback is the most powerful technique for making system accuracy depend on the stable feedback element rather than the imperfect forward path.
