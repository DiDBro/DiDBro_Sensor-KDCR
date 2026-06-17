Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
March, 2026
Tutorial Course for Intro to Sensor-
Integrated Systems
Basic Systematic Error
Three Major Assumptions of Ideal Elements:
➢Perfectly linear: A strictly proportional relationship between input and output.
➢Zero intercept: When the input is 0, the output is strictly 0 (i.e., 𝑎= 0).
➢No environmental inputs: Not affected by corrections or interference from the external environment (e.g., 
temperature, humidity).
Mathematical Expression: For a single element meeting the above conditions, the input-output equation is very simple:
𝑂𝑖= 𝐾𝑖𝐼𝑖
(Where 𝐾𝑖is the linear sensitivity/slope of the 𝑖element)
Derivation Process: Signals are passed like a relay race; the output of the previous element is the input for the next.
•Level 1 Output: 𝑂1 = 𝐾1𝐼
•Level 2 Output: 𝑂2 = 𝐾2𝑂1 = 𝐾2𝐾1𝐼
•Level 3 Output: 𝑂3 = 𝐾3𝑂2 = 𝐾3𝐾2𝐾1𝐼
Conclusion: For an entire measurement system containing 𝑛elements, the final system output 𝑂is:
Core Summary: The Total Sensitivity of a series system, 𝐾𝑠𝑦𝑠, is equal to the product of the individual element sensitivities
Error Definition: Measurement error 𝐸is defined as the difference between the measured value (final system output 𝑂) 
and the true value (initial system input 𝐼).
Exercise
Error Band Modeling and Propagation Analysis
1. Introduction: What is an "Error Band" (±𝒉)?
Engineering Reality: Sensor manufacturers usually only provide an "accuracy range" (e.g., ±1%). This means the actual 
output is restricted within a band-shaped region fluctuating above and below the ideal linear path, with a total width of 
2ℎ.
2. Core Transformation: Turning "Range" into "Variance"
➢Statistical Assumption: Assume the probability of the error falling at any point within ±ℎis equal; that is, it follows 
a rectangular distribution (uniform distribution).
➢An error band with width 2ℎis equivalent to an internal noise source within the system, with its own variance defined 
as:
3. Variance Propagation Rules for Series Systems
➢
In a series system, errors accumulate level by level like a rolling snowball and are amplified by the sensitivity (𝐾) of 
each element.
➢
Recursive Formula:
4. Key Points
➢The initial input of the system (the true physical quantity) usually has no random error, therefore 𝜎𝑖𝑛1
2
= 0.
➢The sensitivity 𝑲𝟏of the first-stage element will never amplify its own error! The output variance of the first 
stage is simply 
ℎ12
3 .
Exercise
Exercise
High-Gain Negative Feedback & Error Reduction
1. The Pain Point: Why are Open-Loop Systems "Fragile"?
In a series (open-loop) system, a parameter drift in any single element of the forward path (e.g., an amplifier affected by 
temperature, or a spring aging) will be directly amplified proportionally, leading to massive measurement errors. 
Searching for "perfect elements" is prohibitively expensive.
2. The Solution: Introducing a Negative Feedback Structure
Core Idea: Instead of blindly trusting the processing result, "pull back" the actual output and compare it with the 
intended input through subtraction. Use the resulting "error signal" to drive the system to self-correct.
3. Closed-Loop Transfer Function
The overall sensitivity of a closed-loop system is no longer a simple product of elements, but rather:
4. High-Gain Approximation (High-Gain Magic)
If we intentionally make the gain of the forward amplifier massive, such that the loop gain 𝐾𝑓𝑜𝑟𝑤𝑎𝑟𝑑∙𝐾𝑓𝑒𝑒𝑑𝑏𝑎𝑐𝑘≫1, the 
"1" in the denominator becomes negligible, and a wonderful simplification occurs:
5. Engineering Takeaway
The "Leverage" Effect: The overall accuracy of the system becomes completely decoupled from the forward path 
(which can now use cheap, drift-prone components) and depends solely on the stability of the single element in the 
feedback loop! This drastically improves the system's immunity to interference.
Exercise
Exercise
Comprehensive Statistical Error Analysis for Non-Ideal Systems
1. Real-World Complexity
Real-world measurement systems are typically non-linear (including quadratic terms, exponential terms, etc.) and are simultaneously 
affected by cross-interference from multiple random variables (e.g., ambient temperature, fluid density, component tolerances).
2. The "Dual-Track" Algorithm
When solving problems, calculations for the mean value and the fluctuations (variance) must be kept strictly separate and treated as 
independent tracks:
Track 1: Calculating Mean Error ഥ𝑬(Systematic Bias)
✓Rule: Ignore fluctuations and plug in mean values. Take all nominal mean values provided in the problem and substitute them step-
by-step into the complex non-linear equations to calculate the final measured mean 𝑂.
✓Formula: System Error ത𝐸= ത𝑂−𝑇𝑟𝑢𝑒 𝐼𝑛𝑝𝑢𝑡 𝐼.
Track 2: Calculating Error Standard Deviation 𝝈𝑬(Random Fluctuation)
✓Rule: Partial derivatives act as weights for amplification. Use the Law of Error Propagation for multi-variable functions to calculate 
the accumulation of variance:
✓Critical Pitfall: The partial derivatives must be evaluated at the mean values derived in "Track 1"! After calculating the total 
variance, take the square root to find 𝜎𝐸.
3. Engineering Diagnosis & Optimization
✓ഥ𝑬is large →Modify the software algorithm. The inverse calculation formula in the microcontroller is inaccurate (e.g., truncation 
errors). Upgrade to a more precise polynomial inverse equation or use a lookup table.
✓𝝈𝑬is large →Increase dynamic compensation. Identify the term in the variance calculation with the largest value (usually 
environmental interference). Add auxiliary sensors (like thermometers or barometers) to the system to feed real-time environmental 
data into the microcontroller for active compensation/cancellation.
Exercise
Exercise
Exercise
Exercise
Exercise
Optimization Plan: Modify the microcontroller's software code.
Exercise
Optimization Plan:
In real-world engineering, the density 𝜌of a fluid (like air or water) is never a constant. It fluctuates drastically
with the real-time temperature and absolute pressure inside the pipe. Hard-coding
ҧ𝜌as a constant 1.2 in the
system design is a severe flaw.
Add dynamic compensation hardware. We must install an additional temperature sensor and an absolute pressure
sensor into the pipeline. The real-time signals from these sensors should be fed into the microcontroller. Using the
ideal gas law (𝜌= 𝑃/𝑅𝑇), the microcontroller can compute the true, real-time density 𝜌on the fly and feed it into
the velocity formula. In the industry, this is known as "Temperature and Pressure Compensation" (or Dynamic
Compensation).
Exercise
Exercise
