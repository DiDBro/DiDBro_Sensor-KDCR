# Tutorial 1 — Static Characteristics of Measurement System Elements

> **Source**: Tutorial 1_Solutions.pdf (17 pages)
> **Instructor**: Qilong Zhong, MSc, GTIIT
> **Corresponds to**: Lecture 1–2 (Chapters 1–2 of Bentley)

---

## 1. The General Measurement System

### 1.1 Accuracy and Error

A perfectly accurate system is theoretical. Real system accuracy is quantified by measurement error $E$:

$$\boxed{E = \text{Measured Value} - \text{True Value}}$$

### 1.2 Measurement System Structure

```
Process → [Sensing Element] → [Signal Conditioning] → [Signal Processing] → [Data Presentation] → Observer
```

---

## 2. Range and Span

| Concept | Definition | Formula |
|---------|------------|---------|
| **Range** | Allowable limits of operation | $I_{min} \to I_{max}$, $O_{min} \to O_{max}$ |
| **Span** | Maximum variation | Input Span $= I_{max} - I_{min}$, Output Span $= O_{max} - O_{min}$ |

> ⚠️ Range describes operation limits, **not** accuracy or precision.

---

## 3. Ideal Straight Line

For a linear element:

$$\boxed{O_{ideal} = KI + a}$$

Where:
- $K = \dfrac{O_{max} - O_{min}}{I_{max} - I_{min}}$ = **slope** (sensitivity)
- $a = O_{min} - KI_{min}$ = **intercept** (zero offset)

> ✅ Units matter: If $F$ is in Newtons and $V$ is in Volts, $K$ carries units of V/N; $a$ has same units as the output.

---

## 4. Non-linearity

### Definition

If the actual output is $O(I)$, then:

$$\boxed{N(I) = O(I) - (KI + a)}$$

- $O(I)$ = actual output
- $KI + a$ = ideal straight-line output
- $N(I)$ = non-linearity deviation at input $I$

### As Percentage of Full-Scale Deflection (FSD)

$$\boxed{\%\text{ f.s.d.} = \frac{\hat{N}}{O_{max} - O_{min}} \times 100\%}$$

where $\hat{N} = \max|N(I)|$ is the **maximum** deviation.

> ⚠️ **Critical**: The denominator is the **output span**, NOT the input span.

---

## 5. Interfering Input ($I_I$)

> **Definition**: An environmental variable that changes the **zero offset (intercept)** of the sensor output. It does NOT change the slope.

**Mathematical model**:

$$\boxed{O = KI + a + K_I I_I}$$

The **intercept** shifts from $a$ to $a + K_I I_I$.

| Symbol | Meaning |
|--------|---------|
| $K_I$ | Environmental sensitivity to interfering input |
| $I_I$ | Deviation from standard condition |

**Example**: Supply voltage variation in a potentiometer — shifts the entire I/O curve up/down without changing sensitivity.

---

## 6. Modifying Input ($I_M$)

> **Definition**: An environmental variable that changes the **sensitivity (slope)** of the sensor. It does NOT shift the intercept.

**Mathematical model**:

$$\boxed{O = (K + K_M I_M)I + a}$$

The **sensitivity** becomes $K + K_M I_M$.

| Symbol | Meaning |
|--------|---------|
| $K_M$ | Change in sensitivity per unit modifying input |
| $I_M$ | Deviation from standard condition |

**Example**: Temperature causes the spring stiffness in a pressure sensor to change → sensitivity changes, but zero-point stays fixed.

---

## 7. The Generalized Model (Summary)

Combining all effects:

$$\boxed{O = KI + a + N(I) + K_M I_M I + K_I I_I}$$

$$\boxed{O = (K + K_M I_M)I + (a + K_I I_I) + N(I)}$$

| Term | Meaning |
|------|---------|
| $KI + a$ | Ideal straight line |
| $N(I)$ | Non-linear deviation |
| $K_M I_M I$ | Gain change due to environment |
| $K_I I_I$ | Zero shift due to environment |

> 📖 **Engineering note**: To calculate $K$, we first set $N(I) = 0$ (assume linearity over the calibration range).

---

## 8. ADC — Analog-to-Digital Converter

### Resolution

For an $n$-bit ADC:

$$\boxed{\Delta V = \frac{V_{max} - V_{min}}{2^n}}$$

$$\boxed{\%\text{ f.s.d.} = \frac{1}{2^n} \times 100\%}$$

| Bits | Levels | Resolution (% f.s.d.) |
|------|--------|-----------------------|
| 8 | 256 | 0.39% |
| 10 | 1024 | 0.0976% |
| 12 | 4096 | 0.0244% |
| 16 | 65536 | 0.0015% |
| 24 | 16777216 | 0.000006% |

---

## 9. Hysteresis

> **Definition**: Output depends on the **direction** of input change. For the same input value, output differs when input is increasing vs. decreasing.

$$\boxed{H = V_{up} - V_{down}}$$

$$\boxed{\%\text{ f.s.d.} = \frac{H}{O_{max} - O_{min}} \times 100\%}$$

---

## 10. Key Formulas Reference

| Formula | Application |
|---------|-------------|
| $O_{ideal} = KI + a$ | Linear element model |
| $K = \frac{O_{max} - O_{min}}{I_{max} - I_{min}}$ | Sensitivity from endpoints |
| $a = O_{min} - KI_{min}$ | Intercept from endpoints |
| $N(I) = O(I) - (KI + a)$ | Non-linearity deviation |
| $\%\text{ N.L.} = \frac{\hat{N}}{O_{max} - O_{min}} \times 100\%$ | Non-linearity as %FSD |
| $O = KI + a + K_I I_I$ | With interfering input |
| $O = (K + K_M I_M)I + a$ | With modifying input |
| $O = KI + a + N(I) + K_M I_M I + K_I I_I$ | Generalized model |
| $\Delta V = \frac{V_{max} - V_{min}}{2^n}$ | ADC resolution |
| $H = V_{up} - V_{down}$ | Hysteresis |

---

> ✅ **Key Takeaway**: The generalized model $O = KI + a + N(I) + K_M I_M I + K_I I_I$ captures **all** static errors. Understanding the distinct roles of $I_I$ (shifts intercept) vs. $I_M$ (changes slope) is essential for sensor calibration and environmental compensation.
