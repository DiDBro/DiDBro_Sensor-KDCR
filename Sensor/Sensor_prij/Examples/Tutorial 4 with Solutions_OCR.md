# Tutorial 4 with Solutions.pdf


## Page 1 [TEXT]
Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
March, 2026
Tutorial Course for Intro to Sensor-
Integrated Systems

## Page 2 [TEXT]
Electrical Loading Effects and Analysis Tools
Core Concept: Loading Effect
➢Ideal State: The sensor transmits the measurement signal to the next stage (e.g., a recorder) without any loss.
➢Actual Situation: When the next-stage instrument is connected as a "load," it draws current from the sensor, 
causing a change in the sensor's output signal (typically a voltage drop).
➢Conclusion: The loading effect is a significant cause of systematic error within measurement systems.
Analysis Tool: Thévenin Equivalent Circuit
➢Simplifies complex internal sensor circuitry into: an Ideal Voltage Source (𝑬𝑻𝒉) + Series Internal Impedance (𝒁𝑻𝒉).
Core Formula Derivation:
𝑉𝐿= 𝐸𝑇ℎ
𝑍𝐿
𝑍𝑇ℎ+ 𝑍𝐿
➢𝑉𝐿: Actual measured load voltage
➢𝐸𝑇ℎ: Open-circuit voltage of the sensor (the true signal)
➢𝑍𝐿: Input impedance of the load (measuring instrument)
➢𝑍𝑇ℎ: Equivalent internal impedance of the sensor
Engineering Insights:
➢To make the measured value 𝑉𝐿approach the true value 𝐸𝑇ℎ, the following condition must be met: 𝒁𝑳≫𝒁𝑻𝒉(Load 
impedance must be much greater than the sensor's internal impedance).

## Page 3 [TEXT]
Potentiometer Loading Effects and Parameter Design
Review of Potentiometric Sensor Principles:
➢Uses a sliding contact to change resistance, achieving the conversion from displacement to voltage.
Thévenin Equivalent after Load Connection (Let relative displacement 𝑥= 𝑑/𝑑𝑇):
➢Open-circuit Voltage:
𝐸𝑇ℎ= 𝑉𝑆𝑥
➢Equivalent Internal Resistance:
𝑅𝑇ℎ= 𝑅𝑃𝑥1 −𝑥
➢Actual Load Voltage:
𝑉𝐿= 𝑉𝑆𝑥
1
𝑅𝑃/𝑅𝐿𝑥1 −𝑥+ 1
Two Major Constraints in System Design:
1. Non-linear Error
➢The connection of a load disrupts the originally perfect linear voltage division.
➢Error Formula: ෡𝑁≈15
𝑅𝑃
𝑅𝐿%
➢Design Requirement: Total sensor resistance 𝑅𝑃should be as small as possible.
2. Maximum Power Rating
➢Sensor heat dissipation must not exceed the limit ෡𝑊.
➢Power Formula:
𝑉𝑆
2
𝑅𝑃≤෡𝑊
➢Design Requirement: Increasing sensitivity requires increasing the supply voltage 𝑉𝑆, but this is limited by 𝑅𝑃and ෡𝑊.
≡

## Page 4 [OCR]
Exercise
linear thermocouple with a sensitivity of 0.04 mV/°C and resistance of 100 S2 is con-
nected to a load with a resistance of 1 kQ. Find the voltage across the load for a temperature
of 250 °C.

## Page 5 [OCR]
Solution
A linear thermocouple with a sensitivity of 0.04 mV/°C and resistance of 100 2 is con-
nected to a load with a resistance of 1 kS. Find the voltage across the load for a temperature
of 250 °C.
1. Identify Known Parameters
Step 2: Calculate the actual load voltage (VL) using the Voltage Divider Formula
• Thermocouple Sensitivity (K): 0.04 mV/°C
• Current Measured Temperature (T): 250°C
RI
VI = ETh X
RTh + RI
• Internal Resistance (RTh): 100 2
Substitute the numerical values:
• Load Resistance (RL): 1 kM = 1000 2
2. Detailed Step-by-Step Solution
1000
VI = 10 x
100 + 1000
Step 1: Calculate the theoretical open-circuit voltage (ETh)
In an ideal state where no load is connected, the total voltage produced by the thermocouple is
1000
VL = 10 x/
1100
determined solely by its sensitivity and the measured temperature:
ETh = K × T
Plugging in the values:
10
VI = 10 ×
• ~ 9.09 mV
ETh = 0.04 × 250 = 10 mV

## Page 6 [OCR]
Exercise
A potentiometer has a supply voltage of 10 V, a resistance of 10 k and a length of 10 cm.
A recorder of resistance 10 k is connected across the potentiometer. Calculate the
Thévenin equivalent circuit for the sensor and the recorder voltage for each of the following
displacements:
(a)
(b)
(c)
2 cm
5 cm
8 cm.

## Page 7 [OCR]
Known Parameters:
• Supply Voltage (Vs): 10 V
• Total Potentiometer Resistance (Rp): 10 kl
• Total Potentiometer Length (dI): 10 cm
• Recorder (Load) Resistance (RL): 10 kl
Core Formulas (Based on relative displacement x = d/dr):
1. Thévenin Equivalent Voltage (Open-circuit Voltage):
ETh = Vs - x
2. Thévenin Equivalent Internal Resistance:
RIh= Rp-x-(1-x)
3. Actual Measured Load Voltage:
RI
VI = Eth RIn + RI
(a) When actual displacement d = 2 cm:
• Relative displacement (x): x = 2/10 = 0.2
• Thévenin Voltage (ETh): ETh = 10 × 0.2 = 2.0 V
• Thévenin Internal Resistance (RTh):
RTh = 10 × 0.2 × (1 - 0.2) = 10 × 0.16 = 1.6 kS
• Actual Load Voltage (VL):
10
VI =2.0 x
1.6 + 10
20
~ 1.72 V
11.6
Solution
(b) When actual displacement d = 5 cm:
• Relative displacement (x): x = 5/10 = 0.5 (Center position)
• Thévenin Voltage (ETh): ETh = 10 × 0.5 = 5.0 V
• Thévenin Internal Resistance (RTh): RTh = 10 × 0.5 × (1 - 0.5) = 10 × 0.25
2.5 k$2
• Actual Load Voltage (VL):
10
VL = 5.0 x
2.5 + 10
50
12.5
= 4.0 V
(c) When actual displacement d = 8 cm:
• Relative displacement (x): x = 8/10 = 0.8
• Thévenin Voltage (ETh): ETh = 10 × 0.8 = 8.0 V
• Thévenin Internal Resistance (Rri): RIk = 10 × 0.8 × (1 - 0.8) = 10 × 0.16 =
1.6 k$2
• Actual Load Voltage (VL):
10
VL = 8.0 x
1.6 + 10
80
• ~ 6.90 V
11.6

## Page 8 [OCR]
Exercise
The motion of a hydraulic ram is to be recorded using a potentiometer displacement sensor
connected to a recorder. The potentiometer is 25 cm long and has linear resistance dis-
placement characteristics. A set of potentiometers with maximum power rating of 5 W and
resistance values ranging from 250 to 2500 S in 250 S steps is available. The recorder has a
resistance of 5000 S2 and the non-linear error of the system must not exceed 2% of full scale.
Find:
(a) the maximum potentiometer sensitivity that can be obtained;
(b) the required potentiometer resistance and supply voltage in order to achieve maximum
sensitivity.

## Page 9 [OCR]
Solution
1. Organizing Known Conditions and Core Formulas
Known Design Constraints and Parameters:
• Full-scale Displacement (dr): 25 cm
• Maximum Power Rating (W): 5 W (Exceeding this will burn the sensor)
• Recorder (Load) Resistance (RI): 5000 S
• Maximum Non-linear Error Requirement (N): Not to exceed 2% of full scale.
• Available Potentiometer Resistances (Rp): From 250 S2 to 2500 S2, in increments of
250 S (i.e., {250, 500, 750, 1000...}).
Core Formulas:
1. Non-linear Error Limit Formula: N = 27 R,% (approximately 15 r %)
2. Maximum Power Constraint Formula: W = # ≤ W
3. System Sensitivity Formula: S = dr
Step 1: Determine the usable Rp range based on "Non-linear Error Limits"
To ensure measurement accuracy, the non-linear error must be ≤ 2%. Substituting into the
limit formula:
400 Rp
• ≤ 2
27 RL

## Page 10 [OCR]
Substituting Rz = 5000 S:
Rp ≤ 2x27 x 5000
Rp ≤ 675 S
Based on the available resistance steps (250 S, 500 S2, 750 S...), the maximum allowable
resistance is Rp = 500 2.
Step 2: Determine the maximum supply voltage Vs based on "Maximum Power Rating"
To maximize sensitivity (S = Vs/dr), we must make the supply voltage Vs as high as possible
while dr remains constant.
Based on the heat dissipation limit:
V5 SW → Vs≤ VW. Rp
This formula clearly shows that the larger Rp is, the higher the allowable voltage Vs. This is
why we chose 500 S instead of 250 S in Step 1.
Substituting W = 5 W and Rp = 500 S:
Vś ≤ 5 × 500 = 2500
Vs ≤ 50 V
Thus, the maximum usable supply voltage is Vs = 50 V.
Solution
Step 3: Calculate the maximum system sensitivity
With the maximum voltage and total length known, calculate the sensitivity directly:
50 V
Max Sensitivity S =
s = 250 cm
. = 2.0 V/cm
Final Answer:
• (a) The maximum achievable potentiometer sensitivity is: 2.0 V/cm
• (b) To achieve this, the required potentiometer resistance is 500 S2 and the supply
voltage is 50 V.

## Page 11 [TEXT]
Random Signals & Basic Statistical Characteristics
Deterministic vs. Random Signals
➢Deterministic Signals: Values at future points in time can be accurately predicted (e.g., standard sine waves, step 
signals).
➢Random Signals: Interfered with by unknown factors; it is impossible to write a definitive time function 𝑦𝑡(e.g., 
actual industrial temperature fluctuations, electromagnetic noise).
➢Strategy: Give up on predicting "exact values" and instead focus on studying statistical patterns over a period of time.
Basic Statistics for Describing Amplitude
➢Mean (ഥ𝒚): The DC offset component of the signal.
➢Standard Deviation (𝝈): The degree of fluctuation/deviation from the mean.
➢Root Mean Square (RMS, 𝒚𝒓𝒎𝒔): Measures the energy carried by the signal.
➢Special Case: When the mean is 0, the Standard Deviation = RMS (𝜎= 𝑦𝑟𝑚𝑠).
Core Energy Formula (Based on 𝟏𝛀impedance reference):
➢Total Power (𝑾𝑻𝑶𝑻):
𝑊𝑇𝑂𝑇= 𝑦𝑟𝑚𝑠
2

## Page 12 [TEXT]
Core Analysis Tool: Autocorrelation Function (ACF)
What is Autocorrelation?
➢Physical Meaning: Measures the degree of "similarity" between a signal at the current moment and itself after a 
time delay 𝛽.
➢Function: It acts like a "sieve," filtering out random, chaotic noise to highlight periodic patterns hidden within the 
signal.
ACF Calculation Formula for Discretely Sampled Signals:
𝑅𝑦𝑦𝑚Δ𝑇= 1
𝑁෍
𝑖=1
𝑁
𝑦𝑖𝑦𝑖−𝑚
➢𝑁: Total number of sampling points
➢𝑚: Number of delay steps (𝑚Δ𝑇is the total delay time 𝛽)
➢𝑦𝑖, 𝑦𝑖−𝑚: Sampled values at the current moment and 𝑚moments prior.
Analysis of Calculation Steps:
1.Create a duplicate copy of the original signal.
2.Shift the duplicate signal to the right (or left) by 𝑚units.
3.Multiply the aligned values term-by-term, then calculate the average of these products.

## Page 13 [OCR]
Exercise
Two complete periods of a square wave can be represented by the following 20 sample values:
+1+1+1+1+1 —1-1-1-1-1+1+1+1+1+1
-1-1-1-1-1
Find the autocorrelation function of the signal over one complete period by evaluating the
coefficients R, (mAT) for m = 0, 1, 2, ...,10.

## Page 14 [TEXT]
Solution
Known Parameters:
➢Signal Waveform: A square wave (represented by discrete sampling points).
➢Sampling Data: The problem provides 20 sampling points, representing two full cycles:
+1, +1, +1, +1, +1, -1, -1, -1, -1, -1, +1, +1, +1, +1, +1, -1, -1, -1, -1, -1
➢Single Cycle Length (𝑵): Since 20 points cover two cycles, one full cycle contains 𝑁= 10 sampling points.
Core Formula:
For a periodic signal or a sampled signal with a full cycle of length 𝑁, the discrete autocorrelation coefficient is calculated as:
𝑅𝑦𝑦𝑚Δ𝑇= 1
𝑁෍
𝑖=1
𝑁
𝑦𝑖𝑦𝑖+𝑚
Meaning: Multiply the original signal (first 10 points) term-by-term with a version of itself shifted left or right by 𝑚steps, 
then sum the products and calculate the average.

## Page 15 [OCR]
Solution
3 When m = 2:
• Sum = 2; Average: Ryy (2AT) = 10 = 0.2
4 When m = 5 (Delayed by half a cycle):
• Delayed: -1, -1, -1, -1, -1, +1, +1, +1, +1, +1 (Completely out of phase with the
original)
• Product: -1, -1, -1, -1, -1, -1, -1, -1, -1, -1
• Sum =-10; Average: Ry(5AT) = 10 = -1.0
5 Use symmetry to complete the rest:
Due to the symmetry and periodicity of the ACF for periodic signals, the values will "rebound"
linearly after m = 5 until m = 10, where the waveform overlaps with itself perfectly again (
Ryy = 1.0).
Summary Table of Results:
Riyy
1.0
1
0.6
2
3
0.2 -0.2
4
-0.6
5
-1.0
6
-0.6
7
-0.2
8
0.2
0.6
10
1.0

## Page 16 [TEXT]
Noise Characteristics & SNR
Internal Noise:
➢Source: Random thermal motion of electrons within resistors and semiconductors (Thermal Noise / Johnson-Nyquist 
Noise).
➢Characteristics: Usually manifests as White Noise, meaning the energy is distributed uniformly across an extremely 
wide frequency range.
How to Quantify White Noise? (Core Formulas)
➢Power Spectral Density (PSD, 𝝓): Power per unit frequency (unit: W/Hz). Think of this as the "concentration" of the 
noise.
➢Total Noise Power (𝑾𝑵):
𝑊𝑁= 𝜙× 𝑓𝐶
where 𝑓𝐶is the system bandwidth or cutoff frequency.
➢Noise RMS Voltage (𝑽𝑵,𝒓𝒎𝒔):
𝑉𝑁,𝑟𝑚𝑠=
𝑊𝑁
Assuming a 1 Ω reference. Since the mean of thermal noise is 0, 𝑉𝑁,𝑟𝑚𝑠equals the standard deviation 𝜎𝑁.
Ultimate Evaluation of Signal Quality: Signal-to-Noise Ratio (SNR)
➢Formula:
𝑆𝑁𝑅𝑑𝐵= 10log10
𝑊𝑆
𝑊𝑁
= 20log10
𝑉𝑆
𝑉𝑁
➢Meaning: The ratio of useful signal power (𝑊𝑆) to noise power (𝑊𝑁).
➢Criterion: If SNR < 0 dB, it indicates that the noise power has exceeded the signal power, and the signal is completely 
"submerged" or lost in noise.

## Page 17 [TEXT]
Interference & Coupling Mechanisms
Interference Sources:
➢50Hz AC Power: The most common "Mains pick-up" or "Hum."
➢Others: Transient pulses from motor switching, radio frequency (RF) transmitters, etc.
Coupling Mechanisms:
1. Inductive Coupling: Changes in spatial magnetic fields (𝑑𝑖/𝑑𝑡) cut across the measurement loop, inducing an 
interference voltage.
2. Capacitive Coupling: Distributed "stray capacitance" between high-voltage cables and signal lines allows AC high 
voltage to leak into the measurement circuit.
3. Multiple Earths / Ground Loops:
➢Phenomenon: If the sensor and receiver are grounded at different points, a potential difference (𝑉𝐸) may exist 
between them, creating an interference current (𝑖𝐸) in the shield or signal line.
Two Forms of Interference Damage:
➢Series Mode (Normal Mode, 𝑽𝑺𝑴): The interference is superimposed in series with the useful signal, leading directly 
to measurement errors. This is the most critical type.
➢Common Mode (𝑽𝑪𝑴): The potential of both signal lines rises simultaneously relative to the ground. While it doesn't 
immediately change the differential voltage between the lines, it can easily convert into series mode interference.

## Page 18 [TEXT]
Suppression Techniques for Noise and Interference
Cutting off the Entry Path:
➢Against Inductive Coupling →Twisted Pairs: Ensures that the induced electromotive forces in adjacent loops have 
opposite polarities, effectively canceling each other out.
➢Against Capacitive Coupling and Ground Loops →Electrostatic Shielding & Single-point Grounding: Enclose 
the circuit in a metal shield and ground it at only one end to completely cut off ground loop currents (𝑖𝐸).
➢Against Common-mode Interference →Differential Amplifier: Amplifies only the voltage difference between the 
two lines while ignoring the common-mode voltage that rises simultaneously on both.
•Residual Error Formula:
𝑉𝐶𝑀_𝑒𝑟𝑟𝑜𝑟=
𝑉𝐶𝑀
𝐶𝑀𝑅𝑅
where CMRR is the Common-Mode Rejection Ratio; the higher, the better.
Signal Processing Methods (Cleaning Residual Noise):
➢Filtering: Use a Band-pass filter to allow only the signal frequencies to pass through, cutting off noise power 
outside the bandwidth.
* Signal Averaging:
• Application: Periodically repeating signals.
• Noise Reduction Formula:
𝜎𝐴𝑉= 𝜎
𝑝
 
where 𝑝is the number of averages.
• Principle: The positive and negative fluctuations of random noise cancel out over multiple averages, while the 
consistent underlying signal is preserved, significantly improving the SNR.

## Page 19 [OCR]
Exercise
A sinusoidal signal of amplitude 1.4 mV and frequency 5 kHz is 'buried' in Gaussian noise
with zero mean value. The noise has a uniform power spectral density of 100 pW Hz' up to
a cut-oft frequency of 1 MHz.
(a) Find the total power, r.m.s. value and standard deviation for the noise signal.
(b) What is the signal-to-noise ratio in dB?
(C)
Sketch the autocorrelation function for the combined signal and noise.
(d)
The combined signal is passed through a band-pass filter with centre frequency 5 kHz
and bandwidth 1 kHz. What improvement in signal-to-noise ratio is obtained?
(e)
The filtered signal is then passed through a signal averager which averages corres-
ponding samples of 100 sections of signal. What further improvement in signal-to-noise
ratio is obtained?

## Page 20 [TEXT]
Solution
Note: System power is calculated based on a 1 Ω reference impedance, i.e., 𝑊= 𝑉𝑟𝑚𝑠
2

## Page 21 [OCR]
Solution
(b) Stage 2: Initial SNR
1. Useful Signal Power (Ws): Find the RMS value of the sine wave first, then square it.
1.4 mV
VS,rms
- ≤ 1.0 mV
Ws = V3ms = (1.0 × 103V)? =1.0×10°₩=1«₩
2. Calculate Initial SNR:
SNR (dB) = 10log10
Ws
1 uW
= 10l0g10
WN
100 W
| = 1010g10(0.01) = -20
Solution to 6.3(c) - Sketch of Autocorrelation Function (ACF)
- Total power peak Ryy (0) = Wror = 101 W
Autocorrelation R(p) (uW)
100
- Noise peak (Wy = 100 W). Very narrow (width ~ 1 us).
Decays to zero.
2
erid T= ms Siersists
200 us
- Rss (P) = 1 MW cos (27 - 5kHz-1
Luw is approx va
0.2
0.3
0.4
Ryy (B) = Rss (B) + RNN (B)
RNN (P) quickly decays, so Ryy (P) = Rss (B) for *0
0.5 Time Delay B (ms)

## Page 22 [TEXT]
Solution
(d) Stage 4: Band-pass Filtering
(e) Stage 5: Signal Averaging

## Page 23 [OCR]
Exercise
A thermocouple giving a 10 mV d.c. output voltage is connected to a high impedance digital
voltmeter some distance away. A difference in potential exists between earth at the thermo-
couple and earth at the voltmeter. Using the equivalent circuit given in Figure Prob. 4.
(a) Calculate the r.m.s. values of the series mode and common mode interference voltages
at the voltmeter input.
(b) If the digital voltmeter has a common mode rejection ratio of 100 dB, find the
minimum and maximum possible measured voltages.
Figure Prob. 4.
Cable
100 S
; Thermocouple
10 mV d.c.
10 MR 3
Leakage
resistance
P
U
10 22
Thermocouple
earth
100 2
Digital
voltmeter
(d.v.m.)
1000 pF
- leakage
capacitance
10 S
100 V r.m.s.
50 Hz
Voltmeter
earth

## Page 24 [TEXT]
Solution
The pure resistance in the loop (10 , Ω + 100 , Ω + 10 , Ω = 120 , Ω) is negligible compared to 3.18 MΩ. Therefore, the total loop 
impedance 𝑍𝑙𝑜𝑜𝑝≈𝑋𝐶.

## Page 25 [OCR]
Solution
Step 2: Calculate Series-Mode Interference Voltage (Vs)
Series-mode interference is the error voltage superimposed directly across the signal terminals
(between R and S). It is caused by the voltage drop produced by the interference current
flowing through the lower cable:
Vs = ig × Rcable = 31.42 pA × 100S = 3142 pV = 3.14 mV (r.m.s.)|
Step 3: Calculate Common-Mode Interference Voltage (Vc)
Common-mode interference is the overall voltage lift of the signal lines relative to ground. In
this circuit, almost the entire 100 V total voltage is dropped across the component with the
largest impedance-the capacitor (from terminal S to ground T):
Vc ~ iE × Xc = 100 V (r.m.s.)
(b) Calculate Extreme Values: What will the voltmeter actually display?
Step 1: Conversion of Common-Mode Rejection Ratio (CMRR)
The voltmeter has a CMRR of 100 dB. Converting this to a linear ratio:
100 dB = 2010g10 (Ratio) → Ratio = 105 = 100,000
This means that for a common-mode interference as high as 100 V, only 1/100, 000 of it will
be converted into harmful series-mode error:
100 V
VCM_error = 100, 000
= 1.0 mV (r.m.s.)

## Page 26 [OCR]
Solution
Step 2: Calculate Total AC Interference Peak (Peak)
There are now two AC interference sources at the voltmeter input:
1. Direct Series-Mode Interference: 3.14 mV (Resistive voltage drop, in phase with
current).
2. Indirect Series-Mode Error from CM Conversion: 1.0 mV (Capacitive voltage, lags
phase by 90°).
Since the two are 90° out of phase, the total RMS AC interference is calculated using the root
sum of squares:
VAC rms = V 3.142 + 1.02 = 19.86 + 1.0 ~ 3.30 mV (r.m.s.)
Convert this to peak AC voltage (maximum amplitude of fluctuation):
VAC_peat=3.30mVx/2~4.66mV
Step 3: Determine Measurement Extremes
The true DC signal from the thermocouple is 10 mV. The voltmeter reading will fluctuate based
on this 10 mV plus the superimposed AC interference peak:
• Maximum Measured Voltage = 10 mV + 4.66 mV = 14.66 mV
• Minimum Measured Voltage = 10 mV - 4.66 mV = 5.34 mV

## Page 27 [TEXT]
Time vs. Frequency Domain
The Limitations of the Time Domain:
➢The horizontal axis represents time, and the vertical axis represents amplitude (similar to the waveform seen on an 
oscilloscope).
➢Disadvantage: When useful signals, high-frequency interference, and white noise are all superimposed, the time-
domain waveform looks like a tangled mess, making it impossible to distinguish "who is who."
The "Dimensionality Strike" of the Frequency Domain:
➢The horizontal axis represents frequency, and the vertical axis represents amplitude/energy.
➢Core Idea (Fourier's Great Discovery): Any complex real-world signal can be viewed as the superposition of 
countless pure sine/cosine waves of different frequencies and amplitudes!
➢Advantage: Signals that are hopelessly entangled in the time domain will automatically "line up" in the frequency 
domain based on their frequency levels.
Analogy (For easy memorization):
➢The Time Domain is like a cooked dish: You can only taste the overall flavor (the aggregate waveform).
➢The Frequency Domain is like the recipe and ingredient list: It clearly tells you that the dish contains 10 g of salt 
(low-frequency signal), 0.5 g of pepper (high-frequency noise), and a pinch of random impurities (white noise).

## Page 28 [TEXT]
Core Mathematical Tool: Fast Fourier Transform (FFT)
Discrete Fourier Transform (DFT): Transitioning Digital Signals to the Frequency Domain
➢Formula:
𝑋𝑘= ෍
𝑛=0
𝑁−1
𝑥𝑛𝑒−𝑗2𝜋
𝑁𝑘𝑛
➢Meaning: 𝑥𝑛represents the discrete data points sampled by the computer; 𝑋𝑘represents the calculated frequency 
spectrum data. Through complex exponential operations, it "projects" time-domain data onto various frequency 
coordinates.
Fast Fourier Transform (FFT):
➢Engineers don't need to do the math by hand! FFT is an extremely efficient computer algorithm for calculating the 
DFT.
➢In data-driven analysis software like Python or MATLAB, a single line of code (e.g., fft(y)) can instantly transform 
tens of thousands of time-domain data points into a spectrum.
How to Read an FFT Spectrum (Frequency Response)?
➢Spikes: These represent a strong periodic signal existing at that specific frequency. The horizontal coordinate of the 
spike corresponds to the frequency, while the vertical coordinate represents the amplitude of that signal.
➢Noise Floor: Because Gaussian white noise contains all frequencies, it doesn't form sharp spikes. Instead, it appears as 
a "fuzzy" layer of grass spread across the bottom of the spectrum.

## Page 29 [TEXT]
The Prerequisite for Digitization: Nyquist Sampling Theorem
Why do we need sampling?
➢Computers do not recognize continuous analog waveforms; they can only take discrete "snapshots" at a specific 
frequency (interval).
➢Sampling Frequency (𝒇𝒔): How many points are captured in one second (Units: Hz or Samples/s).
Nyquist-Shannon Theorem (Core Formula):
➢To perfectly reconstruct the frequency components of the original signal in a computer without distortion, the sampling 
frequency must be strictly greater than twice the highest frequency component (𝑓𝑚𝑎𝑥) in the signal.
➢Formula:
𝑓𝑠> 2𝑓𝑚𝑎𝑥
What happens if the requirement is not met? (Aliasing)
➢If you capture data too slowly (𝑓𝑠< 2𝑓𝑚𝑎𝑥), high-frequency signals will "disguise" themselves as low-frequency 
signals in the spectrum, leading to a complete analysis error.
➢Example: In real life, when looking at a fast-rotating car wheel, it sometimes appears to be spinning backward. This is 
a visual aliasing effect caused by the human eye's insufficient sampling rate.

## Page 30 [TEXT]
Problem 6.6
1. Create a signal 10sin(2πt) and plot it.
2. Add a noise signal 0.5sin(2000πt) to the original signal and plot it.
3. Add Gaussian noise with a mean of 0 and standard deviation of 1 to the combined signal and plot it.
4. Perform an FFT on the synthesized signal to obtain its frequency response and plot it.
Exercise

## Page 31 [TEXT]
Solution
Problem 6.6
1. Create a signal 10sin(2πt) and 
plot it.
2. Add a noise signal 0.5sin(2000πt) 
to the original signal and plot it.
3. Add Gaussian noise with a mean 
of 0 and standard deviation of 1 to 
the combined signal and plot it.
4. Perform an FFT on the 
synthesized signal to obtain its 
frequency response and plot it.
