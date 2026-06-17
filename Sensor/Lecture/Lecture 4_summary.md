# 035033-Intro to Sensor-Integrated Systems — Lecture 4: Signals and Noise in Measurement Systems

> **Source**: Lecture 4.pdf (44 pages)
> **Textbook**: *Principles of Measurement Systems* by John P. Bentley, Chapters 5–6
> **Instructor**: Mingyi Liu, Ph.D., Associate Professor, Mechanical Engineering and Robotics, GTIIT
> **Date**: March 2026

---

## 1. Review: Dynamic Characteristics

### 1.1 Time Constant — The Core Metric

| $\tau$ Value | Sensor Behavior | Verdict |
|-------------|----------------|---------|
| **Small** (e.g., 2 h) | Fast settling | ✅ Better — tracks rapid changes |
| **Large** (e.g., 82 h) | Very slow | ❌ Worse — misses transients |

### 1.2 Bandwidth from Time Constant

**Example**: Photo-resistor circuit with:
- Rising $\tau = 5\text{ ms}$
- Falling $\tau = 70\text{ ms}$

$$f_{\text{max}} \approx \frac{1}{2\tau_{\text{max}}} \approx 7\text{ Hz}$$

> ✅ **Rule of thumb**: Good enough is enough. 5 Hz, 50 Hz, and 500 Hz each have different application domains.

### 1.3 Biological vs. Engineered Time Constants

| System | Response Time | Comment |
|--------|-------------|---------|
| **Human eye** | ~10 ms | Designed for everyday motion |
| **Camera shutter** | ~0.2 ms (1/5000 s) | Much faster — sports/drones/impacts |
| **Everyday photography** | 1/60 – 1/200 s | General purpose |
| **Fast dynamics** | 1/1000 – 1/5000 s | Sports, drones, impact testing |

> ✅ Cameras are **~50× faster** than human eyes in response time.

### 1.4 Second-Order System — Recap

With $\zeta = 0.3$, $\omega_n$ and initial/final conditions:

$$x(t) = x_F - (x_F - x_{INIT}) e^{-\omega_n\zeta t} \sin\left(\sqrt{1-\zeta^2}\,\omega_n t + \text{atan}\frac{\sqrt{1-\zeta^2}}{\zeta}\right)$$

**Example**: $x_{INIT} = 0.01\text{ m}$, $x_F = 0.015\text{ m}$:

$$x = 0.015 - 0.05 e^{-6t} \sin(18t + 72°)$$

> ⚠️ **Question**: Can you do 100 measurements within 1 second? This requires the system settling time to be much less than 10 ms per measurement.

---

## 2. Loading Effects

### 2.1 The Fundamental Problem

| Model | Assumption | Result |
|-------|-----------|--------|
| **Ideal** | $R_{TH} = 0\ \Omega$, $R_L = \infty\ \Omega$ | $V_M = V$ (perfect) |
| **Real** | $R_{TH} = 1\ \Omega$, $R_L = 1\text{ M}\Omega$ | $V_M = \frac{R_L}{R_{TH} + R_L}V = 0.999999V$ |

### 2.2 Quantifying Loading Error

$$\boxed{V_M = \frac{R_L}{R_{TH} + R_L} V}$$

**Example**: $R_L = 2\text{ M}\Omega$, $R_{TH} = 20\ \Omega$:

$$V_M = \frac{2{,}000{,}000}{2{,}000{,}000 + 20} \times 40T = 0.99999 \times 40T$$

$$\text{Error} = 1 - 0.99999 = 0.001\%$$

> ⚠️ **When to worry**: If precision requirement ≥ 0.001%, loading effects **must** be considered. At lower precision, they are negligible.

> ✅ **Key**: Any real measurement instrument has finite input impedance $R_L$ and non-zero source resistance $R_{TH}$. The voltage divider effect is always present — the question is whether it matters for your accuracy requirements.

---

## 3. Noise in Measurement Systems

### 3.1 Core Principle

> Noise is **unavoidable** in measurement. The goal is to **manage** it, not eliminate it entirely.

$$\text{Signal}(t) = \text{True Value} + \text{Noise}(t)$$

### 3.2 Sources of Noise

| Source | Mechanism |
|--------|-----------|
| **Random electron motion** | Thermal noise (Johnson-Nyquist) in all conductors |
| **A.C. power circuits** | 240 V, 50 Hz mains interference |
| **Switching transients** | Large current changes ($di/dt$) on power lines |
| **Corona discharge** | High-voltage power lines ionizing air |
| **Fluorescent lighting** | Arcing produces broadband EMI |
| **RF transmitters** | Radio-frequency interference |
| **Welding equipment** | Electric arc furnaces — extreme broadband noise |

### 3.3 Coupling Mechanisms

| Mechanism | Physical Principle | Key Equation |
|-----------|-------------------|--------------|
| **Inductive / Electromagnetic** | Surrounding magnetic field induces voltage | $V = L \frac{di}{dt}$ |
| **Capacitive / Electrostatic** | Electric field coupling between conductors | $I = C \frac{dV}{dt}$ |

### 3.4 Multiple Earth (Ground Loops)

Ideally: $Z_{SE} = 0$, $Z_{RE} = 0$, $Z_E = 0$, $V_E = 0$ → no interference.

In reality: none are zero → **ground potential differences** become an interfering voltage source.

> ⚠️ **Ground loop**: When two points in a circuit that should be at the same potential actually have a voltage difference, current flows, creating interference.

---

## 4. Random Signal Description

### 4.1 Key Statistics

Given $N$ samples $y_i$ with sampling period $\Delta T = 1/f$:

| Statistic | Formula | Meaning |
|-----------|---------|---------|
| **Mean** | $\displaystyle \bar{y} = \frac{1}{N}\sum_{i=1}^{N} y_i$ | DC offset / average value |
| **Standard Deviation** | $\displaystyle \sigma = \sqrt{\frac{1}{N}\sum_{i=1}^{N}(y_i - \bar{y})^2}$ | Spread / AC RMS about mean |
| **RMS** | $\displaystyle y_{\text{rms}} = \sqrt{\frac{1}{N}\sum_{i=1}^{N} y_i^2}$ | Total power (DC + AC) |

> ✅ **Relationship**: $y_{\text{rms}}^2 = \bar{y}^2 + \sigma^2$ (total power = DC power + AC power)

### 4.2 Probability Density Function (PDF)

When the signal range is divided into sections of width $\Delta y$:

$$P_j = \frac{\text{number of samples in } j^{\text{th}} \text{ section}}{\text{total number of samples}} = \frac{n_j}{N}$$

**Cumulative probability**: $C_j = P_1 + P_2 + \cdots + P_j$, with $C_N = 1$

As $\Delta y \to 0$:
- $P_j \to p(y)$ — the **probability density function**
- $C_j \to P(y)$ — the **cumulative distribution function**

---

## 5. Noise Reduction Methods

### 5.1 Physical Methods

| Method | Application |
|--------|------------|
| **High-altitude plateau** | Thin air reduces atmospheric scattering for optical sensors |
| **Dark environment** | No ambient light for photodetectors |
| **Temperature control** | Reduces thermal noise |

> ✅ **Principle**: Do as much as possible in the physical domain **before** the signal reaches the electronics.

### 5.2 Electromagnetic Shielding

- **Shielding effect**: Conductive enclosure blocks external electric fields (Faraday cage principle)
- **Shielding web/braid**: Flexible shielding for cables

### 5.3 Twisted Pair Cables

- Alternating twists cancel induced magnetic fields
- Common-mode interference is induced equally in both conductors → rejected by differential receiver

### 5.4 Differential Amplifier — Common-Mode Rejection

$$\boxed{V_{OUT} = \frac{R_F}{R_1}(V_2 - V_1) = \frac{R_F}{R_1}E_{Th}}$$

**Derivation** (assuming ideal op-amp):

1. $V^+ = \frac{R_F}{R_1 + R_F} V_2$ (voltage divider at non-inverting input)
2. **Virtual short**: $V^- = V^+ = \frac{R_F}{R_1 + R_F} V_2$
3. **Virtual open**: $I_{+-} = 0$ (no current flows into op-amp inputs)
4. **KCL at inverting node**: $\frac{V_1 - V^-}{R_1} = \frac{V^- - V_{OUT}}{R_F}$
5. Solving: $V_{OUT} = \frac{R_F}{R_1}(V_2 - V_1)$

> ✅ **Key insight**: Any noise that appears equally on both inputs (common-mode) is **cancelled**. Only the **difference** (differential mode) is amplified. This is the fundamental principle behind **instrumentation amplifiers**.

---

## 6. Fourier Analysis

### 6.1 Fourier Series of a Square Wave

$$s(t) = \sum_{n=1,3,5,\ldots}^{\infty} \frac{4}{n\pi} \sin(n\omega t)$$

| Harmonics included | Approximation |
|-------------------|---------------|
| 1st only: $\frac{4}{\pi}\sin(\omega t)$ | Sine wave (fundamental) |
| 1st + 3rd: $\frac{4}{\pi}\sin(\omega t) + \frac{4}{3\pi}\sin(3\omega t)$ | Starts to look square |
| 1st + 3rd + 5th | Better corners |
| 1st + 3rd + 5th + 7th | Good square wave approximation |

> ✅ **Key**: Sharp transitions (edges) require **high-frequency harmonics**. The amplitude drops as $A = \frac{4}{n\pi}$.

### 6.2 Power Spectral Density (PSD)

For a random signal represented by Fourier series:

$$y(t) = a_0 + \sum_{i=1}^{N} \left[a_n \cos\left(\frac{n}{N}\omega_1 t\right) + b_n \sin\left(\frac{n}{N}\omega_1 t\right)\right]$$

- Power in $n^{\text{th}}$ harmonic (if $R = 1\ \Omega$): $w_n = \frac{1}{2}(a_n^2 + b_n^2)$
- Cumulative power: $W_n = w_1 + w_2 + \cdots + w_n$
- **Power Spectral Density**: $\boxed{\phi(\omega) = \frac{dW(\omega)}{d\omega}}$

> 📖 **PSD** tells you how much noise power exists per unit bandwidth at each frequency — essential for designing filters.

---

## 7. Filtering

### 7.1 First-Order Low-Pass Filter (RC Circuit)

$$\boxed{RC \dot{v}(t) + v(t) = v_{in} = Y\cos(\omega t)}$$

**Steady-state sinusoidal response**:

$$\boxed{v(t) = \frac{Y}{\sqrt{1 + R^2 C^2 \omega^2}} \cos\left(\omega t - \arcsin\frac{RC\omega}{\sqrt{1 + R^2 C^2\omega^2}}\right)}$$

**Gain (magnitude ratio)**:

$$\boxed{|G(j\omega)| = \frac{|V_{out}|}{|V_{in}|} = \frac{1}{\sqrt{1 + R^2 C^2 \omega^2}} = \frac{1}{\sqrt{1 + \tau^2 \omega^2}}}$$

| Frequency | Gain | Behavior |
|-----------|------|----------|
| $\omega \ll 1/\tau$ | $|G| \approx 1$ (0 dB) | Signal passes |
| $\omega = 1/\tau$ (cutoff) | $|G| = 1/\sqrt{2} \approx 0.707$ (−3 dB) | Half-power point |
| $\omega \gg 1/\tau$ | $|G| \approx 1/(\tau\omega)$ | −20 dB/decade roll-off |

### 7.2 Higher-Order Filters

| Order | Gain (Low-Pass) | Roll-off Rate |
|-------|-----------------|---------------|
| **1st** | $\displaystyle \frac{1}{\sqrt{1 + (\tau\omega)^2}}$ | −20 dB/decade |
| **2nd** | $\displaystyle \frac{1}{\sqrt{1 + \cdots + \omega^4}}$ | −40 dB/decade |
| **4th** | $\displaystyle \frac{1}{\sqrt{1 + \cdots + \omega^8}}$ | −80 dB/decade |

> ✅ Higher-order filters provide **sharper cutoff** between pass-band and stop-band.

### 7.3 Filter Types

| Type | Characteristic | Best For |
|------|---------------|----------|
| **Butterworth** | Maximally flat passband | No ripple in signal of interest |
| **Chebyshev** | Sharper roll-off, passband ripple | When sharp cutoff matters more than flatness |
| **Bessel** | Linear phase response | Preserving waveform shape |
| **Elliptic** | Sharpest roll-off, ripple in both bands | Aggressive noise rejection |

### 7.4 Simple Moving Average (SMA)

$$\boxed{y_{\text{SMA}}[n] = \frac{1}{k} \sum_{i=0}^{k-1} y[n-i]}$$

- Simplest **digital low-pass filter**
- Unweighted mean of previous $k$ data points
- Trade-off: larger $k$ → smoother output but slower response

---

## 8. Python Implementation — ECG Filtering Example

```python
import numpy as np
import scipy.io.wavfile
import scipy.signal
import matplotlib.pyplot as plt

# Load ECG data from WAV file
sample_rate, temp = scipy.io.wavfile.read('ecg.wav')
data = temp - np.mean(temp)           # Remove DC offset
t = np.arange(len(data)) / sample_rate

# Design 5th-order Butterworth low-pass filter (50 Hz cutoff)
cutoff = 50; poles = 5
Filter = scipy.signal.butter(poles, cutoff, 'lowpass',
                              fs=sample_rate, output='sos')
filtered = scipy.signal.sosfiltfilt(Filter, data)

# Plot: original vs. filtered signal, frequency spectrum
```

> 📖 **Key**: `sosfiltfilt` applies the filter **forward and backward**, achieving **zero phase distortion**. This is essential for preserving the timing of features like ECG peaks.

---

## 9. Practical Take-Home Messages

### 9.1 Signal and Noise Have Different Spectral Characteristics

```
  Time Domain                          Frequency Domain
  ============                         ================
  Signal: slow variation (0 Hz)   →   Low frequency
  Noise:  fast variation (100 Hz) →   High frequency
  ----------------------------------------------------
  OUTCOME: Filter removes noise while retaining signal
```

### 9.2 Noise Power Calculation

$$\text{Noise Power} = \text{PSD} \times \text{Bandwidth}$$

**Example**: 100 pW/√Hz × 1 MHz bandwidth = 100 mW of noise power.

---

## 10. Summary Table

| Concept | Key Idea | Formula / Method |
|---------|----------|-----------------|
| **Loading effect** | Finite $R_L$ creates voltage divider with $R_{TH}$ | $V_M = \frac{R_L}{R_{TH} + R_L}V$ |
| **Differential amplifier** | Cancels common-mode noise | $V_{OUT} = \frac{R_F}{R_1}(V_2 - V_1)$ |
| **Fourier series** | Any periodic signal = sum of sines | $s(t) = \sum \frac{4}{n\pi}\sin(n\omega t)$ |
| **PSD** | Noise power per unit bandwidth | $\phi(\omega) = dW/d\omega$ |
| **RC low-pass filter** | Attenuates frequencies above $f_c$ | $|G| = 1/\sqrt{1 + (\omega RC)^2}$ |
| **Cutoff frequency** | −3 dB point | $f_c = 1/(2\pi RC) = 1/(2\pi\tau)$ |
| **SMA filter** | Digital low-pass | $y_{\text{SMA}}[n] = \frac{1}{k}\sum y[n-i]$ |
| **Shielding** | Blocks electric fields | Faraday cage / conductive enclosure |
| **Twisted pair** | Cancels magnetic induction | Equal coupling → common-mode → rejected |

---

> ✅ **Key Takeaway**: Noise is **inevitable** but manageable. The fundamental insight is that **signal and noise occupy different frequency regions** — filtering exploits this difference. In the physical domain, use shielding, twisted pairs, and differential amplifiers. In the signal processing domain, use analog filters (RC, active) and digital filters (SMA, Butterworth, Chebyshev). The loading effect reminds us that **every measurement disturbs the system** — the question is whether the disturbance is acceptable for your accuracy requirements.
