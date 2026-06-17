# Tutorial 8 — 完整习题·解答·做题技巧

> **来源**: Tutorial 8 w solution - 2026.pdf (14 pages)
> **对应章节**: Lecture 8 — Methods and Correlations for K_La Calculation
> **主题**: 亚硫酸盐氧化法、动态法测定 K_La、K_La 关联式、OTR 计算

---

## 习题 1: 亚硫酸盐法预测连续发酵溶氧 — 停电生存分析

### 📝 题目

亚硫酸盐氧化法测得 $OTR = 67\ mmol\ O_2/L·hr$。连续发酵中 $\mu = 0.6\ hr^{-1}$，$X_F = 2\ g/L$，$Y_{X/O} = 1200\ mgX/gO_2$，$C^* = 0.21\ mmol/L$。

**A.** 求 $K_La$。 **(319 hr⁻¹)**

**B.** 求 OUR。 **(1 gO₂/L·hr)**

**C.** 求稳态 $C_L$。 **(0.112 mmol/L)**

**D.** 临界 $C_{L_{min}} = 0.021\ mmol/L$，发电机 20 秒启动，发酵能存活吗？

---

### 🔢 解答

#### A. $K_La$

亚硫酸盐法中 $C_L = 0$：

$$
K_La = \frac{OTR}{C^*} = \frac{67}{0.21} = \boxed{319\ hr^{-1}}
$$

#### B. OUR

$$
OUR = \frac{\mu X_F}{Y_{X/O}} = \frac{0.6 \times 2}{1.2} = \boxed{1\ \frac{gO_2}{L\cdot hr}}
$$

#### C. 稳态 $C_L$

$$
C_L = C^* - \frac{OUR}{K_La} = 0.21 - \frac{1 \times 1000/32}{319} = \boxed{0.112\ mmol/L}
$$

#### D. 停电分析

断电时 $OTR = 0$，$dC_L/dt = -OUR$：

$$
\Delta t_{safe} = \frac{C_L - C_{L_{min}}}{OUR} = \frac{(0.112 - 0.021) \times 32/1000}{1} = 2.9 \times 10^{-3}\ hr = 10.48\ sec
$$

$10.48 < 20\ sec$ → **发酵无法承受！** 建议发电机启动时间缩短至 10 秒以内。

---

### 🎯 做题技巧

1. **亚硫酸盐法**：$C_L = 0 \Rightarrow K_La = OTR/C^*$。这是最直接的测定方法。

2. **停电分析 = 动态法第一步**：$dC_L = -OUR \cdot dt$。计算 $C_L$ 从当前值降至 $C_{L_{min}}$ 的时间。

---

## 习题 2: 动态法测定 $K_La$ + 限制因子判断

### 📝 题目

500 L 罐批式发酵细菌。$S_0 = 70\ g/L$，$Y_{X/S} = 0.52$，$X_0 = 0.5\ g/L$，$Y_{X/O} = 0.85\ gX/gO_2$。

动态法实验：$t=2\ hr$ 时停气，$C_L$ 从 92.67% 经 15 sec 降至 40%；$t=8\ hr$ 时停气，$C_L$ 从 75.35% 经 5 sec 降至 15.45%。

**A.** 求 $K_La$。 **(~1737 hr⁻¹)**

**B.** 发酵何时结束？ **(14.75 hr，受氧限制)**

---

### 🔢 解答

#### A. $K_La$

**实验 1**（t=2 hr）：

$$
OUR_1 = -\frac{\Delta C_L}{\Delta t} = \frac{(0.9267 - 0.40)C^*}{15/3600} = 126.4\ C^*\ hr^{-1}
$$

$$
K_La(1) = \frac{OUR_1}{C^* - C_{L,2hr}} = \frac{126.4\ C^*}{C^* - 0.9267C^*} = 1724\ hr^{-1}
$$

**实验 2**（t=8 hr）：

$$
OUR_2 = \frac{(0.7535 - 0.1545)C^*}{5/3600} = 431.3\ C^*\ hr^{-1}
$$

$$
K_La(2) = \frac{431.3\ C^*}{C^* - 0.7535C^*} = 1749\ hr^{-1}
$$

平均：$K_La = \boxed{1736.5\ hr^{-1}}$

---

#### B. 发酵结束时间

**Step 1**: 由两次 OUR 之比求 $\mu$（$\mu$ 恒定）：

$$
\frac{OUR_2}{OUR_1} = \frac{X_{8hr}}{X_{2hr}} = \frac{431.3}{126.4} = 3.41
$$

$$
\mu = \frac{\ln(3.41)}{6\ hr} = 0.204\ hr^{-1}
$$

**Step 2**: 分别按糖限制和氧限制计算 $X_f$：

- 糖限制：$X_f^S = 0.52 \times 70 + 0.5 = 36.9\ g/L \to t = 21\ hr$
- 氧限制：$X_f^O = K_La \cdot C^* \cdot Y_{X/O} / \mu = 10.13\ g/L \to t = 14.75\ hr$

$X_f^O < X_f^S$ → **氧是限制因子**，$t = \boxed{14.75\ hr}$

---

### 🎯 做题技巧

1. **动态法求 $K_La$**：停气 → 测 $\Delta C_L/\Delta t$ → 得 $OUR$ → $K_La = OUR/(C^*-C_L)$。

2. **$\mu$ 由两次 OUR 之比求**：$OUR \propto X$（$\mu$ 和 $Y_{X/O}$ 不变），$\ln(X_2/X_1)/(t_2-t_1) = \mu$。

3. **双限制判断**：分别按糖和氧算 $X_f$，较小者为实际限制因子。

---

## 习题 3: K_La 关联式 — 小型发酵罐能力验证

### 📝 题目

3 L 几何体积（2 L 工作体积）二手发酵罐。$K = 42$，$D_T = 25\ cm$，$D_i = 6.7\ cm$，$N_{max} = 1000\ rpm$，$P = 5\times10^7\ g·cm^2/sec^3$，$Q_{air} = 50\ mL/sec$。$\mu_{max} = 1\ hr^{-1}$，$X_{max} = 2\ g/L$，$Y_{X/O} = 1.6$，$C_{L_{min}} = 0.015\ atm$（来自 $\mu$-$C_L$ 图）。

发酵罐能满足需氧吗？

---

### 🔢 解答

**Step 1**: $OUR_{max} = 1 \times 2 / 1.6 = 1.25\ gO_2/L·hr$

**Step 2**: 计算 $K_La$（小型罐关联式）：

$$
V_S = \frac{50 \times 60}{\pi \cdot (25/2)^2} = 6.1\ cm/min
$$

$$
P_g = 25 \times 10^{-3} \cdot \frac{P^2 \cdot N \cdot D_i^{3.7}}{Q^{0.56}} = 6.11 \times 10^{-3}\ HP
$$

$$
\frac{P_g}{V_L} = 3.06\ HP/1000L
$$

$$
K_La = 42 \times (3.06)^{0.95} \times (6.1)^{0.67} = 408.2\ \frac{mmol\ O_2}{L\cdot hr\cdot atm}
$$

**Step 3**: $OTR_{max} = 408.2 \times (0.21 - 0.015) \times 32/1000 = 2.55\ gO_2/L·hr$

$$
OTR_{max} = 2.55 > OUR_{max} = 1.25 \quad \boxed{\text{✅ 满足要求！}}
$$

---

### 🎯 做题技巧

1. **K_La 关联式**：小型罐 $K_La = K \cdot (P_g/V_L)^{0.95} \cdot V_S^{0.67}$。注意各参数单位。

2. **$P_g$（通气功率）**：$P_g = 25\times10^{-3} \cdot (P^2 N D_i^{3.7})/Q^{0.56}$，需单位换算为 HP。

3. **判断标准**：$OTR_{max} \ge OUR_{max}$ → 满足。

---

## 习题 4: 尾气法求 OTR 和 K_La

### 📝 题目

200 L 罐，28°C 培养枯草芽孢杆菌。尾气流量 189 L/min，含 20.1% O₂。溶氧电极显示 52% 饱和，$C^* = 7.8\ mg\ O_2/L$。

**A.** 求 OTR。 **(0.66 gO₂/L·hr)**

**B.** 求 $K_La$。 **(176.3 hr⁻¹)**

---

### 🔢 解答

#### A. OTR

进气 21% O₂，出气 20.1% O₂（假设 $P=1\ atm$）：

$$
OTR = Q_{out} \times \frac{P}{RT} \times (\%O_2^{in} - \%O_2^{out}) / V
$$

$$
OTR = 189 \times \frac{1 \times 60}{0.082 \times 301} \times (0.21 - 0.201) \times 32 / 200 = \boxed{0.66\ \frac{gO_2}{L\cdot hr}}
$$

#### B. $K_La$

$$
K_La = \frac{OTR}{C^* - C_L} = \frac{0.66}{7.8 \times 10^{-3} \times (1 - 0.52)} = \boxed{176.3\ hr^{-1}}
$$

---

## 综合技巧总结

| 方法 | 核心公式 | 适用场景 |
|------|---------|---------|
| **亚硫酸盐法** | $K_La = OTR/C^*$（$C_L=0$） | 离线测定，无生物 |
| **动态法** | $OUR = -\Delta C_L/\Delta t$，$K_La = OUR/(C^*-C_L)$ | 在线测定，停气法 |
| **尾气法** | $OTR = Q\Delta\%O_2 \cdot P/(RT)$ | 连续在线监测 |
| **关联式法** | $K_La = K(P_g/V_L)^\alpha V_S^\beta$ | 工程设计预测 |
