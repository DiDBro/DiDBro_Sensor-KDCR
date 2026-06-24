# Tutorial 10 -- 完整习题解答与做题技巧

> **来源**: Tutorial 10_Solutions.pdf (19 pages)
> **对应章节**: Strain Gauges, Wheatstone Bridge, Cantilever Mechanics, Force Sensors (Bentley Ch.8-9)
> **主讲**: Qilong Zhong, MSc, GTIIT

---
---

# 习题 1: 三种电桥配置对比 -- 公式都从电桥基本方程推出来

## 题目锁定

**关键词**: "全等臂 $R=120\Omega$", "$\Delta R=1.2\Omega$", "$E=4$V", "1/4桥/半桥/全桥"

**知识点**: 直流电桥三种配置的灵敏度。三个公式不是三个不同的东西——全部从同一个电桥基本方程推出来，只是应变片数量和接法不同。

## 物理原理：从同一个起点出发

电桥核心公式（两个分压臂的电压差）：

$$
U_o = E\left(\frac{R_1}{R_1+R_4} - \frac{R_2}{R_2+R_3}\right)
$$

初始状态四臂全等：$R_1=R_2=R_3=R_4=R=120\ \Omega$。电桥平衡（$U_o=0$）。

---

### 推导 1：1/4 桥 — 只有一个应变片

设 $R_1 = R + \Delta R$ 是唯一变化的臂，其余三个是固定电阻 $R$：

$$
\begin{aligned}
U_o &= E\left(\frac{R + \Delta R}{(R + \Delta R) + R} - \frac{R}{R + R}\right) \\[4pt]
    &= E\left(\frac{R + \Delta R}{2R + \Delta R} - \frac{1}{2}\right) \\[4pt]
    &= E \cdot \frac{2(R+\Delta R) - (2R+\Delta R)}{2(2R+\Delta R)} \\[4pt]
    &= \frac{\Delta R}{4R + 2\Delta R} \cdot E
\end{aligned}
$$

当 $\Delta R \ll R$ 时（小应变），分母中的 $2\Delta R$ 可忽略：

$$
\boxed{U_o \approx \frac{\Delta R}{4R} \cdot E}
$$

> **灵敏度系数 = 1/4**。$\Delta R$ 贡献的信号只占全桥信号的四分之一。

---

### 推导 2：半桥差分 — 邻臂一拉一压

关键：$R_1$ 受拉（$+\Delta R$），$R_2$ 在邻臂，受压（$-\Delta R$）。$R_3$ 和 $R_4$ 是固定电阻 $R$。

**邻臂的意思是** $R_1$ 和 $R_2$ 出现在不同的分压臂里——$R_1$ 在左臂的分子，$R_2$ 在右臂的分子。

代入电桥公式：

$$
\begin{aligned}
U_o &= E\left(\frac{R + \Delta R}{(R + \Delta R) + R} - \frac{R - \Delta R}{(R - \Delta R) + R}\right) \\[4pt]
    &= E\left(\frac{R + \Delta R}{2R + \Delta R} - \frac{R - \Delta R}{2R - \Delta R}\right)
\end{aligned}
$$

当 $\Delta R \ll R$，分母中的 $\pm\Delta R$ 可忽略：$2R+\Delta R \approx 2R$，$2R-\Delta R \approx 2R$：

$$
\begin{aligned}
U_o &\approx E\left(\frac{R + \Delta R}{2R} - \frac{R - \Delta R}{2R}\right) \\[4pt]
    &= E \cdot \frac{(R+\Delta R) - (R-\Delta R)}{2R} \\[4pt]
    &= E \cdot \frac{2\Delta R}{2R} = \frac{\Delta R}{2R} \cdot E
\end{aligned}
$$

$$
\boxed{U_o \approx \frac{\Delta R - (-\Delta R)}{4R} \cdot E = \frac{2\Delta R}{4R} \cdot E = \frac{\Delta R}{2R} \cdot E}
$$

> **灵敏度系数 = 1/2（2 倍 1/4 桥）**。分母中的 $\Delta R$ 在近似后消掉——但严格来说半桥差分有**精确的完全线性**（分母中的 $\pm\Delta R$ 在带入不近似时也会对消），这是它比 1/4 桥优越的地方。

---

### 推导 3：全桥差分 — 两拉两压交叉

最极限配置：四个臂全是应变片。$R_1$ 和 $R_3$（对臂）受拉（$+\Delta R$），$R_2$ 和 $R_4$（另一对臂）受压（$-\Delta R$）。

代入电桥公式：

$$
\begin{aligned}
U_o &= E\left(\frac{R + \Delta R}{(R + \Delta R) + (R - \Delta R)} - \frac{R - \Delta R}{(R - \Delta R) + (R + \Delta R)}\right) \\[4pt]
    &= E\left(\frac{R + \Delta R}{2R} - \frac{R - \Delta R}{2R}\right) \\[4pt]
    &= E \cdot \frac{(R+\Delta R) - (R-\Delta R)}{2R} \\[4pt]
    &= E \cdot \frac{2\Delta R}{2R} = \frac{\Delta R}{R} \cdot E
\end{aligned}
$$

$$
\boxed{U_o = \frac{\Delta R}{R} \cdot E}
$$

> **灵敏度系数 = 1（4 倍 1/4 桥）**。注意到分母中 $\pm\Delta R$ 在这一步 **已经完全消失了**——不需要近似！全桥差分的精确公式就是 $\frac{\Delta R}{R}E$，100% 线性。而且 $R_1$ 和 $R_4$、$R_2$ 和 $R_3$ 各自邻臂，同向温漂自动抵消。

---

### 为什么全桥分母里的 $\Delta R$ 会自动消失？

看 $R_1+R_4$：一个是 $R+\Delta R$（拉），一个是 $R-\Delta R$（压）。它们的和 = $(R+\Delta R)+(R-\Delta R) = 2R$ —— $\Delta R$ **直接对消**。

同理 $R_2+R_3 = (R-\Delta R)+(R+\Delta R) = 2R$ —— 两个分压臂的分母都变成常数 $2R$。这就是全桥天生线性、无需近似的根本原因。

---

### 三种配置对比

| 配置 | 推导结果 | 灵敏度系数 | 线性 | 温度补偿 |
|------|---------|-----------|------|---------|
| 1/4 桥 | $\frac{\Delta R}{4R}E$（近似） | ×1/4 | 非线性 | 无 |
| 半桥差分 | $\frac{\Delta R}{2R}E$（近似/精确一致） | ×1/2 | 完全线性 | 有 |
| 全桥差分 | $\frac{\Delta R}{R}E$（精确 = 近似） | ×1 | 完全线性 | 有 |

> 📖 **通用口诀**：$U_o \approx \frac{\Delta R_1 - \Delta R_2 + \Delta R_3 - \Delta R_4}{4R} \cdot E$。记住正负号——邻臂是减号（$-\Delta R_2$），对臂是加号（$+\Delta R_3$）。"一拉一压接邻臂 = 负负得正 = 叠加"。全桥 = 1/4 桥灵敏度的 4 倍。

## 套数计算

$\Delta R = 1.2\ \Omega$, $R = 120\ \Omega$, $E = 4$ V。

- **1/4 桥**：$U_o \approx \frac{1.2}{4\times120} \times 4 = \frac{1.2}{480} \times 4 = \boxed{0.01 \ \mathrm{V} = 10 \ \mathrm{mV}}$
- **半桥差分**：$U_o \approx \frac{1.2}{2\times120} \times 4 = \frac{1.2}{240} \times 4 = \boxed{0.02 \ \mathrm{V} = 20 \ \mathrm{mV}}$（2 倍）
- **全桥差分**：$U_o = \frac{1.2}{120} \times 4 = \boxed{0.04 \ \mathrm{V} = 40 \ \mathrm{mV}}$（4 倍）

## 做题技巧

1. **所有公式从同一个电桥基本方程出发**：$U_o = E(R_1/(R_1+R_4) - R_2/(R_2+R_3))$。代入不同的 $\Delta R$ 阵列即得不同结果。
2. **"一拉一压接邻臂"** 是黄金法则——记住 $-\Delta R_2$ 和 $+\Delta R_1$ 的符号关系。
3. 全桥分母中的 $\Delta R$ 自动消失 → 天生线性 + 不需要近似。
4. 1/4 桥唯一有非线性问题（见习题 5），半桥和全桥没有。

---
---

# 习题 2: 圆柱受压 -- 应变计算

## 题目锁定

**关键词**: "钢圆柱 $\phi5$cm×5cm", "$F=10^5$N", "$E=2\times10^{11}$Pa", "$\nu=0.3$"

**知识点**: 应力→应变→泊松横向应变。

## 物理原理

面积 $A = \pi(0.025)^2 = 1.963\times10^{-3}$ m²。

轴向应力 $\sigma = -10^5 / (1.963\times10^{-3}) \approx -5.09\times10^7$ Pa。

纵向应变 $\varepsilon_L = \sigma/E = -5.09\times10^7 / (2\times10^{11}) = \boxed{-2.546 \times 10^{-4}}$。

横向应变 $\varepsilon_T = -\nu\varepsilon_L = -0.3\times(-2.546\times10^{-4}) = \boxed{+7.639 \times 10^{-5}}$。

## 做题技巧

1. 压缩 → $\sigma$ 负 → $\varepsilon_L$ 负 → $\varepsilon_T$ 正（鼓胀）。
2. 圆面积 $A = \pi d^2/4$。

---
---

# 习题 3: 应变片电阻变化计算

## 题目锁定

**关键词**: "$R=120\Omega$", "$G=2.0$", "$\varepsilon_L=-2.546\times10^{-4}$", "$\varepsilon_T=+7.639\times10^{-5}$"

**知识点**: $\Delta R/R = G \cdot \varepsilon$。

## 套数计算

纵向片：$\Delta R = 120 \times 2.0 \times (-2.546\times10^{-4}) = \boxed{-0.0611 \ \Omega}$。

横向片：$\Delta R = 120 \times 2.0 \times (+7.639\times10^{-5}) = \boxed{+0.0183 \ \Omega}$。

> 纵向压缩 = 电阻减；横向膨胀 = 电阻增。

## 做题技巧

1. $\Delta R = R_0 G \varepsilon$。正负号有意义。
2. 压缩 → $-$；拉伸 → $+$。

---
---

# 习题 4: 悬臂梁布片与全桥接线

## 题目锁定

**关键词**: "悬臂梁", "四片应变片", "最大灵敏度+温度补偿", "布片位置+接线图"

**知识点**: 悬臂梁上拉下压, 两片贴上面(拉), 两片贴下面(压), 交叉接成全桥。

## 物理原理

**布片**：两片贴在靠近固定端的上表面（拉伸区），两片贴在下表面（压缩区）。

**接线**（交叉全桥）：
- $R_1$（上拉）和 $R_3$（上拉）接对臂
- $R_2$（下压）和 $R_4$（下压）接对臂
- $R_1$ 和 $R_2$ 邻臂 = 一拉一压, 差分叠加

结果：两拉两压交叉 → 全桥 4 倍输出 + 温度补偿。

## 做题技巧

1. 上拉下压是悬臂梁的"铁律"。
2. 靠近固定端 = 应变最大处。
3. 全桥 = 最大灵敏度 + 自温补。

---
---

# 习题 5: 1/4 桥非线性误差 -- 精确 vs 近似

## 题目锁定

**关键词**: "1/4 桥", "$R=120\Omega$, $G=2.0$", "$\varepsilon=1000\mu\varepsilon$", "$U_i=5$V", "精确输出电压", "非线性误差"

**知识点**: 1/4 桥的**精确公式**和**近似公式**是两回事。近似公式 `U_o ≈ ΔR/(4R) × U_i` 是课本给的简化版，精确公式分母里多一个 $2\Delta R$。这道题就是要你算两者的差——这就是**非线性误差**。

## 这两个公式到底差在哪？从电桥基本公式一步步推

你熟悉的电桥输出公式是基础：

$$
U_o = U_i\left(\frac{R_1}{R_1+R_4} - \frac{R_2}{R_2+R_3}\right)
$$

**1/4 桥**只有 $R_1$ 是应变片：$R_1 = R + \Delta R$。其余三个臂是固定电阻 $R_2=R_3=R_4=R$。**不做任何近似**, 直接代入：

$$
\begin{aligned}
U_o &= U_i\left(\frac{R + \Delta R}{(R + \Delta R) + R} - \frac{R}{R + R}\right) \\[6pt]
    &= U_i\left(\frac{R + \Delta R}{2R + \Delta R} - \frac{1}{2}\right) \\[6pt]
    &= U_i \cdot \frac{2(R + \Delta R) - 1\cdot(2R + \Delta R)}{2(2R + \Delta R)} \\[6pt]
    &= U_i \cdot \frac{2R + 2\Delta R - 2R - \Delta R}{4R + 2\Delta R} \\[6pt]
    &= \boxed{\frac{\Delta R}{4R + 2\Delta R} \cdot U_i}
\end{aligned}
$$

这就是**精确公式**。分母是 $4R + 2\Delta R$。

---

**近似公式怎么来的？** 当应变很小（$\Delta R \ll R$）时，分母中的 $2\Delta R$ 相对于 $4R$ 可忽略：

$$
U_o \approx \frac{\Delta R}{4R} \cdot U_i
$$

这就是课本上常见的简化版——**它假设 $\Delta R$ 小到对分母的影响可以忽略**。

> 📖 **两个公式的关系**：近似公式是精确公式在 $\Delta R/R \to 0$ 时的极限。$\Delta R$ 越大，两者的差越大。这道题 1000 με 的应变下 $\Delta R = 0.24\ \Omega$，仅 $0.2\%$ 的电阻变化，所以近似（2.500 mV）和精确（2.498 mV）几乎一样。但如果应变大到 $5000\ \mu\varepsilon$，$\Delta R = 1.2\ \Omega$（1% 变化），差就明显了。

---

**非线性误差 = 精确和近似的差**：

$$
\gamma_{NL} \approx \frac{U_{o,approx} - U_{o,exact}}{U_{o,approx}} \approx \frac{\Delta R}{2R} \times 100\%
$$

物理根源：$U_o$ 和 $\Delta R$ 不是严格正比关系——分母里藏着 $\Delta R$。应变越大，分母越大，输出"长得越慢"（曲线向下弯）。

## 套数计算

$\Delta R = 120 \times 2.0 \times 1000\times10^{-6} = 0.24 \ \Omega$。

**精确**：$U_o = \dfrac{0.24}{4\times120 + 2\times0.24} \times 5 = \dfrac{0.24}{480.48} \times 5 \approx \boxed{2.498 \ \mathrm{mV}}$

**近似**：$U_o \approx \dfrac{0.24}{480} \times 5 = \boxed{2.500 \ \mathrm{mV}}$

非线性误差 $\approx (2.500-2.498)/2.500 \approx 0.1\%$（小应变下确实可忽略）。

**消除方案**：把电路升级为**半桥差分**（一拉一压邻臂）。这时候精确公式变为：

$$
U_o = U_i\left(\frac{R+\Delta R}{(R+\Delta R)+(R-\Delta R)} - \frac{1}{2}\right)
     = U_i\left(\frac{R+\Delta R}{2R} - \frac{1}{2}\right)
     = \frac{\Delta R}{2R} \cdot U_i
$$

$\Delta R$ 从分母中**完全消掉**——精确 = 近似，100% 线性。这就是差分的魔力。

## 做题技巧

1. **精确公式** $U_o = \Delta R/(4R+2\Delta R) \cdot U_i$ — 从电桥基本公式直接推导，不做近似。
2. **近似公式** $U_o \approx \Delta R/(4R) \cdot U_i$ — 是精确公式在 $\Delta R \ll R$ 时的简化。**考试优先用这个，题目要求"精确输出"时才用前者**。
3. **非线性来源**：分母里有 $\Delta R$ → 输出不是严格正比。$\Delta R$ 越大越弯。
4. **差分消除**：一拉一压邻臂 → $\Delta R$ 从分母消掉 → 完全线性。

---
---

# 习题 6: 圆柱力传感器 -- 泊松差分全桥

## 题目锁定

**关键词**: "钢圆柱 $A=2\times10^{-3}$m²", "$F=200$kN", "两纵两横四片", "$G=2.0$, $R=120\Omega$", "$U_i=10$V"

**知识点**: 受压圆柱用泊松效应获得横向拉伸信号, 交叉接成全桥。

## 物理原理

$\sigma = -2\times10^5/(2\times10^{-3}) = -10^8$ Pa。

$\varepsilon_L = -10^8/(2\times10^{11}) = -5\times10^{-4}$。

$\varepsilon_T = -0.3\times(-5\times10^{-4}) = +1.5\times10^{-4}$。

纵向片 $\Delta R_L = 120\times2.0\times(-5\times10^{-4}) = -0.12 \ \Omega$。

横向片 $\Delta R_T = 120\times2.0\times(+1.5\times10^{-4}) = +0.036 \ \Omega$。

全桥输出：$U_o = \frac{2(1+\nu)\cdot|\Delta R_L|}{4R}U_i = \frac{2\times1.3\times0.12}{480}\times10$。

代入计算：

$$
\begin{aligned}
U_o &= U_i \cdot \frac{\Delta R_T - (-\Delta R_L) + \Delta R_T - (-\Delta R_L)}{4R} \\[4pt]
    &= U_i \cdot \frac{2(\Delta R_T + \Delta R_L)}{4R} \\[4pt]
    &= 10 \times \frac{2 \times (0.036 + 0.12)}{4 \times 120} \\[4pt]
    &= \boxed{0.0065 \ \mathrm{V} = 6.5 \ \mathrm{mV}}
\end{aligned}
$$

或直接代入 $(1+\nu)$ 因子：$U_o = \dfrac{2\times1.3\times0.12}{480}\times10 = 0.0065\ \mathrm{V} = 6.5\ \mathrm{mV}$。

> 两式等价：$2(\Delta R_T + \Delta R_L) = 2R\cdot G(\varepsilon_T + |\varepsilon_L|) = 2R\cdot G|\varepsilon_L|(1+\nu) = 2(1+\nu)|\Delta R_L|$。

**放大器增益**（若后续需要 5V 输出）：

$$
\boxed{K = \frac{V_{target}}{U_o} = \frac{5}{0.0065} \approx 769.2}
$$

## 做题技巧

1. **泊松 = 天然拉伸**：横向膨胀提供正向 $\Delta R$。
2. 输出系数 $2(1+\nu)/4$，约为传统全桥的 65%（因为横向应变只有纵向的 $\nu$ 倍）。
3. 仍具备完全线性和温度自补偿。

---
---

# 综合技巧总结

**电桥配置**: 1/4 桥(×1/4)→半桥差分(×1/2, 线性)→全桥差分(×1, 线性+温补)

**应力应变**: $\sigma=F/A \to \varepsilon_L=\sigma/E \to \varepsilon_T=-\nu\varepsilon_L \to \Delta R/R=G\varepsilon$

**悬臂梁**: 上拉下压, 靠近固定端, 一拉一压邻臂差分

**圆柱力传感器**: 泊松横向膨胀提供拉伸信号, 输出系数 $2(1+\nu)$
