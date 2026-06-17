# 035033-Intro to Sensor-Integrated Systems — Lecture 1: Introduction

> **Source**: Lecture 1.pdf (60 pages)
> **Textbook**: *Principles of Measurement Systems* by John P. Bentley, Chapters 1–2
> **Instructor**: Mingyi Liu, Ph.D., Associate Professor, Mechanical Engineering and Robotics, GTIIT
> **Date**: March 2026

---

## 1. Course Overview

### 1.1 Course Policy

- **Target cohort**: Cohorts 21–23 (Cohort 24 deferred to next year)
- **Prerequisite**: Mechatronics
- **Scale**: ~105 students (Cohort 21: 7, Cohort 22: 42, Cohort 23: 56)

### 1.2 New Rules

- **Preview Problems**: Must be completed **before** each lecture
- Each lecture, several students are randomly called to answer
- **Attendance**: 10 points — all lost permanently if absent; 5 points lost for incorrect answers

---

## 2. Why Sensors Matter

### 2.1 Sensors in Nature and Engineering

- **Human body** contains dozens of sensors — essential for life; source of inspiration for artificial sensors
- **Eyes** are the most important sensor for most animals
- Sensors are ubiquitous in vehicles, smartphones, airplanes, satellites, etc.

### 2.2 Definition of Sensor

> ✅ **Definition**: A **transducer** that converts a **physical variable** into a **usable signal**.
>
> More formally: A device that detects a physical, chemical, or biological quantity and converts it into a **measurable signal** (typically electrical) for processing or control.

**Example**: Thermometer converts temperature → reading.

### 2.3 Sensor Making: Calibration

- **Calibration**: Use a **highly accurate reference sensor** to "mark" another sensor
- Example circuit: Photoresistor + 10 kΩ voltage divider → Arduino ADC

### 2.4 Goal of the Course

> Why take a whole semester to learn sensors?

| Feature | Toy-level (e.g., mercury thermometer) | Professional (e.g., handheld thermal camera) |
|---------|--------------------------------------|---------------------------------------------|
| Measurement points | 1 | 70,000 |
| Response time | 5 minutes | 20 ms |
| Contact required? | Yes | No |

The course teaches **professional-grade sensor selection, modeling, and integration**.

### 2.5 Instructor Background

- **Undergraduate**: 测试计量技术及仪器 (Measurement & Instrumentation) — NDT methods (Ultrasonic, Radiographic, Magnetic Particle, Eddy Current, Penetrant Testing)
- **Graduate**: 精密仪器及机械 (Precision Instruments & Machinery) — MEMS IMU vs. Russian military optical gyroscopes

| Sensor Type | Price | Weight | Accuracy |
|-------------|-------|--------|----------|
| MEMS IMU | ~¥20 | ~3 g | ~0.02 °/s |
| Russian Military Gyroscope (Optical) | ~¥300,000 | ~30 kg | ~0.00000027 °/s |

---

## 3. Sensor Family Categories

| Category | Sub-types |
|----------|-----------|
| **Position** | Rotary, Linear, Proximity |
| **Contact/Non-contact** | Hall effect, Capacitive, Eddy Current, Ultrasonic, Laser |
| **Physical** | Pressure, Temperature, Force, Vibration, Strain gauges, Piezo |
| **Environmental** | Humidity, Fluid Property |
| **Optical** | Photo Optic Sensors |
| **Flow** | Flow and Level Switches |

---

## 4. Important Features of Sensors (Static Characteristics)

This is the **core content** of Lecture 1. A sensor's quality is quantified by 10 key parameters.

### 4.1 Accuracy (Trueness)

> **Definition**: Closeness of the measured value to the **true value**.

$$\text{Error} = |\text{Measured Value} - \text{True Value}|$$

**Example**: True temperature = 26.48 °C, Measured = 26 °C → Error = 0.48 °C.

| Level | Example | Spec |
|-------|---------|------|
| SOTA | Ouster OS1 LiDAR | Range repeatability ±1.5 cm (high SNR) |
| Average | ST VL53L0X ToF | ±3% distance accuracy (~6 cm error at 2 m) |

### 4.2 Precision / Repeatability

> **Definition**: Closeness of **repeated readings** under the same input and conditions.

**Example**: Readings 26.4, 26.2, 26.3, 26.3 °C → std = 0.08 °C.

| Level | Example | Spec |
|-------|---------|------|
| SOTA | OIML-class load cell | Non-repeatability < ±0.01% |
| Average | Low-cost load washer | Non-repeatability 0.2% FS |

> ⚠️ **Important**: Accuracy ≠ Precision. A sensor can be precise but inaccurate (systematic bias), or accurate on average but imprecise (large random scatter).

### 4.3 Resolution

> **Definition**: Smallest input change that produces a **detectable** output change.

**Example**: 5 V, 10-bit ADC → $2^{10} = 1024$ levels → Resolution = $\frac{5}{1024} = 0.00488$ V.

$$\text{Resolution \%} = \frac{\Delta I_R}{O_{\max} - O_{\min}} \times 100\%$$

| Level | Example | Spec |
|-------|---------|------|
| SOTA | HX711 | 24-bit ADC for bridge sensors |
| Average | Arduino Uno | 10-bit ADC |

### 4.4 Sensitivity (Gain)

> **Definition**: Output change per unit input change.

$$K = \frac{\Delta O}{\Delta I} = \frac{dO}{dI} \quad \text{(in the limit } \Delta I \to 0\text{)}$$

**Example**: 1 mm/°C for a liquid-in-glass thermometer.

| Level | Example | Spec |
|-------|---------|------|
| SOTA | HX711 front-end | ±20 mV full-scale at gain 128 (5 V) |
| Average | Arduino Uno 10-bit ADC | ~4.9 mV/count at 5 V |

### 4.5 Measurement Range (Span)

> **Definition**: Min-to-max input over which specifications are met.

$$\text{Span} = I_{\max} - I_{\min} = 30\text{°C} - 0\text{°C} = 30\text{°C}$$

| Level | Example | Spec |
|-------|---------|------|
| SOTA | Ouster OS1 | Max range 200 m |
| Average | VL53L0X | Typical max 2 m |

### 4.6 Noise Floor

> **Definition**: Output variation with **constant input** — limits the smallest usable signal.

**Example**: If input is 0 °C, readings of 0.01 °C vs. 0.001 °C reflect noise floor.

| Level | Example | Spec |
|-------|---------|------|
| SOTA | HX711 (10 Hz) | Input noise 50 nV (rms) at gain 128 |
| Average | HX711 (80 Hz) | Input noise 90 nV (rms) at gain 128 |

> 📖 **Note**: Same chip, "fast mode" is noisier — a fundamental trade-off between speed and noise.

### 4.7 Bandwidth / Update Rate (Dynamic Response)

> **Definition**: Frequency range (or max update rate) the sensor can track **to specification**.

**Example**: 1/300 s = 0.003 Hz for a slow-response sensor.

| Level | Example | Spec |
|-------|---------|------|
| SOTA | Piezoelectric 6-axis force/moment sensor | ~18 kHz natural frequency |
| Average | HX711 | 10 SPS or 80 SPS |

### 4.8 Drift / Long-Term Stability

> **Definition**: Output change over time with constant input.

**Example**: 10 °C input for 1 day, measurement becomes 10.001 °C → drift = 0.001 °C/day.

| Level | Example | Spec |
|-------|---------|------|
| SOTA | Honeywell HG4930 gyro | Bias in-run stability 0.25 °/hr (1σ) |
| Average | High-end MEMS IMU | ~3 °/hr gyroscopic bias instability |

### 4.9 Linearity

> **Definition**: Max deviation from a straight-line input→output relation (often % Full Span).

```math
\text{Linearity error %} = \frac{\hat{N}}{O_{\max} - O_{\min}} \times 100\%
```

| Level | Example | Spec |
|-------|---------|------|
| SOTA | OIML-class load cell | Linearity & hysteresis < ±0.020% |
| Average | Common load washer | Nonlinearity ±0.5% FS |

### 4.10 Cross-Sensitivity / Crosstalk (Selectivity)

> **Definition**: Unwanted response to "other" inputs (other axes, temperature, EM fields, etc.).

**Example**: 10 °C input with EMI 3 V/m → measurement 10.001 °C → cross-sensitivity = 0.0003 °C/(V/m).

| Level | Example | Spec |
|-------|---------|------|
| SOTA | 6-axis force/moment sensor | Crosstalk < ±3.5% |
| Average | Cheap single-sensor modules | Often no spec provided — discovered in calibration |

---

## 5. Measurement System Architecture

### 5.1 Purpose

> The purpose of a measurement system is to **link the observer to the process**.

- **Process**: A system generating information (chemical reactor, jet fighter, car, human heart, weather system)
- **Observer**: The person who needs this information

### 5.2 Structure of Measurement Systems

```
Process → [Sensing Element] → [Signal Conditioning] → [Signal Processing] → [Data Presentation] → Observer
```

| Stage | Function | Examples |
|-------|----------|----------|
| **Sensing Element** | Contacts the process; output depends on the measured variable | Thermocouple, strain gauge, photoresistor |
| **Signal Conditioning** | Converts sensor output to a more usable form (usually DC voltage/current or frequency) | Amplifier, bridge circuit, filter |
| **Signal Processing** | Converts conditioned signal for presentation | ADC, microcontroller, DSP |
| **Data Presentation** | Presents measured value to the observer | Pointer-scale, chart recorder, digital display, VDU |

---

## 6. Systematic Characteristics — The Ideal Model

### 6.1 Range and Span

- **Range** (`I`): Specified by minimum and maximum values $I_{\min}$ to $I_{\max}$
- **Span**: Maximum variation — input span = $I_{\max} - I_{\min}$, output span = $O_{\max} - O_{\min}$

### 6.2 Ideal Straight Line

An element is **linear** if corresponding values of $I$ and $O$ lie on a straight line:

$$\boxed{O_{\text{ideal}} = KI + a}$$

where $K$ = slope (sensitivity), $a$ = ideal straight-line intercept (bias).

### 6.3 Non-linearity

The straight-line relationship is not obeyed:

$$\boxed{O(I) = KI + a + N(I)}$$

Quantified as maximum non-linearity $\hat{N}$ as percentage of f.s.d.:

$$\frac{\hat{N}}{O_{\max} - O_{\min}} \times 100\%$$

### 6.4 Hysteresis

For a given value of $I$, the output $O$ may differ depending on whether $I$ is increasing or decreasing:

$$\boxed{H(I) = O(I, I\!\downarrow) - O(I, I\!\uparrow)}$$

Maximum hysteresis $\hat{H}$ as percentage of f.s.d.:

$$\frac{\hat{H}}{O_{\max} - O_{\min}} \times 100\%$$

---

## 7. Environmental Effects

The output $O$ depends not only on the signal input $I$, but also on environmental inputs:

### 7.1 Types of Environmental Inputs

| Symbol | Type | Meaning |
|--------|------|---------|
| $I_M$ | **Modifying input** | Changes the **sensitivity** ($K$) of the element |
| $I_I$ | **Interfering input** | Adds a **bias** to the output |

### 7.2 Generalized Model

$$\boxed{O = KI + a + N(I) + K_M I_M I + K_I I_I}$$

| Term | Meaning |
|------|---------|
| $KI$ | Linear response to signal input |
| $a$ | Bias at reference conditions |
| $N(I)$ | Non-linearity |
| $K_M I_M I$ | Modifying input effect (× signal input) — **scales sensitivity** |
| $K_I I_I$ | Interfering input effect — **adds offset** |

**Working Example** (Resistance thermometer):

$$O = R = [2 \times 10^2 \times I] + [2 \times 10^2 \times T \times I] + [100] + [1 \times 10^{-2} T] \; \Omega$$

where $T$ is temperature. Note how $T$ appears both as a modifying term (× $I$) and an interfering term (standalone).

> ✅ **Intuition**: $K_M I_M I$ means the sensitivity itself changes with environment (e.g., gain drifts with temperature). $K_I I_I$ means a constant offset is added (e.g., zero-shift from supply voltage variation).

---

## 8. Error Bands

When non-linearity, hysteresis, and resolution effects are all very small in modern sensors, manufacturers define performance in terms of **error bands** — a single envelope that bounds all errors combined.

> ✅ **Key**: Error bands give a practical, worst-case total error specification instead of decomposing into individual effects.

---

## 9. Statistical Characteristics

### 9.1 Gaussian Distribution

Sensor outputs exhibit statistical variations (repeatability):

$$\boxed{p(x) = \frac{1}{\sigma\sqrt{2\pi}} e^{-\frac{(x-\bar{x})^2}{2\sigma^2}}}$$

where $\bar{x}$ = mean value, $\sigma$ = standard deviation.

### 9.2 Error Propagation

For the generalized model $O = KI + a + N(I) + K_M I_M I + K_I I_I$:

$$\Delta O = \frac{\partial O}{\partial I}\Delta I + \frac{\partial O}{\partial I_M}\Delta I_M + \frac{\partial O}{\partial I_I}\Delta I_I$$

For three independent normal distributions $y = a_1 x_1 + a_2 x_2 + a_3 x_3$:

$$\boxed{\sigma = \sqrt{a_1^2 \sigma_1^2 + a_2^2 \sigma_2^2 + a_3^2 \sigma_3^2}}$$

Then the output $O$ has mean:

$$\bar{O} = K\bar{I} + a + N(\bar{I}) + K_M \bar{I}_M \bar{I} + K_I \bar{I}_I$$

with standard deviation:

$$\boxed{\sigma_O = \sqrt{\left(\frac{\partial O}{\partial I}\right)^2 \sigma_I^2 + \left(\frac{\partial O}{\partial I_M}\right)^2 \sigma_{I_M}^2 + \left(\frac{\partial O}{\partial I_I}\right)^2 \sigma_{I_I}^2}}$$

---

## 10. Calibration

> **Calibration**: The experimental determination of static characteristics.

For the generalized model $O = KI + a + N(I) + K_M I_M I + K_I I_I$, calibration involves:

- Measure corresponding values of $I$, $O$, $I_M$, $I_I$ while $I$ is constant or changing slowly
- Then obtain the unknown parameters: $K, a, N(I), K_M, K_I$

---

## 11. Textbooks

| Book | Orientation | Audience |
|------|------------|----------|
| *Principles of Measurement Systems* (Bentley) | **Engineering-oriented** | Specific to Mechanical Engineering |
| *Measurement Systems: Application and Design* (Doebelin) | **Science-oriented** | General to all Engineering majors |

---

## 12. Course Plan & Preview Problems

| Lecture | Chapter | Topic |
|---------|---------|-------|
| 1 | Ch. 1–2 | The General Measurement System; Static Characteristics |
| 2 | Ch. 3 | Accuracy in Steady State |
| 3 | Ch. 4 | Dynamic Characteristics |
| 4 | Ch. 5 | Loading Effects and Two-Port Networks |
| 5 | Ch. 6 | Signals and Noise |
| 6 | Ch. 7 | Reliability, Choice and Economics |
| 7 | Ch. 8 | Sensing Elements |
| 8 | Ch. 9 | Signal Conditioning Elements |
| 9 | Ch. 10–11 | Signal Processing; Data Presentation |

---

## 13. Project

- **Task**: Find one sensor → explain it well → use it in a cool application → make a video
- **Example from last year**: Self-assembled digital scale (accuracy < 0.1 g; target: 148 g, reading: 147.9–148.1 g)
- **Example of cool project**: Gyroscope-controlled mouse pointer
- **Structure**: Sensor development groups meeting every Monday evening, each member gives 3-minute professional progress report

---

## 14. Summary Table of Sensor Features

| # | Feature | Definition | Formula/Unit |
|---|---------|------------|--------------|
| 1 | **Accuracy** | Closeness to true value | $\vert\text{Measured} - \text{True}\vert$ |
| 2 | **Precision** | Closeness of repeated readings | Standard deviation $\sigma$ |
| 3 | **Resolution** | Smallest detectable change | $\Delta I_R$, % of span |
| 4 | **Sensitivity** | Output change per input change | $K = dO/dI$ |
| 5 | **Range/Span** | Min-to-max input meeting spec | $I_{\max} - I_{\min}$ |
| 6 | **Noise Floor** | Output variation at constant input | nV(rms), µV(rms) |
| 7 | **Bandwidth** | Frequency range tracking to spec | Hz, SPS |
| 8 | **Drift** | Output change over time | °/hr, unit/day |
| 9 | **Linearity** | Max deviation from straight line | %FS |
| 10 | **Cross-sensitivity** | Unwanted response to other inputs | Crosstalk % |

---

> ✅ **Key Takeaway**: A sensor is more than just "something that measures." Professional sensor work requires understanding the **generalized model** $O = KI + a + N(I) + K_M I_M I + K_I I_I$, quantifying each static characteristic, and performing **calibration** to determine these parameters.
