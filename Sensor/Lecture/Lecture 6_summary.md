# 035033-Intro to Sensor-Integrated Systems — Lecture 6: Sensing Elements

> **Source**: Lecture 6.pdf (32 pages)
> **Textbook**: *Principles of Measurement Systems* by John P. Bentley, Chapter 8
> **Instructor**: Mingyi Liu, Ph.D., Associate Professor, Mechanical Engineering and Robotics, GTIIT
> **Date**: April 2026

---

## 1. Sensing Element — Definition and Role

> **Sensing element**: In contact with the process, gives an output that depends on the variable to be measured.

- **First element** in the measurement system
- **Draws energy** from the process/system being measured
- Converts the measurand into a more usable form

```
Force   → [Sensing Element] → Resistance → Voltage
Position → [Sensing Element] → Resistance → Voltage
Light   → [Sensing Element] → Resistance → Voltage
```

---

## 2. Classification of Sensing Elements

### 2.1 Overall Schematic

| Measurand | → | Sensing Element Types | → | Output |
|-----------|---|----------------------|---|--------|
| Magnetic field, Humidity, Ionic concentration, Gas composition | → | Resistive, Capacitive, Inductive | → | $\Delta R / \Delta C / \Delta L$ |
| Acceleration, Velocity, Displacement/Strain | → | Piezoresistive, Piezoelectric | → | $\Delta R$ / Voltage |
| Flow velocity/rate, Density, Level | → | Turbine, Vortex, Coriolis, Pneumatic | → | Frequency / $\Delta P$ |
| Torque, Force, Pressure | → | Elastic, Piezoelectric | → | $\Delta R$ / Voltage |
| Heat/Light flux, Temperature | → | Thermoelectric, Photovoltaic, Pyroelectric, Photoconductive | → | Voltage / $\Delta R$ |
| Position | → | Hall effect, Electromagnetic, FET | → | Voltage |

### 2.2 Passive vs. Active Devices

| Type | Description | Examples |
|------|-------------|----------|
| **Passive** | Require **external power supply** to give voltage/current output | Resistive, capacitive, inductive elements |
| **Active** | **No external power supply needed** — self-generating | Electromagnetic, thermoelectric, piezoelectric, photovoltaic elements |

### 2.3 Primary vs. Secondary Sensing

| Stage | Function | Example |
|-------|----------|---------|
| **Primary** (mechanical output) | Sense mechanical variables | Elastic cantilever in force measurement |
| **Secondary** (electrical output) | Convert mechanical to electrical | Resistive strain gauge on the cantilever |

**Example 1**: Force → Elastic cantilever deflection → Strain gauge resistance change
**Example 2**: Flow → Turbine angular velocity → Electromagnetic tachogenerator voltage

---

## 3. Resistive Sensing Elements

### 3.1 Fundamental Resistance Relation

$$\boxed{R = \frac{l}{\sigma A} = \frac{\rho l}{A}}$$

where $l$ = length, $A$ = cross-section area, $\sigma$ = conductivity, $\rho = 1/\sigma$ = resistivity.

### 3.2 Potentiometers — Position Sensing

**Rotational potentiometer**:

$$\boxed{E_{TH} = \frac{R}{R_T} V_s = \frac{\frac{\theta r}{\sigma A}}{\frac{\theta_T r}{\sigma A}} V_s = \frac{\theta}{\theta_T} V_s}$$

where $\theta$ is angular position, $\theta_T$ is maximum travel angle.

**Linear potentiometer**:

$$\boxed{E_{TH} = \frac{R_d}{R_T} V_s = \frac{d}{d_T} V_s}$$

where $d$ is linear displacement, $d_T$ is maximum travel.

**Design considerations**:

| Parameter | Guideline |
|-----------|-----------|
| $d_T, \theta_T$ | Determined by sensing range requirement |
| $V_S$ | Determined by output voltage requirement |
| Power rating $W = V_S^2 / R_T$ | To reduce power consumption, $R_T$ should be **large** |
| $R_d$ | Balance between power consumption and load effect |

### 3.3 Metal Resistance Thermometers (RTD)

$$\boxed{R_T = R_0(1 + \alpha T + \beta T^2 + \gamma T^3 + \cdots)}$$

- For small temperature ranges: $\boxed{R_T \approx R_0(1 + \alpha T)}$
- Read $V_{out}$ → measure $R_T$ → determine $T$
- Non-linearity is usually small for platinum (Pt100)

### 3.4 Thermistors (Semiconductor)

$$\boxed{R_T = K e^{\beta/T}}$$

where $K$ and $\beta$ are constants. $T$ is in Kelvin.

> ✅ **Thermistors** have much higher sensitivity than RTDs but are more non-linear.

### 3.5 Thick-film Polymer Sensors

- Resistance changes with temperature
- Low cost, flexible form factor

---

## 4. Resistive Strain Gauges

### 4.1 Stress and Strain

| Quantity | Definition | Formula |
|----------|------------|---------|
| **Stress** | Force per unit area | $\sigma = \pm F/A$ (+ tensile, − compressive) |
| **Strain** | Fractional change in length | $e = \Delta l / l$ (+ tensile, − compressive) |
| **Poisson's ratio** | Ratio of transverse to longitudinal strain | $\displaystyle \nu = -\frac{e_T}{e_L}$ (typically 0.25–0.4) |
| **Young's modulus** | Stress-to-strain ratio | $E = \sigma / e$ |

### 4.2 Gauge Factor

Starting from $R = \rho l / A$:

$$\frac{\Delta R}{R} = \frac{\Delta l}{l} + \frac{\Delta \rho}{\rho} - \frac{\Delta A}{A}$$

For a rectangular cross-section $A = wt$:
$$\frac{\Delta A}{A} = \frac{\Delta t}{t} + \frac{\Delta w}{w} = -\nu e_L - \nu e_L = -2\nu e_L$$

$$\boxed{\frac{\Delta R}{R} = (1 + 2\nu) e_L + \frac{\Delta \rho}{\rho}}$$

**Gauge factor**:

$$\boxed{G = \frac{\Delta R / R}{e} = 1 + 2\nu + \frac{1}{e}\frac{\Delta \rho}{\rho} \approx 2}$$

- $1 + 2\nu \approx 1 + 2(0.3) = 1.6$ (geometric contribution)
- $\frac{1}{e}\frac{\Delta \rho}{\rho} \approx 0.4$ for metals (piezoresistive contribution — small)
- Total $G \approx 2$ for metal strain gauges

### 4.3 Wheatstone Bridge — Full Bridge Configuration

With 4 strain gauges on a cantilever beam (2 in tension, 2 in compression):

$$\boxed{V_{out} = V^+ - V^- = -\frac{\Delta R}{R} V_s}$$

**Derivation**:

$$V_{out} = \frac{R - \Delta R}{R + \Delta R + R - \Delta R} V_s - \frac{R + \Delta R}{R + \Delta R + R - \Delta R} V_s = \frac{R - \Delta R - (R + \Delta R)}{2R} V_s = -\frac{\Delta R}{R} V_s$$

> ✅ **Full bridge** provides: maximum sensitivity, temperature compensation (all 4 gauges drift together), and cancellation of common-mode effects.

---

## 5. Capacitive Sensing Elements

### 5.1 Fundamental Capacitance Relation

$$\boxed{C = \frac{\varepsilon_0 \varepsilon A}{d}}$$

| Symbol | Meaning | Value |
|--------|---------|-------|
| $\varepsilon_0$ | Permittivity of free space | $8.85\text{ pF/m}$ |
| $\varepsilon$ | Relative permittivity (dielectric constant) | Material-dependent |
| $A = x \cdot w$ | Area of plate overlap | m² |
| $d$ | Plate separation | m |

### 5.2 Configurations

**Variable-area** (linear displacement):
$$C = \frac{\varepsilon_0 \varepsilon (A \pm wx)}{d}$$

**Variable-dielectric** (material boundary moves):
$$C = \frac{\varepsilon_0}{d} \left[\varepsilon_1 wx + \varepsilon_2 (A - wx)\right] = \frac{\varepsilon_0 w}{d} \left[\varepsilon_2 l - (\varepsilon_2 - \varepsilon_1)x\right]$$

**Variable-gap** (cylindrical, liquid level sensing):
$$C_h = \frac{2\pi\varepsilon_0\varepsilon h}{\log_e(b/a)} + \frac{2\pi\varepsilon_0(l - h)}{\log_e(b/a)}$$

### 5.3 Practical Challenges

| Challenge | Solution |
|-----------|----------|
| $\varepsilon_{\text{air}} = 1$ → $\Delta C$ very small | Reduce plate thickness $t$ for greater deflection; or use **liquid-filled ceramic membrane** sensors |
| Mechanical strength reduction | Silicon oil ($\varepsilon \gg 1$) fills gap — high dielectric constant gives large $\Delta C$ without weakening |
| Differential pressure sensing | $p_1 - p_2$ causes membrane movement → $C_1$ increases, $C_2$ decreases → differential measurement |

---

## 6. Inductive Sensing Elements

### 6.1 Magnetic Circuit Fundamentals

| Quantity | Symbol | Formula | Unit |
|----------|--------|---------|------|
| Magnetomotive force (m.m.f.) | $\mathcal{F}$ | $\mathcal{F} = Ni$ | Ampere-turns |
| Reluctance | $\mathcal{R}$ | $\mathcal{R} = \frac{l}{\mu A}$ | H⁻¹ |
| Flux | $\Phi$ | $\Phi = \frac{\mathcal{F}}{\mathcal{R}} = \frac{Ni}{\mathcal{R}}$ | Weber |
| **Inductance** | $L$ | $\displaystyle L = \frac{N^2}{\mathcal{R}}$ | Henry |

where $\mu = \mu_0 \mu_r$ is permeability, $l$ is core length, $A$ is cross-section area.

### 6.2 Variable-Reluctance Displacement Sensor

Total reluctance: $\mathcal{R}_{tot} = \mathcal{R}_{core} + \mathcal{R}_{gap} + \mathcal{R}_{armature}$

$$\boxed{\mathcal{R}_{tot} = \frac{R}{\mu_0 \mu_C r^2} + \frac{2d}{\mu_0 \pi r^2} + \frac{R}{\mu_0 \mu_A rt} = \mathcal{R}_0 + kd}$$

where $\mathcal{R}_0 = \frac{R}{\mu_0 r}\left(\frac{1}{\mu_C r} + \frac{1}{\mu_A t}\right)$, $k = \frac{2}{\mu_0 \pi r^2}$

$$\Phi = f(\mathcal{R}) = f(d) \quad \Rightarrow \quad \text{Inductive displacement sensor}$$

### 6.3 Bridge Circuit for Linearity

$$L = \frac{N^2}{\mathcal{R}_0 + kd} = \frac{L_0}{1 + \alpha d}, \quad \alpha = \frac{k}{\mathcal{R}_0}$$

For a differential pair: $L_1 = \frac{L_0}{1 + \alpha(a - x)}$, $L_2 = \frac{L_0}{1 + \alpha(a + x)}$

**Bridge output**:

$$\boxed{E_{TH} = V_S\left(\frac{L_1}{L_1 + L_2} - \frac{1}{2}\right) = V_S \frac{\alpha}{2(1 + \alpha a)} x}$$

> ✅ The bridge configuration yields a **linear relationship** between $E_{TH}$ and displacement $x$.

### 6.4 Linear Variable Differential Transformer (LVDT)

$$\boxed{V_{out} = V_1 - V_2 = f(x)}$$

- **Null point**: When the core is centered, $V_1 = V_2$, $V_{out} = 0$
- Amplitude of $V_{out}$ → **magnitude** of displacement
- Phase of $V_{out}$ → **direction** of displacement
- After phase-sensitive demodulation, D.C. output gives both magnitude and direction

> ✅ **LVDT advantages**: Non-contact, infinite resolution, high linearity, robust.

---

## 7. Electromagnetic Sensing Elements

$$\Phi(t) = a + b\sin(m\omega t)$$

$$\boxed{EMF = -N\frac{d\Phi}{dt} = -N m\omega b \cos(m\omega t)}$$

> ✅ **Faraday's Law**: The induced voltage is proportional to the **rate of change** of magnetic flux. The output amplitude is proportional to the velocity $m\omega$.

---

## 8. Thermoelectric Sensing Elements (Thermocouples)

### 8.1 Seebeck Effect

$$\boxed{E_{T}^{AB} = a_1 T + a_2 T^2 + a_3 T^3 + \cdots}$$

For a temperature **difference** between two junctions:

$$\boxed{E_{T_1, T_2}^{AB} = a_1(T_1 - T_2) + a_2(T_1^2 - T_2^2) + a_3(T_1^3 - T_2^3) + \cdots}$$

> ✅ **Key**: A thermocouple measures temperature **difference** between the measuring junction ($T_1$) and the reference junction ($T_2$). The reference junction must be held at a known temperature (e.g., ice bath at 0 °C) for absolute temperature measurement.

---

## 9. Elastic Sensing Elements

### 9.1 Principle — Accelerometer

An elastic element (spring-mass-damper) converts acceleration to displacement:

$$m\ddot{x} + \lambda\dot{x} + kx = ma$$

Transfer function:

$$\boxed{\frac{x}{a}(s) = \frac{1}{\omega_n^2} \cdot \frac{1}{\frac{1}{\omega_n^2}s^2 + \frac{2\zeta}{\omega_n}s + 1}}$$

With small damping and $\omega_n \gg \omega$ (excitation frequency):

$$\boxed{\frac{x}{a} \approx \frac{1}{\omega_n^2} \cdot \frac{1}{1 - \frac{\omega^2}{\omega_n^2}}}$$

For $\omega_n \gg \omega$:

$$\boxed{a = \omega_n^2 x = \frac{k}{m} x}$$

> ✅ **Physical meaning**: We can obtain acceleration from the **deflection amplitude** $x$. The natural frequency must be set **much larger** than the excitation frequency for this relationship to be accurate.

### 9.2 Key Design Guideline

$$\boxed{\omega_n \gg \omega_{\text{excitation}}}$$

- If $\omega \ll \omega_n$: $a \approx \omega_n^2 x = (k/m)x$ — **linear relationship**
- If $\omega \approx \omega_n$: resonance — reading is unreliable
- This is exactly why accelerometers have high stiffness and small mass (high $\omega_n$)

---

## 10. Hall Effect Sensing Element

A rectangular slab with current $I$ (along $x$) and magnetic field $B$ (along $z$):

$$\boxed{E = -\frac{JB}{ne} = -R_H J B}$$

| Symbol | Meaning |
|--------|---------|
| $J$ | Current density ($J_x$, in x-direction) |
| $B$ | Magnetic flux density ($B_z$, in z-direction) |
| $n$ | Charge carrier density |
| $e$ | Electron charge |
| $R_H = 1/(ne)$ | **Hall coefficient** |

> ✅ The Hall voltage $V_H$ is proportional to $B$ — used for **magnetic field sensing**, **current sensing**, and **contactless position sensing**.

**Metal vs. Semiconductor**:
- Metals: electrons only (n-type)
- Semiconductors: both electrons (n) and holes (p) — can have much larger Hall coefficient

---

## 11. Final Project — Load Cell (Scale)

| Step | Task |
|------|------|
| 1 | Make a load sensor (scale) **from scratch** |
| 2 | Conceive, debug, and make it work |
| 3 | Compare with standard weights, perform error analysis |
| 4 | Answer 6 questions — each covers one lecture topic |

> ✅ **Key**: The project integrates all six lectures: static characteristics, accuracy, dynamics, noise/loading, reliability, and sensing element design.

---

## 12. Summary Table — Sensing Element Types

| Type | Physical Principle | Measurand | Output | Active/Passive |
|------|-------------------|-----------|--------|---------------|
| **Potentiometer** | $R = \rho l/A$ | Displacement (linear/rotary) | Voltage (via divider) | Passive |
| **RTD** | $R_T = R_0(1 + \alpha T)$ | Temperature | $\Delta R$ | Passive |
| **Thermistor** | $R_T = K e^{\beta/T}$ | Temperature | $\Delta R$ (large) | Passive |
| **Strain Gauge** | $\Delta R/R = G \cdot e$ | Strain/Force | $\Delta R$ (via bridge) | Passive |
| **Capacitive** | $C = \varepsilon_0\varepsilon A/d$ | Displacement, Level, Pressure | $\Delta C$ | Passive |
| **Inductive** | $L = N^2/\mathcal{R}$ | Displacement | $\Delta L$ or $V_{out}$ (bridge/LVDT) | Passive |
| **Electromagnetic** | $EMF = -N d\Phi/dt$ | Velocity, Flow | Voltage | **Active** |
| **Thermocouple** | $E = f(T_1 - T_2)$ | Temperature | Voltage | **Active** |
| **Piezoelectric** | Charge under stress | Force, Acceleration | Voltage | **Active** |
| **Hall Effect** | $E = -JB/(ne)$ | Magnetic field, Current | Voltage | Passive |
| **Elastic** | $a = \omega_n^2 x$ | Acceleration | Displacement → electrical | Passive (with secondary) |

---

## 13. Key Equations Reference

| Equation | Application |
|----------|-------------|
| $\displaystyle R = \frac{\rho l}{A}$ | Basic resistance |
| $\displaystyle G = \frac{\Delta R/R}{e} = 1 + 2\nu + \frac{1}{e}\frac{\Delta\rho}{\rho}$ | Strain gauge factor |
| $\displaystyle V_{out} = -\frac{\Delta R}{R}V_s$ | Full Wheatstone bridge |
| $\displaystyle C = \frac{\varepsilon_0\varepsilon A}{d}$ | Capacitance |
| $\displaystyle L = \frac{N^2}{\mathcal{R}}, \quad \mathcal{R} = \frac{l}{\mu A}$ | Inductance and reluctance |
| $\displaystyle E_{TH} = V_S \frac{\alpha}{2(1 + \alpha a)}x$ | Linearized inductive bridge |
| $\displaystyle EMF = -N\frac{d\Phi}{dt}$ | Faraday's Law |
| $\displaystyle a = \omega_n^2 x = \frac{k}{m}x$ | Accelerometer principle |

---

> ✅ **Key Takeaway**: Sensing elements are the **front-end** of any measurement system — they directly interface with the process and convert the physical quantity of interest into an electrical signal. The choice of sensing element involves understanding: (1) whether it's **passive** (needs excitation) or **active** (self-generating); (2) its **sensitivity and linearity**; (3) **bridge circuit** configurations to convert small $\Delta R/\Delta C/\Delta L$ into measurable voltage; and (4) **environmental compensation** (temperature, loading effects). For the final project, all these principles come together in building a working load cell.
