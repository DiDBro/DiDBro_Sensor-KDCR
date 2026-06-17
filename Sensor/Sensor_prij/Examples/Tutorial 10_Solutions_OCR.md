# Tutorial 10_Solutions.pdf


## Page 1 [TEXT]
Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
2026
Tutorial Course for Intro to Sensor-
Integrated Systems

## Page 2 [TEXT]
Mechanical Deformation and Electromechanical Conversion
1. Core Physical Effects (Theoretical Basis)
➢Hooke's Law: Force →causes mechanical deformation
➢Poisson Effect: Longitudinal stretching is inevitably accompanied by transverse contraction (The core for transverse strain gauge 
calculations)
➢Strain Effect: Metal wire stretches and becomes thinner →Resistance increases (+); compresses and becomes thicker →
Resistance decreases (−)
2. Core Formulas and Parameter Derivation
➢Normal Stress (Stress):
𝜎= 𝐹
𝐴
(Note: F is the axial force; tension is positive, compression is negative)
➢Longitudinal Strain:
𝜀𝐿= 𝜎
𝐸
(Note: E is Young's modulus, representing material stiffness)
➢Transverse Strain:
𝜀𝑇= −𝜈⋅𝜀𝐿
(Reminder of common mistake: 𝜈is Poisson's ratio, the negative sign in the formula must absolutely not be omitted!)
➢Electromechanical Conversion (Relative change rate of resistance):
Δ𝑅
𝑅= 𝐺⋅𝜀
(Note: G is the strain gauge sensitivity factor (gauge factor). Substitute 𝜀𝐿for longitudinal mounting, substitute 𝜀𝑇for transverse 
mounting)

## Page 3 [TEXT]
Measurement Circuits — DC Wheatstone Bridge
1. Core Circuit Principles
➢Purpose: The resistance change of a single strain gauge is extremely small, so a bridge circuit is required to convert it into a 
measurable voltage difference 𝑈𝑜.
➢Differential Principle: Adjacent bridge arms "one under tension, one under compression" →output voltages are superimposed and 
amplified.
•
Adjacent bridge arms change in the same direction under the influence of ambient temperature →output voltages cancel each 
other out (achieving temperature compensation).
2. Core Formulas and Engineering Characteristics (Assuming the initial resistance of all four arms is 𝑅, and the supply voltage is 𝑈𝑖)
①Quarter Bridge - Only 1 bridge arm is a strain gauge
•
Formula: 𝑈𝑜≈
1
4 ⋅
Δ𝑅
𝑅⋅𝑈𝑖
•
Characteristics: Sensitivity baseline, presence of non-linear error, no temperature compensation.
②Half Bridge (Differential) - 2 bridge arms are strain gauges (usually one tension and one compression connected to adjacent 
arms)
•
Formula: 𝑈𝑜≈1
2 ⋅Δ𝑅
𝑅⋅𝑈𝑖
•
Characteristics: Sensitivity is 2 times that of a quarter bridge, eliminates non-linear error, possesses self-temperature 
compensation.
③Full Bridge (Differential) - All 4 bridge arms are strain gauges
•
Formula: 𝑈𝑜≈Δ𝑅
𝑅⋅𝑈𝑖
•
Characteristics: Sensitivity is 4 times that of a quarter bridge, strongest anti-interference capability, the first choice for 
industrial applications!

## Page 4 [OCR]
Exercise
A DC strain gauge bridge circuit is shown in the figure. The bridge power supply is E = 4V.
The initial resistances of the four arms are equal: R1 = R2 = R3 = R4 = 120S2. When
subjected to strain, the absolute change in resistance for each active gauge is A R1 =
AR2 = AR3 = AR4 = 1.20.
Calculate the approximate output voltage (U, ~?) for the following four conditions:
1. Quarter Bridge: Only R1 is an active strain gauge, and the others are fixed resistors.
2. Half Bridge (Differential): Ry and R2 are active strain gauges experiencing opposite
strains (one tension, one compression), and they are connected in adjacent arms.
3. Half Bridge (Same Strain): R1 and R2 are active strain gauges experiencing the same
strain (both tension or both compression), and they are connected in adjacent arms.
4. Full Bridge: R1, R2, Rz, and Ry are all active strain gauges forming a differential full
bridge circuit.

## Page 5 [OCR]
Solution
General Approximation Formula: When AR « R, the output voltage U, can be
approximated as:
U. ~
ARI- ARz+ AR3 - ARL E
1. Quarter Bridge
• Only A R1 = 1.20 exists; others are O.
AR
1.2
•
Vo ~
-E =
× 4 = 0.01V = 10mV
4R
4 × 120
2. Half Bridge - Opposite Strains
• Ry and Rz are in adjacent arms. Tension gives + A R, compression gives - A R.
•
AR - (-AR) E=
2AR
2 × 1.2
-E=
- × 4 = 0.02V = 20mV
4R
3. Half Bridge - Same Strains
4R
4 × 120
• Both experience tension (+ A R) or both experience compression (- A R).
AR - AR
U.~
-E = 0V
4. Full Bridge
4R
• Four gauges, adjacent arms have opposite strains, opposite arms have same strains.
• Vo ~
AR- (-AR) + AR- (-AR)E =
1ARE =.
4 × 1.2
x 4 = 0.04V = 40mV
4R
4 × 120

## Page 6 [OCR]
Exercise
Description:
A load cell consists of a solid steel cylinder 5 cm in diameter and 5 cm long. An axial
compressive load of 10° N is applied to the cylinder.
Given the material properties of steel:
• Young's modulus (E) = 2 × 10" N/m?
(or Pa)
• Poisson's ratio (v) = 0.3
Find:
1. The longitudinal strain (EL)
2. The transverse strain (єт)

## Page 7 [OCR]
Solution
Step 1: Calculate the Cross-sectional Area (A)
The diameter of the cylinder is d = 5 cm = 0.05 m.
Step 3: Calculate the Longitudinal Strain (EL)
Using Hooke's Law:
A =
4
T. (0.05)?
4
A ~ 1.963 × 10-3 m?
Step 2: Calculate the Axial Stress (o)
Since the applied force F = 10° N is a compressive load, we denote it as negative (- 10° N).
F
0 = A
- 10°
1.963 x 10-3
0 ~ - 5.093 × 10° N/m? (Pa)
EL = E=
- 5.093 × 107
2 × 10-1
€1 ~ - 2.546 × 10 1 (or - 254.6 мє)
Step 4: Calculate the Transverse Strain (er)
Using Poisson's ratio:
ET = -V• EL = -0.3 × (-2.546 × 10-1)
єт ~ +7.639 × 10-5 (or + 76.4 є)

## Page 8 [OCR]
Exercise
Description:
8.17).
Two strain gauges are bonded to the solid steel cylinder from the previous problem (Problem
• Gauge 1 is parallel to the cylinder axis (longitudinal direction).
• Gauge 2 is at right angles to it (transverse direction).
The unstrained resistance of each gauge is R = 12012 and the gauge factor is G = 2.0.
Recall from Problem 8.17:
• Longitudinal strain: 61 = - 2.546 × 10-1
• Transverse strain: €т = +7.639 × 10-5
Find:
Calculate the change in resistance (AR) of each gauge.

## Page 9 [OCR]
Solution
General Formula:
The relationship between the change in resistance and the mechanical strain is given by:
AR
•=G•€ → AR=R•G•є
Step 1: Calculate the resistance change for Gauge 1 (Longitudinal)
Gauge 1 is attached parallel to the axis, so it experiences the longitudinal strain (eL).
AR1= R•G• EL
AR1 = 120 × 2.0 × (-2.546 × 10-*)
AR1~ -0.061152
Step 2: Calculate the resistance change for Gauge 2 (Transverse)
Gauge 2 is attached at a right angle to the axis, so it experiences the transverse strain (€T)
caused by the Poisson effect.
AR2=R•G•єr
A Rz = 120 × 2.0 × (+7.639 × 10-5)
AR 710018322

## Page 10 [TEXT]
Mechanical Analysis and Gauge Placement Strategy
1. Mechanical Characteristics of a Cantilever Beam
➢Force and Deformation: When a downward force F is applied to the free end of the cantilever beam, bending stress is generated 
inside.
•
Upper surface: Bulges outward →under tension (Tension, +𝜖) →strain gauge resistance increases (+Δ𝑅)
•
Lower surface: Curves inward →under compression (Compression, −𝜖) →strain gauge resistance decreases (−Δ𝑅)
➢Stress Distribution Law: The closer to the fixed end (root of the beam), the greater the bending strain. Therefore, strain gauges must 
be bonded close to the fixed end to obtain the maximum signal.
2. Bridge Wiring Golden Rules
➢Design Objective: To make the resistance changes of all active strain gauges superimpose in the same direction in the bridge output.
➢General Approximate Formula of the Bridge: 𝑈𝑜∝Δ𝑅1 −Δ𝑅2 + Δ𝑅3 −Δ𝑅4
➢Core Mnemonics:
•
"One tension, one compression, connect to adjacent bridge arms" (e.g., if 𝑅1 is connected to the upper surface tension gauge, 
𝑅2 must be connected to the lower surface compression gauge; minus and minus make plus, doubling the signal)
•
"Same tension / same compression, connect to opposite bridge arms" (e.g., 𝑅1 and 𝑅3 are opposite to each other, both 
connected to the upper surface tension gauges)

## Page 11 [TEXT]
Non-linear Error and Elimination
1. Non-linear Error of a Quarter Bridge
➢Exact Formula of a Quarter Bridge:
𝑈𝑜=
Δ𝑅
4𝑅+ 2Δ𝑅𝑈𝑖
➢Cause of Error: The denominator contains the independent variable 2Δ𝑅. When the external force increases and the strain becomes 
larger, the relationship between 𝑈𝑜and Δ𝑅is no longer perfectly linear, causing the output curve to bend.
➢Maximum Non-linear Error Percentage:
𝛾≈2Δ𝑅
4𝑅× 100% = Δ𝑅
2𝑅× 100%
2. Differential Elimination
➢Half Bridge Differential (One tension and one compression connected to adjacent arms):
𝑈𝑜=
𝑅+ Δ𝑅
𝑅+ Δ𝑅+ 𝑅−Δ𝑅−1
2 𝑈𝑖= Δ𝑅
2𝑅𝑈𝑖
➢Full Bridge Differential (Two tension and two compression cross-connected):
𝑈𝑜= Δ𝑅
𝑅𝑈𝑖
➢Core Conclusion and Engineering Significance:
•
After adopting the differential half bridge or full bridge, the variable Δ𝑅in the denominator is completely canceled out, and the 
denominator becomes a constant.
•
The non-linear error drops directly to 0%, achieving a perfectly linear output, while the measurement sensitivity is 
simultaneously increased by 2 to 4 times!

## Page 12 [OCR]
Exercise
Description:
It is proposed to design a force measurement system using a cantilever beam of uniform cross-
section. Four identical resistance strain gauges will be bonded to the beam to form a
differential full-bridge circuit.
Questions:
1. Gauge Placement: How should these four strain gauges be attached to the cantilever
beam? (Describe the placement and draw the schematic).
2. Circuit Wiring: How should they be connected in a Wheatstone bridge circuit to achieve
maximum sensitivity and temperature compensation? (Draw the circuit diagram).

## Page 13 [OCR]
Solution
Part 1: Gauge Placement Strategy
• Mechanical Analysis: When a downward force F is applied to the free end of the
cantilever beam, it bends.
• The upper surface undergoes tensile strain (Tension, † e).
• The lower surface undergoes compressive strain (Compression, - e).
• The bending moment is maximum near the fixed end (root) of the beam.
• Placement: To obtain the maximum signal, all four gauges should be placed near the
fixed end.
• Two gauges (R, and Rs) must be bonded to the top surface to measure tension.
• Two gauges (R2 and Ry) must be bonded to the bottom surface to measure
compression.
Part 2: Bridge Circuit Wiring
R, +
AR,
R,-
AR,

## Page 14 [OCR]
Exercise
Description:
A force measurement system uses a cantilever beam. A single strain gauge R1 is bonded to the
surface of the beam. The unstrained resistance of the gauge is R = 1202, and its gauge
factor is G = 2.0.
The gauge is connected to a quarter-bridge circuit (single active arm). The other three
arms are fixed resistors of 120S2. The bridge excitation voltage is Ui = 5V. When a load F is
applied, the strain gauge experiences a longitudinal strain of € = 1000p€ (1000 × 10-°).
Questions:
1. Calculate the exact output voltage (Uo) of this quarter-bridge circuit.
2. Calculate the non-linear error percentage of the measurement.
3. Explain how to modify the circuit design to reduce or eliminate this non-linear error.

## Page 15 [OCR]
Solution
Part 1: Calculate the Exact Output Voltage
• Relative resistance change:
AR
- = G• € = 2.0 x (1000 × 10-°) = 0.002
R
• Absolute resistance change:
AR = 0.002 × 1202 = 0.240
• Exact output equation for a quarter bridge:
R+AR
• Calculation:
0.24
Vo = 5V × (4 120) + 2(0.24))
0.24
) = 5x 480.48
) = 0.0024975V (2.4975mV)
Part 2: Calculate the Non-linear Error
• Ideal Linear Output (Approximation):
Valian) = V. (AR)
= 5V ×
0.24
480
= 0.0025 V (2.5mV)
• Non-linear Error Percentage (Y):
y = Voltinear) - Votezact) x 100%
Vollinear)
Alternatively, using the theoretical error formula:
AR
0.24
2R
× 100% = 240
× 100% = 0.1%

## Page 16 [OCR]
Solution
Part 3: How to Eliminate the Error (System Optimization)
• Solution: Upgrade the circuit from a quarter-bridge to a differential half-bridge or full-
bridge.
• Explanation: By bonding a second identical strain gauge on the opposite surface of the
beam (experiencing compressive strain, -€) and connecting it to the adjacent arm of the
bridge, the variable A R in the denominator is canceled out. This not only doubles the
sensitivity but also mathematically forces the non-linear error to 0%.

## Page 17 [TEXT]
Column-type Integrated Force Measurement System
1. Mechanical Strategy (Core Challenge & Breakthrough)
➢Force Dilemma: Heavy-duty load columns only withstand axial compression. Surface strain gauges can only detect compression 
signals, making it impossible to form a differential full bridge directly.
➢Engineering Breakthrough: Cleverly utilizing the Poisson Effect
•
Longitudinal Mounting: Parallel to the axis of the applied force, sensing axial compression →resistance decreases (−Δ𝑅)
•
Transverse Mounting: Perpendicular to the axis of the applied force, sensing transverse expansion (getting thicker) →obtains a 
natural tension signal (+Δ𝑅)
•
Conversion Core: Transverse strain 𝜖𝑇= −𝜈⋅𝜖𝐿(𝜈is the Poisson's ratio of the material, typically around 0.3 for steel)
2. Cross-Dimensional Differential Full Bridge Integration (Bridge Integration)
➢Wiring Principle: Adhering to the golden rule of "one tension, one compression, connect to adjacent bridge arms", the 
longitudinal gauges (compression) and transverse gauges (tension) are connected alternately into the bridge circuit.
➢Output Equation:
𝑈𝑜≈Δ𝑅𝑡𝑟𝑎𝑛𝑠−−Δ𝑅𝑙𝑜𝑛𝑔+ Δ𝑅𝑡𝑟𝑎𝑛𝑠−−Δ𝑅𝑙𝑜𝑛𝑔
4𝑅
𝑈𝑖= 2 1 + 𝜈Δ𝑅𝑙𝑜𝑛𝑔
4𝑅
𝑈𝑖
➢Engineering Value: Although the output is not exactly 4 times that of a quarter bridge due to Poisson's ratio (it is approximately 2.6 
times), it completely eliminates non-linear error and achieves perfect self-temperature compensation.
3. Signal Conditioning and System Closed-Loop (Signal Conditioning)
➢Industrial Pain Point: The bridge output 𝑈𝑜is extremely weak, typically only at the millivolt (mV) level. It is highly susceptible to 
noise submergence and cannot be identified by subsequent ADC stages.
➢Solution: Introduce an Instrumentation Amplifier with a high Common-Mode Rejection Ratio (CMRR) for cascade amplification.
➢Final System Output Formula:
𝑉𝑓𝑖𝑛𝑎𝑙= 𝐺𝑎𝑖𝑛𝐾× 𝑈𝑜

## Page 18 [OCR]
Exercise
Description:
A cylindrical load cell made of steel (E = 2 × 10'1 Pa, v = 0.3) has a cross-sectional area of
A = 2 × 10-3 m'. It is subjected to an axial compressive load of F = 200 kN (2 × 10° N).
Four identical strain gauges (Gauge factor G = 2.0, R = 12052) are bonded to the cylinder to
form a temperature-compensated differential full-bridge:
• Two gauges are placed longitudinally (parallel to the axis).
• Two gauges are placed transversely (perpendicular to the axis).
The bridge excitation voltage is U; = 10V.
Questions:
1. Calculate the longitudinal strain (EL) and transverse strain (ET).
2. Calculate the exact output voltage (U.) of this full-bridge circuit.
3. If the data acquisition system requires a final output voltage of Vfinal = 5V, what must
be the gain (K) of the instrumentation amplifier?

## Page 19 [OCR]
Solution
Part 1: Mechanical Strain Calculation
• Axial Stress (o):
-2 × 10° N
• = A =
2x10-3m? =-1 x 10° Pa
• Longitudinal Strain (EL) [Compression]:
-1 × 10°
EL =
E
= 2 × 1011
= -500 × 10-6 (-500рє)
• Transverse Strain (er) [Tension via Poisson effect]:
єт = -v • €L = -0.3 × (-500мє) = +150 × 10-° (+150мє)
Part 2: Bridge Output Voltage (U.)
• Relative Resistance Changes:
• Longitudinal gauges: f. = G - eL = 2.0 x (-0.0005) = -0.001
• Transverse gauges: ARI = G • €т = 2.0 × (+0.00015) = +0.0003
• Bride Equation: (Transverse and Longitudinal gauges are placed in adiacent arms)
- - (AR) + AR - (AR). _0.0026 10V = 0.0065V (6.5mV)
Vo=#
4
× 10V = 0.0065V (6.5mV)
Part 3: Amplifier Gain (K)
Vfinal = K.Vo = K=-
Viinal
K = 0.0065V ~ 769.2
