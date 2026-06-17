Qilong Zhong, MSc
Mechanical Engineering and Robotics
Guangdong Technion - Israel Institute of Technology
qilong.zhong@gtiit.edu.cn
March, 2026
Tutorial Course for Intro to Sensor-
Integrated Systems
Step Response of First-order Systems
Engineering Background: Commonly used to describe components without mass or inertia, such as temperature sensors 
(thermocouples) in integrated sensor systems, liquid-level systems, and RC low-pass filter circuits.
➢These systems only exhibit "resistance" and "capacitance" characteristics.
Core Dynamic Parameter: Time Constant 𝝉
➢Physical Significance: The core indicator determining the speed of the system response. The smaller the 𝜏, the faster 
the sensor tracks the true signal.
➢Thermodynamic Definition: 𝜏=
𝑀𝐶
𝑈𝐴
Mathematical Model for Step Response:
When the system is subjected to a step input of height Δ𝐼, the transient change in output is:
Δ𝑂𝑡= 𝐾⋅Δ𝐼⋅1 −𝑒−𝑡/𝜏
(Note: 𝐾is the steady-state sensitivity of the system)
Key Points:
➢When 𝑡= 𝜏, the sensor output reaches 63.2% of its final steady-state change.
➢When 𝑡= 4𝜏∼5𝜏, the system basically reaches its new steady state.
Step Response of Second-order Systems
Engineering Background:
➢Used to describe physical mechanisms containing "inertia," such as mechanical elastic force sensors and
accelerometers.
➢Due to the presence of mass (𝑚), springs (𝑘), and dampers (𝜆), the system is prone to overshoot and oscillation when
subjected to a step impact.
Two Core Dynamic Parameters:
➢Natural Frequency 𝝎𝒏: 𝜔𝑛=
𝑘/𝑚. Determines the speed of the system's inherent oscillation.
➢Damping Ratio 𝝃: 𝜉=
𝜆
2 𝑘𝑚. Measures the system's ability to dissipate energy and suppress oscillation (the optimal
engineering design value is usually 𝜉≈0.7).
Mathematical Model for Underdamped (𝝃< 𝟏) Step Response:
Δ𝑂𝑡= 𝐾⋅Δ𝐼⋅1 −𝑒−𝜉𝜔𝑛𝑡
cos𝜔𝑑𝑡+
𝜉
1 −𝜉2 sin𝜔𝑑𝑡
(Note: Damped natural frequency 𝜔𝑑= 𝜔𝑛
1 −𝜉2)
Key Points:
Waveform Characteristics: The exponential decay term 𝑒−𝜉𝜔𝑛𝑡determines the Settling Time (𝑇𝑠≈
5
𝜉𝜔𝑛), while the
trigonometric terms determine the oscillation frequency.
Exercise
Solution
Solution
Exercise
Solution
How to Handle Complex Periodic Signals?
Engineering Pain Point: Real-world signals are not perfect.
➢In industrial settings (e.g., fluid pulsation, mechanical vibration), sensors often receive continuous periodic signals with 
complex waveforms rather than a single pure sine wave.
➢Fourier Series: Any complex periodic signal can be "decomposed" into a superposition of a series of sine waves of 
different frequencies (Fundamental + Higher Harmonics).
General Response Model: "Deformation" of a Sine Wave
When the input is a single-frequency signal 𝐼𝑡= 𝐴𝑖sin 𝜔𝑡, the steady-state output of a linear system must be a sine 
wave of the same frequency:
𝑂𝑡= 𝐴𝑖⋅𝐺𝑗𝜔
⋅sin 𝜔𝑡+ 𝜙
➢Amplitude Ratio ( 𝑮): Determines whether the frequency signal is amplified or attenuated.
➢Phase Shift (𝝓): Determines the time lag (or lead) angle of the frequency signal.
The Ultimate Problem-Solving Weapon: Superposition Principle
➢Total Output = The direct sum of the system's responses to each individual single-frequency input (fundamental, 2nd 
harmonic, 3rd harmonic, etc.).
"Frequency Fingerprints" of First and Second-order Systems
First-order Systems (e.g., Thermocouples, RC Filter Circuits)
➢Amplitude Ratio: 𝐺𝑗𝜔
=
𝐾
1+ 𝜔𝜏2
➢Phase Shift: 𝜙= −arctan 𝜔𝜏
➢Engineering Characteristics: Natural Low-pass Filter. Low-frequency signals pass through with almost no loss
(amplitude ratio close to 1), while high-frequency signals are severely attenuated.
Second-order Systems (e.g., Mechanical Force Transducers, Accelerometers)
➢Amplitude Ratio: 𝐺𝑗𝜔
=
𝐾
1−
𝜔
𝜔𝑛
2 2
+ 2𝜉𝜔
𝜔𝑛
2
➢Phase Shift: 𝜙= −arctan
2𝜉𝜔
𝜔𝑛
1−
𝜔
𝜔𝑛
2
➢Engineering Characteristics: Hidden Resonance Crisis. When the input frequency 𝜔approaches the system's
undamped natural frequency 𝜔𝑛and the damping ratio 𝜉is small, destructive Resonance Amplification occurs,
leading to severe measurement distortion.
Exercise
Solution
Exercise
Solution
Solution
Solution
Solution
Open-loop Dynamic Compensation
Core Philosophy: Mathematical Cancellation
➢When the physical characteristics of a sensor are poor (e.g., the time constant 𝜏is too large, leading to a sluggish 
response) and cannot be changed physically, we can series-connect an electronic compensation circuit (such as a 
lead-lag network) at its output.
➢Zero-Pole Cancellation: Design the transfer function of the circuit to generate a "zero" that precisely cancels out the 
"pole" of the original sensor, while introducing a new pole with a much smaller time constant.
Mathematical Expression:
➢Original Sensor: 𝐺𝑠𝑠=
1
1+𝜏𝑠𝑙𝑜𝑤𝑠
➢Compensation Circuit: 𝐺𝑐𝑠=
1+𝜏𝑠𝑙𝑜𝑤𝑠
1+𝜏𝑓𝑎𝑠𝑡𝑠
➢Total Transfer Function: 𝐺𝑡𝑜𝑡𝑎𝑙𝑠= 𝐺𝑠𝑠⋅𝐺𝑐𝑠=
1
1+𝜏𝑓𝑎𝑠𝑡𝑠
Engineering Pros & Cons:
➢Pros: Low cost and simple to implement; significantly broadens the flat bandwidth of the system.
➢Fatal Weakness: Extremely poor anti-interference capability. If environmental changes cause the sensor's physical 
𝜏𝑠𝑙𝑜𝑤to drift (parameter mismatch), the "perfect cancellation" will fail completely.
Closed-loop Negative Feedback Architecture
Core Philosophy: The Ultimate Architectural Revolution
➢Stop letting the sensor "fight alone." Instead, introduce a feedback loop that converts the output signal back into a 
physical quantity at the input, comparing it in real-time with the original input (finding the error). The system then only 
responds to the "net error."
A Leap in Engineering Performance (Example: Force-Balanced Accelerometer):
➢Explosive Bandwidth & Speed: The natural frequency of the closed-loop system 𝜔𝑛𝑐is much higher than that of the 
open-loop sensor 𝜔𝑛.
➢Perfect Dynamic Damping: By adjusting the circuit magnification, the closed-loop damping ratio 𝜉𝑐can be locked at 
the optimal 0.7, completely eliminating annoying mechanical oscillations.
➢Ultimate Robustness: Steady-state sensitivity 𝐾is no longer affected by aging mechanical parameters (like spring 
stiffness); instead, it depends on highly stable electronic components (standard resistors) and magnetic field strength.
Exercise
Solution
Solution
Solution
Exercise
