Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
March, 2026
Tutorial Course for Intro to Sensor-
Integrated Systems
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
Exercise
Solution
Exercise
Solution
Exercise
Solution
Solution
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
Exercise
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
Solution
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
Exercise
Solution
Note: System power is calculated based on a 1 Ω reference impedance, i.e., 𝑊= 𝑉𝑟𝑚𝑠
2
Solution
(b) Stage 2: Initial SNR
Solution
(d) Stage 4: Band-pass Filtering
(e) Stage 5: Signal Averaging
Exercise
Solution
The pure resistance in the loop (10 , Ω + 100 , Ω + 10 , Ω = 120 , Ω) is negligible compared to 3.18 MΩ. Therefore, the total loop 
impedance 𝑍𝑙𝑜𝑜𝑝≈𝑋𝐶.
Solution
Solution
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
Problem 6.6
1. Create a signal 10sin(2πt) and plot it.
2. Add a noise signal 0.5sin(2000πt) to the original signal and plot it.
3. Add Gaussian noise with a mean of 0 and standard deviation of 1 to the combined signal and plot it.
4. Perform an FFT on the synthesized signal to obtain its frequency response and plot it.
Exercise
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
