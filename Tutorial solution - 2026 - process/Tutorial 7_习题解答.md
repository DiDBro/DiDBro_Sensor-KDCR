# Tutorial 7 — 完整习题·解答·做题技巧

> **来源**: Tutorial 7 w solution - 2026.pdf (15 pages)
> **对应章节**: Lecture 7 — Oxygen Transfer (Bentley Ch.9)
> **主题**: 氧传质系数 (K_La)、临界溶氧、OUR/OTR 平衡、Henry 定律、逐步富氧策略

---

## 习题 1: 逐步富氧批式发酵 — 时间表与末次氧含量

### 📝 题目

120 m³ 罐批式发酵酵母产蛋白（占菌体 45%），每批目标 1000 kg 纯蛋白（纯化产率 92.6%）。$t_d = 72\ min$，$Y_{X/O} = 0.825\ gX/gO_2$，$C_{L_{min}} = 0.125\ mM$。$P = 3\ atm$，$K_La = 700\ hr^{-1}$。接种 6 kg 酵母。

初始进空气 21% O₂，$C^* = 9\ ppm$。每当 $C_L$ 降至 $C_{L_{min}}$ 时，O₂ 含量梯度增加 15%（36% → 51% → 66%...）。Henry 常数 $H = 70\ atm·L/gO_2$。

**A.** 规划富氧时间表。

**B.** 最后一次富氧应加多少 O₂ 才能避免浪费？

---

### 🔢 解答

#### A. 富氧时间表

**Step 1**: 基本参数

$$
\mu = \frac{\ln 2}{t_d} = \frac{0.693}{1.2\ hr} = 0.578\ hr^{-1}
$$

$$
X_0 = \frac{6000\ g}{120,000\ L} = 0.05\ g/L
$$

目标蛋白产量：$W_P^{clean} = 1000 \to W_P^{crude} = 1000/0.926 = 1080\ kgP$

$$
P_f = \frac{1080 \times 1000}{120,000} = 9\ gP/L
$$

$$
X_f = \frac{P_f}{Y_{P/X}} + X_0 = \frac{9}{0.45} + 0.05 = 20.05\ gX/L
$$

$C_{L_{min}} = 0.125\ mM \times 32\ mg/mmol = 0.004\ gO_2/L$

---

**Step 2**: 第一次富氧（$C_1^* = 9\ ppm$，21% O₂）

由 $OTR = OUR$ 即 $K_La(C^* - C_{L_{min}}) = \mu X / Y_{X/O}$：

$$
X_{t1} = \frac{700 \times (0.009 - 0.004)}{0.578 / 0.825} = 5\ g/L
$$

$$
\Delta t_1 = \frac{\ln(5/0.05)}{0.578} = \boxed{7.97\ hr} \to \text{36%}
$$

---

**Step 3**: 第二次富氧（$C_2^* = 3 \times 0.36 / 70 = 0.015\ g/L$）

$$
X_{t2} = \frac{700 \times (0.015 - 0.004)}{0.578 / 0.825} = 11\ g/L
$$

$$
\Delta t_2 = \frac{\ln(11/0.05)}{0.578} = \boxed{9.33\ hr} \to \text{51%}
$$

---

**Step 4**: 第三次富氧（$C_3^* = 3 \times 0.51 / 70 = 0.022\ g/L$）

$$
X_{t3} = \frac{700 \times (0.022 - 0.004)}{0.578 / 0.825} = 18\ g/L
$$

$$
\Delta t_3 = \frac{\ln(18/0.05)}{0.578} = \boxed{10.2\ hr} \to \text{66%}
$$

此时 $X_{t3} = 18 < 20.05$，但第四次将超（$X_{t4} = 24 > 20.05$），需精确控制最后一次。

---

#### B. 末次精确 O₂ 含量

设 $X_f = 20.05$ 时的 $C^*$ 为 $C^*_{last}$：

$$
C^*_{last} = \frac{0.578 \times 20.05}{700 \times 0.825} + 0.004 = 0.024\ g/L
$$

Henry 定律：

$$
\%O_2 = \frac{0.024 \times 70}{3} = \boxed{56\%}
$$

---

### 🎯 做题技巧

1. **Henry 定律**：$C^* = P \cdot \%O_2 / H$。$H$ 从初始条件求出：$H = 3 \times 0.21 / 0.009 = 70$。

2. **$OTR = OUR$ 求解 $X$**：$X = K_La \cdot (C^* - C_{L_{min}}) \cdot Y_{X/O} / \mu$。用此公式逐个判断何时 $C_L$ 降至临界值。

3. **$C_{L_{min}}$ 单位转换**：$0.125\ mM = 0.125 \times 32\ mg/mmol = 0.004\ g/L$。

---

## 习题 2: 操作失误 — 同时改变 O₂% 和 K_La

### 📝 题目

学生误操作使空气 O₂ 翻倍，又误降搅拌速度。原始 $C_L = 0.8C^*$，稳定后 $C_L^{new} = 0.75C^*_{new}$。5 m³ 罐，接种 890 g，$t_{lag}=2\ hr$，$t_{log}=15\ hr$，$t_d=8603\ sec$，$Y_{X/O}=0.799\ gX/gO_2$。

**A.** K_La 变化了几倍？

**B.** 发酵何时结束？

---

### 🔢 解答

#### A. K_La 变化

操作迅速 → $OUR$ 不变 → $OTR$ 不变。

$$
\frac{K_La^{new}}{K_La} = \frac{OTR/(C^* - C_L)^{new}}{OTR/(C^* - C_L)} = \frac{C^* - C_L}{(C^* - C_L)^{new}}
$$

$\%O_2^{new} = 2\%O_2 \Rightarrow C^*_{new} = 2C^*$

$$
\frac{K_La^{new}}{K_La} = \frac{C^* - 0.8C^*}{2C^* - 0.75 \cdot 2C^*} = \frac{0.2}{0.5} = 0.4
$$

$$
\boxed{K_La^{new} = \frac{1}{2.5} K_La \text{（下降了 2.5 倍）}}
$$

---

#### B. 新发酵时间

$\mu = \ln 2 / 2.39 = 0.29\ hr^{-1}$，$X_0 = 890/5000 = 0.178\ g/L$

原始：$X_f = 0.178 \times e^{0.29 \times 15} = 13.79\ g/L$

新终浓度（氧为限制因子，$OTR_{max} = K_La \cdot C^*$）：

$$
\frac{X_f^{new}}{X_f} = \frac{(K_La \cdot C^*)^{new}}{(K_La \cdot C^*)} = \frac{1}{2.5} \times 2 = 0.8
$$

$$
X_f^{new} = 0.8 \times 13.79 = 11\ g/L
$$

$$
t_{log}^{new} = \frac{\ln(11/0.178)}{0.29} = 14.23\ hr
$$

$$
t_{tot} = 2 + 14.23 = \boxed{16.23\ hr}
$$

---

### 🎯 做题技巧

1. **$K_La$ 比率法**：利用 $OTR$ 不变条件，$K_La^{new}/K_La = (C^*-C_L)/(C^*-C_L)^{new}$。

2. **$C^* \propto \%O_2$**：由 Henry 定律直接正比。

3. **氧限制时 $X_f \propto K_La \cdot C^*$**：两个变化的影响可乘性叠加（×2 × 1/2.5 = ×0.8）。

---

## 习题 3: 连续发酵 OUR + Cooney + K_La 优化

### 📝 题目

连续发酵细菌，$D = 0.8\ hr^{-1}$，$S_0 = 9\ g/L$（99% 利用），$Y_{X/S} = 45\%$，$Y_{X/O} = 1.2\ gX/gO_2$，$K_S = 90\ mg/L$。放热 3,648 Kcal/day。$P = 1.75\ atm$，$T = 35°C$，$C^* = 8\ ppm$，$C_L = 15\%\ C^*$。

**A.** 生物质生产率 $G_X$？ **(48.77 gX/hr)**

**B.** 空气流量（8% 溶解）？ **(1,091 L/hr)**

**C.** $K_La$ 翻倍后 $C_L^{new}$？ **(0.0046 g/L = 4.6 ppm)**

**D.** 不冲洗的最大 $D$？ **(1.6 hr⁻¹)**

---

### 🔢 解答

#### A. $G_X$

Cooney 方程 + 连续发酵稳态：

$$
Q_{ferm} = 3.74 \cdot OUR \cdot V = 3.74 \cdot \frac{\mu X}{Y_{X/O}} \cdot V
$$

$$
Q_{ferm} = 3.74 \cdot \frac{D \cdot G_X / D}{Y_{X/O}} = 3.74 \cdot \frac{G_X}{Y_{X/O}}
$$

$$
G_X = \frac{152 \times 1.2}{3.74} = \boxed{48.77\ gX/hr}
$$

---

#### B. 空气流量

$OUR \cdot V = G_X / Y_{X/O} = 48.77/1.2 = 40.64\ gO_2/hr$

理想气体换算（21% O₂，8% 溶解）：

$$
LPH = 40.64 \times \frac{0.082 \times 308}{1.75} \times \frac{100}{21} \times \frac{1}{0.08} = \boxed{1,091\ L/hr}
$$

---

#### C. $K_La$ 翻倍

$OTR = K_La(C^* - C_L)$ 不变：

$$
2K_La(C^* - C_L^{new}) = K_La(C^* - 0.15C^*) \Rightarrow C_L^{new}/C^* = 0.575
$$

$$
C_L^{new} = 0.575 \times 8 = \boxed{4.6\ ppm}
$$

---

#### D. 最大 $D$

由 Monod 反推 $\mu_{max}$：

$$
\mu_{max} = D \cdot \frac{K_S + S_F}{S_F} = 0.8 \times \frac{0.09 + 0.09}{0.09} = 1.6\ hr^{-1}
$$

$$
D_c = \mu_{max} = \boxed{1.6\ hr^{-1}}
$$

---

## 综合技巧总结 (Global Strategy Summary)

| 题型 | 核心公式 | 易错点 |
|------|---------|--------|
| **OTR=OUR 平衡** | $K_La(C^*-C_L) = \mu X/Y_{X/O}$ | $C_L=C_{L_{min}}$ 时的 $X$ 是关键节点 |
| **Henry 定律** | $C^* = P \cdot \%O_2 / H$ | 先由已知条件求 $H$ |
| **逐步富氧** | 每次用新 $C^*$ 重算 $X_{ti}$ | $C^*$ 随 $\%O_2$ 线性变化 |
| **$K_La$ 比率** | $K_La^{new}/K_La = (C^*-C_L)/(C^*-C_L)^{new}$ | 快速变化时 $OTR$ 不变 |
| **Cooney 定律** | $Q_{ferm} = 3.74 \cdot OUR \cdot V$ | Kcal→KJ 换算 (×4.184) |
| **连续 $G_X$** | $G_X = Q_{ferm} \cdot Y_{X/O} / 3.74$ | 无需 $F, V$ 也能求 |
