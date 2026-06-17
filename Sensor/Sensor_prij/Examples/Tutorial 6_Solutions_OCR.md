# Tutorial 6_Solutions.pdf


## Page 1 [TEXT]
Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
2026
Tutorial Course for Intro to Sensor-
Integrated Systems

## Page 2 [TEXT]
Basic DC Bridge Analysis and Calibration
Core Concept: Why do we need a bridge?
➢Pain Point: The output of sensors (such as RTDs) is typically a minute change in resistance, which instruments 
cannot read directly.
➢Function: A Deflection Bridge is a conversion circuit responsible for accurately transforming "changes in resistance" 
into "measurable voltage differences."
Key Parameters and Symbol Definitions
➢𝑉𝑠(Supply Voltage): The reference voltage driving the system, determining the upper output limit and power 
consumption.
➢𝐸𝑇ℎ(Output Voltage): The Thévenin equivalent potential difference read at the measurement terminals.
➢𝑅1 or 𝑅𝑇: Active Bridge Arm (i.e., the sensor itself, whose resistance changes with temperature, etc.).
➢𝑅2, 𝑅3, 𝑅4: Fixed Bridge Arms (precision reference resistors selected by the engineer).
Three Core Formulas
➢Output Voltage Formula:
𝐸𝑇ℎ= 𝑉𝑠
𝑅1
𝑅1 + 𝑅4
−
𝑅2
𝑅2 + 𝑅3
➢Bridge Balance Condition:
When the required output 𝐸𝑇ℎ= 0, the cross-ratio equality must be met:
𝑅4
𝑅1
= 𝑅3
𝑅2
➢Temperature Characteristics of Metal Resistance (RTD (Resistance Temperature Detector) Sensor Formula):
𝑅𝑇= 𝑅0 1 + 𝛼𝑇
(Note: 𝑅0 is the reference resistance at 0°C, and 𝛼is the temperature coefficient)

## Page 3 [OCR]
Exercise
A deflection bridge has a supply voltage of 10 V. Find the bridge output voltage when:
(a) R, = 101S, R. = 99S, R; = 101S, R4= 99 S
(b) R, = 100.1 S, R, = 99.9 S2, Rz = 100.1 S2, R+= 99.9 S2.
12
ETh
D'
P
o Vs

## Page 4 [OCR]
Solution
(a)
101
Ern = 10x (101 + 99
99 + 101)
Ern= 10x (200
200)
Ern = 10x 200) = 10x0.01 = 0.1V
(b)
EIn= 10x1
100.1
,100.1 + 99.9
ETh = 10 x (100.1
200
99.9
99.9 + 100.1)
2009)
Ern = 10 x (202) = 10 × 0.001=0.01 V

## Page 5 [OCR]
Exercise
A platinum resistance sensor has a resistance of 100 S at 0 °C and a temperature coefficient
of resistance of 4 × 10-3 °C-l.
(a) The above sensor is incorporated into a bridge circuit which has R/R, = 100. Find the
value of R, such that Vour = 0 at 0 °C.
(b) Complete the bridge design by calculating the supply voltage required to give Vour =
100 mV at 100 °C.

## Page 6 [OCR]
Solution
Known Parameters:
• Initial resistance of the Platinum resistance sensor at 0°C: Ro = 100 S
• Temperature Coefficient of Resistance (TCR): a = 4 × 10-3 °C-1
(a) Find the value of Ry such that Vour = 0 at 0°C.
Solution:
At 0°C, the resistance of the sensor is Ry = Ro = 100 S.
The problem requires the output voltage Vour = 0 at this time, which means the bridge is in a
balanced state.
According to the balance condition of a deflection bridge (Textbook Formula [9.9]):
R3
Given the bridge arm ratio # = 100, substitute the known data into the formula:
= 100
100
R1 = 100 × 100 = 10,000 S

## Page 7 [TEXT]
Solution
(b) Complete the bridge design: Calculate the required supply voltage 𝑉𝑠to output 100 mV at 100°C.

## Page 8 [TEXT]
Engineering Design and Linearization of Sensor Bridges
1. Core Pain Point: The Gap Between Ideal and Reality
➢Ideal State: We hope for a perfectly proportional, linear relationship between the input (e.g., temperature) and the output voltage.
➢Reality: The voltage division characteristics of the bridge itself possess inherent nonlinearity; furthermore, some sensors (such as 
thermistors) exhibit severe exponential nonlinearity.
➢Engineering Goal: Without relying on software algorithms, use the clever configuration of hardware circuit parameters to "force" 
the output curve into a straight line.
2. Strategy One: Large Bridge Arm Ratio Method (For minute changes like RTD Platinum resistors)
➢Design Concept: Make the fixed bridge arm resistance much larger than the sensor resistance (i.e., bridge ratio 𝑟= 𝑅3/𝑅2 ≫1). 
Use a massive fixed base value to "dilute/mask" the fluctuations in the denominator.
➢Engineering Trade-off: Sacrifice system sensitivity (resulting in a smaller output voltage) in exchange for excellent linearity.
➢Engineering Approximation Formula:
𝑉𝑂𝑈𝑇≈𝑉𝑠
1
𝑟𝛼𝑇
3. Strategy Two: Three-Point Design Method (For severe nonlinearity like Thermistors)
➢Design Concept: Utilize the "upward curvature" of the bridge output curve to precisely cancel out the "downward curvature" caused 
by the exponential drop in thermistor resistance (𝑅𝜃∝𝑒1/𝑇).
➢Three-Step Practical Guide:
1. Lock in the Start Point, Midpoint, and End Point of the measurement temperature range.
2. Mandate that these three points output perfectly equidistant voltages (e.g., 0 𝑉, 0.5 𝑉, 1.0 𝑉).
3. Set up a system of equations for the three states to solve for the unique Bridge Ratio 𝒓(typically the optimal 𝑟value for 
thermistors is between 0.25 ∼0.30) and the Supply Voltage 𝑽𝒔.

## Page 9 [OCR]
Exercise
A platinum resistance sensor has a resistance of 100 2 at 0 °C and a temperature coefficient
of resistance of 4 × 10-3 °C-'. Given that a 15 V supply is available, design a deflection bridge
giving an output range of 0 to 100 mV for an input range of 0 to 100 °C:
(a) using the procedure summarised by eqns [9.7] and [9.8];
(b) using the linear approximation of eqn [9.15].
Give values for all circuit components and assume a high impedance load.
(c) How should the circuit be altered if the input range is changed to 50 to 150 °C?
[9.7]
1
[9.8]
[9.15]

## Page 10 [OCR]
Solution
Known Initial Parameters:
• Platinum resistor value at 0°C: Ro = 100 S2
• Temperature Coefficient of Resistance (TCR): a = 4 × 10-3 °C-1
• Supply Voltage: Vs = 15 V
• Input Temperature Range: 0°C to 100°C
• Target Output Voltage Range: 0 V to 100 mV (0.1 V)
First, calculate the sensor resistance values at the endpoints of the temperature range using
Rr = Ro(1+ aT):
• At TMIN = 0°C: RMIN = 100 2
At TMAx = 100°C: RMAx = 100(1 + 0.004 × 100) = 140 S
(a) Exact Design using Formulas [9.7] and [9.8]
Let the bridge arm ratio ber = Es
1. Based on Zero-Point Balance Condition (Output is OV at 0°C):
According to formula [9.7], the simplified balance equation [9.9] is:
RA =
B3=P→ Ry=r. RMIN = 100r
RMIN
2. Based on Full-Scale Condition (Output is 0.1V at 100°C):
Substitute into the general deflection bridge formula [9.8]:
1
0.1 = 15 |
1 + RA/RMAX
I+r)
Cross-multiply to obtain a quadratic equation:
p2+2.4r+1.4=60r → y2-57.6r+1.4=0
r= 57.6 + V57.62 - 4x1.4
~ 57.58
3. Calculate Specific Component Values:
• R4 = 100 × 57.58 = 5758 2
• Assuming R2 = 100 2
R3 = 5758 S2.

## Page 11 [OCR]
Solution
(b) Design using the Linear Approximation Method from Formula [9.15]
The linear approximation formula [9.15] in the textbook is built on the assumption that r » 1:
1. Determine r based on Full-Scale Requirements:
Substitute T = 100°C and Eth = 0.1 V:
0.1=15x= x= x x 100
0.1= = x0.4
r = 60

## Page 12 [OCR]
Solution
(c) How should the circuit change if the input range is changed to 50°C to 150°C?
We need to redefine the resistance range:
• New start point TIn = 50°C = RIN = 100(1 + 0.004 × 50) = 120 S
• New end point Imax = 150°C = Rmax = 100(1 + 0.004 × 150) = 160 2
The circuit requires two key modifications:
1. Change the Zero-Balance Resistor (R.4):
To output OV at 50°C (when sensor resistance is 120 2), the balance condition changes
to RA = r. RMIN = 120r.
2. Adjust the Bridge Arm Sensitivity Ratio (r):
Although the temperature span is still 100 degrees (and the resistance span is still 40 S2),
the relative change rate has changed. Therefore, r must be recalculated to ensure the
full scale remains 100 mV.
• Using Linear Approximation: Full-scale formula becomes ETh ~ V,#(AR)
0.1 = 15 × ÷ × 120 → 0.1 = } → r = 50
Corresponding R4 = 50 × 120 = 6000 S2.
• Using Exact Method: 0.1 = 15 (160+120г -I#) = 3p2 -
143r + 4 =
0 → r ~ 47.64
Corresponding R1 = 47.64 × 120 = 5717 S.

## Page 13 [OCR]
Exercise
The resistance R, & of a thermistor varies with temperature e K according to the following
equation:
Ro= 0.0585 exp 3260)
Design a deflection bridge, incorporating the thermistor, to the following specification:
Input range 0 to 50 °C
Output range 0 to 1.0 V
Relationship between output and input to be approximately linear.

## Page 14 [OCR]
Solution
Step 1: Calculate thermistor resistance at key temperature points
The known thermistor formula is: Ro = 0.0585 exp (2).
Convert Celsius to Kelvin (0 = T + 273) and calculate the resistance at 0°C, 25°C (midpoint),
and 50°C:
• Start Point (0°C = 273 K):
Rizt3 = 0.0585 exp 3260
273)
| = 0.0585 exp(11.9414) ~ 8979.2 S
• Midpoint (25°C = 298 K):
8208 = 0.0585 ex (3260)
298) = 0.0585 exp(10.9396) ~ 3297.35
• Endpoint (50°C = 323 K):
R323 = 0.0585 ex 3260
323)
| = 0.0585 exp(10.0929) ~ 1413.92

## Page 15 [OCR]
Solution
Step 2: Establish the system of equations for linearization conditions
The output voltage formula for a deflection bridge is:
Let the bridge arm fixed resistance ratio be r = R3/ Rz. We mandate that the output voltage
satisfies an absolute linear relationship:
1. At 0°C (273 K), output is 0 V (Zeroing condition):
2. At 25°C (298 K), output is 0.5 V (Forced linearity):
0.5 - V E
3. At 50°C (323 K), output is 1.0 V (Full-scale condition):
10=V (171

## Page 16 [OCR]
Solution
Step 3: Solve for the bridge ratio r
To simplify the calculation, first calculate the resistance ratio coefficients:
• а = 12т8 = 3297.3 ~ 2.7232
• b = 1323 =
979.2 ~ 6.3507
1413.9
Divide the 1.OV equation by the 0.5V equation to eliminate Vs:
1
1.0
05 = 2 = 1b IF
4.2456r = 1.1051 = r ~ 0.2603
Itar - I+r
Step 4: Calculate remaining component parameters
1. Calculate Zeroing Resistor R4:
R1 = r. R273 = 0.2603 × 8979.2 0 ~ 2337 S2
2. Calculate Supply Voltage Vs:
Substitute r = 0.2603 and coefficient b into the 1.0 V equation:
1.0 = Vs (I + 6.3507 × 0.2603
1 + 0.2603)
1.0 = -0.4166 • Vs = Vs~ -2.40 V
3. Determine R and Rs:
The ratio is fixed at R3/ Rz = 0.2603. To limit current and power consumption, reference
resistors of a reasonable order of magnitude can be freely chosen. For example:
• Rz = 10 kg (10,000 S)|
• R = 2.6 kR (2603 S)

## Page 17 [TEXT]
System-Level Integration and Signal Amplification 
1. Core Pain Point: Why is a bridge alone not enough?
➢Reality Bottleneck: The bridge output (𝐸𝑇ℎ) derived in the previous sections is typically extremely weak, often only a few millivolts 
(mV) or even microvolts (𝜇 𝑉).
➢Industrial Requirement: Backend microcontrollers, ADCs, or PLCs usually require standard voltage signals of 1.0 V to 5.0 V. The 
gap between the two is by a factor of hundreds!
➢The Solution: An Amplifier must be cascaded at the backend of the bridge.
2. Core Weapon: Ideal Operational Amplifier (Op-Amp)
The cornerstone of modern signal conditioning. Always remember its two "magic tricks" (ideal assumptions) when solving problems:
➢"Virtual Open" (𝒊+ = 𝒊−= 𝟎): The input impedance of the op-amp is infinite. This means it will never "steal" any current from 
the bridge, perfectly ensuring that the bridge formulas we learned earlier remain valid!
➢"Virtual Short" (𝑽+ = 𝑽−): Under negative feedback, the potentials at the two input terminals of the op-amp are always forced to 
be equal.
3. System Integration: Bridge + Amplifier = Ultimate Formula
When a Four-Arm Active Bridge is connected to a Differential Amplifier, the final integrated output formula is:
𝑉𝑂𝑈𝑇= 2 𝑅𝐹
𝑅0
𝑉𝑆𝐺𝑒
• 𝑉𝑂𝑈𝑇: Final standard output voltage (e.g., 1.0 V)
• 𝑅𝐹: Feedback resistor of the op-amp (The only component engineers need to calculate and select!)
• 𝑅0: Initial reference resistance of the sensor (e.g., 120 Ω)
• 𝑉𝑆: Bridge supply voltage (e.g., 15 V)
• 𝐺: Sensitivity coefficient of the sensor (Gauge Factor)
• 𝑒: Minute physical variable (e.g., mechanical Strain)

## Page 18 [OCR]
Exercise
A strain in the range 0 to 10- is to be measured using a four-strain-gauge bridge connected
to a differential amplifier (Figure 9.11). The strain gauges have resistance 120 S2 and gauge
factor 2.1, and the supply voltage is 15 V. Find the value of the amplifier feedback resistance
if the output signal range is 0 to 1.0 V.
igure 9.11 Strain gaugd
ridge connected to
differential amplifier.
AOL
→ 0

## Page 19 [OCR]
Solution
Known Parameters:
• Upper limit of strain measurement range: e = 10-3 (i.e., 1000 pe)
• Resistance of strain gauge with no strain: Ro = 120 2
• Sensitivity coefficient (Gauge factor): G = 2.1
• Bridge supply voltage: Vs = 15 V
• Target full-scale output voltage: Vour = 1.0 V
1. Bridge Output: In a full-bridge configuration (one pair of opposite arms in tension, the
other pair in compression), the bridge's own differential output voltage (V½
- VI) is
VsGe.
2. Bridge Equivalent Internal Resistance: Looking in from the output terminals, the
Thévenin equivalent resistance of the bridge is RIN ~ Ro/2.
3. Differential Amplifier Gain: The closed-loop gain is Rp/ RIv-
VoUT = 2-
BE VsGe
The problem requires us to find the feedback resistor Rp for a given strain e and a specific
output voltage Vour. Rearranging the formula:
VouT • Ro
RE = 2. Vs. G. e
Substitute all known values into the formula:
1.0 × 120
BF = 2 x 15 x 2.1 x 10-3
RE ~ 1904.76 22
