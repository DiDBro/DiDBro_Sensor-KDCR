Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
March, 2026
Tutorial Course for Intro to Sensor-
Integrated Systems
The General Measurement System
The accuracy of the system can be defined as the closeness of the measured value to the true value. A perfectly accurate 
system is a theoretical ideal and the accuracy of a real system is quantified using measurement system error E, where
Structure of measurement systems
Examples of measurement systems
Static Characteristics of Measurement System Elements
Range specifies the minimum and maximum values of an input or output variable.
Input range: 
𝐼𝑚𝑖𝑛→𝐼𝑚𝑎𝑥
Output range: 
𝑂𝑚𝑖𝑛→𝑂𝑚𝑎𝑥
Range describes the allowable limits of operation. It does not indicate accuracy or precision.
Span is the difference between the maximum and minimum values.
Input span:
Input Span = 𝐼𝑚𝑎𝑥−𝐼𝑚𝑖𝑛
Output span:
Output Span = 𝑂𝑚𝑎𝑥−𝑂𝑚𝑖𝑛
Ideal Straight Line
Definition
For a linear element:
𝑂𝑖𝑑𝑒𝑎𝑙= 𝐾𝐼+ 𝑎
Where:
•𝐾= slope (sensitivity)
•𝑎= intercept (zero offset)
𝐾=
𝑂𝑚𝑎𝑥−𝑂𝑚𝑖𝑛
𝐼𝑚𝑎𝑥−𝐼𝑚𝑖𝑛
𝑎= 𝑂𝑚𝑖𝑛−𝐾𝐼𝑚𝑖𝑛
Exercise
𝑎= 𝑂𝑚𝑖𝑛−𝐾𝐼𝑚𝑖𝑛
𝑎= 1 V
The unit of force F is Newton (N), and the unit of voltage V is Volt (V).
𝑎= 𝑂𝑚𝑖𝑛−𝐾𝐼𝑚𝑖𝑛
𝑎= 4 𝑚𝐴
Static Characteristics of Measurement System Elements
Non-linearity (Non-linear Error)
1. Why Non-linearity Exists
     In practice, most sensors are not perfectly linear.
     The real input–output relationship does not exactly follow the ideal straight line:
𝑂𝑖𝑑𝑒𝑎𝑙= 𝐾𝐼+ 𝑎
     Therefore, we define non-linearity as the deviation of the actual output from this ideal straight line.
2. Mathematical Definition
If the actual output is 𝑂𝐼 ,then:
𝑁𝐼= 𝑂𝐼−𝐾𝐼+ 𝑎
Where:
•𝑂𝐼 = actual output
•𝐾𝐼+ 𝑎 = ideal straight-line output
•𝑁𝐼 = non-linearity at input 𝐼
3. Non-linearity as Percentage of Full-Scale Deflection (FSD)
Manufacturers usually express non-linearity as a percentage of span (full-scale deflection).
% f.s.d. =
෡𝑁
𝑂𝑚𝑎𝑥−𝑂𝑚𝑖𝑛× 100%
Where:
• ෡𝑁= 𝑚𝑎𝑥∣𝑁(𝐼) ∣ maximum deviation
•𝑂𝑚𝑎𝑥−𝑂𝑚𝑖𝑛 = output span
Important: The denominator is the output span, not the input span.
Exercise
Final Answer:
1.The non-linearity error of the sensor at 4 bar is 0.20 V.
2.The non-linearity as a percentage of span is 4%.
Exercise
Exercise
Static Characteristics of Measurement System Elements
Interfering Input (𝑰𝑰)
Definition: An interfering input is an environmental variable that causes a change in the zero offset (intercept) of the 
sensor output.
It does not change the slope, but shifts the entire input–output relationship vertically.
Mathematical Expression
For a linear element:
𝑂= 𝐾𝐼+ 𝑎
If an interfering input 𝐼𝐼exists:
𝑂= 𝐾𝐼+ 𝑎+ 𝐾𝐼𝐼𝐼
Where:
•𝐾𝐼 =environmental sensitivity to interfering input
•𝐼𝐼 =deviation from standard condition
So the intercept changes from 𝑎 to:
𝑎+ 𝐾𝐼𝐼𝐼
Mathematical Expression
Original linear model:
𝑂= 𝐾𝐼+ 𝑎
With modifying input:
𝑂= 𝐾+ 𝐾𝑀𝐼𝑀𝐼+ 𝑎
Where:
•𝐾𝑀 = change in sensitivity per unit modifying input
•𝐼𝑀 = deviation from standard condition
So sensitivity becomes:
𝐾+ 𝐾𝑀𝐼𝑀
Static Characteristics of Measurement System Elements
Modifying Input (𝑰𝑴)
Definition: A modifying input is an environmental variable that changes the sensitivity (slope) of the sensor.
It does not shift the intercept, but changes how steep the input-output curve is.
Static Characteristics of Measurement System Elements
The Generalized Model of a Measurement Element
Now we combine:
➢Ideal linear behavior
➢Non-linearity
➢Interfering input
➢Modifying input
Complete Static Model
𝑂= 𝐾𝐼+ 𝑎+ 𝑁𝐼+ 𝐾𝑀𝐼𝑀𝐼+ 𝐾𝐼𝐼𝐼
𝑂= (𝐾+ 𝐾𝑀𝐼𝑀)𝐼+ 𝑎+ 𝐾𝐼𝐼𝐼
Term
Meaning
𝐾𝐼+ 𝑎
Ideal straight line
𝑁𝐼
Non-linear deviation
(Engineering reason: N(I) = 0. To calculate the slope (sensitivity K), it is necessary 
that this line be a straight line.)
𝐾𝑀𝐼𝑀𝐼
Gain change due to environment
𝐾𝐼𝐼𝐼
Zero shift due to environment
Exercise
Exercise
Exercise
Static Characteristics of Measurement System Elements
ADC (Analog-to-Digital Converter)
An ADC converts a continuous analog signal into a discrete digital code.
➢Input: analog voltage 𝑉𝑖𝑛
➢Output: digital binary number
Resolution
Definition：
The smallest change in input voltage that produces a change in output code.
It is also called the quantization step size.
Mathematical Expression
For an n-bit ADC:
Δ𝑉= 𝑉𝑚𝑎𝑥−𝑉𝑚𝑖𝑛
2𝑛
Hysteresis
Definition：
Hysteresis occurs when:
The output depends on the direction of input change.
For the same input value:
➢Output differs when input is increasing
➢Compared to when input is decreasing
Mathematical representation of hysteresis error:
𝐻= 𝑉𝑢𝑝−𝑉𝑑𝑜𝑤𝑛
%𝑓. 𝑠. 𝑑. = 1
2𝑛× 100%
%𝑓. 𝑠. 𝑑. =
𝐻
𝑂𝑚𝑎𝑥−𝑂𝑚𝑖𝑛
× 100%
Exercise
Exercise
