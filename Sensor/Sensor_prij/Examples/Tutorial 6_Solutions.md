Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
2026
Tutorial Course for Intro to Sensor-
Integrated Systems
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
Exercise
Solution
= 0.1 V
(𝑎)
(𝑏)
= 0.01 V
Exercise
Solution
Solution
(b) Complete the bridge design: Calculate the required supply voltage 𝑉𝑠to output 100 mV at 100°C.
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
Exercise
Solution
Solution
Solution
Exercise
Solution
Solution
Solution
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
Exercise
Solution
