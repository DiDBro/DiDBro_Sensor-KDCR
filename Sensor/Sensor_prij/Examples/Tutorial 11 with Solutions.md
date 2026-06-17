Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
2026
Tutorial Course for Intro to Sensor-
Integrated Systems
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
Exercise
Solution
Exercise
Solution
Solution
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
Exercise
Solution
Exercise
Solution
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
Exercise
Solution
Solution
Exercise
Solution
