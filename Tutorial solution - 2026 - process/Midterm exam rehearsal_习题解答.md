# Midterm Exam Rehearsal — 完整习题·解答·做题技巧

> **来源**: Tutorial - Midterm exam rehearsal - Solutions 2026.pdf (12 pages)
> **对应章节**: Midterm Rehearsal (考前模拟)
> **主题**: Arrhenius 灭菌温度计算、批式发酵综合（维护时间 + 产物/氧产率）

---

## 习题 1: Arrhenius 方程求连续灭菌温度

### 📝 题目

10,000 L 批式发酵罐。培养基含 10⁵ spores/L，灭菌要求污染概率为 1/1000 批。培养基在填充过程中经连续灭菌器灭菌（体积 1,125 L），填充时间 80 min。

文献数据：
- 127°C (400 K) 灭菌 11 min → $N_f/N_0 = 1.85 \times 10^{-6}$
- 145°C (418 K) 灭菌 12 min → $N_f/N_0 = 3.2 \times 10^{-9}$

Arrhenius 方程：$K_d = A \cdot e^{-E_a/RT}$，$R = 1.98\ cal/mol\cdot K$

**求**：灭菌温度以符合要求。 **(188°C / 461 K)**

| 参数 | 符号 | 数值 |
|------|------|------|
| 发酵罐体积 | V_ferm | 10,000 L |
| 初始污染 | N₀' | 10⁵ spores/L |
| 目标污染概率 | N_f | 1/1000 ferm |
| 灭菌器体积 | V_sterilizer | 1,125 L |
| 填充时间 | t_fill | 80 min |
| 文献 T₁ | T₁ | 127°C = 400 K |
| 文献 t_st1 | t_st1 | 11 min |
| 文献存活率₁ | N_f/N₀ | 1.85×10⁻⁶ |
| 文献 T₂ | T₂ | 145°C = 418 K |
| 文献 t_st2 | t_st2 | 12 min |
| 文献存活率₂ | N_f/N₀ | 3.2×10⁻⁹ |

---

### 🔢 解答

#### Step 1: 求工艺所需的 $K_d$

培养基流量：

$$
Q = \frac{V_{ferm}}{t_{fill}} = \frac{10,000}{80} = 125\ L/min
$$

灭菌器停留时间：

$$
t_{st} = \frac{V_{sterilizer}}{Q} = \frac{1125}{125} = 9\ min
$$

灭菌前孢子总数：

$$
N_0 = 10^5 \times 10,000 = 10^9\ spores
$$

目标 $N_f = 0.001\ spores/ferm$

由灭菌方程：

$$
K_d = -\frac{\ln(N_f/N_0)}{t_{st}} = -\frac{\ln(10^{-12})}{9} = \frac{27.63}{9} = 3.07\ min^{-1}
$$

---

#### Step 2: 文献数据求 Arrhenius 参数

**文献温度 1**（400 K）：

$$
K_d^{400K} = -\frac{\ln(1.85\times10^{-6})}{11} = 1.20\ min^{-1}
$$

**文献温度 2**（418 K）：

$$
K_d^{418K} = -\frac{\ln(3.2\times10^{-9})}{12} = 1.63\ min^{-1}
$$

---

#### Step 3: 求活化能 $E_a$

Arrhenius 两式相除：

$$
\frac{K_d^{418K}}{K_d^{400K}} = \exp\left[\frac{E_a}{R}\left(\frac{1}{400} - \frac{1}{418}\right)\right]
$$

$$
\frac{1.63}{1.20} = \exp\left[\frac{E_a}{1.98} \times \frac{18}{400 \times 418}\right]
$$

$$
1.358 = \exp\left[\frac{E_a}{1.98} \times 1.076 \times 10^{-4}\right]
$$

$$
\ln(1.358) = E_a \times 5.43 \times 10^{-5} \Rightarrow E_a = \frac{0.306}{5.43 \times 10^{-5}} = \boxed{5,628\ cal/mol}
$$

---

#### Step 4: 求频率因子 $A$

由 400 K 数据：

$$
A = K_d \cdot e^{E_a/RT} = 1.20 \times \exp\left(\frac{5628}{1.98 \times 400}\right) = 1.20 \times e^{7.106} = \boxed{1,463\ min^{-1}}
$$

---

#### Step 5: 求所需灭菌温度

$$
3.07 = 1463 \times \exp\left(-\frac{5628}{1.98 \times T}\right)
$$

$$
\exp\left(-\frac{2842.4}{T}\right) = 2.098 \times 10^{-3}
$$

$$
-\frac{2842.4}{T} = -6.167 \Rightarrow T = 461\ K = \boxed{188°C}
$$

---

### 🎯 做题技巧

1. **Arrhenius 两式相除法**：先消去 $A$ 求 $E_a$，再回代求 $A$，最后求 $T$。这是标准三步走。

2. **停留时间**：连续灭菌中 $t_{st} = V/Q$，不是灭菌周期。

3. **单位一致**：$E_a$ 用 cal/mol，$R = 1.98\ cal/mol·K$，温度用 K。

4. **$N_f$ 可以是分数**：$1/1000 = 0.001$，不要写 1。

---

## 习题 2: 批式发酵综合 — 维护时间与产物/氧产率

### 📝 题目

900 L 批式发酵酵母产胞外蛋白。甘油初始 2%，$X_0 = 400\ ppm$，$t_{lag}=2\ hr$，$t_d=1.5\ hr$。分离总产率 86.9%，月产 168 kg 纯蛋白（30 天，24/7）。

空气 1500 LPM，35°C，1 atm。发酵结束时氧溶解度 13%。$q_P = 0.24\ gP/gX·hr$，$R_X = 1150\ gX/hr$，$R_S = 2.95\ gS/L·hr$，甘油完全消耗。

| 参数 | 符号 | 数值 |
|------|------|------|
| 罐体积 | V | 900 L |
| 底物初浓 | S₀ | 2% = 20 g/L |
| 初始菌浓 | X₀ | 400 ppm = 0.4 g/L |
| 延迟期 | t_lag | 2 hr |
| 倍增时间 | t_d | 1.5 hr |
| 分离产率 | η | 86.9% |
| 月纯蛋白 | — | 168 kg/month |
| 比生产速率 | q_P | 0.24 gP/gX·hr |
| 总生物质产率 | R_X | 1150 gX/hr |
| 体积底物消耗率 | R_S | 2.95 gS/L·hr |
| 空气流量 | Q_air | 1500 L/min |
| 温度 | T | 35°C = 308 K |
| 压力 | P | 1 atm |
| 发酵终氧溶解度 | %Sol | 13% |

**A.** 清洗准备时间？ **(6.3 hr)**

**B.** 产物对氧的产率 $Y_{P/O}$？ **(0.624 gP/gO₂)**

---

### 🔢 解答

#### A. 计算维护时间

**Step 1**: 基础参数

$$
\mu = \frac{\ln 2}{t_d} = \frac{0.693}{1.5} = 0.462\ hr^{-1}
$$

$$
Y_{P/X} = \frac{q_P}{\mu} = \frac{0.24}{0.462} = 0.52\ \frac{gP}{gX}
$$

**Step 2**: 生长产率

$$
Y_{X/S} = \frac{R_X}{R_S \cdot V} = \frac{1150}{2.95 \times 900} = 0.43\ \frac{gX}{gS}
$$

**Step 3**: 终菌浓（$S_f = 0$）

$$
X_f = Y_{X/S}(S_0 - 0) + X_0 = 0.43 \times 20 + 0.4 = 9\ gX/L
$$

**Step 4**: 每批蛋白产量

$$
\Delta P = Y_{P/X}(X_f - X_0) = 0.52 \times (9 - 0.4) = 4.47\ gP/L
$$

$$
W_P^{ferm} = 4.47 \times 900 / 1000 = 4\ kgP/批
$$

**Step 5**: 月产粗蛋白与批次数

月产粗蛋白 = $168 / 0.869 = 193\ kgP/月$

批次数/月 = $193 / 4 = 48.3$

周期时间 = $30 \times 24 / 48.3 = 14.9 \approx 15\ hr$

**Step 6**: 对数生长期

$$
t_{log} = \frac{\ln(9/0.4)}{0.462} = 6.7\ hr
$$

**Step 7**: 维护时间

$$
t_{maint} = t_T - t_{lag} - t_{log} = 15 - 2 - 6.7 = \boxed{6.3\ hr}
$$

---

#### B. 计算 $Y_{P/O}$

**Step 1**: 进氧速率（理想气体方程，1 atm，308 K，21% O₂）

$$
\dot{V}_{O_2}^{in} = \frac{Q_{air}}{V} \times \%O_2 \times \frac{P \cdot MW_{O_2}}{R \cdot T}
$$

$$
\dot{V}_{O_2}^{in} = \frac{1500 \times 60}{900} \times 0.21 \times \frac{1 \times 32}{0.082 \times 308} = 100 \times 0.21 \times 1.267 = 26.61\ \frac{gO_2}{L\cdot hr}
$$

**Step 2**: 发酵结束时 OUR（氧溶解度 13%）

$$
OUR_f = \dot{V}_{O_2}^{in} \times \frac{\%Sol}{100} = 26.61 \times 0.13 = 3.46\ \frac{gO_2}{L\cdot hr}
$$

**Step 3**: $Y_{X/O}$

$$
OUR_f = \frac{\mu X_f}{Y_{X/O}} \Rightarrow Y_{X/O} = \frac{0.462 \times 9}{3.46} = 1.2\ \frac{gX}{gO_2}
$$

**Step 4**: $Y_{P/O}$

$$
Y_{P/O} = Y_{P/X} \times Y_{X/O} = 0.52 \times 1.2 = \boxed{0.624\ \frac{gP}{gO_2}}
$$

---

### 🎯 做题技巧

1. **$R_X$ 和 $R_S$ 求 $Y_{X/S}$**：$Y_{X/S} = R_X / (R_S \cdot V)$，注意 $R_X$ 是总量（g/hr），$R_S$ 是体积量（g/L·hr）。

2. **胞外产物 $P_0 = 0$**：$\Delta P = P_f$。

3. **$\%Sol$ 求 OUR**：$OUR = \dot{V}_{O_2}^{in} \times \%Sol/100$。这是溶氧百分比在发酵结束时的物理意义。

4. **$Y_{P/O} = Y_{P/X} \times Y_{X/O}$**：产率可连乘，但注意方向。

---

## 综合技巧总结 (Global Strategy Summary)

| 题型 | 核心公式 | 易错点 |
|------|---------|--------|
| **Arrhenius 灭菌** | $K_d = A e^{-E_a/RT}$；两式相除消 $A$ 求 $E_a$ | $N_f/N_0$ 比值直接用，不需绝对值 |
| **连续灭菌** | $t_{st} = V_{sterilizer}/Q$；$Q = V_{ferm}/t_{fill}$ | $t_{st}$ 不是 $t_{fill}$ |
| **批式综合** | $Y = R/(rate \cdot V)$；$t_T = \Delta P/Prod$ | $R_X$ 总量 vs $R_S$ 体积量 |
| **$Y_{P/O}$** | $Y_{P/O} = Y_{P/X} \cdot Y_{X/O}$ | $Y_{X/O}$ 需从 $OUR_f$ 反求 |
