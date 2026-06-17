1. For the following circuit with 𝑅= 1 Ω and 𝐶= 1 𝐹. Please plot the system response 𝑣𝑜𝑢𝑡 
with the following four case inputs: 
1). 𝑣𝑖𝑛= 3.3 sin(2𝜋𝑡); 
2). 𝑣𝑖𝑛= 2 sin(10 ∗2𝜋𝑡); 
3). 𝑣𝑖𝑛= 4 sin(100 ∗2𝜋𝑡); 
4). 𝑣𝑖𝑛= 3.3 sin(2𝜋𝑡) + 4 sin(100 ∗2𝜋𝑡); Please explain the phenomenon you observed. 
5). Please plot the system gain as a function of the input frequency. 
 
In the complex frequency domain (𝑠-domain), the transfer function 𝐻(𝑠) of the system is: 
 
1) to 3) Theoretical Responses for Each Input Case 
+ - 
𝐶 
𝑅 
𝑣𝑖𝑛 
𝑣𝑜𝑢𝑡 
 
 
 
 
Explanation of Observed Phenomena 
 
 
 
 
2. A signal of sin 10𝜋𝑡 is interference by a noise of 0.5 sin 300𝜋𝑡. The details can be obtained 
by the following python code. 
sample_rate = 400 
N = 200  # Number of sample points 
T = 1 / sample_rate  # sample spacing 
t = np.linspace(0.0, N*T, N) 
f1 = 5 
f2 = 150 
signal_input = np.sin(f1 * 2.0*np.pi*t) 
noise = 0.5*np.sin(f2 * 2.0*np.pi*t) 
measurement = signal_input+noise 
 
Please do FFT analysis and get the frequency response (more details can be found here.)  
Please also use a Butterworth filter with cut off frequency of 50 Hz to filter the high 
frequency noise. Please plot the signal, noise, and measurement in Sub-figure 1. The FFT 
result in Sub-figure 2. The FFT result in dB scale in Sub-figure 3. The measurement, the 
signal, and the result after low pass filter in Sub-figure 4. Please also do a FFT with its 
original equation: 
 
And plot the result in Sub-figure 5. Please plot the Gain of the low-pass filter as well as the 
FFT of the measurement in Sub-figure 6. I have done it, and the figures are shown below 
for your reference. You can find the example code in the slides and if there is anything that 
you don’t understand, please search it online. 
 
Problem 3: 
 
(a) Mean and Standard Deviation 
 
Mean, 𝑦̅ 
 
Standard Deviation, 𝑠 
 
 
(b) 
 
