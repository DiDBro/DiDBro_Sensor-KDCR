Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
2026
Tutorial Course for Intro to Sensor-
Integrated Systems
Reliability Assessment
➢Reliability 𝑅𝑡: The probability that a system operates normally and achieves the specified performance within a 
defined environment and time frame.
➢Unreliability 𝐹𝑡: The probability that the system fails to achieve the specified performance under the 
aforementioned conditions.
➢Golden Rule: Equipment is either good or bad, therefore 𝑅𝑡+ 𝐹𝑡= 1
To measure equipment quality, we need to focus on three core time periods:
➢MTTF (Mean Time To Failure): For non-repairable components, this calculates the "average lifespan."
➢MDT (Mean Down Time): For repairable components, this calculates "how long each repair takes on average.“
➢MDT = Total Down Time / Number of Failures
➢MTBF (Mean Time Between Failures): For repairable components, this calculates "how long it can be used 
between two failures.“
MTBF = Total Up Time / Number of Failures
Based on the times above, we derive two ultimate metrics to measure the system:
➢Mean Failure Rate ( ҧ𝜆): The frequency of damage per unit of time.
Formula: ҧ𝜆= 1/𝑀𝑇𝐵𝐹
➢Availability (𝐴): The probability that the system "doesn't drop the ball" (fails) at critical moments (the proportion of 
uptime).
Formula: 𝐴=
𝑀𝑇𝐵𝐹
𝑀𝑇𝐵𝐹+𝑀𝐷𝑇
Exercise
Solution
System Architecture Reliability Assessment
Constant Failure Rate Model
For components in their normal useful life period, the failure rate 𝜆is constant.
➢Reliability Exponential Decay Formula: 𝑅𝑡= 𝑒−𝜆𝑡
➢Unreliability: 𝐹𝑡= 1 −𝑒−𝜆𝑡
Series Systems
➢Logic: All components must work normally at the same time for the system to operate.
➢Calculation Rules:
•
Multiplication of Reliability: 𝑅𝑆𝑌𝑆𝑇= 𝑅1 × 𝑅2 × ⋯× 𝑅𝑛
•
Addition of Failure Rates (Most Common): 𝜆𝑆𝑌𝑆𝑇= 𝜆1 + 𝜆2 + ⋯+ 𝜆𝑛
➢Best Practice Guide: The more components in series, the higher the total failure rate! Design should follow the 
principle: "Do not multiply entities beyond necessity."
Parallel Systems
➢Logic: The system can operate as long as at least one component is working normally (it only fails if everything fails).
➢Calculation Rules: Convert to calculating "Unreliability 𝑭".
•
Multiplication of Unreliability: 𝐹𝑆𝑌𝑆𝑇= 𝐹1 × 𝐹2 × ⋯× 𝐹𝑛
•
Shortcut for Identical Components: 𝐹𝑆𝑌𝑆𝑇= 𝐹𝑛
➢Best Practice Guide: Parallelism is a "heavy hitter" for improving reliability (probabilities get smaller as they are 
multiplied), but the trade-off is doubled costs.
Exercise
A more cost-effective mixed redundancy system is now designed: three thermocouples are used in parallel (output via a 
median selector), which are then connected in series with one converter and one recorder. Find the total reliability 
(𝑅𝑂𝑉𝐸𝑅𝐴𝐿𝐿) and unreliability (𝐹𝑂𝑉𝐸𝑅𝐴𝐿𝐿) of this mixed system at 𝑡= 0.5 years.
Solution
1. Calculate the equivalent unreliability and reliability of the parallel thermocouple section:
The unreliability of a single thermocouple (𝜆1 = 1.1) at 𝑡= 0.5 is 1 −𝑒−1.1×0.5 = 1 −𝑒−0.55.
The unreliability after connecting three in parallel is 𝐹1 = 1 −𝑒−0.55 3 = 0.076.
The equivalent reliability is 𝑅1 = 1 −0.076 = 0.924.
2. Calculate the reliability of the remaining series components (converter, recorder, etc., assuming 𝝀= 𝟎. 𝟏):
𝑅2 = 𝑅3 = 𝑅4 = 𝑒−0.1×0.5 = 𝑒−0.05 = 0.951.
3. Calculate the overall system reliability:
The entire system can be viewed as a series connection of these equivalent modules:
𝑅𝑂𝑉𝐸𝑅𝐴𝐿𝐿= 𝑅1𝑅2𝑅3𝑅4 = 0.924 × 0.951 3 = 0.795
The total unreliability 𝐹𝑂𝑉𝐸𝑅𝐴𝐿𝐿= 1 −0.795 = 0.205.
Exercise
Solution
Based on the information provided, we first list the annual failure rates (𝜆, unit: failures/year) and the operating time (𝑡, unit: 
years) for each component:
In a constant failure rate model, a component's reliability is 𝑅𝑡= 𝑒−𝜆𝑡, and the probability of failure (unreliability) is 
𝐹𝑡= 1 −𝑒−𝜆𝑡.
Solution
Solution
The TLOC Assessment Method
Total Life Cycle Operating Cost (TLOC)
For any given application, the best system is the one with the minimum TLOC.
𝑇𝐿𝑂𝐶= 𝐼𝑛𝑖𝑡𝑖𝑎𝑙𝑃𝑢𝑟𝑐ℎ𝑎𝑠𝑒𝐶𝑜𝑠𝑡+ 𝑇𝑜𝑡𝑎𝑙𝐹𝑎𝑖𝑙𝑢𝑟𝑒𝑀𝑎𝑖𝑛𝑡𝑒𝑛𝑎𝑛𝑐𝑒𝐶𝑜𝑠𝑡+ 𝑇𝑜𝑡𝑎𝑙𝑀𝑒𝑎𝑠𝑢𝑟𝑒𝑚𝑒𝑛𝑡𝐸𝑟𝑟𝑜𝑟𝐶𝑜𝑠𝑡
Process Downtime Loss (𝑪𝑷)
➢Formula Analysis: Cost of a Single Failure = Spare Parts/Labor + 𝐶𝑃× 𝑅𝑒𝑝𝑎𝑖𝑟𝑇𝑖𝑚𝑒
➢The loss caused by a factory shutdown due to equipment failure is often hundreds or thousands of times the 
cost of a spare part! "Repairing quickly" and "not breaking easily" are extremely valuable.
Measurement Error Penalty Cost (𝑪𝑬)
➢The equipment may not be broken, but it may be inaccurate (e.g., mixing ratios out of balance in a chemical 
plant, or low flow in an oil pipeline). The hidden losses saved by high-precision equipment often lead to a 
rapid return on investment.
Exercise
Solution
Based on the conditions provided in the problem:
1. Breakdown maintenance only: This means there are no periodic preventive maintenance costs.
2. Identical measurement errors: This means the potential financial losses caused by measurement errors for both systems 
are the same and can be ignored during the comparison.
3. Total Lifespan (𝑻): 10 years.
Therefore, the TLOC formula for comparing the two systems can be simplified to:
𝑇𝐿𝑂𝐶= 𝐼𝑛𝑖𝑡𝑖𝑎𝑙𝐶𝑜𝑠𝑡+ 𝑇𝑜𝑡𝑎𝑙𝐹𝑎𝑖𝑙𝑢𝑟𝑒𝑀𝑎𝑖𝑛𝑡𝑒𝑛𝑎𝑛𝑐𝑒𝐶𝑜𝑠𝑡𝑜𝑣𝑒𝑟𝐿𝑖𝑓𝑒𝑠𝑝𝑎𝑛
Where:
➢Total failures over lifespan = Annual failure rate (𝜆) × Total lifespan (𝑇)
➢Cost per failure = Material cost (𝐶𝑅) + [Labor cost (𝐶𝐿) + Process cost (𝐶𝑃)] × Repair time (𝑇𝑅)
Thus, the simplified formula is:
𝑇𝐿𝑂𝐶= 𝐶1 + 𝐶𝑅+ 𝐶𝐿+ 𝐶𝑃× 𝑇𝑅× 𝜆× 𝑇
System 1
➢Initial Cost (𝑪𝟏): £1000
➢Cost per failure:
£20 +
£10 + £100 × 8 ℎ= 20 + 110 × 8 = £900
➢Total failures over 10 years:
2.0𝑓𝑎𝑖𝑙𝑢𝑟𝑒𝑠/𝑦𝑒𝑎𝑟× 10 𝑦𝑒𝑎𝑟𝑠= 20 𝑓𝑎𝑖𝑙𝑢𝑟𝑒𝑠
➢Total maintenance cost over lifespan:
£900 × 20 = £18,000
➢TLOC of System 1:
𝑇𝐿𝑂𝐶1 = 1000 + 18000 = £19,000
System 2
➢Initial Cost (𝑪𝟏): £2000
➢Cost per failure:
£15 +
£10 + £100 × 12 ℎ= 15 + 110 × 12 = £1,335
➢Total failures over 10 years:
1.0 𝑓𝑎𝑖𝑙𝑢𝑟𝑒𝑠/𝑦𝑒𝑎𝑟× 10 𝑦𝑒𝑎𝑟𝑠= 10 𝑓𝑎𝑖𝑙𝑢𝑟𝑒𝑠
➢Total maintenance cost over lifespan:
£1,335 × 10 = £13,350
➢TLOC of System 2:
𝑇𝐿𝑂𝐶2 = 2000 + 13350 = £15,350
Capacitive Sensing Components
1. Core Physical Model and Formula
➢Fundamental Formula: 𝐶=
𝜀0𝜀𝑟𝐴
𝑑
Capacitance 𝐶depends on: vacuum permittivity 𝜀0, relative permittivity 𝜀𝑟, plate overlap area 𝐴, and plate separation 
distance 𝑑
➢Three Main Types: Variable distance type (change 𝑑), variable area type (change 𝐴), and variable dielectric 
constant type (change 𝜺𝒓).
2. Key Focus: Variable Dielectric Constant Sensor
➢Equivalent Circuit Principle: When a dielectric plate is inserted or pulled from between the plates, the sensor is 
equivalent to two capacitors in parallel (Air section + Dielectric section).
➢Total Capacitance Formula:
𝐶𝑡𝑜𝑡𝑎𝑙= 𝐶𝑎𝑖𝑟+ 𝐶𝑑𝑖𝑒𝑙𝑒𝑐𝑡𝑟𝑖𝑐
𝐶𝑡𝑜𝑡𝑎𝑙= 𝜀0𝑤
𝑑
𝜀1𝑥+ 𝜀2 𝑙−𝑥
➢Measurement Characteristic: There is a perfectly linear relationship between capacitance 𝐶and displacement 𝑥.
Exercise
Solution
Solution
Variable Reluctance Sensing Components
1. Core Physical Model and Formulas
➢Ohm's Law for Magnetic Circuits: 𝑚. 𝑚. 𝑓. = 𝜙× 𝑅 (Magnetomotive force = Magnetic flux × Reluctance)
➢Relationship between Inductance and Reluctance: 𝐿=
𝑛2
𝑅𝑡𝑜𝑡𝑎𝑙​ (Inductance L is inversely proportional to total 
reluctance)
➢Reluctance Calculation Formula: 𝑅=
𝑙
𝜇𝜇0𝐴 (Reluctance depends on path length l, area A, and material magnetic 
permeability μ)
2. Key Focus: Variable Reluctance Displacement Sensor
➢Series Composition of Total Reluctance:
𝑅𝑡𝑜𝑡𝑎𝑙= 𝑅𝑐𝑜𝑟𝑒𝐼𝑟𝑜𝑛𝐶𝑜𝑟𝑒+ 𝑅𝑎𝑟𝑚𝑎𝑡𝑢𝑟𝑒𝐴𝑟𝑚𝑎𝑡𝑢𝑟𝑒+ 𝑅𝑔𝑎𝑝𝐴𝑖𝑟𝐺𝑎𝑝
➢Core Characteristics (Highly Non-linear):
• For ferromagnetic materials, 𝜇≈100 ∼1000, while for air, 𝜇≈1.
• Conclusion: Even if the air gap (𝑑) is only 1​𝑚𝑚, its reluctance may be far greater than that of a thick iron 
core!
• A tiny increase in displacement 𝑑will cause the total reluctance to rise sharply, leading to a non-linear 
plunge in inductance 𝐿.
Exercise
Solution
Solution
Solution
Active Electrical Sensing Elements
1. Core Concept: What does "Active" mean?
➢Self-generating Mechanism: Does not require an external power supply; it extracts energy directly from the measured 
object or system (such as mechanical kinetic energy).
➢Energy Conversion: Directly converts physical motion into an AC electrical signal output.
2. Operating Principle: Faraday's Law of Induction
➢Fundamental Formula: 𝐸= −
𝑑𝑁
𝑑𝑡
(The induced electromotive force is equal to the negative rate of change of the magnetic flux linkage)
➢Physical Process: Rotation of a ferromagnetic gear →Periodic change in the air-gap magnetic flux between the teeth 
and magnetic poles →Fluctuations in the magnetic flux linkage 𝑁within the coil →Generation of AC voltage 𝐸.
3. Mathematical Model and Core Conclusions
➢Magnetic Flux Equation: The flux linkage varies approximately sinusoidally with the angular displacement 𝜃:
𝑁𝜃≈𝑎+ 𝑏​cos 𝑚𝜃​
(where 𝑚is the number of gear teeth)
➢Output Signal Equation: Derived using the chain rule of calculus to find the AC electrical signal:
𝐸= 𝑏𝑚𝜔𝑟​sin 𝑚𝜔𝑟𝑡            (where 𝜔𝑟is the angular velocity of the gear, i.e., 𝑑𝜃/𝑑𝑡)
The Two "Direct Proportionality" Laws:
➢Amplitude Proportionality: The peak value of the output voltage, ෠𝐸= 𝑏𝑚𝜔𝑟, is directly proportional to the rotational 
speed.
➢Frequency Proportionality: The frequency of the AC signal, 𝑓=
𝑚𝜔𝑟
2𝜋, is directly proportional to the rotational speed.
(Engineering shortcut formula: 𝑓=
𝑅𝑃𝑀
60 × 𝑚​(𝑛𝑢𝑚𝑏𝑒𝑟​𝑜𝑓​𝑡𝑒𝑒𝑡ℎ))
Exercise
Solution
Solution
Mechanical Mechanics & Elastic Deformation
1. Stress and Strain
➢Stress (Stress, 𝝈) — The "Cause" of deformation:
• Definition: Internal force sustained per unit area.
• Formula: 𝜎= 𝐹/𝐴(Tensile force is positive +, compressive force is negative −).
➢Strain (Strain, 𝒆) — The "Result" of deformation:
• Definition: The relative change in the dimensions of an object (dimensionless).
• Formula: 𝑒= Δ𝑙/𝑙.
➢Hooke's Law:
• Relationship: Young's Modulus 𝐸= 𝜎/𝑒(Describes a material's ability to resist elastic deformation/stiffness).
2. 3D Deformation Linkage Rule: Poisson's Effect
➢Physical Phenomenon: When a material is stretched (lengthened), it must become thinner; when compressed 
(shortened), it must become thicker.  
➢Core Formula:
𝑒𝑇= −𝜈𝑒𝐿
(Transverse strain 𝑒𝑇= −(𝑃𝑜𝑖𝑠𝑠𝑜𝑛′𝑠​𝑟𝑎𝑡𝑖𝑜)​𝜈× (𝑙𝑜𝑛𝑔𝑖𝑡𝑢𝑑𝑖𝑛𝑎𝑙​𝑠𝑡𝑟𝑎𝑖𝑛)​𝑒𝐿)
➢The negative sign (−) in the formula is vital! It indicates that the directions of transverse and longitudinal deformation 
are always opposite.
➢If subjected to compressive force →longitudinal strain 𝑒𝐿is negative →a negative times a negative equals a positive, 
so transverse strain 𝑒𝑇is positive (the material bulges and thickens).
Exercise
Solution
Dynamic Characteristics of Sensors
1. Physical Limitations of Dynamic Measurement
➢Ideal Sensor: The output signal instantaneously and perfectly follows the changes in the input physical quantity.
➢Real-world Sensor: All elastic sensing elements (such as accelerometers and pressure diaphragms) physically consist 
of three basic elements, forming a second-order mechanical system:
• Mass / Moment of Inertia (𝒎/ 𝑰): Possesses inertia and resists sudden changes in the state of motion.
• Damping / Friction (𝝀/ 𝒃): Dissipates energy and hinders relative motion.
• Stiffness / Elasticity (𝒌/ 𝒄): Provides restorative force or torque during deformation.
2. Three Core Parameters Describing Dynamic Response
The dynamic transfer function 𝐺𝑠of the system is entirely determined by the following three parameters:
➢Steady-state Gain (𝑲): The measurement sensitivity under static conditions.
➢Natural Frequency (𝝎𝒏): The "vibrational DNA" of the system itself (Translational 𝜔𝑛=
𝑘/𝑚, Rotational 
𝜔𝑛=
𝑐/𝐼).
➢Damping Ratio (𝝃): Determines how quickly or slowly oscillations decay after the system is disturbed.
Response and Accelerometer Analysis
1. The Physical Essence of Accelerometer Measurement: Relative Displacement
➢The outer casing of the accelerometer vibrates along with the object being measured.
➢The internal inertial mass block lags behind due to inertia, resulting in a relative displacement (𝜽or 𝒙) between the 
mass block and the casing. The sensor measures exactly this relative displacement.
2. Amplitude-Frequency Characteristic Formula
At a sinusoidal input of angular frequency 𝜔, the relationship between the relative displacement amplitude መ𝜃and the base 
input amplitude ෢
𝜙𝑖is given by:
መ𝜃
෢
𝜙𝑖
=
𝜔/𝜔𝑛2
1 −𝜔/𝜔𝑛2 2 + 2𝜉𝜔/𝜔𝑛2
(Note: 𝜔/𝜔𝑛is called the frequency ratio).
3. Engineering's "Golden Damping Ratio": 𝝃= 𝟎. 𝟕𝟎𝟕(𝟏/ 𝟐)
➢Physical Significance: This ratio allows the sensor to maintain a flat response over the widest possible frequency 
range, neither producing sharp resonance peaks nor responding too sluggishly.
➢Mathematical Trick (Problem-Solving Secret): When 𝜉= 1/ 2, the complex denominator of the formula above 
can be perfectly simplified to:
1 + 𝜔/𝜔𝑛4
This significantly reduces calculation difficulty!
Exercise
Solution
Solution
