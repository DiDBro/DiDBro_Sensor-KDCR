# Tutorial 12 -- 完整习题解答与做题技巧

> **来源**: Tutorial 12 with Solutions.pdf (17 pages)
> **对应章节**: Second-order Sensors, Strain Gauges, Bridge Circuits, Load Cells (Bentley Ch.4, 8-9)
> **主讲**: Qilong Zhong, MSc, GTIIT

---
---

# 习题 1: 二阶力传感器

## 题目锁定

**关键词**: "mass 0.5 kg", "stiffness $2\times10^2$ N/m", "damping 6.0 Ns/m", "steady-state sensitivity", "natural frequency", "damping ratio"

**知识点**: 二阶 spring-mass-damper 系统的三个核心参数。

## 物理原理

二阶机械系统方程：$m\ddot{x} + c\dot{x} + kx = F$。

- 稳态灵敏度 $K = 1/k$（力→位移）
- 自然频率 $\omega_n = \sqrt{k/m}$
- 阻尼比 $\xi = c/(2\sqrt{mk})$

## 套数计算

$K = 1/200 = 0.005$ m/N。$\omega_n = \sqrt{200/0.5} = 20$ rad/s。$\xi = 6.0/(2\sqrt{100}) = 0.3$。

稳态位移 $x = KF = 0.005 \times 2 = 0.01$ m。

---
---

# 习题 2: 弹性力传感器 + 传递函数

## 题目锁定

**关键词**: "mass 0.1 kg", "stiffness 10 N/m", "damping 14 Ns/m", "transfer function"

**知识点**: 严重过阻尼($\xi=7.0$)的二阶系统传递函数推导。

## 物理原理

$m\ddot{x} + c\dot{x} + kx = F$ → 拉氏变换：$(ms^2 + cs + k)X(s) = F(s)$ → $G(s) = \frac{X(s)}{F(s)} = \frac{1}{ms^2 + cs + k}$。

## 套数计算

$\omega_n = \sqrt{10/0.1} = 10$ rad/s。$\xi = 14/(2\sqrt{1}) = 7.0$（严重过阻尼！）。

$$
\boxed{G(s) = \frac{1}{0.1s^2 + 14s + 10} = \frac{10}{s^2 + 140s + 100}}
$$

---
---

# 习题 3: 地震质量加速度计 -- 弹簧·气隙·电感

## 题目锁定

**关键词**: "seismic mass accelerometer", "$f_n=25$ Hz", "0 to 5g", "variable reluctance", "$W=500$ turns", "gap at zero accel = 3 mm"

**知识点**: 加速度计的力学-电磁耦合设计。

## 物理原理

**(a) 弹簧刚度**：$\omega_n = 2\pi f_n = 50\pi \approx 157$ rad/s → $k = m\omega_n^2 = 0.025 \times (50\pi)^2 \approx 616.9$ N/m。

**(b) 最大加速度气隙**：$a_{max} = 5g = 49.05$ m/s²。惯性力 $F = ma = 1.226$ N。位移 $x = F/k \approx 1.99 \times 10^{-3}$ m。气隙从 3 mm 缩小至 $3 - 1.99 \approx 1.01$ mm。

**(c) 电感变化范围**：总磁阻 = 铁芯磁阻 + 衔铁磁阻 + 两气隙磁阻。$R_{iron} = 16/\mu_0$, $R_{gap} = 80000d/\mu_0$。

$L(d) = \frac{N^2}{R_{total}} = \frac{0.1\pi}{16 + 80000d}$ H。

$d=3$ mm → $L \approx 0.01227$ H = 12.27 mH；$d=1$ mm → $L \approx 0.03272$ H = 32.72 mH。

$\Delta L \approx 20.4$ mH。

## 做题技巧

1. $f_n$ → $\omega_n$ → $k = m\omega_n^2$。
2. 加速度 → 惯性力 → 位移 → 新气隙。
3. 电磁部分：磁路串联合并，铁芯磁阻远小于气隙。

---
---

# 习题 4: 钢棒受压 -- 应力应变

## 题目锁定

**关键词**: "$A=10^{-3}$ m²", "$E=2\times10^{11}$ Pa", "$\nu=0.4$", "$F=-10^5$ N (compressive)"

## 套数计算

$\sigma = -10^5 / 10^{-3} = -10^8$ Pa。

$\varepsilon_L = \sigma/E = -10^8/(2\times10^{11}) = -5 \times 10^{-4}$。

$\varepsilon_T = -\nu \cdot \varepsilon_L = -0.4 \times (-5\times10^{-4}) = +2 \times 10^{-4}$。

---
---

# 习题 5: 应变片电阻变化

## 题目锁定

**关键词**: "$R_0=120\Omega$", "$G=2.0$", longitudinal $\varepsilon_L=-5\times10^{-4}$, transverse $\varepsilon_T=+2\times10^{-4}$

## 套数计算

$\Delta R_L = 120 \times 2.0 \times (-5\times10^{-4}) = -0.12\ \Omega$ → $R_L = 119.88\ \Omega$。

$\Delta R_T = 120 \times 2.0 \times (2\times10^{-4}) = +0.048\ \Omega$ → $R_T = 120.048\ \Omega$。

---
---

# 习题 6: 扭矩测量 -- 全桥设计 ⭐⭐

## 题目锁定

**关键词**: "torque on cylindrical shaft", "4 cm diameter", "4 strain gauges", "shear modulus $S=1.1\times10^{11}$", "$G=2.1$, $R=120\Omega$, $I_{max}=50$ mA", "$T=10^3$ Nm"

**知识点**: 圆轴扭转的 45° 主应力方向应变 + 桥路最大电流约束 + 全桥输出。

## 物理原理

扭转产生的主应变（45° 方向）：$\varepsilon = \pm T/(\pi S a^3)$，$a$ = 半径。

桥路电流约束：每臂两片串联 = $240\Omega$，$V_S = I_{max} \times 240 = 12$ V。

全桥输出：$V_{out} = V_S \cdot G \cdot \varepsilon$。

## 套数计算

$a = 0.02$ m。$\varepsilon = 10^3 / (\pi \times 1.1\times10^{11} \times 0.02^3) \approx 3.617 \times 10^{-4}$。

$V_S = 0.05 \times 240 = 12$ V。

$V_{out} = 12 \times 2.1 \times 3.617\times10^{-4} \approx 9.12$ mV。

## 做题技巧

1. 扭矩应变公式 $\varepsilon = T/(S a^3)$（题目给出，直接套）。
2. 桥路最大电流约束：$I_{max}$ 流过每臂两个串联应变片。
3. 布片：45° 方向，两拉两压交叉成全桥。

---
---

# 习题 7: 圆柱力传感器 + 差分放大器 ⭐⭐

## 题目锁定

**关键词**: "domed steel cylinder", "20 cm × 15 cm", "10 cm square flats", "two longitudinal compression + two transverse tension", "$R=100\Omega$, $G=2.1$, $I_{max}=30$ mA", "$F=10^5$ N", "amplifier output 1 V"

**知识点**: 泊松效应交叉全桥 + 差分放大器增益设计。

## 物理原理

方截面 $A = 0.1 \times 0.1 = 0.01$ m²。$\sigma = -10^5/0.01 = -10^7$ Pa。

$\varepsilon_L = \sigma/E = -10^7/(2.1\times10^{11}) \approx -4.76\times10^{-5}$。

$\varepsilon_T = -\nu \varepsilon_L = 0.29 \times 4.76\times10^{-5} \approx 1.38\times10^{-5}$。

两纵($-\varepsilon_L$)两横($+\varepsilon_T$)交叉全桥。

全桥输出（泊松差分形式）：$V_{out} = \frac{V_S \cdot G \cdot (\varepsilon_L + \varepsilon_T)}{2} = \frac{V_S \cdot G \cdot \varepsilon_L \cdot (1+\nu)}{2}$。

桥源电压约束：$I_{max}=30$ mA，每臂 $200\Omega$，$V_S = 0.03 \times 200 = 6$ V。

$V_{out} = \frac{6 \times 2.1 \times 4.76\times10^{-5} \times 1.29}{2} \approx 3.87 \times 10^{-4}$ V。

放大器增益 $K = 1 / (3.87\times10^{-4}) \approx 2584$。

## 做题技巧

1. 纵向压缩→$-$，横向泊松膨胀→$+$，邻臂一拉一压差分配。
2. 泊松差分全桥输出含 $(1+\nu)$ 因子。
3. 桥压约束 = $I_{max} \times$ 单臂串联电阻。
4. 放大器增益 = 目标输出 / 桥路输出。

---
---

# 综合技巧总结

**二阶系统参数**: $K=1/k$, $\omega_n=\sqrt{k/m}$, $\xi=c/(2\sqrt{mk})$

**加速度计**: $f_n \to \omega_n \to k=m\omega_n^2 \to F=ma \to x=F/k$

**应变片**: $\Delta R = R_0 G \varepsilon$；全桥 $V_{out} = V_S G \varepsilon$

**扭矩**: $\varepsilon = T/(S a^3)$，45° 布片

**泊松全桥**: $V_{out} \propto V_S G \varepsilon_L (1+\nu)$

**增益设计**: $K = V_{target} / V_{bridge}$

## 分析这个题的三个层次

### 第一层：锁定公式（题目→关键词→公式）

看到电路图里有**电阻 R 和电容 C 串联、输出从电容两端取**，这就是**一阶 RC 低通滤波器**。

核心公式就一个：

$$ \boxed{f_c = \frac{1}{2\pi RC}} $$

不需要推导。这是定义。记住就行。

---

### 第二层：代入数字（注意单位）

$R = 1\ \Omega$，$C = 1\ \mu\mathrm{F}$。

**最大的坑是单位**：$1\ \mu\mathrm{F} = 1 \times 10^{-6}\ \mathrm{F}$。

直接代入：

$$ f_c = \frac{1}{2\pi \times 1 \times 10^{-6}} = \frac{10^6}{2\pi} \approx 1.59 \times 10^5\ \mathrm{Hz} = 159\ \mathrm{kHz} $$

---

### 第三层：理解含义（为什么叫"截止频率"）

**物理上发生了什么**：

|频率区域|电容行为|输出情况|
|---|---|---|
|$f \ll f_c$（低频）|电容阻抗 $Z_C = 1/(j\omega C)$ 很大 → 分到的电压多|**信号通过**|
|$f = f_c$（截止点）|$Z_C = R$|幅值降到 $1/\sqrt{2} \approx 0.707$（-3 dB）|
|$f \gg f_c$（高频）|电容近似短路 → 分到的电压趋近 0|**信号被滤掉**|

$$ |H(j\omega)| = \frac{1}{\sqrt{1 + (\omega RC)^2}} = \frac{1}{\sqrt{1 + (f/f_c)^2}} $$

当 $f = f_c$ 时，$|H| = 1/\sqrt{2}$。**截止频率就是输出功率降到一半的频率**（-3 dB 点）。

---

### 做题时脑子里的完整链条

```
看到 R 和 C → 锁定低通滤波器 → 掏出 f_c = 1/(2πRC) → 注意 μF 转成 10⁻⁶ → 按计算器 → 写答案 → 标注单位 Hz
```

整个过程不超过 30 秒。10 分题考的就是**记不记得公式**和**会不会换算 μF**，没有第二个坑。