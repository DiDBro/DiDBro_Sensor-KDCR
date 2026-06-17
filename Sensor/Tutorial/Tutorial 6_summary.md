# Tutorial 6 — DC Bridge Analysis, Linearization & Signal Amplification

> **Source**: Tutorial 6_Solutions.pdf
> **Instructor**: Qilong Zhong, MSc, GTIIT
> **Corresponds to**: Lectures 6, 8 (Chapters 8–9 of Bentley)

---

## 1. Basic DC Bridge Analysis

### 1.1 Why a Bridge?

> Sensors (e.g., RTDs, strain gauges) typically output a **minute change in resistance** — instruments cannot read this directly. The **Deflection Bridge** is a conversion circuit that transforms $\Delta R$ into a **measurable voltage difference**.

### 1.2 Key Parameters

| Symbol | Name | Role |
|--------|------|------|
| $V_S$ | Supply voltage | Drives the system; determines upper output limit and power consumption |
| $E_{Th}$ | Output voltage | Thévenin equivalent potential at measurement terminals |
| $R_1$ (or $R_T$) | **Active bridge arm** | The sensor itself — resistance changes with measurand |
| $R_2, R_3, R_4$ | **Fixed bridge arms** | Precision reference resistors selected by the engineer |

### 1.3 Three Core Formulas

**1) Output Voltage Formula:**

$$\boxed{E_{Th} = V_S \left(\frac{R_1}{R_1 + R_4} - \frac{R_2}{R_2 + R_3}\right)}$$

**2) Bridge Balance Condition ($E_{Th} = 0$):**

$$\boxed{\frac{R_4}{R_1} = \frac{R_3}{R_2}}$$

**3) RTD Temperature Characteristic (Metal Resistance):**

$$\boxed{R_T = R_0(1 + \alpha T)}$$

where $R_0$ = resistance at 0 °C, $\alpha$ = temperature coefficient.

---

## 2. Bridge Design — Worked Example

### Problem Setup
- RTD sensor: $\alpha = 0.00385$/ °C, $R_0 = 100\ \Omega$
- Bridge arms: $R_2 = R_3 = R_4 = 100\ \Omega$
- Supply voltage $V_S = 10$ V

### (a) Output at 0 °C and 100 °C

At 0 °C: $R_1 = R_0 = 100\ \Omega$, bridge balanced → $E_{Th} = 0$ V

At 100 °C:
$$R_1 = 100(1 + 0.00385 \times 100) = 138.5\ \Omega$$

$$E_{Th} = 10\left(\frac{138.5}{138.5 + 100} - \frac{100}{100 + 100}\right) = 10(0.5808 - 0.5) = 0.808\text{ V}$$

### (b) Design $V_S$ to output 100 mV at 100 °C

Scaling proportionally: $V_S = 10 \times \frac{0.1}{0.808} = 1.24\text{ V}$

---

## 3. Engineering Design and Linearization of Sensor Bridges

### 3.1 The Core Pain Point

| State | Description |
|-------|-------------|
| **Ideal** | Perfectly proportional, linear relationship between measurand and $V_{out}$ |
| **Reality** | Bridge voltage division has **inherent nonlinearity**; some sensors (thermistors) exhibit **severe exponential nonlinearity** |

> **Engineering Goal**: Without software, use clever hardware circuit parameter choices to **"force" the output curve into a straight line**.

### 3.2 Strategy One: Large Bridge Arm Ratio Method

> **For**: Small $\Delta R$ sensors like RTD platinum resistors.

**Design Concept**: Make fixed bridge arm resistance much larger than sensor resistance. Bridge ratio $r = R_3/R_2 \gg 1$. Use a massive fixed base value to "dilute/mask" fluctuations in the denominator.

$$\boxed{V_{OUT} \approx V_S \cdot \alpha T \cdot \frac{1}{r}}$$

| Trade-off | Effect |
|-----------|--------|
| **Linearity** | ✅ Excellent — denominator fluctuations are negligible |
| **Sensitivity** | ❌ Reduced — output voltage is smaller |

### 3.3 Strategy Two: Three-Point Design Method

> **For**: Severe nonlinearity sensors like **thermistors** ($R_\theta \propto e^{1/T}$).

**Design Concept**: Use the "upward curvature" of the bridge output curve to **precisely cancel** the "downward curvature" from the exponential drop in thermistor resistance.

**Three-Step Guide**:
1. **Lock in** Start Point, Midpoint, and End Point of the measurement temperature range
2. **Mandate** that these three points output perfectly equidistant voltages (e.g., 0 V, 0.5 V, 1.0 V)
3. **Set up** a system of 3 equations → solve for the unique $\boxed{\text{Bridge Ratio } r}$ and $\boxed{\text{Supply Voltage } V_S}$

> ✅ For thermistors, the optimal $r$ is typically between **0.25 ∼ 0.30**.

---

## 4. System-Level Integration — Bridge + Amplifier

### 4.1 Why an Amplifier?

| Reality | Requirement | Gap |
|---------|-------------|-----|
| Bridge output $E_{Th}$: few mV → μV | ADC/microcontroller needs: 1.0 V ∼ 5.0 V | **×100 to ×1000** |

### 4.2 The Ideal Op-Amp — Two "Magic Tricks"

| Assumption | Meaning | Consequence |
|------------|---------|-------------|
| **Virtual Open** $i_+ = i_- = 0$ | Infinite input impedance | Never "steals" current from the bridge |
| **Virtual Short** $V_+ = V_-$ | Under negative feedback, both inputs forced to same potential | Simplifies analysis |

> ✅ Virtual Open guarantees that the op-amp **doesn't load** the bridge — all bridge formulas remain valid.

### 4.3 Ultimate Formula — Full Bridge + Differential Amplifier

For a **four-arm active bridge** (all 4 strain gauges) connected to a differential amplifier:

$$\boxed{V_{OUT} = 2 \cdot V_S \cdot G \cdot e \cdot \frac{R_F}{R_0}}$$

| Symbol | Meaning | Example |
|--------|---------|---------|
| $V_{OUT}$ | Final standard output voltage | 1.0 V |
| $R_F$ | **Feedback resistor** (only component to calculate!) | To be designed |
| $R_0$ | Initial sensor resistance | 120 Ω |
| $V_S$ | Bridge supply voltage | 15 V |
| $G$ | Gauge factor of strain gauge | ~2 |
| $e$ | Physical strain | — |

> ✅ **Only $R_F$ needs to be calculated** — the rest are sensor specs or system requirements!

---

## 5. Summary Table

| Topic | Key Formula | Notes |
|-------|-------------|-------|
| Bridge output | $E_{Th} = V_S\left(\frac{R_1}{R_1+R_4} - \frac{R_2}{R_2+R_3}\right)$ | General formula |
| Balance condition | $R_4/R_1 = R_3/R_2$ | Required for $E_{Th} = 0$ |
| RTD $R(T)$ | $R_T = R_0(1 + \alpha T)$ | Linear approximation (metal) |
| Large ratio approx | $V_{OUT} \approx V_S \alpha T / r$ | Sacrifice sensitivity for linearity |
| Three-point method | Solve 3 equations for $(r, V_S)$ | For thermistor linearization |
| Full bridge + diff amp | $V_{OUT} = 2 V_S G e (R_F/R_0)$ | Complete system design |

---

> ✅ **Key Takeaway**: The Wheatstone bridge is the fundamental interface between resistive sensors and the electrical world. Bridge **balance** ($R_4/R_1 = R_3/R_2$) zeros the output at reference. The **Large Ratio Method** ($r \gg 1$) and **Three-Point Design Method** are the two engineering strategies for linearization. Cascading a **differential amplifier** amplifies the μV–mV bridge output to standard 1–5 V levels — with the **feedback resistor $R_F$** being the sole design parameter.
