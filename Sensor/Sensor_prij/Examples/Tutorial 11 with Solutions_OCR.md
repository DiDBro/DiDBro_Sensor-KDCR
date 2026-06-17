# Tutorial 11 with Solutions.pdf


## Page 1 [TEXT]
Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
2026
Tutorial Course for Intro to Sensor-
Integrated Systems

## Page 2 [TEXT]
Core Principles and Physical Modeling of Inductive Sensors
Core Idea: Convert the measured physical quantity (such as displacement Δ𝛿) into a change in the reluctance (𝑅𝑚) of the 
magnetic circuit, which in turn causes a change in the coil inductance (𝐿).
1. Reluctance Formula:
𝑅𝑚= 𝑙
𝜇𝑆
(Note: The magnetic permeability of the air gap is extremely low, so the total reluctance is mainly determined by the air gap)
2. Inductance Definition Formula:
𝐿= 𝑊2
𝑅𝑚
3. Initial Inductance Formula for Variable Air-Gap Inductive Sensors:
𝐿0 = 𝜇0𝑆0𝑊2
2𝛿0
Symbols List
➢𝐿0: Initial inductance, unit: 𝐻(Henry) or 𝑚𝐻.
➢𝑊: Number of coil turns, dimensionless.
➢𝜇0: Vacuum permeability, constant 4𝜋× 10−7𝐻/𝑚.
➢𝑆0: Cross-sectional area of magnetic circuit/air gap, unit must be converted to: 𝑚2 (if given in 𝑐𝑚2 in the problem, 
multiply by 10−4).
➢𝛿0: Initial air gap length, unit must be converted to: 𝑚(if given in 𝑐𝑚or 𝑚𝑚in the problem, multiply by 10−2 or 
10−3).

## Page 3 [TEXT]
Single-ended vs. Differential Structure
Sensitivity
➢Definition: The amount of inductance change caused by a unit change in displacement.
➢Formula:
𝐾= Δ𝐿
Δ𝛿
Single-ended Structure
➢Characteristics: The armature movement changes the air gap on one side, resulting in non-linear errors in the output 
characteristics.
➢Approximate Sensitivity: Under micro-displacement, it is approximated as 𝐾𝑠𝑖𝑛𝑔𝑙𝑒≈
𝐿0
𝛿0.
Differential Structure
➢Principle: Two identical coils are used. When the armature moves, one air gap 
increases (𝛿0 + Δ𝛿) while the other air gap decreases by an equal amount (𝛿0 −
Δ𝛿).
➢Advantage 1 (Improved Linearity): The inductance change of the two coils 
subtracts from each other, canceling out the even-harmonic non-linear terms 
and significantly improving linearity.
➢Advantage 2 (Doubled Sensitivity): The inductance change of the differential 
output is Δ𝐿𝑑𝑖𝑓𝑓= 2𝐿0
Δ𝛿
𝛿0. This means the differential sensitivity is twice that 
of the single-ended structure (𝐾𝑑𝑖𝑓𝑓= 2𝐾𝑠𝑖𝑛𝑔𝑙𝑒).

## Page 4 [OCR]
Exercise
For a variable air-gap inductive sensor, the cross-sectional area of the iron core is S = 1.5 cm?.
, the
length of the magnetic circuit is L = 20 cm, the relative permeability is fly. = 5000, the initial air
gap is do = 0.5 cm, the change in the air gap is A = 10.1 mm, the permeability of free space is
40 = 1T × 10- H/m, and the number of coil turns is W = 3000.
Calculate the sensitivity AL / Ao of the single-ended sensor. If it is constructed as a differential
structure, how will its sensitivity change?

## Page 5 [OCR]
Solution
Step 1: Calculate the initial inductance (Lo)
First, convert the units to the standard SI system (1 cm? = 10-4 m?, 1 cm = 10-2 m):
Lo MASTE
200
4т × 10-7 × 1.5 × 10-4 × 30002
Lo =
2 × 0.5 × 10-2
Lo ~ 169.6 mH
Step 2: Calculate the inductance after the air gap changes (L)
Note that 48 = 10.1mm = =0.01 cm.
L =
HOSW2
28
4т × 10-7 × 1.5 × 10-4 × 30002
L =
2 × (0.5 ‡ 0.01) × 10-2
L = 169.6 - 3.5 mH
Therefore, the change in inductance AL = 3.5 mH.
Step 3: Calculate the sensitivity of the single-ended sensor (K)
K=AL
3.5 × 10-3
A5 =
• = 35 H/m
0.1 × 10-3
Step 4: Calculate the sensitivity for a differential structure
If connected in a differential structure, the sensitivity is doubled: diff = 2. 4б
AL = 2 × 35 = 70 H/m

## Page 6 [OCR]
Exercise
A variable reluctance sensor consists of a core, a variable air gap, and an armature. The core is a
steel rod of diameter 1 cm bent into a semi-circle of mean diameter 4 cm. A coil of 500 turns is
wound onto the core. The armature is a steel plate of thickness 0.5 cm. The relative permeability of
the steel is 100. Calculate the inductance of the sensor for air gaps of 1 mm and 3 mm.

## Page 7 [OCR]
Solution
Step 1: Identify and calculate the physical parameters of the magnetic circuit
Core (Steel rod):
• Area Ac = Jd = =x 001 m]' = 7.854 x 10-5 m?
Pathlengh/c==*x(004m) = 0.06283 m
Armature (Steel plate):
Assuming the effective width matches the core diameter (1 cm) to cover the poles, the
cross-sectional area is Ac = width × thickness = 0.01 m x 0.005 m = 5 x
10-5 m?
• Path length between poles la = 0.04 m
Air Gaps:
• There are two air gaps in series. For an air gap of x, the total gap length is lg = 2x.
• The effective area is the pole face area: Ag
= Ac = 7.854 × 10-5 m?
Step 2: Calculate the magnetic reluctance (Rm) of the iron parts
The general formula for magnetic reluctance is
Rm =
MOH, A
(where 40=4m × 10-'H/m).
0.06283
Core reluctance: Rmc =
4т × 10-7 × 100 x 7.854 × 10-5 = 6.366 × 10° H
• Armature reluctance:
0.04
Rma =
4T x 10-7 × x5 × 10-5 = 6.366 × 10° H 1
• Total iron reluctance:
Riron = Rmc + Rma = 12.732 × 10° H 1
Step 3: Calculate the inductance for an air gap of x = 1 mm
• Air gap reluctance (where x = 0.001 m and fly. = 1 for air):
2 × 0.001
Rng =
= 20.264 10H1
4T × 10-1 × 1 × 7.854 × 10-5
• Total reluctance:
Rtotal = Riron + Rmg = (12.732 + 20.264) × 10° = 32.996 × 10° H
• Inductance (L= Recal
-):
L = 32.996 × 106 ~ 0.00758 H = 7.58 mH

## Page 8 [OCR]
Solution
Step 4: Calculate the inductance for an air gap of x = 3 mm
Air gap reluctance (where x = 0.003 m):
2 × 0.003
ng = 4T X 10-1× 1 × 7.854 × 10-5 = 60.792 × 10° H 1
Total reluctance:
Rtotal = Riron + Rimg = (12.732 + 60.792) × 10° = 73.524 × 10° H-1
Inductance (L = Rectal):
500-
L =
73.524 × 106 ~ 0.00340 H = 3.40 mH

## Page 9 [TEXT]
Core Essentials of Capacitive Sensors
Basic Physical Modeling and Three Major Classifications:
➢Core Formula:
𝐶= 𝜀0𝜀𝑟𝐴
𝑑
➢Three Major Variant Types (Determined by the three elements in the formula):
•
Variable Distance Type (Variable 𝒅): The output is inversely proportional to the plate distance (non-linear). In 
engineering, a differential structure must be adopted to improve linearity.
•
Variable Area Type (Variable 𝑨): The output is strictly linear with the area, commonly used to measure larger linear 
or angular displacements.
•
Variable Dielectric Constant Type (Variable 𝜺𝒓): The output is strictly linear with the change in dielectric medium, a 
typical application is the capacitive liquid level gauge.
Classic Application Modeling: Cylindrical Capacitive Liquid Level Gauge
➢Modeling Idea: The liquid height is ℎ, which can be equivalent to a parallel combination of the liquid-segment 
capacitance and the air-segment capacitance.
➢Derivation Conclusion:
𝐶𝑡𝑜𝑡𝑎𝑙= 𝐶𝑙𝑖𝑞𝑢𝑖𝑑+ 𝐶𝑎𝑖𝑟= 𝐶0 + 𝐾⋅ℎ
•
This proves that the total capacitance change Δ𝐶has a strictly linear relationship with the liquid level height ℎ.

## Page 10 [OCR]
Exercise
A variable dielectric displacement sensor consists of two square metal plates of side 5 cm,
separated by a distance of 1 mm. A sheet of dielectric material of thickness 1 mm and the same
area as the plates can slide between them. Given that the relative permittivity of air is 1.0 and that of
the dielectric is 4.0, calculate the capacitance of the sensor for displacements x of 0.0, 2.5, and
5.0 cm.
• Plate length/width: w = 5 cm = 0.05 m
• Plate separation: d = 1 mm = 0.001 m
• Permittivity of free space: 60 = 8.85 × 10-12 F/m
→ x
i El
Relative permittivity of air: Er1 = 1.0
Relative permittivity of dielectric: E+2 = 4.0
• 1/
Variable dielectric

## Page 11 [OCR]
Solution
The basic formula for a flat parallel-plate capacitor is:
C= -
EDE, A
d
The total area of the plate is w × w. When the displacement is x, the area of the dielectric part is
Adielectric = W •x, and the area of the air part is Aair =w-(W-I).
Therefore, the total capacitance Ctotal is:
Cratal =C1+02=805r2(20-2z)
+ E0Erı(20 - (W - X))
Ctotal = Eow
d lEr22 + Er1 (W - 2)]
Ctotal =4.425 × 10-10. (3.0x +0.05)
• Case 1: When displacement x = 0.0 cm = 0.0 m (The space is entirely filled with air)
C=4.425 × 10-10. (3.0 × 0 + 0.05)
C = 4.425 × 10-10 × 0.05 = 2.2125 × 10-" F = 22.13 pF
• Case 2: When displacement x = 2.5 cm = 0.025 m (The space is exactly half air and half
dielectric)
C = 4.425 × 10-10. (3.0 × 0.025 + 0.05)
C = 5.53125 × 10-" F = 55.31 pF
• Case 3: When displacement x = 5.0 cm = 0.05 m (The space is entirely filled with the
dielectric sheet)
C=4.425 × 10-10. (3.0 x 0.05 + 0.05)
C = 8.85 × 10-1I F = 88.50 pF

## Page 12 [OCR]
Exercise
A parallel plate capacitive pressure sensor consists of two circular plates of diameter 2 cm
separated by an air gap of 1 mm. Given that the relative permittivity of air is 1.0 and the permittivity
of free space 80 = 8.85 pF /m, calculate the initial capacitance of the sensor.
• Diameter (D): 2 cm = 0.02 m
• Radius (r): = 1cm = 0.01 m
• Initial separation distance (d): 1 mm = 0.001 m = 1 × 10-3 m
• Permittivity of free space (Eo): 8.85 pF/m = 8.85 x 10-12 F/m
• Relative permittivity of air (Er): 1.0

## Page 13 [OCR]
Solution
The core governing formula for the capacitance of a flat parallel-plate capacitor is:
EDE, A
Co =
A=1p?=T × (0.01m)2=0.00017m'= t × 10-4m?
A ~ 3.1416 × 10-4 m?
(8.85 × 10-12 F/m) × 1.0 × (3.1416 × 10-4 m?)
Co =
1 × 10-3 m
Convert the final answer back to picofarads (pF), noting that 1 pF = 10-12 F:
Co ~ 2.78 pF

## Page 14 [TEXT]
Core Essentials of Strain Gauges
Core Conversion Chain and Physical Formulas
➢Physical Process: External Force →Structural Stress (𝜎) →Material Strain (𝜀) →Resistance Change (Δ𝑅/𝑅)
➢Mechanics Formula (Hooke's Law):
𝜀= 𝜎
𝐸
➢Electronics Formula (Strain Effect):
Δ𝑅
𝑅= 𝐾⋅𝜀
(Note: 𝐾is the sensitivity coefficient of the strain gauge, usually around 2.0)
➢Strain is extremely small. Problems often give microstrain (𝜇𝜀), which must be converted during calculation: 𝟏𝝁𝜺=
𝟏𝟎−𝟔. The standard unit for Young's modulus 𝐸and stress 𝜎is 𝑃𝑎or 𝑁/𝑚2.
DC Wheatstone Bridge
➢Purpose: To convert the extremely small resistance change (Δ𝑅) into a measurable voltage output (𝑈𝑜𝑢𝑡).
➢Comparison of Three Classic Bridge Configurations:
•
Quarter Bridge - 1 gauge:
𝑈𝑜𝑢𝑡≈1
4 𝑈𝑒𝑥𝐾𝜀
•
Half Bridge (Differential) - 2 gauges, one in tension and one in compression:
𝑈𝑜𝑢𝑡≈1
2 𝑈𝑒𝑥𝐾𝜀
•
Full Bridge (Differential) - 4 gauges, two in tension and two in compression:
𝑈𝑜𝑢𝑡= 𝑈𝑒𝑥𝐾𝜀

## Page 15 [OCR]
Exercise
Four strain gauges are bonded onto a cantilever as shown in Figure 8.20(a). Given that the
gauges are placed halfway along the cantilever and the cantilever is subject to a downward
force of 0.5 N, use the data given below to calculate the resistance of each strain gauge:
Cantilever data
Length
1 = 25 cm
Width
w= 6cm
Thickness
t = 3 mm
Young's modulus E = 70 × 10° Pa
Strain gauge data
Gauge factor
G = 2.1
Unstrained resistance Ro = 120 S2
te
F
(a)

## Page 16 [OCR]
Solution
Step 1: Calculate the bending moment (M) at the location of the strain gauges
The force Fis applied at the free end of the cantilever, and the strain gauges are placed halfway
along its length. Therefore, the distance (moment arm) from the applied force to the gauges is x =
• Force F = 0.5 N
• Distance x = 25cm = 12.5 cm = 0.125 m
M = F x x = 0.5 × 0.125 = 0.0625 Nm
Step 2: Calculate the second moment of area (J) of the cantilever cross-section
For a rectangular cross-section, the formula is I = "if , where w is the width and t is the thickness.
• Width w = 6 cm = 0.06 m
• Thicknesst = 3 mm = 0.003 m
0.06 × (0.003)3
0.06 × 2.7 × 10-8
[ =
= 1.35 × 10-10 m*
12
12
Step 3: Calculate the stress (o) at the surface of the cantilever
The stress at the surface (distance y = from the neutral axis) is given by the bending stress
formula o = My
• Distance to surface y = 0.003 m = 0.0015 m
0.0625 × 0.0015
0 = —
1.35 × 10-10 = 694,444.44 Pa

## Page 17 [OCR]
Solution
Step 4: Calculate the strain (E) experienced by the gauges
Using Hooke's Law (o = E • e), we can find the strain.
• Young's modulus E = 70 × 10° Pa
694444.44
€ = E = 70 × 10°
* ~ 9.92 × 10-6
Step 5: Calculate the change in resistance (A R) for each gauge
The relationship between strain and resistance change is given by the gauge factor G = AR/Ro.
• Gauge factor G = 2.1
• Unstrained resistance Ro = 120 2
AR = Ro•G•E
AR = 120 × 2.1 × (9.9206 × 10-°) = 0.0025 S
Step 6: Determine the final resistance of each strain gauge
When a downward force is applied to a cantilever, the top surface stretches (tension) and the
bottom surface compresses (compression).
• For the two gauges on the top surface (Tension), the resistance increases:
Ritop = Ro + AR = 120 + 0.0025 = 120.0025 S
• For the two gauges on the bottom surface (Compression), the resistance decreases:
Rbottom = Ro - AR = 120 - 0.0025 = 119.9975 S

## Page 18 [OCR]
Exercise
A strain gauge having an unstrained resistance of 120 S and a gauge factor of 2.1 is bonded
onto a steel girder so that it experiences a tensile stress of 10% Pa. If Young's modulus for steel
is 2 × 10"' Pa, calculate the strained resistance of the gauge.

## Page 19 [OCR]
Solution
Unstrained resistance (Ro) = 120 S2
• Gauge factor (G) = 2.1
• Tensile stress (o) = 10° Pa
Young's modulus for steel (E) = 2 × 10 Pa
Calculate the Strain (e)
€ =
E
108 Pa
€ = 2 x 1011 Pa
= 0.5 × 10-3 = 5 × 10-4
Calculate the Change in Resistance (AR)
AR = Ro•G• E
AR = 120 × 2.1 × (5 × 10-4)
AR = 252 × 0.0005 = 0.126 S
Calculate the Final Strained Resistance
Rstrained = Ro+ AR
Rstrained = 120 + 0.126 = 120.126 2
