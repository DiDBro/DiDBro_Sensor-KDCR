# Tutorial 1_Solutions.pdf


## Page 1 [TEXT]
Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
March, 2026
Tutorial Course for Intro to Sensor-
Integrated Systems

## Page 2 [TEXT]
The General Measurement System
The accuracy of the system can be defined as the closeness of the measured value to the true value. A perfectly accurate 
system is a theoretical ideal and the accuracy of a real system is quantified using measurement system error E, where
Structure of measurement systems
Examples of measurement systems

## Page 3 [TEXT]
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

## Page 4 [TEXT]
Exercise
𝑎= 𝑂𝑚𝑖𝑛−𝐾𝐼𝑚𝑖𝑛
𝑎= 1 V
The unit of force F is Newton (N), and the unit of voltage V is Volt (V).
𝑎= 𝑂𝑚𝑖𝑛−𝐾𝐼𝑚𝑖𝑛
𝑎= 4 𝑚𝐴

## Page 5 [TEXT]
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

## Page 6 [TEXT]
Exercise
Final Answer:
1.The non-linearity error of the sensor at 4 bar is 0.20 V.
2.The non-linearity as a percentage of span is 4%.

## Page 7 [OCR]
Exercise
A non-linear temperature sensor has an input range of 0 to 400 °C and an output range of 0 to
20 mV. The output signal at 100 °C is 4.5 mV. Find the non-linearity at 100 °C in millivolts
and as a percentage of span.
N (100°C) = 4.5 mV - 5.0 mV = -0.5 mV
(Note: The magnitude of error usually takes the absolute value, meaning it deviates by 0.5 mV.
In engineering expressions, you can say the maximum non-linearity magnitude is 0.5 mV.)|
0.5 mV
% f.s.d. = 20 mV
- × 100% = 2.5%

## Page 8 [OCR]
Exercise
A thermocouple used between 0 and 500 °C has the following input-output characteristics:
Input T°C
Output E UV
100
5268
200
10 777
300
16 325
500
27388
(a) Find the equation of the ideal straight line.
) Find the non-linearity at 100 °C and 300 °C in uV and as a percentage of f.s.d.
Answer (a):
The ideal straight-line equation for this thermocouple is Eideal = 54.776 × I (where the unit
of E is uV and the unit of I is °C).
Percentage of f.s.d.:
% f.s.d.
|N (300)|
107.8
f.s.d.
× 100% = 27388
: × 100% ~ 0.394%

## Page 9 [TEXT]
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

## Page 10 [TEXT]
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

## Page 11 [TEXT]
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

## Page 12 [OCR]
Exercise
A force sensor has an input range of 0 to 10 kN and an output range of 0 to 5 V at a standard
temperature of 20 °C. At 30 °C the output range is 0 to 5.5 V. Quantify this environmental
effect.
Final Answer:
The temperature change for this sensor manifests only as a modifying input effect (there is
no interfering effect, KI = 0).
This environmental effect can be quantified by the modifying sensitivity constant:
K = 0.005 V/(kN . °C).

## Page 13 [OCR]
Exercise
A pressure transducer has an output range of 1.0 to 5.0 V at a standard temperature of 20 °C,
and an output range of 1.2 to 5.2 V at 30 °C. Quantify this environmental effect.
In this pressure transmitter, the temperature change manifests only as an Interfering Input
effect (there is no modifying effect, so K = 0).
This environmental effect can be quantified by the interfering environmental coupling constant:
K1 = 0.02 V/°C
(Physical meaning: For every 1 °C' increase in environmental temperature, the output of this
transmitter will shift upward as a whole by 0.02 V).

## Page 14 [OCR]
Exercise
A pressure transducer has an input range of 0 to 10° Pa and an output range of 4 to 20 mA
at a standard ambient temperature of 20 °C. If the ambient temperature is increased to 30 °C,
the range changes to 4.2 to 20.8 mA. Find the values of the environmental sensitivities K,
and KM-
Final Answer:
• The interfering input constant is Ky = 0.02 mA/°C.
• The modifying input constant is Kv = 6 × 10-° mA/(Pa. °C).

## Page 15 [TEXT]
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

## Page 16 [OCR]
Exercise
An analogue-to-digital converter has an input range of 0 to 5 V. Calculate the resolution error
both as a voltage and as a percentage of f.s.d. if the output digital signal is:
(a)
8-bit binary
(b) 16-bit binary.
(a) 8-bit ADC: Resolution error is approximately 19.53 mV, which is 0.391% of the span.
(b) 16-bit ADC: Resolution error is approximately 76.29 uV, which is 0.00153% of the
span.

## Page 17 [OCR]
Exercise
A level transducer has an output range of 0 to 10 V. For a 3 metre level, the output voltage
for a falling level is 3.05 V and for a rising level 2.95 V. Find the hysteresis as a percentage
of span.
The hysteresis error of this liquid level transmitter is 0.10 V.
The hysteresis error as a percentage of the span is 1%.
