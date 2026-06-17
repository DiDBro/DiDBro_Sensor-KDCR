# 035033-Intro to Sensor-Integrated Systems — Lecture 5: Reliability, Choice and Economics of Measurement Systems

> **Source**: Lecture 5.pdf (28 pages)
> **Textbook**: *Principles of Measurement Systems* by John P. Bentley, Chapter 7
> **Instructor**: Mingyi Liu, Ph.D., Associate Professor, Mechanical Engineering and Robotics, GTIIT
> **Date**: March 2026

---

## 1. Why Reliability Matters

> The **Space Shuttle Challenger** disaster: an O-ring seal failure caused the explosion.
>
> **The same principle applies to instruments** — every component can wear, tear, and fail.

**Key question**: Which sensor is more reliable — a pH sensor or a strain gauge? Reliability engineering gives us the tools to answer this quantitatively.

---

## 2. Reliability and Unreliability — Definitions

### 2.1 Basic Definitions

$$\boxed{R(t) = \text{Probability that the element/system operates to specification for time } t \text{ under specified conditions}}$$

$$\boxed{F(t) = 1 - R(t) \quad \text{(Unreliability)}}$$

**Example**: 100 measurements → 98 successes → $R = 0.98$ (98%), $F = 0.02$ (2%).

### 2.2 Practical Reliability Metrics

| Metric | Symbol | Formula | Unit |
|--------|--------|---------|------|
| **Mean Down Time** | MDT | $\displaystyle \frac{1}{N_F}\sum_{j=1}^{N_F} T_{D,j}$ | hours, years |
| **Total Up Time** | — | $NT - N_F \cdot MDT$ | hours, years |
| **Mean Time Between Failures** | MTBF | $\displaystyle \frac{NT - N_F \cdot MDT}{N_F}$ | years |
| **Mean Failure Rate** | $\bar{\lambda}$ | $\displaystyle \frac{1}{\text{MTBF}} = \frac{N_F}{NT - N_F \cdot MDT}$ | yr⁻¹ |
| **Availability** | $A$ | $\displaystyle \frac{\text{Total Up Time}}{\text{Test Interval}} = \frac{NT - N_F \cdot MDT}{NT}$ | — |
| **Unavailability** | $U$ | $1 - A$ | — |

**Worked Example**: 150 faults recorded for 200 transducers over 1.5 years, MDT = 0.002 years:

$$N = 200, T = 1.5\text{ yr}, N_F = 150, NT = 200 \times 1.5 = 300\text{ yr}$$

$$\text{MTBF} = \frac{300 - 150 \times 0.002}{150} = \frac{299.7}{150} \approx 2.0\text{ yr}$$

$$\bar{\lambda} = \frac{1}{2.0} = 0.5\text{ yr}^{-1}$$

$$A = \frac{300 - 150 \times 0.002}{300} = \frac{299.7}{300} = 0.999$$

---

## 3. The Bathtub Curve

The failure rate $\lambda(t)$ follows a characteristic **bathtub shape** over the product lifetime:

```
λ(t)
 │
 │  ╲                ╱
 │   ╲   ───────    ╱
 │    ╲            ╱
 │     ╲__________╱
 │
 └────────────────────────── t
   Early    Useful    Wear-out
   Failure  Life      Region
```

| Region | $\lambda(t)$ Behavior | Cause |
|--------|----------------------|-------|
| **Early Failure** | Decreasing | Design faults, poor quality components, manufacturing errors, installation errors, operator unfamiliarity |
| **Useful Life** | **Constant** (low) | Weak components removed; failures due to unpredictable low-level causes |
| **Wear-out** | Increasing | Long-life components reaching end of design life |

> ✅ **Key**: Many measurement elements have a useful life of **many years** → $\lambda(t) = \lambda$ (constant) is often an excellent approximation.

> ⚠️ **Mean failure rate** $\bar{\lambda}$ is constant. **Instantaneous failure rate** $\lambda(t)$ varies with time per the bathtub curve.

---

## 4. Exponential Reliability Model

For the constant failure rate region (useful life):

$$\boxed{R(t) = e^{-\lambda t}}$$

$$\boxed{F(t) = 1 - e^{-\lambda t}}$$

### 4.1 Derivation

The failure rate $\lambda$ is defined as:

$$\lambda = \frac{f(t)}{R(t)}$$

where $f(t) = -\frac{dR(t)}{dt}$ is the probability density function of failure time.

Then:
$$\lambda = -\frac{1}{R}\frac{dR}{dt} \quad \Rightarrow \quad -\int_{R_0}^{R(t)} \frac{dR}{R} = \int_0^t \lambda\, d\tau$$

$$\Rightarrow \quad \ln\frac{R_0}{R(t)} = \lambda t \quad \Rightarrow \quad \boxed{R(t) = e^{-\lambda t}}$$

> 📖 **Physical meaning**: The probability that an element survives $t$ years decreases exponentially with failure rate $\lambda$.

---

## 5. Reliability of Series and Parallel Systems

### 5.1 Series System

> A series system **fails if any one element fails**.

$$\boxed{R_{\text{SYS}} = R_1 \cdot R_2 \cdot R_3 \cdots R_N = e^{-\lambda_1 t} \cdot e^{-\lambda_2 t} \cdots e^{-\lambda_N t} = e^{-(\lambda_1 + \lambda_2 + \cdots + \lambda_N) t}}$$

$$\boxed{\lambda_{\text{SYS}} = \sum_{i=1}^{N} \lambda_i}$$

> ⚠️ **Series systems are fragile**: The system failure rate is the **sum** of all component failure rates.

### 5.2 Parallel System (Redundancy)

> A parallel system **fails only if ALL elements fail simultaneously**.

$$\boxed{F_{\text{SYS}} = F_1 \cdot F_2 \cdots F_N = (1 - e^{-\lambda_1 t})(1 - e^{-\lambda_2 t})\cdots(1 - e^{-\lambda_N t})}$$

$$\boxed{R_{\text{SYS}} = 1 - F_{\text{SYS}} = 1 - \prod_{i=1}^{N}(1 - e^{-\lambda_i t})}$$

> ✅ **Parallel systems are robust**: Redundancy dramatically increases reliability.

### 5.3 Numerical Example

| Configuration | $\lambda$ Values | $R$ at $t = 0.5$ yr |
|---------------|-----------------|---------------------|
| Single element | $\lambda = 0.3$ | $e^{-0.15} = 0.86$ |
| Single element | $\lambda = 0.5$ | $e^{-0.25} = 0.78$ |
| **Series** (both) | $\lambda = 0.3 + 0.5 = 0.8$ | $e^{-0.4} = 0.67$ |
| **Parallel** (both) | — | $1 - (1-e^{-0.15})(1-e^{-0.25}) = 0.97$ |

### 5.4 Triple Redundancy Example

For three identical subsystems, each with $R_i = e^{-1.3t}$:

- At $t = 0.5$ yr: $R_1 = R_2 = R_3 = e^{-0.65} = 0.52$
- **Triple parallel**: $R = 1 - (1-0.52)^3 = 1 - 0.48^3 = 1 - 0.11 = \boxed{0.89}$

> ✅ **Dramatic improvement**: From 52% (single) to 89% (triple parallel) at $t = 0.5$ yr.

---

## 6. Middle Value Selector

> A cost-effective alternative to full parallel redundancy.

**Principle**: Use 3 sensors, take the **median value**:

| Case | 3 Sensor Readings | Middle Value | Result |
|------|-------------------|-------------|--------|
| All good | [5.1, 5.1, 5.1] | 5.1 | ✅ Correct |
| 1 failed low | [5.1, 5.1, 0] | 5.1 | ✅ Correct |
| 1 failed high | [5.1, 5.1, 50] | 5.1 | ✅ Correct |
| 2 failed opposite | [5.1, 0, 50] | 5.1 | ✅ Still correct! |
| 2 failed same | [5.1, 0, 0] | 0 | ❌ Wrong |
| 2 failed same | [5.1, 50, 50] | 50 | ❌ Wrong |

> ✅ **Key advantage**: Tolerates **single** failure and some **double** failures (if they fail in opposite directions). The probability of two simultaneous failures in the same direction is very small.

---

## 7. Design for Reliability

### 7.1 Four Principles

| Principle | Description | Example |
|-----------|-------------|---------|
| **Element Selection** | Use elements with well-established failure rate data | Inductive LVDT is inherently more reliable than resistive potentiometer |
| **Environment** | Define environment first, select components that withstand it | Industrial vs. laboratory environment |
| **Minimum Complexity** | Minimize number of components (series system $\lambda_{\text{SYS}} = \sum \lambda_i$) | Fewer components = fewer failure modes |
| **Redundancy** | Use parallel identical elements | Triple-redundant sensors |
| **Diversity** | Use different operating principles in parallel | Temperature: electronic sensor + pneumatic sensor in parallel |

> ✅ **Diversity** protects against **common-cause failures** — faults that simultaneously affect identical elements (e.g., all electronic sensors fail in an EMP event, but pneumatic ones survive).

---

## 8. Total Lifetime Operating Cost (TLOC)

### 8.1 TLOC Formula

$$\boxed{TLOC = C_I + [C_R + (C_L + C_P)T_R]\lambda T + (C_M + C_L T_M)m + T\int_{-\infty}^{\infty} C_E p(E)\, dE}$$

| Term | Meaning |
|------|---------|
| $C_I$ | Initial cost (purchase, delivery, installation, commissioning) |
| $C_R$ | Average materials cost per repair |
| $C_L$ | Repair labour cost per hour |
| $C_P$ | Process cost per hour (cost of downtime) |
| $T_R$ | Repair time in hours |
| $\lambda T$ | Expected number of failures over lifetime $T$ |
| $C_M$ | Materials cost per scheduled maintenance |
| $T_M$ | Maintenance time in hours |
| $m$ | Number of scheduled maintenance events |
| $C_E$ | Cost of measurement error $E$ |
| $p(E)$ | Probability density function of error $E$ |

### 8.2 Worked Comparison

| System | $C_I$ | $C_R$ | $C_L$ | $C_P$ | $T_R$ | $\lambda T$ | TLOC |
|--------|-------|-------|-------|-------|-------|------------|------|
| System A | 1000 | 20 | 10 | 100 | 8 h | 2 × 10 | **19,000** |
| System B | 2000 | 15 | 10 | 100 | 12 h | 1 × 10 | **15,350** |

> ✅ **Insight**: System B has **higher initial cost** ($C_I = 2000$ vs $1000$) but **lower TLOC** (15,350 vs 19,000) because of lower failure rate. **Cheapest to buy ≠ cheapest to own.**

---

## 9. Preview Problem for Lecture 6

> **Problem**: A batch of 100 identical thermocouples were tested over a 10-week period. Twenty failures were recorded and the total down times is 120 h.
> a) Calculate the mean time between failures and mean failure rate.
> b) Calculate the reliability when 5 such sensors are connected in parallel in one month.
> c) Calculate the reliability when this sensor is integrated with a signal conditioning element ($\lambda = 1.2$ yr⁻¹) and an ADC ($\lambda = 0.3$ yr⁻¹) within one year.
> d) Continue question c): If you have 5 such sensors, how much reliability can you improve to?

---

## 10. Summary Table

| Concept | Formula | Notes |
|---------|---------|-------|
| **Reliability** | $R(t) = e^{-\lambda t}$ | For constant failure rate (useful life) |
| **Unreliability** | $F(t) = 1 - e^{-\lambda t}$ | Complement of reliability |
| **MTBF** | $\text{MTBF} = \frac{NT - N_F \cdot MDT}{N_F}$ | Mean time between failures |
| **Failure rate** | $\bar{\lambda} = 1/\text{MTBF}$ | Reciprocal of MTBF |
| **Availability** | $A = \frac{NT - N_F \cdot MDT}{NT}$ | Fraction of time operational |
| **Series reliability** | $R_{\text{SYS}} = \prod R_i = e^{-\sum \lambda_i t}$ | Weakest-link behavior |
| **Parallel reliability** | $R_{\text{SYS}} = 1 - \prod(1 - R_i)$ | Redundancy improves reliability |
| **TLOC** | See Section 8.1 | Total cost over system lifetime |

---

## 11. Key Equations Reference

| Equation | Usage |
|----------|-------|
| $\displaystyle \bar{\lambda} = \frac{N_F}{NT - N_F \cdot MDT}$ | Calculate failure rate from field data |
| $\displaystyle R(t) = e^{-\lambda t}$ | Predict reliability at time $t$ |
| $\displaystyle R_{\text{series}} = e^{-(\lambda_1 + \lambda_2 + \cdots)t}$ | Series system reliability |
| $\displaystyle R_{\text{parallel}} = 1 - (1 - e^{-\lambda t})^N$ | $N$ identical parallel elements |
| $\displaystyle A = \frac{\text{MTBF}}{\text{MTBF} + \text{MDT}}$ | Steady-state availability |

---

> ✅ **Key Takeaway**: Reliability is a **quantitative** engineering discipline. The exponential model $R(t) = e^{-\lambda t}$ captures the useful-life behavior of most measurement elements. **Parallel redundancy** dramatically improves system reliability (from 52% to 89% in the triple-redundant example), while **series configurations** multiply failure risks. **Total Lifetime Operating Cost (TLOC)** reveals that the cheapest initial purchase is often NOT the most economical choice — lower failure rates can more than compensate for higher upfront costs.
