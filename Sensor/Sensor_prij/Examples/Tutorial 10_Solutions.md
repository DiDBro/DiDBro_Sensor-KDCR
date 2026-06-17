Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
2026
Tutorial Course for Intro to Sensor-
Integrated Systems
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
Exercise
Solution
Exercise
Solution
Exercise
Solution
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
Exercise
Solution
Exercise
Solution
Solution
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
Exercise
Solution
