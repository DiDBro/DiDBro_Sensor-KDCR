# Tutorial 5 with Solutions.pdf


## Page 1 [TEXT]
Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
2026
Tutorial Course for Intro to Sensor-
Integrated Systems

## Page 2 [TEXT]
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

## Page 3 [OCR]
Exercise
A batch of 100 identical thermocouples were tested over a 12-week period. Twenty failures
were recorded and the corresponding down times in hours were as follows:
5, 6, 7, 8, 4, 7, 8, 10, 5, 4, 8, 5, 4, 5, 6, 5, 4, 9, 8, 6
Calculate:
(a) Mean down time
(b) Mean time between failures
(e) Mean failure rate
(d) Availability.

## Page 4 [OCR]
Solution
Summary of Given Data
• Total number of tested items (N): 100
• Total test duration (T'): 12 weeks. Converted to hours: T = 12 × 7 × 24 = 2016 hours
• Total number of failures (NF): 20
• Total down time (2 TDj): Summing up the 20 down times listed in the problem:
5+6+7+8+4+7+8+10+5+4+8+5+4+5+6+5+4+9+8+6=124 hours
(a) Mean down time (MDT)
Mean down time is equal to the total down time divided by the number of failures.
Total down time
124
MDT =
- =
- = 6.2 hours
NE
20
(b) Mean time between failures (MTBF)
First, we need to calculate the total up time of these 100 thermocouples during the test
period, which is the theoretical total test time minus the total down time, and then divide by the
number of failures.
(c) Mean failure rate (1)
I = MIBF
1 = 10073.8
- ~ 9.927 × 10 ° failures/hour
(d) Availability (A)
Total test time = N × T = 100 × 2016 = 201,600 hours
Total up time = 201, 600 - 124 = 201,476 hours
MIBF = 1
Total up time _ 201,476
- = 10,073.8 hours
10073.8
A = 10073.8 + 6.2
MTBF
A = MTBF + MDT
10073.8
- ~ 0.99938 (or 99.938%)
10080

## Page 5 [TEXT]
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

## Page 6 [TEXT]
Exercise
A more cost-effective mixed redundancy system is now designed: three thermocouples are used in parallel (output via a 
median selector), which are then connected in series with one converter and one recorder. Find the total reliability 
(𝑅𝑂𝑉𝐸𝑅𝐴𝐿𝐿) and unreliability (𝐹𝑂𝑉𝐸𝑅𝐴𝐿𝐿) of this mixed system at 𝑡= 0.5 years.

## Page 7 [TEXT]
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

## Page 8 [OCR]
Exercise
A flow measurement system consists of an orifice plate (2 = 0.75), differential pressure
transmitter (1 = 1.0), square root extractor (2 = 0.1) and recorder (2 = 0.1). Calculate the
probability of losing the flow measurement after 0.5 year for the following:
(a) A single flow measurement system
(b) Three identical flow measurement systems in parallel
(c) A system with three orifice plates, three differential pressure transmitters and a middle
value selector relay (2 = 0.1). The selected transmitter output is passed to a single square
root extractor and recorder.
Annual failure rate data are given in brackets; assume that all systems were initially checked
and found to be working correctly.

## Page 9 [TEXT]
Solution
Based on the information provided, we first list the annual failure rates (𝜆, unit: failures/year) and the operating time (𝑡, unit: 
years) for each component:
In a constant failure rate model, a component's reliability is 𝑅𝑡= 𝑒−𝜆𝑡, and the probability of failure (unreliability) is 
𝐹𝑡= 1 −𝑒−𝜆𝑡.

## Page 10 [OCR]
Solution
(b) Three Identical Flow Measurement Systems in Parallel
This is a parallel redundancy system. The system only loses measurement data when all
three single systems fail simultaneously. According to the formula for parallel systems, the total
unreliability equals the product of the unreliability of each branch. We already calculated the
unreliability of a single system in part (a): Fa = 0.6228.
Unreliability of three systems in parallel (Fb):
E, = (Fa)? = (0.6228)3 ~ 0.2416 (or 24.16%)
(c) Mixed Redundancy System
This system is more complex and can be broken down into two parts for analysis:
Part 1: Front-end Parallel Subsystem
This consists of 3 parallel branches, each made of an orifice plate and a differential pressure
transmitter in series. Per the textbook's simplified method for "middle value selector" front-end
parallel circuits (see Section 7.1.5), this part is treated as a single redundant module:
• Failure rate of a single branch: Abranch = 11 + 12 = 0.75 + 1.0 = 1.75 year-1
• Unreliability of a single branch: Fbranch = 1 - e -1.75x0.5 = 1 - e-0.875
~ l—
0.4169 = 0.5831
• Unreliability of the entire front-end: Front = (Fbranch)3 = (0.5831)3 ~ 0.1983
• Reliability of the front-end module: Rfront = 1 - 0.1983 = 0.8017

## Page 11 [OCR]
Solution
Part 2: Back-end Series Subsystem
The signal from the selector passes through the middle value selector relay, square root
extractor, and recorder. These three components are in series.
• Total failure rate of the back-end series: Jback = 15 + 13 + 14 = 0.1 + 0.1 + 0.1 =
0.3 year
• Reliability of the back-end: Rback =e-0.3x0.5 = e-0.15 ~ 0.8607
Calculating the Total System:
The entire system is equivalent to "Part 1" and "Part 2" in series.
Re = Rfront × Rback
Rc = 0.8017 × 0.8607 ~ 0.6900
Probability of losing measurement (unreliability Fc:
Fc = 1 - Rc = 1 - 0.6900 = 0.3100 (or 31.00%)

## Page 12 [TEXT]
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

## Page 13 [OCR]
Exercise
Use the data given in Table Prob. 3 to decide which level measurement system should be
purchased. Assume a breakdown maintenance only strategy is practised, each system has the
same measurement error, and there is a 10-year total lifetime.
Parameter
Initial cost
Materials cost per repair
Labour cost per hour
Process cost per hour
Repair time
Annual failure rate
h
yr'
System 1
1000
20
10
100
8
2.0
System 2
2000
15
10
100
12
1.0

## Page 14 [TEXT]
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

## Page 15 [TEXT]
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

## Page 16 [OCR]
Exercise
A variable dielectric capacitive displacement sensor consists of two square metal plates of side
5 cm, separated by a gap of 1 mm. A sheet of dielectric material 1mm thick and of the same
area as the plates can be slid between them as shown in Figure 8.9. Given that the dielectric
constant of air is 1 and that of the dielectric material 4, calculate the capacitance of the
sensor when the input displacement x = 0.0, 2.5 and 5.0 cm.
E1
E2
— 1-
→
Variable dielectric

## Page 17 [OCR]
Solution
1. Extract Known Parameters
• Plate Dimensions: Square, side length w = l = 5 cm = 0.05 m
• Plate Separation: d = 1mm = 0.001 m
• Dielectric Thickness: 1 mm (equal to the plate separation, meaning the dielectric
completely fills the gap vertically)
• Relative Permittivity of Air: 61 = 1
• Relative Permittivity of Dielectric: 62 = 4
• Vacuum Permittivity: 6o = 8.85 pF/m = 8.85 x 10-12 F/m
• Displacements to be calculated (x): 0.0 cm, 2.5 cm, and 5.0 cm respectively.
2. Formula Derivation
When the dielectric plate is pulled out by a distance x:
• Area covered by the air section: A1 = w - x
• Remaining area covered by the dielectric: A2 = w - (l- x)|
The total capacitance C' is the sum of these two parallel capacitors (per textbook formula
[8.20]):

## Page 18 [OCR]
Solution
0 = 02(12 + 6211- 2)1
Substituting the relative permittivities €1 = 1 and 62 = 4:
C= E01 (+ 4(1 - 2)) = 9010(41-30)
First, let's calculate the constant coefficient at the front of the formula:
8.85 × 10-12 F/m × 0.05 m
= 4.425 × 10-10 F/m = 442.5 pF/m
0.001 m
3. Calculate Capacitance for Three Displacement Scenarios
Case (1): Displacement x = 0.0 cm = 0 m
Case (3): Displacement x = 5.0 cm = 0.05 m
C = 442.5 × |4 × 0.05 - 3 × 0 = 442.5 × 0.2
C = 442.5 × |4 × 0.05 - 3 × 0.05| = 442.5 × [0.2 - 0.15] = 442.5 × 0.05
C = 88.5 pF
Case (2): Displacement x = 2.5 cm = 0.025 m
' = 442.5 × |4 × 0.05 - 3 × 0.025] = 442.5 × [0.2 - 0.075] = 442.5 × 0.125
C = 22.125 pF
C = 55.3125 pF

## Page 19 [TEXT]
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

## Page 20 [OCR]
Exercise
A variable reluctance sensor consists of a core, a variable air gap and an armature. The core
is a steel rod of diameter 1 cm and relative permeability 100, bent to form a semi-circle of
diameter 4 cm. A coil of 500 turns is wound onto the core. The armature is a steel plate
of thickness 0.5 cm and relative permeability 100. Assuming the relative permeability of
air = 1.0 and the permeability of free space = 4mx x H Hm!
", calculate the inductance of the
sensor for air gaps of 1mm and 3 mm.
Core
Radius
Air gap
Armature
permeability HA
(c)

## Page 21 [OCR]
Solution
1. Extract Known Parameters and Symbol Mapping
• Core:
• Cross-sectional diameter = 1 cm → radius r = 0.5 cm = 0.005 m
• Semicircle radius = 4 cm → core mean radius R = 2 cm = 0.02 m
• Relative magnetic permeability of the core fl, = 100
• Coil: Number of turns n = 500
• Armature:
• Thickness t = 0.5 cm = 0.005 m
• Relative magnetic permeability of the armature uA = 100
• Environment Constants:
• Relative magnetic permeability of air fair = 1.0
• Vacuum permeability po = 4т × 10-' H-m m-1
• Target Air Gaps (d): d1 = 1 mm = 0.001 m, d2 = 3 mm = 0.003 m

## Page 22 [OCR]
Solution
2. Formula Derivation
According to the principles of magnetic circuits, the total reluctance RoTaL is composed of
three parts in series:
RIOTAL = RCORE + RARMATURE + RGAP
Substituting the reluctance calculation formulas provided in the textbook:
1. Core Reluctance: RCORE = Hot (r) = HоH-F
2. Armature Reluctance (path length is 2r): RARMATURE = HORA (27t)
3. Air Gap Reluctance (two gaps, total length 2d): RAp = H0(Fr)
HORATE
In this problem, r = t = 0.005 m and f, = HA = 100. Therefore, the core and armature
reluctances are equal. We can define the fixed reluctance (excluding the air gap) as Ro:
0.02
Ro = RCORE + RARMATURE = 2 x
(4т × 10-7) × 100 × (0.005)=
0.04
Ro =
100 × 25 × 10-6 × 4т × 10-7
4 × 10°
- ~ 12.732 × 10° H-1

## Page 23 [OCR]
Solution
3. Calculating Inductance for Different Air Gaps
The final calculation formula for inductance is: L = RIOTAi
Scenario (1): When air gap d = 1 mm = 0.001 m
• Calculate Gap Reluctance:
2 × 0.001
RGAP =
(4т × 10-7) × т x (0.005)2
10-102
2 × 10ª
- ~ 20.264 × 10° H-1
• Calculate Total Reluctance:
• Calculate Inductance:
RIOTaL = (12.732 + 20.264) × 10º = 32.996 × 10° H-1
500º
L =
• ~ 0.00758 H
= 7.58 mH
32.996 × 106
Scenario (2): When air gap d = 3 mm = 0.003 m
• Calculate Gap Reluctance:
Since the gap length has tripled, the gap reluctance also triples:
RaAP = 3 × 20.264 × 10° = 60.793 × 10° H 1
• Calculate Total Reluctance:
RIOTAL = (12.732 + 60.793) × 10° = 73.525 × 10° H 1
• Calculate Inductance:
5002
L = 73.525 × 106 ~ 0.00340 H = 3.40 mH

## Page 24 [TEXT]
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

## Page 25 [OCR]
Exercise
A variable reluctance tachogenerator consists of a ferromagnetic gear wheel with 22 teeth
rotating close to a magnet and coil assembly. The total flux N linked by the coil is given by:
N(0) = 4.0 + 1.5 cos 220 milliwebers
where O is the angular position of the wheel relative to the axis of the magnet. Calculate the
amplitude and frequency of the output signal when the angular velocity of the wheel is 1000
and 10 000 r.p.m.

## Page 26 [OCR]
Solution
1. Extract Known Parameters
• Number of teeth (m): 22
• Equation for flux linkage (N (0)): N(0) = 4.0 + 1.5 cos(220) mWb
(Note the unit conversion: 1 mWb = 10-3 Wb, so the varying flux amplitude b =
1.5 × 10-3 Wb)
• Given rotational speeds: 1000 r.p.m. and 10000 r.p.m. (revolutions per minute)
2. Theoretical Formula Derivation
According to Faraday's Law, the induced electromotive force E (output signal) in the coil is the
negative rate of change of flux linkage over time:
dN
E = -
dt
Using the Chain Rule from calculus, we expand this as the product of the derivative with
respect to angular displacement 0 and the angular velocity wr:
dN
de
de
E =
Given angular velocity do = w, (rad/s), we substitute the flux equation:
E = - [1.5 × 10-3 × (- sin 220) × 22] • wr
E =
do (4.0 + 1.5 cos 220) × 10
-3
• Шт
E = 0.033w, sin(220)
Since angular displacement 9 = wrt, the final expression for the AC output signal is:
E = 0.033w, sin(22w, t)

## Page 27 [OCR]
Solution
From this, we extract the two key parameter calculation formulas:
• Amplitude (E): E = 0.033wr (V)|
• Frequency (f): The angular frequency of the signal is 22w,, so the actual frequency is
f = 22w= (Hz).
(A faster engineering calculation: f= revolutions per second x teeth, i.e., f= RPM x m
3. Numerical Calculation
Case (1): When speed is 1000 г.p.m.
2т
First, convert the speed to standard angular velocity w, (rad/s): w, = 1000 x
- = 100 г
- ~ 104.72 rad/s
60
3
• Calculate Amplitude E:
E= 0.033 x
100+= 1.17 ~ 3.456 V
1000
2200
• Calculate Frequency f:
f=
- × 22 =
- ~ 366.67 Hz
Case (2): When speed is 10000 г.p.m.
60
60
Since the speed is exactly 10 times that of Case (1), and based on our derivation, both
amplitude and frequency have a strict direct proportionality with speed, the results are
simply scaled by 10:
•w=10000x20 = 100= ~ 1047.2 rad/s
• Amplitude E: E = 1.1T × 10 = 117 ~ 34.56 V
• Frequency f: f = 366.67 × 10 ~ 3666.67 Hz

## Page 28 [TEXT]
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

## Page 29 [OCR]
Exercise
A steel bar has a cross-sectional area of 10m, Young's modulus of 2 × 10" Pa and
Poisson's ratio of 0.4. If the bar is subject to a compressive force of 10' N, find the corresponding
longitudinal and transverse strains.

## Page 30 [OCR]
Solution
1. Extract Known Parameters and Symbol Definitions
• Cross-sectional area (A): 10-3 m?
• Young's modulus (E): 2 × 1041 Pa (or N/m?)
• Poisson's ratio (v): 0.4
• Applied Force (F): - 10° N
Step 1: Calculate Longitudinal Strain (eL)
Step 2: Calculate Transverse Strain (er)
According to Hooke's Law, stress o = F / A and o = E • eL According to the definition of Poison's ratio, as a material shortens longitudinally under
Therefore, the formula for longitudinal strain is:
compression, it simultaneously expands transversally (bulges). The relationship is given by
formula [8.9] in the textbook:
eL =
F
E AE
Substituting the known values:
ет = -veL
-10°
eL = 10-3 × 2 x 1011
-10°
eL = 2x 108
Substituting the known values:
ет = -0.4x (-5×10-1)
eL = -0.5 × 10-3
ст = 2 × 10-4
eL = -5 × 10-1

## Page 31 [TEXT]
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

## Page 32 [TEXT]
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

## Page 33 [OCR]
Exercise
An accelerometer is to measure the angular acceleration of a rotating mixing vessel. The
angular position of the vessel varies sinusoidally with time with amplitude 2.5 rad and period
s. The rotating seismic mass is equivalent to a mass of 0.1 kg on a weightless arm of length
5 cm. The stiffness of the spring is 2.5 × 10-2 N m rad and the damping ratio is 1/V2. The
angular position of the seismic mass is measured with a secondary potentiometric sensor. What
should the input range of this sensor be?

## Page 34 [OCR]
Solution
1. Extracted Parameters and Physical Model
• Input Vibration (Base) Parameters:
• Amplitude of angular displacement: Ø; = 2.5 rad
• Vibration period: T = 2 s → Source angular frequency w = # = T rad/s
• Internal Sensor (Angular Accelerometer) Parameters:
• Equivalent inertial mass: m = 0.1 kg
• Arm length: r = 5 cm = 0.05 m
• Spring torsional stiffness: c = 2.5 × 10-2 N• m • rad l
• Damping ratio: § = 1/V 2 (This is the engineering Golden Damping Ratio)
2. Core System Parameter Calculation
Step 1: Calculate the Moment of Inertia (1)
I = mr? = x × (0.05)? = 2.5 × 10-4 kg - m?
Step 2: Calculate the Natural Angular Frequency (wn)
Based on the second-order dynamic formula:
2.5 × 10-2
wn = VT =V x10-1 = V100 = 10 rad/s
Step 3: Calculate the Frequency Ratio (x)
x = -
wn
- = -
- ~ 0.31416
10

## Page 35 [OCR]
Solution
3. Transfer Function and "Golden Simplification" (The Technical Highlight)
According to the accelerometer equation [8.19] in the textbook: IÖ + b0 + c0 = - Iöi. This
converts to the amplitude ratio formula for frequency response:
(w/wn)-
DiVII - (w/wn)212 + (2[w/wn)V(1- 222)3 + (2522)7
Since the problem specifies { = 1/V2, the cross-term in the denominator simplifies as
follows:
(2{2)2= (2x-
Now, look inside the square root:
(1 22)3+223=11-223+24) +223=1+24
The complex amplitude ratio formula is simplified to:
V1 + 24
4. Final Numerical Substitution
Calculate the values based on the simplified formula:
• x? = (т/10)? ~ 0.0987
• x* = (т/10)* ~ 0.0097
• Denominator = V1 + 0.0097 = v1.0097 ~ 1.0048
Calculate the final relative displacement amplitude Ô:
V1+24
0.0987
= 2.5 x
~ 0.2456 rad
1.0048
