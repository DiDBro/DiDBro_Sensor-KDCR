# Tutorial 4 — Loading Effects, Random Signals, Noise & Frequency Domain

> **Source**: Tutorial 4 with Solutions.pdf
> **Instructor**: Qilong Zhong, MSc, GTIIT
> **Corresponds to**: Lecture 4 (Chapters 5–6 of Bentley)

---

## 1. Electrical Loading Effects

### 1.1 Core Concept

| State | Description |
|-------|-------------|
| **Ideal** | Sensor transmits signal to next stage without any loss |
| **Actual** | Next-stage instrument draws current → causes voltage drop → **loading effect** |

> ⚠️ Loading effect is a **major cause of systematic error** in measurement systems.

### 1.2 Thévenin Equivalent Circuit

Simplify complex sensor internals into: **Ideal Voltage Source ($E_{Th}$) + Series Internal Impedance ($Z_{Th}$)**.

$$\boxed{V_L = E_{Th} \cdot \frac{Z_L}{Z_{Th} + Z_L}}$$

| Symbol | Meaning |
|--------|---------|
| $V_L$ | Actual measured load voltage |
| $E_{Th}$ | Open-circuit voltage (the true signal) |
| $Z_L$ | Input impedance of load (measuring instrument) |
| $Z_{Th}$ | Equivalent internal impedance of sensor |

> ✅ **Golden rule**: To make $V_L \approx E_{Th}$, ensure $\boxed{Z_L \gg Z_{Th}}$.

---

## 2. Potentiometer Loading Effects

### 2.1 Review of Potentiometric Sensor

Uses sliding contact to change resistance → displacement → voltage.

### 2.2 With Load (Relative displacement $x = d/d_T$)

| Quantity | Formula |
|----------|---------|
| **Open-circuit voltage** | $E_{Th} = V_S x$ |
| **Equivalent internal resistance** | $R_{Th} = R_P \, x(1-x)$ |
| **Actual load voltage** | $\displaystyle V_L = V_S x \cdot \frac{1}{\frac{R_P}{R_L}x(1-x) + 1}$ |

### 2.3 Two Design Constraints

| Constraint | Formula | Design Rule |
|-----------|---------|-------------|
| **Non-linear error** | $\hat{N} \approx 15\frac{R_P}{R_L}\%$ | $R_P$ should be as **small** as possible |
| **Maximum power rating** | $\dfrac{V_S^2}{R_P} \leq \hat{W}$ | $V_S$ limited by $R_P$ and power rating $\hat{W}$ |

> ⚠️ **Trade-off**: Small $R_P$ → better linearity but higher power consumption; Large $V_S$ → higher sensitivity but may exceed power rating.

---

## 3. Random Signals — Statistical Characteristics

### 3.1 Deterministic vs. Random

| Type | Description | Example |
|------|-------------|---------|
| **Deterministic** | Future values accurately predictable | Sine waves, step signals |
| **Random** | Impossible to write a definitive time function | Industrial temperature fluctuations, EM noise |

> ✅ **Strategy**: Give up on predicting exact values. Instead, study **statistical patterns**.

### 3.2 Core Statistics

| Statistic | Formula | Meaning |
|-----------|---------|---------|
| **Mean** $\bar{y}$ | $\frac{1}{N}\sum y_i$ | DC offset |
| **Standard deviation** $\sigma$ | $\sqrt{\frac{1}{N}\sum(y_i - \bar{y})^2}$ | Fluctuation from mean |
| **RMS** $y_{rms}$ | $\sqrt{\frac{1}{N}\sum y_i^2}$ | Signal energy |

> ✅ **Special case**: When mean = 0, $\boxed{\sigma = y_{rms}}$.

### 3.3 Power-Energy Relationship (1 Ω reference)

$$\boxed{W_{TOT} = y_{rms}^2 = \bar{y}^2 + \sigma^2}$$

> Total Power = DC Power + AC Power

---

## 4. Autocorrelation Function (ACF)

### 4.1 Concept

> **Physical meaning**: Measures the degree of "similarity" between a signal at the current moment and itself after a time delay $\beta$.

**Function**: Acts like a "sieve" — filters out random chaotic noise to **highlight periodic patterns** hidden within the signal.

### 4.2 Discrete ACF Formula

$$\boxed{R_{yy}(m\Delta T) = \frac{1}{N}\sum_{i=1}^{N} y_i \, y_{i-m}}$$

| Symbol | Meaning |
|--------|---------|
| $N$ | Total number of sampling points |
| $m$ | Number of delay steps ($m\Delta T$ = total delay time $\beta$) |
| $y_i, y_{i-m}$ | Sampled values at current moment and $m$ moments prior |

### 4.3 Calculation Steps

1. Create a duplicate copy of the original signal
2. Shift the duplicate by $m$ units
3. Multiply aligned values term-by-term
4. Calculate the average of these products

---

## 5. Noise Characteristics & SNR

### 5.1 Internal Noise

> **Source**: Random thermal motion of electrons in resistors and semiconductors (Johnson-Nyquist / Thermal Noise).

**Characteristics**: **White Noise** — energy distributed uniformly across an extremely wide frequency range.

### 5.2 Quantifying White Noise

| Quantity | Formula | Unit |
|----------|---------|------|
| **PSD** $\phi$ | Power per unit frequency | W/Hz |
| **Total noise power** | $\boxed{W_N = \phi \times f_C}$ | W |
| **Noise RMS voltage** | $\boxed{V_{N,rms} = \sqrt{W_N}}$ | V |

where $f_C$ is the system bandwidth (cutoff frequency).

> ✅ Since thermal noise mean = 0, $V_{N,rms} = \sigma_N$.

### 5.3 Signal-to-Noise Ratio (SNR)

$$\boxed{SNR_{dB} = 10\log_{10}\frac{W_S}{W_N} = 20\log_{10}\frac{V_S}{V_N}}$$

| SNR | Meaning |
|-----|---------|
| > 0 dB | Signal stronger than noise |
| = 0 dB | Signal equals noise |
| < 0 dB | Noise **exceeds** signal → signal is **submerged/lost** |

---

## 6. Interference & Coupling Mechanisms

### 6.1 Sources

| Source | Description |
|--------|-------------|
| **50/60 Hz mains** | Most common "hum" / "mains pick-up" |
| **Motor switching** | Transient pulses |
| **RF transmitters** | Radio frequency interference |

### 6.2 Coupling Mechanisms

| Mechanism | Physical Process |
|-----------|-----------------|
| **Inductive** | Changing magnetic field ($di/dt$) cuts across measurement loop → induces interference voltage |
| **Capacitive** | Stray capacitance between HV cables and signal lines → AC voltage leaks into measurement circuit |
| **Ground loops** | If sensor and receiver grounded at different points → potential difference $V_E$ → interference current $i_E$ |

### 6.3 Two Forms of Interference Damage

| Type | Description | Severity |
|------|-------------|----------|
| **Series mode (Normal mode, $V_{SM}$)** | Interference superimposed in series with useful signal | **Most critical** — directly causes measurement error |
| **Common mode ($V_{CM}$)** | Both signal lines rise simultaneously relative to ground | Indirect — but can convert to series mode |

---

## 7. Noise and Interference Suppression

### 7.1 Cutting Off Entry Paths

| Against | Method | Principle |
|---------|--------|-----------|
| **Inductive coupling** | **Twisted pairs** | Induced EMF in adjacent loops has opposite polarity → cancellation |
| **Capacitive coupling** | **Electrostatic shielding** | Metal enclosure acts as Faraday cage |
| **Ground loops** | **Single-point grounding** | Shield grounded at only one end → no ground loop current $i_E$ |
| **Common-mode** | **Differential amplifier** | Amplifies only difference, rejects common-mode |

$$\boxed{V_{CM\_error} = \frac{V_{CM}}{CMRR}}$$

> ✅ Higher CMRR (Common-Mode Rejection Ratio) → less common-mode error.

### 7.2 Signal Processing Methods

| Method | Application | Formula |
|--------|-------------|---------|
| **Band-pass filtering** | Remove noise outside signal bandwidth | — |
| **Signal averaging** | Periodically repeating signals | $\boxed{\sigma_{AV} = \dfrac{\sigma}{\sqrt{p}}}$ |

where $p$ = number of averages.

> ✅ **Averaging principle**: Positive and negative random noise fluctuations cancel over multiple averages; consistent signal is preserved. SNR improves by $\sqrt{p}$.

---

## 8. Time Domain vs. Frequency Domain

### 8.1 The Analogy

| Domain | Like a... |
|--------|-----------|
| **Time domain** | Cooked dish — you taste the overall flavor (aggregate waveform) |
| **Frequency domain** | Recipe and ingredient list — tells you 10 g salt (LF signal), 0.5 g pepper (HF noise), random impurities (white noise) |

### 8.2 Discrete Fourier Transform (DFT)

$$\boxed{X[k] = \sum_{n=0}^{N-1} x[n] \, e^{-j\frac{2\pi}{N}kn}}$$

### 8.3 Fast Fourier Transform (FFT)

- An extremely efficient algorithm for computing the DFT
- In Python/MATLAB: `fft(y)` transforms thousands of time-domain points into a spectrum instantly

### 8.4 How to Read an FFT Spectrum

| Feature | Meaning |
|---------|---------|
| **Spikes (peaks)** | Strong periodic signal at that specific frequency |
| **Noise floor** | Gaussian white noise — appears as "fuzzy grass" spread across the spectrum |

---

## 9. Nyquist-Shannon Sampling Theorem

$$\boxed{f_s > 2f_{max}}$$

> To perfectly reconstruct the original signal without distortion, the sampling frequency must be **strictly greater than twice** the highest frequency component in the signal.

### Aliasing

If $f_s < 2f_{max}$ → high-frequency signals **disguise themselves** as low-frequency signals in the spectrum.

**Analogy**: A fast-rotating car wheel appearing to spin backward — visual aliasing from the eye's insufficient sampling rate.

---

## 10. Summary Table

| Concept | Key Formula / Method |
|---------|---------------------|
| Loading effect | $V_L = E_{Th} \cdot Z_L/(Z_{Th} + Z_L)$; require $Z_L \gg Z_{Th}$ |
| Potentiometer non-linearity | $\hat{N} \approx 15 \frac{R_P}{R_L}\%$ |
| Total signal power | $W_{TOT} = y_{rms}^2 = \bar{y}^2 + \sigma^2$ |
| Autocorrelation | $R_{yy}(m\Delta T) = \frac{1}{N}\sum y_i y_{i-m}$ |
| Noise power | $W_N = \phi \times f_C$ |
| SNR | $SNR_{dB} = 10\log_{10}(W_S/W_N)$ |
| Common-mode rejection | $V_{CM\_error} = V_{CM}/CMRR$ |
| Averaging noise reduction | $\sigma_{AV} = \sigma/\sqrt{p}$ |
| Nyquist theorem | $f_s > 2f_{max}$ |

---

> ✅ **Key Takeaway**: Loading effects arise because every real instrument has finite $Z_L$ — the cure is $Z_L \gg Z_{Th}$. Random noise is quantified via PSD ($\phi$) and bandwidth ($f_C$): $W_N = \phi f_C$. The frequency domain (FFT) is the "dimensionality strike" that separates signal from noise by their frequency fingerprints. Nyquist's theorem is the unbreakable digital rule: sample at **more than twice** your highest frequency of interest.
