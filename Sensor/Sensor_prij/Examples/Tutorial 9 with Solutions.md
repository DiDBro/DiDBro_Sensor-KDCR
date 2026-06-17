Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
2026
Tutorial Course for Intro to Sensor-
Integrated Systems
Measurement Error Basics
1. Quantitative Definitions of Errors
➢Absolute Error: Δ𝑥= 𝑥−𝑥0 (Measured Value - True Value)
➢Relative Error: 𝛾=
Δ𝑥
𝑥0 × 100% (Reflects measurement accuracy more objectively)
➢Referenced / Fiducial Error: 𝛾𝑛= Δ𝑥
𝑥𝐹.𝑆× 100% (Relative to the Full Scale 𝑥𝐹.𝑆; used to define instrument accuracy classes)
2. The Three Types of Errors & Countermeasures
➢Systematic Error:
•
Characteristics: Remains constant or changes according to a specific pattern.
•
Countermeasure: Cannot be eliminated by repeated measurements! Requires finding the root cause or introducing a "correction 
value" for compensation.
➢Random Error:
•
Characteristics: Unpredictable in magnitude and sign, but follows statistical laws (e.g., Normal Distribution) over multiple trials.
•
Countermeasure: Increase the number of measurements and calculate the average (mean).
➢Gross Error / Outlier:
•
Characteristics: Extreme data points that significantly distort the results (usually caused by human mistakes or sudden 
instrument faults).
•
Countermeasure: Identify and strictly eliminate using statistical criteria like the $3\sigma$ rule or Grubbs' test.
Core Data Processing Methods
1. Statistical Description of Data
➢Arithmetic Mean: ҧ𝑥= 1
𝑛σ𝑖=1
𝑛
𝑥𝑖(The best estimate of the true value)
➢Residual Error: 𝑣𝑖= 𝑥𝑖−ҧ𝑥
➢Standard Deviation (Single Measurement): 𝜎≈𝑆=
σ 𝑣𝑖
2
𝑛−1 (Bessel's formula; evaluates the uncertainty or dispersion of data)
➢Weighted Average: Used when datasets have different precisions. The weight is inversely proportional to the variance: 𝑝𝑖= 1
𝜎𝑖
2.
2. How do Errors "Propagate"? (Indirect Measurement)
➢Given a functional relationship 𝑦= 𝑓𝑥1, 𝑥2 with independent variables.
➢Root-Sum-Square (RSS) Formula: 𝜎𝑦=
𝜕𝑓
𝜕𝑥1 𝜎𝑥1
2
+
𝜕𝑓
𝜕𝑥2 𝜎𝑥2
2
3. Method of Least Squares (Linear Regression)
➢Core Idea: Find the best-fit straight line 𝑦= 𝑎+ 𝑏𝑥.
➢Objective: Minimize the sum of the squared deviations of all measured points from the line: 𝑄= σ𝑖=1
𝑛
𝑦𝑖−𝑎+ 𝑏𝑥𝑖
2 = min.
➢Application: The ultimate tool for determining a sensor's static calibration, including its Sensitivity (slope b) and Zero Offset
(intercept a).
Exercise
Solution
Exercise
Solution
Exercise
Solution
Exercise
Solution
Sensor Static Characteristics
1. Core Definitions (Key Indicators)
➢Sensitivity (𝑺): The ratio of the incremental output (Δ𝑦) to the incremental input (Δ𝑥), i.e., 𝑆= Δ𝑦/ Δ𝑥.
➢Linearity (Non-linearity): The maximum deviation of the actual calibration curve from a specified fitted straight line.
➢Hysteresis: The non-coincidence between the loading (increasing input) and unloading (decreasing input) output curves of a sensor.
➢Repeatability: The closeness of agreement among successive measurements of the same input, carried out in the same direction 
under identical conditions.
➢Drift: The variation in the sensor's output over time or due to environmental changes (e.g., temperature) while the input remains 
constant.
2. Quantifying Errors (Calculation Formulas)
➢Linearity Error: 𝛾𝐿= ±
Δ𝐿𝑚𝑎𝑥
𝑦𝐹.𝑆× 100\%
•
Δ𝐿𝑚𝑎𝑥: Maximum non-linear deviation; 𝑦𝐹.𝑆: Full-scale (F.S.) output.
➢Hysteresis Error: 𝛾𝐻= ±
Δ𝐻𝑚𝑎𝑥
𝑦𝐹.𝑆× 100\%
•
Δ𝐻𝑚𝑎𝑥: Maximum output difference between the loading and unloading curves.
➢Repeatability Error: 𝛾𝑅= ±
𝑘⋅𝜎
𝑦𝐹.𝑆× 100\%
•
𝜎: Standard deviation of the measurements; 𝑘: Confidence coefficient (usually 2 or 3, depending on the required confidence 
level).
Exercise
Solution
Solution
Sensor Dynamic Characteristics
1. Fundamental Concepts
➢Dynamic Characteristics: Refers to the response characteristics of a sensor's output when the input signal changes over time. 
➢Ideal Goal: The output should reproduce the changes in the input signal without distortion or delay. 
➢Physical Constraints: Due to system inertia (mass) and resistance (energy dissipation), the output often lags behind the input. 
2. First-Order Systems: Time Constant (𝝉)
➢Typical Application: Temperature sensors (e.g., thermocouples). 
➢Step Response: 𝑦𝑡= 𝑦∞1 −𝑒−𝑡/𝜏. 
➢Key Indicator: The time constant 𝜏determines response speed; a smaller 𝜏 means a faster sensor. 
➢Settling Time: After 1𝜏, the output reaches 63.2% of the steady-state value. 
3. Second-Order Systems: Damping and Frequency
➢Typical Application: Force sensors and piezoelectric accelerometers. 
➢Key Parameters:
•
Natural Frequency (𝝎𝒏): Determines the upper limit of the response speed. 
•
Damping Ratio (𝜻): Controls the oscillation and overshoot. 
➢Damping States:
•
Underdamped (𝜻< 𝟏): Fast response but includes oscillations (ringing). 
•
Overdamped (𝜻> 𝟏): Sluggish response with no oscillation. 
•
Engineering Optimum: Usually designed at 𝜻≈𝟎. 𝟕𝟎𝟕to balance speed and stability. 
Exercise
Solution
Exercise
Solution
