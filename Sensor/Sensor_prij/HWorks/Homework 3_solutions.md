Please set up a light measurement circuit according to the figure below. Use an Arduino board to output 
a 5 Hz square wave to drive an LED. Then, build a light measurement system using a photoresistor 
and measure the voltage across it. 
1. Download the data from the oscilloscope and fit it using a first-order system equation 
 𝑉(𝑡) = 𝐴𝑒−𝑡
𝜏+ 𝐵 
to obtain the time constant τ for both the rising edge and the falling edge by data fitting. Why are 
these two time constants different? 
Solution: 
 
Data Fitting and Time Constant Analysis 
𝑉(𝑡) = 𝐴𝑒−𝑡
𝜏+ 𝐵 
Edge Type 
Physical Process 
Fitted Time Constant (τ) Fitted Equation (Representative) 
Rising Edge 
LED OFF (Dark 
Recovery) 
𝝉𝒓𝒊𝒔𝒆≈𝟔𝟎. 𝟓𝟖 ms 
𝑉(𝑡) = −0.85𝑒−
𝑡
60.58 + 1.45 
Falling Edge 
LED ON (Photo-
excitation) 
𝝉𝒇𝒂𝒍𝒍≈𝟗.𝟖𝟕 ms 
𝑉(𝑡) = 1.72𝑒−𝑡
9.87 + 0.62 
Why are these two time constants different? 
The experimental results demonstrate a significant asymmetry in the dynamic response: the dark 
recovery process (rising edge) is much slower than the photo-excitation process (falling edge). 
This discrepancy is fundamentally rooted in the semiconductor physics of the photoresistor (typically 
Cadmium Sulfide, CdS): 
Photo-excitation (Falling Edge - Faster): 
When the LED is turned on, high-energy photons strike the semiconductor material. Electrons in the 
valence band absorb this energy and are instantaneously promoted to the conduction band, generating 
a high concentration of electron-hole pairs. Since the injection of photons provides a rapid and 
powerful energy source, the generation of carriers occurs almost immediately, leading to a swift 
decrease in resistance. This process is primarily limited by the carrier generation rate, resulting in a 
smaller time constant (≈ 9.87 ms). 
Dark Recovery (Rising Edge - Slower): 
When the LED is turned off, the excess carriers in the conduction band must recombine with holes to 
return to the initial high-resistance "dark" state. However, polycrystalline materials like CdS contain a 
high density of trap states (defects within the crystal lattice). During the recombination process, 
electrons are frequently captured by these traps and only released slowly. This "trapping effect" 
significantly retards the rate at which the carrier concentration returns to equilibrium. Consequently, 
the dark recovery exhibits a long "tail" in its response, leading to a much larger time constant (≈60.58 
ms). 
 
2. Record the peak-to-peak voltage from the previous case. Then increase the square wave frequency 
to 50 Hz, 500 Hz, and 5000 Hz, and measure the peak-to-peak voltage for each case. 
 
 
Frequency Response Measurement 
Frequency 
(Hz) 
Peak-to-Peak Voltage 
𝑽𝒑𝒑 (V) 
Result 
5  
1.84 V 
 
50 
1.12 V 
 
500 
0.48 V 
 
5000 
0.32 V 
 
3. Use your knowledge of system transfer functions to explain your observations in part (2). 
System Transfer Function Explanation 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
