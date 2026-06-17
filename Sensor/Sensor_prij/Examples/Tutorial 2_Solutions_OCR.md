# Tutorial 2_Solutions.pdf


## Page 1 [TEXT]
Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
March, 2026
Tutorial Course for Intro to Sensor-
Integrated Systems

## Page 2 [TEXT]
Basic Systematic Error
Three Major Assumptions of Ideal Elements:
➢Perfectly linear: A strictly proportional relationship between input and output.
➢Zero intercept: When the input is 0, the output is strictly 0 (i.e., 𝑎= 0).
➢No environmental inputs: Not affected by corrections or interference from the external environment (e.g., 
temperature, humidity).
Mathematical Expression: For a single element meeting the above conditions, the input-output equation is very simple:
𝑂𝑖= 𝐾𝑖𝐼𝑖
(Where 𝐾𝑖is the linear sensitivity/slope of the 𝑖element)
Derivation Process: Signals are passed like a relay race; the output of the previous element is the input for the next.
•Level 1 Output: 𝑂1 = 𝐾1𝐼
•Level 2 Output: 𝑂2 = 𝐾2𝑂1 = 𝐾2𝐾1𝐼
•Level 3 Output: 𝑂3 = 𝐾3𝑂2 = 𝐾3𝐾2𝐾1𝐼
Conclusion: For an entire measurement system containing 𝑛elements, the final system output 𝑂is:
Core Summary: The Total Sensitivity of a series system, 𝐾𝑠𝑦𝑠, is equal to the product of the individual element sensitivities
Error Definition: Measurement error 𝐸is defined as the difference between the measured value (final system output 𝑂) 
and the true value (initial system input 𝐼).

## Page 3 [OCR]
Exercise
A force measurement system consists of four elements with sensitivities 102, 5 × 102, 103
and 1.9. Find the system error for a true value input of 10 kN.
Krys = 0.95
E= (Ksys -1)xI
E = (0.95 - 1) × 10
E=-0.05 × 10
E = -0.5 kN
A level measurement system consists of three linear elements with sensitivities of 0.050, 21.5
and 0.99. Find the system error for a true value input of 5.0 metres.
Ksys = K1 × K2 x K3
Ksys = 1.06425
E = (Ksys - 1) × I
E = (1.06425
- 1) × 5.0 m
E = 0.06425 × 5.0 m
E = 0.32125 m

## Page 4 [TEXT]
Error Band Modeling and Propagation Analysis
1. Introduction: What is an "Error Band" (±𝒉)?
Engineering Reality: Sensor manufacturers usually only provide an "accuracy range" (e.g., ±1%). This means the actual 
output is restricted within a band-shaped region fluctuating above and below the ideal linear path, with a total width of 
2ℎ.
2. Core Transformation: Turning "Range" into "Variance"
➢Statistical Assumption: Assume the probability of the error falling at any point within ±ℎis equal; that is, it follows 
a rectangular distribution (uniform distribution).
➢An error band with width 2ℎis equivalent to an internal noise source within the system, with its own variance defined 
as:
3. Variance Propagation Rules for Series Systems
➢
In a series system, errors accumulate level by level like a rolling snowball and are amplified by the sensitivity (𝐾) of 
each element.
➢
Recursive Formula:
4. Key Points
➢The initial input of the system (the true physical quantity) usually has no random error, therefore 𝜎𝑖𝑛1
2
= 0.
➢The sensitivity 𝑲𝟏of the first-stage element will never amplify its own error! The output variance of the first 
stage is simply 
ℎ12
3 .

## Page 5 [OCR]
Exercise
pressure measurement system consists of a pressure sensor, deflection bridge, amplifier and
recorder. Table Prob. 2 gives the linear sensitivities and error bandwidths for each element in
the system.
(a) Calculate the standard deviation Of of the error distribution function.
(b) Given that the recorder is incorrectly adjusted so that its sensitivity is 225 Pa mV,
calculate the mean error E for an input pressure of 5 × 10° Pa.
Element
Linear sensitivity K
Error bandwidth ‡ h
Pressure sensor
Deflection bridge
Amplifier
Recorder
10- 2 Pa'
4 × 102 mV 2'
10mV mV-
250 Pa mV-'
‡0.005 S2
5x10-mv
10.5 mV
‡100 Pa

## Page 6 [OCR]
Exercise
(a)
0} = K} - (0) +
hi
3
Calculate the standard deviation Of of the error distribution function.
0.0052
25 × 10-6
01=
3
03 = K3• (01) +
= K? h}
03= (4X10 3)3 x 03 + (5x10 1)2
3
3
29 × 10-8
3
03 = Kg• (02) +
= Kg
2, hg
0.52
03= (103)2×03+
0.54
= 0.18
03 = 01= Ki• (03) +
+ hi
1002
0Ẻ = (250)? × 03+
- ~ 14583.33
b)
TE =V14583.33~120.76 Pa
Given that the recorder is incorrectly adjusted so that its sensitivity is 225 Pa mV!
calculate the mean error E for an input pressure of 5 × 10° Pa.
Kactual = K1 × K2 × K3 × K4
Õ = Katal × İ = 0.9 × (5 × 10º Pa) = 4500 Pa
Kactual = 4 × 10-3 × 225 = 0.9
E =0-I
E = 4500 Pa
- 5000 Pa = -500 Pa

## Page 7 [TEXT]
High-Gain Negative Feedback & Error Reduction
1. The Pain Point: Why are Open-Loop Systems "Fragile"?
In a series (open-loop) system, a parameter drift in any single element of the forward path (e.g., an amplifier affected by 
temperature, or a spring aging) will be directly amplified proportionally, leading to massive measurement errors. 
Searching for "perfect elements" is prohibitively expensive.
2. The Solution: Introducing a Negative Feedback Structure
Core Idea: Instead of blindly trusting the processing result, "pull back" the actual output and compare it with the 
intended input through subtraction. Use the resulting "error signal" to drive the system to self-correct.
3. Closed-Loop Transfer Function
The overall sensitivity of a closed-loop system is no longer a simple product of elements, but rather:
4. High-Gain Approximation (High-Gain Magic)
If we intentionally make the gain of the forward amplifier massive, such that the loop gain 𝐾𝑓𝑜𝑟𝑤𝑎𝑟𝑑∙𝐾𝑓𝑒𝑒𝑑𝑏𝑎𝑐𝑘≫1, the 
"1" in the denominator becomes negligible, and a wonderful simplification occurs:
5. Engineering Takeaway
The "Leverage" Effect: The overall accuracy of the system becomes completely decoupled from the forward path 
(which can now use cheap, drift-prone components) and depends solely on the stability of the single element in the 
feedback loop! This drastically improves the system's immunity to interference.

## Page 8 [OCR]
Exercise
Figure Prob. 3 shows a block diagram of a force transducer using negative feedback. The
elastic sensor gives a displacement output for a force input; the displacement sensor gives a
voltage output for a displacement input. Vs is the supply voltage for the displacement sensor.
(a) Calculate the output voltage Vo when
(1)
Vs=1.0V,F=50N
Vo ~ 4.9505 V
(II) Vs = 1.5 V, F = 50 N.
Vo4.9669 V
(b) Comment on the practical significance of the variation of the supply voltage Vs.
Input
force
Output
voltage
→ Vo
F
Balancing
force
10-4
Elastic
force sensor
103
Amplifier
→ 100 × Vs
Displacement
sensor
10
Coil and
magnet

## Page 9 [OCR]
Exercise
Figure Prob. 4 is a block diagram of a voltmeter. The motor produces a torque T proportional
to voltage V, and the output angular displacement O of the spring is proportional to T. The
stiffness K, of the spring can vary by ‡10% about the nominal value of 5 × 102 rad N-'m!.
Given that the following are available:
(i) a d.c. voltage amplifier of gain 1000
(11) a voltage subtraction unit
(iii) a stable angular displacement transducer of sensitivity 100 V rad',
(a) draw a block diagram of a modified system using these components, which reduces the
effect of changes in K;;
(b) calculate the effect of a 10% increase in K, on the sensitivity of the modified system.
•
Volts
K= 2 × 10-
NmV-
K, = 5 × 10-2
rad N°'m
Nm
rad
Motor
Spring
• Calculate the Final Sensitivity Variation Rate (Impact):
Variation Rate =
. 11010
- 1) × 100% = 11010
- × 100% ~ 0.009%

## Page 10 [TEXT]
Comprehensive Statistical Error Analysis for Non-Ideal Systems
1. Real-World Complexity
Real-world measurement systems are typically non-linear (including quadratic terms, exponential terms, etc.) and are simultaneously 
affected by cross-interference from multiple random variables (e.g., ambient temperature, fluid density, component tolerances).
2. The "Dual-Track" Algorithm
When solving problems, calculations for the mean value and the fluctuations (variance) must be kept strictly separate and treated as 
independent tracks:
Track 1: Calculating Mean Error ഥ𝑬(Systematic Bias)
✓Rule: Ignore fluctuations and plug in mean values. Take all nominal mean values provided in the problem and substitute them step-
by-step into the complex non-linear equations to calculate the final measured mean 𝑂.
✓Formula: System Error ത𝐸= ത𝑂−𝑇𝑟𝑢𝑒 𝐼𝑛𝑝𝑢𝑡 𝐼.
Track 2: Calculating Error Standard Deviation 𝝈𝑬(Random Fluctuation)
✓Rule: Partial derivatives act as weights for amplification. Use the Law of Error Propagation for multi-variable functions to calculate 
the accumulation of variance:
✓Critical Pitfall: The partial derivatives must be evaluated at the mean values derived in "Track 1"! After calculating the total 
variance, take the square root to find 𝜎𝐸.
3. Engineering Diagnosis & Optimization
✓ഥ𝑬is large →Modify the software algorithm. The inverse calculation formula in the microcontroller is inaccurate (e.g., truncation 
errors). Upgrade to a more precise polynomial inverse equation or use a lookup table.
✓𝝈𝑬is large →Increase dynamic compensation. Identify the term in the variance calculation with the largest value (usually 
environmental interference). Add auxiliary sensors (like thermometers or barometers) to the system to feed real-time environmental 
data into the microcontroller for active compensation/cancellation.

## Page 11 [OCR]
Exercise
easurement system consists of a chromel-alumel thermocouple (with cold junction com-
pensation), a millivolt-to-current converter and a recorder. Table Prob. 1 gives the model equa-
tions, and parameters for each element. Assuming that all probability distributions are normal,
calculate the mean and standard deviation of the error probability distribution, when the input
temperature is 117 °C.
Model equation
Mean values
Standard deviations Oc. = 6.93 × 102
Chromel-alumel S
e.m.f-to-current
Recorder
thermocouple
converter
E=Co+C,T+C,T? ¡=K,E+K„EAT,+K,AT,+a, IM=K,i+az
C, = 0.00
K, = 3.893
C, =4.017 × 10-2
AT.= -10
K2 = 6.25
ā, = 25.0
C, = 4.66 × 10-6
ā, = -3.864
Ky = 1.95 × 10-4
K, = 2.00 x10-3
Oa, = 0.14, OsT. = 10
OK. = OKM= OK,=0
Oa. = 0.30
Ок= = 0.0

## Page 12 [OCR]
Exercise
Calculating the Mean Measured Value and Mean System Error Esys
E = C+ CT +CT? = 4.76368 mV
i=KIE+КмЕАТ. + KıT, + ā1 = 14.6517 mA
Їм = Kzi + àz = 116.573 °C
Esys = T - T = 116.573 - 117 = -0.427 °C
Calculating Error Variance and Standard Deviation E.
03- (2) 03 - 0.004802 m7=
0E = VON = V3.7291 ~ 1.931°C

## Page 13 [OCR]
Exercise
A fluid velocity measurement system consists of a pitot tube, a differential pressure trans-
mitter, an 8-bit analogue-to-digital converter and a microcontroller with display facilities.
Table Prob. 6 gives the model equations and parameters for each element in the system. The
microcontroller calculates the measured value of velocity assuming a constant density.
(a) Estimate the mean and standard deviation of the error probability density function
assuming the true value of velocity v, is 14.0 m s'. Use the procedure of Table 3.1,
treating the rectangular distributions as normal with o = h/v3.
(b)
Explain briefly what modifications could be made to the system to reduce the quanti-
ties calculated in (a).
Pitot tube Differential
Analogue-to-
Microcontroller
pressure transmitter digital converter with display
Model equations AP=†p0} i= K,AP +a,
Mean values
p = 1.2
K, = 0.064
a, = 4.0
h, = 0.1
ha, = 0.04
n= Ki + az
K, = 12.80
ā, = 0.0
n rounded off
to nearest integer
has = 0.5
UN= K, \n - 51
K3 = 1.430
hx, = 0.0
Half-widths of
rectangular
distribution

## Page 14 [OCR]
(a)
Exercise
Estimate the mean and standard deviation of the error probability density function
assuming the true value of velocity vy is 14.0 m s'. Use the procedure of Table 3.1,
treating the rectangular distributions as normal with o = h/v3.
Part (a): Statistical Analysis
I. Mean Systematic Error E (Nominal Tracking)
1. Core Formulas (Substitute Mean Values):
• Pitot tube: AP = 0.5p0g = 117.6 Pa
• Transmitter: i = K1P + ă1 = 11.5264 mA
• ADC: n = Kzi + āz = 147.5379
• Microcontroller: 0 = K3vn - 51 = 14.050 m/s
2. Final Result:
E = VM - vr = 14.050 - 14.0 = +0.050 m/
II. Error Standard Deviation 0g (Variance Propagation)
1. Core Formulas (Partial Derivatives Squared):
• Pitot tube variance:
03p= (DAP)=(987 x0003333=32.0133Pa
• Transmitter variance:
• ADC variance:
• Microcontroller total variance: (Note: derivative evaluated at n)|
m= (on) -(0.0277) x 21.851=0.114 (10/33
2. Final Result:
. = V0.1147 ~ 0.339 m/s

## Page 15 [TEXT]
Exercise
Optimization Plan: Modify the microcontroller's software code.

## Page 16 [TEXT]
Exercise
Optimization Plan:
In real-world engineering, the density 𝜌of a fluid (like air or water) is never a constant. It fluctuates drastically
with the real-time temperature and absolute pressure inside the pipe. Hard-coding
ҧ𝜌as a constant 1.2 in the
system design is a severe flaw.
Add dynamic compensation hardware. We must install an additional temperature sensor and an absolute pressure
sensor into the pipeline. The real-time signals from these sensors should be fed into the microcontroller. Using the
ideal gas law (𝜌= 𝑃/𝑅𝑇), the microcontroller can compute the true, real-time density 𝜌on the fly and feed it into
the velocity formula. In the industry, this is known as "Temperature and Pressure Compensation" (or Dynamic
Compensation).

## Page 17 [OCR]
Exercise
A temperature measurement system consists of a thermistor, bridge and recorder. Table Prob. 7
gives the model equations, mean values and standard deviations for each element in the
system. Assuming all probability distributions are normal, calculate the mean and standard
deviation of the error probability density function for a true input temperature of 320 K
Thermistor
Bridge
Recorder
Model equations
Ro-Ki, exp (!)
Vo = Vs
1
- aL
3.3
Ro
Mean values
Standard deviations
K, = 5 × 10-1 kg
B=3×10° K
OK. =0.5×10-
OB =0
Vs = -3.00 V
à, = 0.77
Or, = 0.03
Oa, = 0.01
R2 = 50.0 K/V
a = 300 K
OK. = 0.0
Oa. = 3.0

## Page 18 [OCR]
Exercise
Part (a): Statistical Analysis
I. Mean Systematic Error E (Nominal Tracking)
1. Core Formulas (Substitute Mean Values):
• Thermistor: Ro = Kj exp (8) = 5.895 kn
• Bridge: Vo = Vs {1=33/F - 51} = 0.3867 V
• Recorder: Ôм = K2Vo + àz = 319.335 K
2. Final Result:
E = 0 - A = 319.335 - 320 = -0.665 K
II. Error Standard Deviation og (Variance Propagation)
1. Core Formulas (Partial Derivatives Squared):
• Thermistor variance:
2
Ơk, = 0.3475 (kS)=
• Bridge variance: (Note: This is the most error-prone derivative step)
R, = 0.00568 V2
2. Final Result:
• Recorder (Total System) variance:
03и = (Da) O+ (202))
Our = 23.2K°
0E=10= V23.2~4.82K
