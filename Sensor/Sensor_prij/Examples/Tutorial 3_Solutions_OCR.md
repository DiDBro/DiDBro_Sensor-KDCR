# Tutorial 3_Solutions.pdf


## Page 1 [TEXT]
Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
March, 2026
Tutorial Course for Intro to Sensor-
Integrated Systems

## Page 2 [TEXT]
Step Response of First-order Systems
Engineering Background: Commonly used to describe components without mass or inertia, such as temperature sensors 
(thermocouples) in integrated sensor systems, liquid-level systems, and RC low-pass filter circuits.
➢These systems only exhibit "resistance" and "capacitance" characteristics.
Core Dynamic Parameter: Time Constant 𝝉
➢Physical Significance: The core indicator determining the speed of the system response. The smaller the 𝜏, the faster 
the sensor tracks the true signal.
➢Thermodynamic Definition: 𝜏=
𝑀𝐶
𝑈𝐴
Mathematical Model for Step Response:
When the system is subjected to a step input of height Δ𝐼, the transient change in output is:
Δ𝑂𝑡= 𝐾⋅Δ𝐼⋅1 −𝑒−𝑡/𝜏
(Note: 𝐾is the steady-state sensitivity of the system)
Key Points:
➢When 𝑡= 𝜏, the sensor output reaches 63.2% of its final steady-state change.
➢When 𝑡= 4𝜏∼5𝜏, the system basically reaches its new steady state.

## Page 3 [TEXT]
Step Response of Second-order Systems
Engineering Background:
➢Used to describe physical mechanisms containing "inertia," such as mechanical elastic force sensors and
accelerometers.
➢Due to the presence of mass (𝑚), springs (𝑘), and dampers (𝜆), the system is prone to overshoot and oscillation when
subjected to a step impact.
Two Core Dynamic Parameters:
➢Natural Frequency 𝝎𝒏: 𝜔𝑛=
𝑘/𝑚. Determines the speed of the system's inherent oscillation.
➢Damping Ratio 𝝃: 𝜉=
𝜆
2 𝑘𝑚. Measures the system's ability to dissipate energy and suppress oscillation (the optimal
engineering design value is usually 𝜉≈0.7).
Mathematical Model for Underdamped (𝝃< 𝟏) Step Response:
Δ𝑂𝑡= 𝐾⋅Δ𝐼⋅1 −𝑒−𝜉𝜔𝑛𝑡
cos𝜔𝑑𝑡+
𝜉
1 −𝜉2 sin𝜔𝑑𝑡
(Note: Damped natural frequency 𝜔𝑑= 𝜔𝑛
1 −𝜉2)
Key Points:
Waveform Characteristics: The exponential decay term 𝑒−𝜉𝜔𝑛𝑡determines the Settling Time (𝑇𝑠≈
5
𝜉𝜔𝑛), while the
trigonometric terms determine the oscillation frequency.

## Page 4 [OCR]
Exercise
A temperature measurement system consists of linear elements and has an overall steady-state
sensitivity of unity. The dynamics of the system are determined by the first-order transfer func-
tion of the sensing element. At time t = 0, the sensing element is suddenly transferred from
air at 20 °C to boiling water. One minute later the element is suddenly transferred back to air.
Using the data given below, calculate the system dynamic error at the following times: t = 10,
20,50, and and s.
Sensor data
Mass = 5 x 102 kg
Surface area = 10-3m?
Specific heat = 0.2 J kg-' °C-
Heat transfer coefficient for air = 0.2 W m-2 °c-l
Heat transfer coefficient for water = 1.0 W m2°C-l

## Page 5 [OCR]
Solution
1. Calculation of Time Constants (7)
For a first-order system, the time constant r is calculated using:
mC
T=
hA
Based on the data given in the problem:
• m = 5 × 10-2 kg
• A = 10-3 m?
• C= 0.2 J. kg 1° C-1
2. Establish the temperature response equation
The steady-state sensitivity of the measurement system is 1, which means that the measured
value equals the true temperature at steady state. The dynamic error is defined as: the
difference between the measured temperature and the current true environmental
temperature, i.e., E(t) = Im(t) - Itrue-
Stage 1: In boiling water (0 ≤ t ≤ 60 s)
• Initial temperature: Im (0) = 20°C
• Environmental temperature: To.1 = 100°C
• Temperature response equation:
Time constant in boiling water (Tw):
Given the heat transfer coefficient in water hw = 1.0W-m? °C1
Im(t) = Ix,1 + [Im (0) - Ico,1)e /Tu
Tw = (5x10-3) x 0.2
1.0 × 10-3
0.01
0.001
Tm (t) = 100 + (20 - 100)e -1/10 = 100 - 80e-t/10
= 10 s
• Dynamic error equation for this stage (true temperature is 100°C):
Time constant in air (Ta):
Given the heat transfer coefficient in air ha = 0.2 W-m ? °C-1
E_(t) = Im(t) - 100 = - 80e -4/10
Ta = (5 × 10-2) × 0.2
0.01
0.2 × 10-3
= 0.0002
= 50 s
At t = 60 s (after one minute), the temperature of the sensor is:
Im (60) = 100 - 80e 60/10 = 100 - 80e ° ~ 100 - 80 × 0.002479 = 99.8017° C

## Page 6 [OCR]
Solution
Stage 2: Returning to air (t > 60 s)
• t = 10 s (Belongs to Stage 1):
• Initial temperature: i.e., the temperature at the end of the first stage, Im (60) = E(10) = -80e-10/10 = -80e ' = -80 × 0.3679 ~ -29.43°C
99.8017°C
• Environmental temperature: 1∞0,2 = 20°C
• t = 20 s (Belongs to Stage 1):
E(20) = -80e-20/10= -80e-= -80 x 0.1353 ~ -10.83°C
• Define a new time variable: t' = t - 60 (the time elapsed after returning to the air).
• Temperature response equation:
• t = 50 s (Belongs to Stage 1):
(50) = - 80e-50/10 = - 80е " = - 80 × 0.00674 ~ -0.54°C
Im(t) = I0,2 + [Im (60) - Io,2]e (2-60)/ Fa
Im(t) = 20 + (99.8017 - 20)e (1-60)/50 = 20 + 79.8017e (4-60)/50
• t = 120 s (Belongs to Stage 2):
E(120) = 79.8017e (120-60)/50 = 79.8017e 60/50 = 79.8017e-12
• Dynamic error equation for this stage (true temperature is 20°C):
E(120) = 79.8017 × 0.3012 ~ 24.04°C
Ez(t) = Im (t) - 20 = 79.8017e (t-60)/50
• t = 300 s (Belongs to Stage 2):
E(300) = 79.8017e (300-60)/50 = 79.8017e-240/50 = 79.8017e 4.8
E(300) = 79.8017 × 0.00823 ~ 0.66°C

## Page 7 [OCR]
Exercise
A force sensor has a mass of 0.5 kg, stiffness of 2 × 10° N m' and a damping constant of
6.0 N s m'
(a) Calculate the steady-state sensitivity, natural frequency and damping ratio for the sensor.
(b) Calculate the displacement of the sensor for a steady input force of 2 N.
(C)
If the input force is suddenly increased from 2 to 3N, derive an expression for the
resulting displacement of the sensor.

## Page 8 [OCR]
Solution
(a) Calculate steady-state sensitivity, natural frequency, and damping ratio
(c) Derive the displacement expression when the input force jumps from 2 N to 3 N
AF=3-2= 1N
1. Steady-state sensitivity (K):
For this type of mechanical sensor, the steady-state sensitivity is the reciprocal of the stiffness 1. Calculate the necessary intermediate parameters:
k:
Atstcady = K × AF = 0.005 x 1 = 0.005 m
• Exponential decay coefficient: {wn = 0.3 × 20 = 6
K =
= 0.005 mN N1
200
• Damped natural frequency (actual oscillation frequency):
wa = wnV1-8=20/1-0.32 = 20/0.91 ~ 19.08 rads 1
2. Natural frequency (wn):
• Sine term coefficient:
200
= V400 = 20 rads
wn =Vm
= V 0.5
3. Damping ratio (E):
0.3
VI-8 V0.91
= ~ 0.314
2. Write the equation for the change in displacement Ax(t):
According to the standard formula for the step response of an underdamped system!
{=
2vkm
6.0
2/200 x 0.5
6.0
2v100
6.0
= 0.3
20
Ax(t) = Atsteady
Substituting the numerical values:
(b) Calculate sensor displacement for a steady input force of 2 N
Under steady-state conditions, the system has no acceleration or velocity. Damping and
inertial forces are zero. The initial displacement x (0) can be obtained by directly multiplying
the steady-state sensitivity by the input force:
Ax (t) = 0.005 [1 - e " (cos 19.08t + 0.314 sin 19.08t)]|
3. Derive the final total displacement equation x (t):
x(t) = x (0) + Ax(t)|
The final expression is:
х(0) = K × F = 0.005 × 2 = 0.01 m
*(t) = 0.01 + 0.005 [1 - e " (cos 19.08t + 0.314 sin 19.08t)] (Unit: m)|

## Page 9 [TEXT]
How to Handle Complex Periodic Signals?
Engineering Pain Point: Real-world signals are not perfect.
➢In industrial settings (e.g., fluid pulsation, mechanical vibration), sensors often receive continuous periodic signals with 
complex waveforms rather than a single pure sine wave.
➢Fourier Series: Any complex periodic signal can be "decomposed" into a superposition of a series of sine waves of 
different frequencies (Fundamental + Higher Harmonics).
General Response Model: "Deformation" of a Sine Wave
When the input is a single-frequency signal 𝐼𝑡= 𝐴𝑖sin 𝜔𝑡, the steady-state output of a linear system must be a sine 
wave of the same frequency:
𝑂𝑡= 𝐴𝑖⋅𝐺𝑗𝜔
⋅sin 𝜔𝑡+ 𝜙
➢Amplitude Ratio ( 𝑮): Determines whether the frequency signal is amplified or attenuated.
➢Phase Shift (𝝓): Determines the time lag (or lead) angle of the frequency signal.
The Ultimate Problem-Solving Weapon: Superposition Principle
➢Total Output = The direct sum of the system's responses to each individual single-frequency input (fundamental, 2nd 
harmonic, 3rd harmonic, etc.).

## Page 10 [TEXT]
"Frequency Fingerprints" of First and Second-order Systems
First-order Systems (e.g., Thermocouples, RC Filter Circuits)
➢Amplitude Ratio: 𝐺𝑗𝜔
=
𝐾
1+ 𝜔𝜏2
➢Phase Shift: 𝜙= −arctan 𝜔𝜏
➢Engineering Characteristics: Natural Low-pass Filter. Low-frequency signals pass through with almost no loss
(amplitude ratio close to 1), while high-frequency signals are severely attenuated.
Second-order Systems (e.g., Mechanical Force Transducers, Accelerometers)
➢Amplitude Ratio: 𝐺𝑗𝜔
=
𝐾
1−
𝜔
𝜔𝑛
2 2
+ 2𝜉𝜔
𝜔𝑛
2
➢Phase Shift: 𝜙= −arctan
2𝜉𝜔
𝜔𝑛
1−
𝜔
𝜔𝑛
2
➢Engineering Characteristics: Hidden Resonance Crisis. When the input frequency 𝜔approaches the system's
undamped natural frequency 𝜔𝑛and the damping ratio 𝜉is small, destructive Resonance Amplification occurs,
leading to severe measurement distortion.

## Page 11 [OCR]
Exercise
A force measurement system consists of linear elements and has an overall steady-state
sensitivity of unity. The dynamics of the system are determined by the second-order transfer
function of the sensing element, which has a natural frequency c, = 40 rad s' and a damping
ratio § = 0.1. Calculate the system dynamic error corresponding to the periodic input force
signal:
F(t) = 50(sin 10t + ÷ sin 30t + | sin 50t)
The complex input periodic force F(t) = 50(sin 10t + ‡ sin 30t + ‡ sin 50t) is
decomposed into three independent frequency components:
• Component 1 (Fundamental): Frequency wy = 10 rad s, Amplitude A, = 50
• Component 2 (3rd Harmonic): Frequency w, = 30 rad s 1, Amplitude A, = 50 ~ 16.67
• Component 3 (5th Harmonic): Frequency w3 = 50 rad s 1, Amplitude A3 = 50 = 10

## Page 12 [OCR]
Frequency 1: w1 = 10 rad s 1
• Frequency ratio: 51 = 10 = 0.25
• Amplitude ratio:
1
V0.9375 + 0.057 ~ 1.065
V (1 - 0.252)? + (2 × 0.1 × 0.25)=
• Phase shift:
0.05
¢, = - arctan (
0.9375) = - 3.05°
• Output component:
O1(t) = 50 × 1.065 sin(10t - 3.05°) = 53.25 sin(10t - 3.05°)|
Frequency 2: w2 = 30 rad s 1
• Frequency ratio: =10
= 0.75
• Amplitude ratio:
Giz| = VI - 0.752)= + (2 × 0.1 × 0.75)=
• Phase shift:
V0.4375 + 0.153 ~ 2.162
02=-aretan 04375) ~-18:92
Solution
Frequency 3: w3 = 50 rad s 1
• Frequency ratio: 4 = 10 = 1.25
• Amplitude ratio:
G3 =
(Gal = V-1.25)* + (2 x 0.1 x 1.25: "V-0.5625)* +0.25 ~ 1.625
• Phase shift (A Common Error Point):
Because the real part of the denominator in the formula 1 - (w/wn)? = -0.5625 < 0,
the system phase shift has already crossed the -90° boundary into the third quadrant.
You must subtract 180° from the calculation result:
1s =-aretan (-0.5625) - 180° = 23.96 - 180° = -156.04°
• Output component:
Оз(t) = 10 × 1.625 sin(50t - 156.04°) = 16.25 sin(50t - 156.04°)
5. Calculate System Dynamic Error
System dynamic error is defined as: the actual output signal of the measurement system minus
the true input signal.
• Output component:
0½(t) = 16.67 × 2.162 sin(30t - 18.92°) = 36.04 sin(30t - 18.92°) |
E(t) = [O, (t) + Oz(t) + Os(t)] - F(t)
E(t) = 53.25 sin(10t — 3.05°) — 50 sin 10t||
+ 36.04 sin(30t - 18.92 ) - 16.67 sin 30t)|
+ 16.25 sin(50t - 156.04°) - 10 sin 50t]|

## Page 13 [OCR]
Exercise
A force measurement system consisting of a piezoelectric crystal, charge amplifier and
recorder is shown in Figure Prob. 7.
(a) Calculate the system dynamic error corresponding to the force input signal:
F(t) = 50(sin 10t + ≤ sin 30t + 5 sin 50г)
b)
Explain briefly the system modifications necessary to reduce the error in (a) Chint: see
Figure 8.22).
Piezoelectric
crystal
Charge
amplifier
True
force
20
Charge
10-3 Ts
1+ TS
Volts
т =0.1 s
Recorder
50
05 + 25 + 1
Cn =50 rad s-l
§=0.2
Measured
force

## Page 14 [OCR]
Solution
(a) Calculate the system dynamic error
3. Calculate the steady-state response for each frequency
1. Derive the overall transfer function G(s)
Frequency 1: Fundamental w1 = 10 rad s
G(8) = 1201. 1034.15
Through High-pass HA:
1 + 0.1s]
| 8/50) + 2(02)(8/50) + 1)
Ha(i10) = i+jI → |Hal=
12~0.707, <H1 = 90°- 45° = 45
Multiplying the constants yields: 20 × 10-3 × 50 = 1 (the static gain completely cancels out). Through Low-pass H:
By substituting s = jw, we can reorganize the equation into a first-order high-pass filter
Ho(310) = 11-0.04) + 30.00-0.06+30.08 → |Hal=
~ 1.038.
V0.928
(amplifier) and a second-order low-pass filter (recorder) in the frequency domain:
<HB ~ -4.76°
G(iw) = (10.1w
• (I (E) + 5(000)
Output component O, (t):
Overall amplitude ratio = 0.707 × 1.038 = 0.734, Overall phase shift = 45° —
4.76° = 40.24°
High-pass HA
2. Extract the components of the input signal F(t)
Low-pass HB
O, (t) = 50 × 0.734 sin(10t + 40.24°) = 36.70 sin(10t + 40.24°)|
F(t) = 50 sin(10t) + 16.67 sin(30t) + 10 sin(50t)
• Fundamental component: w1 = 10 rads*,
, Amplitude A1 = 50
• Third harmonic: w2 = 30 rad s*, Amplitude A2 = 16.67
• Fifth harmonic: w3 = 50 rad s 1, Amplitude A3 = 10
Frequency 2: Third Harmonic w2 = 30 rad s 1
Through High-pass HA:
HA (930) = 1 + = |H| = v10
~ 0.949 <H1 = 90° - arctan(3) ~ 18.43
Through Low-pass Ha:
Ha (330) = (1 - 0.36) + j0.24
=0.64 + 10.24 → |Hal= V0.4672
: ~ 1.463
<Ho = - arctan (0.64) ~-20.56
Output component O2 (t):
O›(t) = 16.67 × 1.388 sin(30t - 2.13°) = 23.14 sin(30t - 2.13°)

## Page 15 [OCR]
Solution
Frequency 3: Fifth Harmonic w3 = 50 rad s ' (Resonance Point)
Through High-pass HA:
HA (150) = 15
1+0 = Hİ=
5
126 0.981
<HA = 90° - arctan(5) ~ 11.31°
Through Low-pass HB (Real part becomes zero):
Question: Briefly explain the system modifications necessary to reduce the error in (a).
Based on the calculated steady-state frequency response of the system to the input signal, the
measurement system exhibits severe low-frequency attenuation (the fundamental amplitude
ratio is only 0.734) and intense high-frequency resonance distortion (the fifth harmonic
amplitude ratio reaches 2.453) within its operating frequency band (10 rad/s ~ 50 rad/s).
To minimize the system's dynamic error and achieve distortion-free measurement, the
following two core hardware modifications are strictly necessary:
1. Modification for Low-frequency Attenuation: Increase the Charge Amplifier's Time
1
1
HB (350) = [1 - 1] + j0.4
Output component O3 (t):
O3 (t) = 10 × 2.453 sin(50t - 78.69°) = 24.53 sin(50t - 78.69°)
30.4 → HB|= 2.5, <H= -90° Constant T
• Principle Analysis: The significant signal attenuation and phase lead occurring at w1 =
10 rad/s are due to the charge amplifier acting as a first-order high-pass filter. Its current
time constant + = 0.1 s results in a high-pass cutoff frequency (wc = 1/т = 10 rad/s)
that is too high, which severely interferes with the effective operating bandwidth.
• Modification Scheme: The time constant r of the charge amplifier must be significantly
4. Assemble the dynamic error equation
The dynamic error is defined as E(t) = O, (t) + O, (t) + O3 (t)| - F(t):
E(t) = [36.70 sin(10t + 40.24°) - 50 sin 10t]
increased (which can be achieved physically by increasing the feedback capacitance or
resistance in the circuit). This will shift its high-pass cutoff frequency to a value well below
the lowest frequency component of the input signal (the fundamental 10 rad/s), thereby
ensuring that low-frequency signals remain within the flat passband where the amplitude
ratio is constantly 1.
+ (23.14 sin(30t - 2.13°) - 16.67 sin 30t]].
+[24.53 sin(50t - 78.69°) - 10 sin 50t]

## Page 16 [OCR]
Solution
2. Modification for High-Frequency Resonance: Optimize the Recorder's Damping Ratio E
and Natural Frequency wn
• Principle Analysis: The severe amplitude amplification and phase lag occurring at w3 =
50 rad/s are due to this high-frequency component directly exciting the undamped
natural frequency (wn = 50 rad/s) of the recorder (a second-order low-pass system).
Additionally, the current damping ratio (Ę = 0.2) is too low, leaving the system in a
severely underdamped state that cannot effectively suppress the resonance peak.
• Modification Scheme: (
• (Primary Requirement): Mechanical or electromagnetic damping must be added to
the recorder to increase its damping ratio & to the optimal dynamic damping value
(approximately 0.7). This will completely eliminate the amplitude distortion caused by
the resonance peak.
• (Optimization Requirement): Provided the physical structure allows, the undamped
natural frequency wn of the recorder should be further increased (e.g., by increasing
mechanical stiffness or reducing the mass of the moving parts) so that it is
significantly higher than the highest frequency component of the input signal (the
fifth harmonic 50 rad/s). This will effectively broaden the usable flat bandwidth of
the measurement system.

## Page 17 [OCR]
Fourier Series Synthesis
— Total Sum
.... Fundamental
Hunanmemnunes
5th Harmonic (50 radis)
50.0
3rd Harmonic (30 radis
Solution
Fourier Series Synthesis
PEAK AMPLITUDE COMPLEXITY
47.1
2 cosponents
— Teral Sum
.... Fundamental
Fourier Series Synthesis
PAKANPUTUOECOMPXTY
46.7
3 corponents
Fundamental (10 radis)
3rd Harmonic (30 radis)
02
Fundamental (10 rads)O
Sth Harmonic (50 radi)O
0.6
0.8
Tima (camatei
10
3rd Harmonic (30 radls) O

## Page 18 [TEXT]
Open-loop Dynamic Compensation
Core Philosophy: Mathematical Cancellation
➢When the physical characteristics of a sensor are poor (e.g., the time constant 𝜏is too large, leading to a sluggish 
response) and cannot be changed physically, we can series-connect an electronic compensation circuit (such as a 
lead-lag network) at its output.
➢Zero-Pole Cancellation: Design the transfer function of the circuit to generate a "zero" that precisely cancels out the 
"pole" of the original sensor, while introducing a new pole with a much smaller time constant.
Mathematical Expression:
➢Original Sensor: 𝐺𝑠𝑠=
1
1+𝜏𝑠𝑙𝑜𝑤𝑠
➢Compensation Circuit: 𝐺𝑐𝑠=
1+𝜏𝑠𝑙𝑜𝑤𝑠
1+𝜏𝑓𝑎𝑠𝑡𝑠
➢Total Transfer Function: 𝐺𝑡𝑜𝑡𝑎𝑙𝑠= 𝐺𝑠𝑠⋅𝐺𝑐𝑠=
1
1+𝜏𝑓𝑎𝑠𝑡𝑠
Engineering Pros & Cons:
➢Pros: Low cost and simple to implement; significantly broadens the flat bandwidth of the system.
➢Fatal Weakness: Extremely poor anti-interference capability. If environmental changes cause the sensor's physical 
𝜏𝑠𝑙𝑜𝑤to drift (parameter mismatch), the "perfect cancellation" will fail completely.

## Page 19 [TEXT]
Closed-loop Negative Feedback Architecture
Core Philosophy: The Ultimate Architectural Revolution
➢Stop letting the sensor "fight alone." Instead, introduce a feedback loop that converts the output signal back into a 
physical quantity at the input, comparing it in real-time with the original input (finding the error). The system then only 
responds to the "net error."
A Leap in Engineering Performance (Example: Force-Balanced Accelerometer):
➢Explosive Bandwidth & Speed: The natural frequency of the closed-loop system 𝜔𝑛𝑐is much higher than that of the 
open-loop sensor 𝜔𝑛.
➢Perfect Dynamic Damping: By adjusting the circuit magnification, the closed-loop damping ratio 𝜉𝑐can be locked at 
the optimal 0.7, completely eliminating annoying mechanical oscillations.
➢Ultimate Robustness: Steady-state sensitivity 𝐾is no longer affected by aging mechanical parameters (like spring 
stiffness); instead, it depends on highly stable electronic components (standard resistors) and magnetic field strength.

## Page 20 [OCR]
Exercise
An uncompensated thermocouple has a time constant of 10 s in a fast-moving liquid.
(a) Calculate the bandwidth of the thermocouple frequency response.
(b) Find the range of frequencies for which the amplitude ratio of the uncompensated
thermocouple is flat within 15%.
(c) A lead/lag circuit with transfer function G(s) = (1 + 10s)/(1 + s) is used to compensate
for thermocouple dynamics. Calculate the range of frequencies for which the amplitude
ratio of the compensated system is flat within 15%.
(d)
The velocity of the liquid is reduced, causing the thermocouple time constant to
increase to 20 s. By sketching |G(jw)| explain why the effectiveness of the above
compensation is reduced.

## Page 21 [OCR]
Solution
The uncompensated thermocouple (a first-order system) has a time constant T = 10 s.
Assuming its static sensitivity K = 1, the original transfer function is:
1
Gu(s) = I + 10s
(a) Calculate the bandwidth of the thermocouple frequency response.
For a first-order system, the bandwidth is defined as the frequency at which the amplitude
ratio drops to 1/V 2 ~ 0.707 (i.e., the - 3dB cutoff frequency wc).
The formula is:
wc =
Substituting the given data:
1
wc=
= 0.1 rad/s
(b) Find the range of frequencies for which the amplitude ratio of the uncompensated
thermocouple is flat within 15%. |
A first-order low-pass system only attenuates high-frequency signals, so its maximum
amplitude ratio is 1. An error within 15% means the amplitude ratio |G. (jw)| must remain
greater than or equal to 0.95.
Setting up the inequality for the uncompensated system:
Gu(jw)| =
VI + (10)= =0.95
Solving for w:
1 + 100W= (6.95)3
~ 1.108
100w? ≤ 0.108 → w? ≤ 0.00108
w ≤ 0.0329 rad/s

## Page 22 [OCR]
Solution
(c) Calculate the range of frequencies for which the amplitude ratio of the compensated
system is flat within 15%.
When the lead/lag circuit with the transfer function Ge(s) = (1 + 10s)/(1 + s) is added, the
overall transfer function becomes the product of the two.
The term (1 + 10s) in the compensator's numerator perfectly cancels out the slow pole in the
sensor's denominator (a technique known as Zero-Pole Cancellation): |
Gamp (8) = Gu(8). G(8) = (1+105) (1110)
I+s
The entire system now behaves as a new first-order system with an improved time constant
Tnew = 1 s. Recalculating the 0.95 amplitude threshold:
1
Gcomp(iw)| =
VI+ (14)= ≥ 0.95
1 +w? ≤ 1.108 → w° ≤0.108
w ≤ 0.329 rad/s

## Page 23 [OCR]
Solution
1. Root Cause: "Pole-Zero Mismatch" Induced by Parameter Drift
• The Gap Between Theory and Reality: The original compensation design (the green
curve) relies heavily on a perfect mathematical cancellation (the circuit's zero precisely
negating the sensor's pole, assuming both have т = 10 s).
• Physical Condition Shift: When the fluid velocity decreases, the sensor's actual thermal
inertia increases (r becomes 20 s). The fixed, hard-coded circuit parameters cannot
adapt to this change, causing the mathematical cancellation to fail completely.
2. Visual Characteristics: "Mid-Frequency Dip" and Bandwidth Reduction
• The Dip: As illustrated by the red curve, the system encounters the actual, slower pole (
1/20 rad/s) prematurely, which initiates attenuation. Meanwhile, the compensator's zero
(1/10 rad/s) lags in providing the necessary amplification. This timing discrepancy
creates a massive "dip" (sag) in the mid-frequency range (0.05 ~ 0.3 rad/s).
• Breaking the Threshold: The red curve rapidly drops below the 0.95 dashed line (5%
error limit) at a very low frequency. This indicates that the system's high-accuracy flat
bandwidth is severely compressed, resulting in performance that is arguably worse than
the original, uncompensated baseline in that mid-frequency band.
3. Engineering Insight: The "Fragility" of Open-Loop Compensation
• While open-loop dynamic compensation (lead-lag network) is low-cost and yields
impressive theoretical results, it fundamentally lacks robustness.
• It demonstrates that relying solely on static circuit compensation is highly unreliable in
real-world industrial environments where external disturbances are common and plant
parameters are prone to fluctuation.
Thermocouple Frequency Response
Hover over the chart to inspect Amplitude Ratios at specific frequencies.
FREQUENCY (W) GI RATIO G2 RATIO
0.03 rad/s
0. 954
1.1
1.0
• • Uncompensated (G1)
- Ideally Comp. (G2)
- Mismatched (G3)
Ratio (G(jw)!
0.8
0.7
0.6
0.5
0.4
0.3
0.2
0.1
0.0
0.01
0.02 0.03|
0.10
0.20 0.30
Frannantu in leaniel
1.00
2.003.00
10.00

## Page 24 [OCR]
Exercise
An elastic force sensor has an effective seismic mass of 0.1 kg, a spring stiffness of
10 N m' and a damping constant of 14 Ns m'.
(a) Calculate the following quantities:
(1) sensor natural frequency
(ii) sensor damping ratio
(iii) transfer function relating displacement and force.
(b)
The above sensor is incorporated into a closed-loop, force balance accelerometer. The
following components are also present:
Potentiometer displacement sensor: sensitivity 1.0 V m
Amplifier: voltage input, current output, sensitivity 40 A V
Coil and magnet: current input, force output, sensitivity 25 N A-
Resistor: 250 S.
(i) Draw a block diagram of the accelerometer.
(ii) Calculate the overall accelerometer transfer function.
(iii) Explain why the dynamic performance of the accelerometer is superior to that of
the elastic sensor.
