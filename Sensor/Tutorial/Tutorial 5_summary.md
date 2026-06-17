# Tutorial 5 — Reliability, TLOC, Capacitive/Inductive/Active Sensing & Mechanics

> **Source**: Tutorial 5 with Solutions.pdf
> **Instructor**: Qilong Zhong, MSc, GTIIT
> **Corresponds to**: Lectures 5–6 (Chapters 7–8 of Bentley)

---

## 1. Reliability Assessment

### 1.1 Core Definitions

| Metric            | Symbol          | Formula                                         | Meaning                                                             |
| ----------------- | --------------- | ----------------------------------------------- | ------------------------------------------------------------------- |
| **Reliability**   | $R(t)$          | —                                               | Probability of normal operation within specified environment & time |
| **Unreliability** | $F(t)$          | $F = 1 - R$                                     | Probability of failure                                              |
| **MTTF**          | —               | $\sum T_i / N$                                  | Average lifespan (non-repairable)                                   |
| **MDT**           | —               | Total Down Time $/$ Number of Failures          | Average repair duration                                             |
| **MTBF**          | —               | Total Up Time $/$ Number of Failures            | Time between two failures                                           |
| **Failure rate**  | $\bar{\lambda}$ | $1/\text{MTBF}$                                 | Failures per unit time                                              |
| **Availability**  | $A$             | $\dfrac{\text{MTBF}}{\text{MTBF} + \text{MDT}}$ | Probability system is operational                                   |

> ✅ **Golden rule**: $R(t) + F(t) = 1$ — equipment is either working or not.

---

## 2. System Architecture Reliability

### 2.1 Constant Failure Rate Model

For components in useful life: $\lambda$ = constant.

$$\boxed{R(t) = e^{-\lambda t}}$$
$$\boxed{F(t) = 1 - e^{-\lambda t}}$$

### 2.2 Series Systems

> **Logic**: ALL components must work for the system to operate.

| Rule | Formula |
|------|---------|
| **Multiply reliabilities** | $R_{SYS} = R_1 \times R_2 \times \cdots \times R_n$ |
| **Add failure rates** | $\boxed{\lambda_{SYS} = \lambda_1 + \lambda_2 + \cdots + \lambda_n}$ |

> ⚠️ Design principle: "Do not multiply entities beyond necessity" — minimize component count.

### 2.3 Parallel Systems

> **Logic**: System works as long as at least ONE component works (fails only if ALL fail).

| Rule | Formula |
|------|---------|
| **Multiply unreliabilities** | $F_{SYS} = F_1 \times F_2 \times \cdots \times F_n$ |
| **Identical components** | $\boxed{F_{SYS} = F^n}$ |

> ✅ Parallelism is a "heavy hitter" for improving reliability (probabilities shrink when multiplied), but at the cost of doubled hardware.

### 2.4 Mixed Redundancy (Median Selector)

> **Principle**: Three sensors in parallel → output via **median selector** → connected in series with other components.

**Example** (3 thermocouples, $\lambda_1 = 1.1$, + converter + recorder, each $\lambda = 0.1$, $t = 0.5$ yr):

| Step | Calculation | Result |
|------|-------------|--------|
| Single TC unreliability | $F = 1 - e^{-1.1 \times 0.5}$ | $1 - e^{-0.55}$ |
| 3-way parallel unreliability | $F_1 = (1 - e^{-0.55})^3$ | 0.076 |
| 3-way parallel reliability | $R_1$ | 0.924 |
| Series components | $R_2 = R_3 = R_4 = e^{-0.1 \times 0.5}$ | 0.951 each |
| **Overall system** | $R = 0.924 \times 0.951^3$ | **0.795** |

---

## 3. Total Life Cycle Operating Cost (TLOC)

### 3.1 Definition

> For any given application, the best system is the one with the **minimum TLOC**.

$$\boxed{TLOC = \text{Initial Purchase Cost} + \text{Total Failure/Maintenance Cost} + \text{Total Measurement Error Cost}}$$

### 3.2 Simplified Comparison Formula

When measurement errors are identical and there's no preventive maintenance:

$$\boxed{TLOC = C_1 + [C_R + (C_L + C_P) \times T_R] \times \lambda \times T}$$

| Term | Meaning |
|------|---------|
| $C_1$ | Initial purchase cost |
| $C_R$ | Material cost per repair |
| $C_L$ | Labor cost per hour |
| $C_P$ | **Process downtime cost** per hour |
| $T_R$ | Repair time (hours) |
| $\lambda$ | Annual failure rate |
| $T$ | Total lifespan (years) |

> ⚠️ **$C_P$ is the hidden giant**: Process downtime loss is often **hundreds or thousands of times** the spare parts cost. "Repairing quickly" and "not breaking easily" are extremely valuable.

### 3.3 Worked Example (10-year lifespan)

| | System 1 | System 2 |
|---|----------|----------|
| Initial cost | £1,000 | £2,000 |
| Cost per failure | £900 | £1,335 |
| Failures over 10 years | 20 | 10 |
| Total maintenance | £18,000 | £13,350 |
| **TLOC** | **£19,000** | **£15,350** ✅ |

> ✅ System 2 costs **twice as much** initially but has **lower TLOC** because of lower failure rate.

---

## 4. Capacitive Sensing Components

### 4.1 Fundamental Formula

$$\boxed{C = \frac{\varepsilon_0 \varepsilon_r A}{d}}$$

$C$ depends on: $\varepsilon_0$ (vacuum permittivity), $\varepsilon_r$ (relative permittivity), $A$ (plate overlap area), $d$ (plate separation).

### 4.2 Three Types

| Type | What Changes | Application |
|------|-------------|-------------|
| **Variable distance** | $d$ | Pressure sensors (diaphragm deflection) |
| **Variable area** | $A$ | Linear displacement |
| **Variable dielectric** | $\varepsilon_r$ | Liquid level, material boundary detection |

### 4.3 Variable Dielectric Sensor — Equivalent Circuit

When a dielectric plate is inserted between the plates:

$$\boxed{C_{total} = C_{air} + C_{dielectric} = \frac{\varepsilon_0 w}{d}\left[\varepsilon_1 x + \varepsilon_2(l - x)\right]}$$

> ✅ **Perfectly linear** relationship between $C$ and displacement $x$.

---

## 5. Variable Reluctance Sensing Components

### 5.1 Magnetic Circuit Fundamentals

| Quantity | Formula | 
|----------|---------|
| Ohm's Law for magnetic circuits | $\mathcal{F} = \Phi \times \mathcal{R}$ |
| Inductance-Reluctance relation | $\boxed{L = \dfrac{N^2}{\mathcal{R}_{total}}}$ |
| Reluctance | $\boxed{\mathcal{R} = \dfrac{l}{\mu \mu_0 A}}$ |

### 5.2 Variable Reluctance Displacement Sensor

$$\mathcal{R}_{total} = \mathcal{R}_{core} + \mathcal{R}_{armature} + \mathcal{R}_{gap}$$

| Material | $\mu$ | Reluctance |
|----------|-------|------------|
| Ferromagnetic (iron) | ~100–1000 | Very low |
| Air | 1 | **Extremely high** |

> ⚠️ **Critical insight**: Even if the air gap $d$ is only 1 mm, its reluctance may be **far greater** than a thick iron core! A tiny increase in $d$ → total reluctance rises sharply → inductance $L$ **plunges non-linearly**.

---

## 6. Active Electrical Sensing Elements

### 6.1 What Does "Active" Mean?

> **Self-generating**: Does NOT require external power supply. Extracts energy directly from the measurand (e.g., mechanical kinetic energy) and converts it into an AC electrical signal.

### 6.2 Faraday's Law of Induction

$$\boxed{E = -\frac{d\Psi}{dt}}$$

Induced EMF = negative rate of change of magnetic flux linkage.

### 6.3 Mathematical Model — Variable Reluctance Tachometer

- Flux linkage varies sinusoidally with angular displacement: $\Psi(\theta) \approx a + b\cos(m\theta)$
- $m$ = number of gear teeth
- $\omega_r$ = angular velocity of gear ($d\theta/dt$)

$$\boxed{E = b m \omega_r \sin(m\omega_r t)}$$

### 6.4 Two Direct Proportionality Laws

| Law | Formula | Meaning |
|-----|---------|---------|
| **Amplitude** | $\hat{E} = b m \omega_r$ | Peak voltage $\propto$ rotational speed |
| **Frequency** | $f = \dfrac{m\omega_r}{2\pi} = \dfrac{RPM}{60} \times m$ | AC signal frequency $\propto$ rotational speed |

---

## 7. Mechanical Mechanics & Elastic Deformation

### 7.1 Stress and Strain

| Quantity | Definition | Formula |
|----------|------------|---------|
| **Stress $\sigma$** | Internal force per unit area | $\sigma = F/A$ (+ tensile, − compressive) |
| **Strain $e$** | Relative change in dimension | $e = \Delta l / l$ |
| **Young's Modulus $E$** | Stiffness of material | $E = \sigma / e$ |

### 7.2 Poisson's Effect (3D Deformation Linkage)

> **Physical phenomenon**: When stretched (lengthened), material **must** become thinner. When compressed (shortened), it **must** become thicker.

$$\boxed{e_T = -\nu \, e_L}$$

| Symbol | Meaning | Typical Value |
|--------|---------|---------------|
| $e_L$ | Longitudinal strain | — |
| $e_T$ | Transverse strain | — |
| $\nu$ | Poisson's ratio | 0.25–0.4 |

> ⚠️ The **negative sign** is vital! Transverse and longitudinal deformation are always in **opposite** directions. Compressive force → $e_L < 0$ → $e_T > 0$ (material bulges/thickens).

---

## 8. Dynamic Characteristics of Sensors

### 8.1 Three Elements of a Real Sensor

| Element | Role |
|---------|------|
| **Mass / Inertia ($m, I$)** | Resists sudden changes in motion |
| **Damping / Friction ($\lambda, b$)** | Dissipates energy, hinders relative motion |
| **Stiffness / Elasticity ($k, c$)** | Provides restorative force during deformation |

### 8.2 Three Core Dynamic Parameters

| Parameter | Formula (Translation) | Formula (Rotation) |
|-----------|----------------------|---------------------|
| Steady-state gain $K$ | — | — |
| Natural frequency $\omega_n$ | $\sqrt{k/m}$ | $\sqrt{c/I}$ |
| Damping ratio $\xi$ | $\lambda/(2\sqrt{km})$ | — |

### 8.3 Accelerometer Principle — Relative Displacement

> The outer casing vibrates with the measured object. The internal proof mass **lags behind** due to inertia → **relative displacement** between mass and casing is what the sensor measures.

### 8.4 Amplitude-Frequency Characteristic

$$\boxed{\frac{\hat{\theta}}{\hat{\phi}_i} = \frac{(\omega/\omega_n)^2}{\sqrt{\left[1 - (\omega/\omega_n)^2\right]^2 + \left[2\xi(\omega/\omega_n)\right]^2}}}$$

### 8.5 Engineering's Golden Damping Ratio

$$\boxed{\xi = 0.707 = \frac{1}{\sqrt{2}}}$$

> ✅ This ratio enables the **flattest possible response** over the widest frequency range. Mathematically: the complex denominator simplifies to $\sqrt{1 + (\omega/\omega_n)^4}$, greatly reducing calculation difficulty.

---

## 9. Summary Table

| Domain | Key Concept | Core Formula |
|--------|-------------|-------------|
| Reliability | Exponential model | $R(t) = e^{-\lambda t}$ |
| Series system | Add failure rates | $\lambda_{SYS} = \sum \lambda_i$ |
| Parallel system | Multiply unreliabilities | $F_{SYS} = \prod F_i$ |
| TLOC | Total ownership cost | $C_1 + [C_R + (C_L+C_P)T_R]\lambda T$ |
| Capacitive | Variable dielectric | $C_{total} = \frac{\varepsilon_0 w}{d}[\varepsilon_1 x + \varepsilon_2(l-x)]$ |
| Inductive | Variable reluctance | $L = N^2/\mathcal{R}_{total}$ |
| Active (EM) | Faraday's Law | $E = -d\Psi/dt$ |
| Strain/Poisson | 3D deformation | $e_T = -\nu e_L$ |
| Accelerometer | Relative displacement | $\frac{\hat{\theta}}{\hat{\phi}_i} = f(\omega/\omega_n, \xi)$ |

---

> ✅ **Key Takeaway**: Reliability is quantified by $\lambda$ and modeled as exponential decay $R = e^{-\lambda t}$. Series systems multiply risk ($\lambda_{SYS} = \sum \lambda_i$); parallel redundancy divides it ($F_{SYS} = \prod F_i$). TLOC reveals that higher initial cost often means lower lifetime cost. Capacitive, inductive, and electromagnetic sensing each exploit a different physical domain. Accelerometer design targets $\xi = 0.707$ for the flattest frequency response.
