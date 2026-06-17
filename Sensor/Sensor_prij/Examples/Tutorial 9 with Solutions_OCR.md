# Tutorial 9 with Solutions.pdf


## Page 1 [TEXT]
Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
2026
Tutorial Course for Intro to Sensor-
Integrated Systems

## Page 2 [TEXT]
Measurement Error Basics
1. Quantitative Definitions of Errors
➢Absolute Error: Δ𝑥= 𝑥−𝑥0 (Measured Value - True Value)
➢Relative Error: 𝛾=
Δ𝑥
𝑥0 × 100% (Reflects measurement accuracy more objectively)
➢Referenced / Fiducial Error: 𝛾𝑛= Δ𝑥
𝑥𝐹.𝑆× 100% (Relative to the Full Scale 𝑥𝐹.𝑆; used to define instrument accuracy classes)
2. The Three Types of Errors & Countermeasures
➢Systematic Error:
•
Characteristics: Remains constant or changes according to a specific pattern.
•
Countermeasure: Cannot be eliminated by repeated measurements! Requires finding the root cause or introducing a "correction 
value" for compensation.
➢Random Error:
•
Characteristics: Unpredictable in magnitude and sign, but follows statistical laws (e.g., Normal Distribution) over multiple trials.
•
Countermeasure: Increase the number of measurements and calculate the average (mean).
➢Gross Error / Outlier:
•
Characteristics: Extreme data points that significantly distort the results (usually caused by human mistakes or sudden 
instrument faults).
•
Countermeasure: Identify and strictly eliminate using statistical criteria like the $3\sigma$ rule or Grubbs' test.

## Page 3 [TEXT]
Core Data Processing Methods
1. Statistical Description of Data
➢Arithmetic Mean: ҧ𝑥= 1
𝑛σ𝑖=1
𝑛
𝑥𝑖(The best estimate of the true value)
➢Residual Error: 𝑣𝑖= 𝑥𝑖−ҧ𝑥
➢Standard Deviation (Single Measurement): 𝜎≈𝑆=
σ 𝑣𝑖
2
𝑛−1 (Bessel's formula; evaluates the uncertainty or dispersion of data)
➢Weighted Average: Used when datasets have different precisions. The weight is inversely proportional to the variance: 𝑝𝑖= 1
𝜎𝑖
2.
2. How do Errors "Propagate"? (Indirect Measurement)
➢Given a functional relationship 𝑦= 𝑓𝑥1, 𝑥2 with independent variables.
➢Root-Sum-Square (RSS) Formula: 𝜎𝑦=
𝜕𝑓
𝜕𝑥1 𝜎𝑥1
2
+
𝜕𝑓
𝜕𝑥2 𝜎𝑥2
2
3. Method of Least Squares (Linear Regression)
➢Core Idea: Find the best-fit straight line 𝑦= 𝑎+ 𝑏𝑥.
➢Objective: Minimize the sum of the squared deviations of all measured points from the line: 𝑄= σ𝑖=1
𝑛
𝑦𝑖−𝑎+ 𝑏𝑥𝑖
2 = min.
➢Application: The ultimate tool for determining a sensor's static calibration, including its Sensitivity (slope b) and Zero Offset
(intercept a).

## Page 4 [OCR]
Exercise
Measurements of the speed of light were conducted, yielding four sets of results along with
their standard deviations as follows:
• Set 1: C, = 2.98000 x 108 m/s, 01 = 0.01000 x 108 m/s
• Set 2: Cz = 2.98500 x 10° m/s, 02 = 0.01000 x 108 m/s
• Set 3: C3 = 2.99990 × 108 m/s, 03 = 0.00200 × 108 m/s
• Set 4: Cx = 2.99930 × 108 m/s, 04 = 0.00100 × 108 m/s
Task: Calculate the weighted arithmetic mean (DD*X*#*J1E) of the speed of light and its
standard deviation (FE#).

## Page 5 [OCR]
Solution
Pi P2 Pi: PA=
1
1
052
1
=:-
0 5g
1
= = I:l:25:100
(2.98000 x1+2.98500 x1+ 2.99990 x 25 + 2.99930 x 100) x 108
= 2.99915 x108
m/s
1+1+ 25 + 100
O5, =
/Ix (2.98000- 2.99915)? +1x (2.98500- 2.99915)' +25 x (2.99990- 2.99915)' +100x (2.99930 - 2.99915)
(4 - 1)(1 + 1 + 25 +100)
=0.00127×10°m/s≤|

## Page 6 [OCR]
Exercise
A potentiometer circuit is used to measure an unknown electromotive force (EMF) signal, Ex.
The known parameters of the balanced circuit are:
• Branch currents: 11 = 4 mA, I2 = 2 mA
• Resistances: R1 = 552, Rz = 10S2, Rip = 10S2, and the active sliding portion rp = 552.
• The known constant systematic errors (absolute errors) of the resistors are:
AR1 = +0.0152, ARz = +0.019, Arp = +0.00552.
Assuming the errors of the galvanometer and the stable branch currents (11, I2) are negligible.
Calculate the true magnitude of Er after eliminating the systematic errors.
Tova
+
E=1v
0E.F

## Page 7 [OCR]
Re,
Toya
R.
E=1v
0E.F
Solution
I,(R, +rp)-1,R, =Ex
Ex= L,(R, tr.)-I,R, =4x(5+5)-2x10=20mv
OG SE, - DE: AR, + O : Ar, +!
E= A1, +
OR,
SE. NR, + OF: N,
= I,AR, + 1,Ar, + R,A7, + r, AT, - I,AR, - R,AI,
= 4×0.01+ 4×0.005 - 2×0.01= 0.04mv
Ex =20-0.04=19.96mv

## Page 8 [OCR]
Exercise
The current and voltage of a specific circuit are measured as I = 22.5 mA and U = 12.6 V.
Their corresponding standard deviations (uncertainties) are 01 = 0.5 mA and ou = 0.1 V.
respectively.
Task: Calculate the nominal consumed power P and its standard deviation o p.

## Page 9 [OCR]
Solution
The current and voltage of a specific circuit are measured as I = 22.5 mA and U = 12.6 V.
Their corresponding standard deviations (uncertainties) are 01 = 0.5 mA and ou = 0.1 V.
respectively.
Task: Calculate the nominal consumed power P and its standard deviation o p.
Po=UI=22.5×12.6=283.5mw
0=\U0}+10} =\12.6×0.5°+22.5×0.1=6.69mw

## Page 10 [OCR]
Exercise
When using an X-ray machine to inspect internal defects of magnesium alloy castings, the
penetrating voltage (y) should vary with the thickness of the inspected part (x) to achieve
optimal sensitivity. An experiment yielded the following dataset.
Task: Determine the best-fit empirical formula for the penetrating voltage (y) as a function of
thickness (x) using the Method of Least Squares.
X/m
m
12
13
14
15
16
18
20
22
24
26
Y/kv | 52. 0| 55. 0 58. O 61. O 65. 0 |70. 0 75. 0 80. O 85.0 91.0

## Page 11 [OCR]
Solution
Assuming the scatter plot indicates a linear relationship, we define the empirical formula as:
y= a + br
According to the Method of Least Squares, the optimal coefficients a and b must minimize the
sum of squared residual errors. This yields the following system of linear normal equations:
2. a[x:+6[x}=[xi·i
Given the number of data points n = 10, we calculate the sum components from the table:
• [x; = 12 + 13 + ... + 26 = 180
• Lyi = 52.0 + 55.0 + ... + 91.0 = 692
• [x} = 122 + 132 + ... + 262 = 3450
• Ґх:y: = (12 × 52) + (13 × 55) + ... + (26 × 91) = 13032
Substitute the summations into the normal equations:
1. 10a + 1806 = 692
b ~ 2.74
a ~ 19.88
2. 180a + 34506 = 13032
The best-fit empirical formula for the penetrating voltage is:
y = 19.88 + 2.74x

## Page 12 [TEXT]
Sensor Static Characteristics
1. Core Definitions (Key Indicators)
➢Sensitivity (𝑺): The ratio of the incremental output (Δ𝑦) to the incremental input (Δ𝑥), i.e., 𝑆= Δ𝑦/ Δ𝑥.
➢Linearity (Non-linearity): The maximum deviation of the actual calibration curve from a specified fitted straight line.
➢Hysteresis: The non-coincidence between the loading (increasing input) and unloading (decreasing input) output curves of a sensor.
➢Repeatability: The closeness of agreement among successive measurements of the same input, carried out in the same direction 
under identical conditions.
➢Drift: The variation in the sensor's output over time or due to environmental changes (e.g., temperature) while the input remains 
constant.
2. Quantifying Errors (Calculation Formulas)
➢Linearity Error: 𝛾𝐿= ±
Δ𝐿𝑚𝑎𝑥
𝑦𝐹.𝑆× 100\%
•
Δ𝐿𝑚𝑎𝑥: Maximum non-linear deviation; 𝑦𝐹.𝑆: Full-scale (F.S.) output.
➢Hysteresis Error: 𝛾𝐻= ±
Δ𝐻𝑚𝑎𝑥
𝑦𝐹.𝑆× 100\%
•
Δ𝐻𝑚𝑎𝑥: Maximum output difference between the loading and unloading curves.
➢Repeatability Error: 𝛾𝑅= ±
𝑘⋅𝜎
𝑦𝐹.𝑆× 100\%
•
𝜎: Standard deviation of the measurements; 𝑘: Confidence coefficient (usually 2 or 3, depending on the required confidence 
level).

## Page 13 [OCR]
Pressure (MPa)
0.00
0.02
0.04
0.06
0.08
0.10
Exercise
A pressure sensor was tested over three calibration cycles. The input pressure (z, in MPa) and
the corresponding output voltage (y, in mV) for both the loading (forward stroke) and
unloading (reverse stroke) processes are recorded in the table below.
Task: Calculate the Non-linearity Error, Hysteresis Error, and Repeatability Error of this
pressure sensor.
Raw Calibration Data:
Cycle 1 Loading
Cycle 1 Unloading
Cycle 2 Loading Cycle 2 Unloading
Cycle 3 Loading
-2.73
-2.71
-2.71
-2.68
-2.68
0.56
0.66
0.61
0.68
0.64
3.96
4.06
3.99
4.09
4.03
7.40
7.49
7.43
7.53
7.45
10.88
10.95
10.89
10.93
10.94
14.42
14.42
14.47
14.47
14.46
Cycle 3 Unloading
-2.69
0.69
4.11
7.52
10.99
14.46

## Page 14 [OCR]
Solution
First, we calculate the arithmetic mean for the loading (gt) and unloading (yu) outputs at each
pressure point across the 3 cycles. Then, we find the hysteresis difference (AH = JU - JI) |
and the overall average output (y = " til).
х (MPa)
Avg Loading JI
Avg Unloading Ju Hysteresis Diff. ДН
Overall Avg y
0.00
-2.706
-2.693
0.013
-2.70
0.02
0.603
0.677
0.074
0.64
0.04
3.993
4.087
0.093 (Max)
4.04
0.06
7.426
7.513
0.087
7.47
0.08
10.903
10.957
0.054
10.93
0.10
14.450
14.450
0.000
14.45
From the table, the maximum hysteresis difference is AH... ~ 0.093 mV.
Step 2: Least Squares Fitting & Non-Linearity Error
Using the Method of Least Squares on the overall average values (J), we fit the best straight line y = a + bx.
By solvina the normal equations (omittina intermediate steps), the fitted line is: 4 = 17150_2 77
• Theoretical Full-Scale (F.S.) Output: yE.s = y (0.10) - y(0.00) = 14.38 - (-2.77) = 17.15 mV

## Page 15 [OCR]
Solution
Next, we compare the overall average (Y) with the theoretical value from the fitted line (Y fitted)
to find the maximum deviation (AL).
• At x = 0.00 MPa: Y fitted = - 2.77 mV, deviation = | - 2.70 - (-2.77)| = 0.07 mV
• At x = 0.10 MPa: Yfitted = 14.38 mV, deviation = |14.45 - 14.38| = 0.07 mV
• The maximum non-linear deviation is ALmaz = 0.07 mV.
Non-linearity Error (YI):
VL = 1 Almas x 100% = = 17.15 × 100% = 10.41%
Step 3: Hysteresis Error Calculation
Using the maximum hysteresis difference from Step 1:
YH = 1Almaz × 100% = -17.15 × 100% = 10.54%
Step 4: Repeatability Error Calculation
We calculate the standard deviation (S) for each calibration point using Bessel's formula. By
calculating the variance for both loading and unloading data at each point, the maximum
standard deviation occurs at x = 0.02 MPa (Loading), where Omar ~ 0.0404 mV.
Assuming a confidence coefficient k = 3 (which corresponds to a 99.73% confidence level):
YR = 130maz × 100% = ‡3×0.0404 × 100% = 10.71%

## Page 16 [TEXT]
Sensor Dynamic Characteristics
1. Fundamental Concepts
➢Dynamic Characteristics: Refers to the response characteristics of a sensor's output when the input signal changes over time. 
➢Ideal Goal: The output should reproduce the changes in the input signal without distortion or delay. 
➢Physical Constraints: Due to system inertia (mass) and resistance (energy dissipation), the output often lags behind the input. 
2. First-Order Systems: Time Constant (𝝉)
➢Typical Application: Temperature sensors (e.g., thermocouples). 
➢Step Response: 𝑦𝑡= 𝑦∞1 −𝑒−𝑡/𝜏. 
➢Key Indicator: The time constant 𝜏determines response speed; a smaller 𝜏 means a faster sensor. 
➢Settling Time: After 1𝜏, the output reaches 63.2% of the steady-state value. 
3. Second-Order Systems: Damping and Frequency
➢Typical Application: Force sensors and piezoelectric accelerometers. 
➢Key Parameters:
•
Natural Frequency (𝝎𝒏): Determines the upper limit of the response speed. 
•
Damping Ratio (𝜻): Controls the oscillation and overshoot. 
➢Damping States:
•
Underdamped (𝜻< 𝟏): Fast response but includes oscillations (ringing). 
•
Overdamped (𝜻> 𝟏): Sluggish response with no oscillation. 
•
Engineering Optimum: Usually designed at 𝜻≈𝟎. 𝟕𝟎𝟕to balance speed and stability.

## Page 17 [OCR]
Exercise
When the temperature of the measured medium changes abruptly from 25°C to 300°C, the
temperature sensor (a typical first-order system) shows a response defined by a time constant
т = 120 s.
Task: Determine the dynamic error of the measurement after 350 s have elapsed.

## Page 18 [OCR]
Solution
When the temperature of the measured medium changes abruptly from 25°C to 300°C, the
temperature sensor (a typical first-order system) shows a response defined by a time constant
т = 120 s.
Task: Determine the dynamic error of the measurement after 350 s have elapsed.
NO) = 1-et = 1-e 130 = 0.945
4 = (300 - 25) × (1-0.945) = 14.88 °c

## Page 19 [OCR]
Exercise
A force sensor is modeled as a second-order system with a natural frequency fn = 800 Hz
and an initial damping ratio 5 = 0.14.
1. Calculate the amplitude ratio A(w) and the phase angle (w) when the sensor is used
to measure a sinusoidal force with a frequency f = 400 Hz.
2. If the damping ratio is adjusted to 5 = 0.7, determine the new values for A(w) and d(w).
Compare the results to evaluate the effect of damping.

## Page 20 [OCR]
Solution
Step 1: Identify key parameters and the frequency ratio
• Natural frequency: fn = 800 Hz
• Input signal frequency: f = 400 Hz
• Frequency ratio: n= - = 800 = 0.5
Step 2: Case 1 - Underdamped (S = 0.14)
Using the frequency response formulas for a second-order system:
• Amplitude Ratio A(w):
Step 3: Case 2 - Optimized Damping (5 = 0.7)
A(W) = V0.75 + 0.72 - V0.5625 + 0.19 = 0.975
0(4) = arctan (2X0.7 x 0.5) = - arctan (0.75) =-13.037
A(W) =
A(W) =
V0.752 + 0.142
• Phase Angle (w):
V(1-17)2 +(25n)2
V0.5625 + 0.0196 ~ 1.311
0(w) = - arctan
2-7)
du) =- arctan (2x0-1.50.5) = - arctan (0.75) =-10.57
