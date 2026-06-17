# Tutorial 4 — 完整习题·解答·做题技巧

> **来源**: Tutorial 4 w solutions - 2026.pdf (17 pages)
> **对应章节**: Lecture 4 — Sterilization (Bentley Ch.7)
> **主题**: 批式灭菌、连续灭菌、死亡常数、污染概率、灭菌故障分析

---

## 习题 1: 多污染源批式灭菌 — 最小灭菌时间

### 📝 题目

工厂在 1 m³ 发酵罐中生产酵母分泌蛋白。碳源为糖蜜（65% 固体），初始浓度 30%，初始污染 10⁴ bacteria/g。培养基还含 15 g/L 盐（污染 10⁶ bacteria/kg）以及水（补足体积，污染 2×10³ bacteria/mL）。132°C 灭菌（$K_d = 1.75\ min^{-1}$），接种 400 g 酵母后立即对数生长，至菌浓 2.2%。发酵允许终了时每罐最多 1,000 个细菌。$\mu_{yeast} = 0.267\ hr^{-1}$，$\mu_{bacteria} = 0.14\ hr^{-1}$。

**求**：最小灭菌时间。 **(10 min)**

| 参数 | 符号 | 数值 |
|------|------|------|
| 发酵罐体积 | V_ferm | 1 m³ = 1000 L |
| 灭菌温度 | T | 132°C = 405 K |
| 死亡常数 | K_d | 1.75 min⁻¹ |
| 糖蜜浓度 | S₀_molasses | 30% = 300 g/L |
| 糖蜜固体 | — | 65% |
| 糖蜜初始污染 | N₀'_molasses | 10⁴ cells/g |
| 盐浓度 | S₀_salt | 15 g/L |
| 盐初始污染 | N₀'_salt | 10⁶ cells/kg |
| 水初始污染 | N₀'_H₂O | 2×10³ cells/mL |
| 接种量 | W_X₀ | 400 gX |
| 最终菌浓 | X_f | 2.2% = 22 g/L |
| 允许终污染 | N_f | 1000 cells/ferm |
| μ_yeast | μ_y | 0.267 hr⁻¹ |
| μ_bacteria | μ_b | 0.14 hr⁻¹ |

---

### 🔢 解答

**Step 1**: 由酵母参数求发酵周期。

初始酵母浓度：

$$
X_0 = \frac{W_{X_0}}{V_{ferm}} = \frac{400\ gX}{1000\ L} = 0.4\ gX/L
$$

对数生长期：

$$
\Delta t = \frac{\ln(X_f/X_0)}{\mu_y} = \frac{\ln(22/0.4)}{0.267} = 15\ hr
$$

---

**Step 2**: 由发酵终了允许的细菌数反推起始细菌数（对数生长方程）：

$$
N_f = N_1 \times e^{\mu_b \cdot \Delta t} \Rightarrow N_1 = \frac{1000}{e^{0.14 \times 15}} = 122.5\ cells/ferm
$$

---

**Step 3**: 计算灭菌前各污染源的细菌总数 $N_0$：

- **糖蜜**：$N_0^{molasses} = 10^4 \times 300 \times 1000 = 3 \times 10^9\ cells$

- **盐**：$N_0^{salt} = 10^6 \times 15 \times 1000 / 10^3 = 1.5 \times 10^7\ cells$

- **水**（糖蜜含水 35%，水体积 = 1000 − 糖蜜水体积）：
  $$V_{molasses}^{water} = 300 \times 1000 \times 0.35 / 1000 = 105\ L$$
  $$V_{H_2O} = 1000 - 105 = 895\ L$$
  $$N_0^{H_2O} = 2 \times 10^3 \times 10^3 \times 895 = 1.79 \times 10^9\ cells$$

$$
N_0 = (3 \times 10^9) + (1.5 \times 10^7) + (1.79 \times 10^9) = 4.8 \times 10^9\ cells
$$

---

**Step 4**: 灭菌方程求时间：

$$
\ln\frac{N_1}{N_0} = -K_d \cdot t_{st} \Rightarrow \ln\frac{122.5}{4.8 \times 10^9} = -1.75 \cdot t_{st}
$$

$$
t_{st} = \frac{\ln(4.8 \times 10^9 / 122.5)}{1.75} = \boxed{10\ min}
$$

---

### 🎯 做题技巧

1. **倒推法**：$N_f$（允许）→ $N_1$（灭菌后/发酵前）→ $N_0$（灭菌前）→ $t_{st}$。

2. **多污染源求和**：$N_0 = \sum N_0^i$，分别计算每个组分的贡献。

3. **体积扣减法**：水的体积 = 总体积 − 其他成分（如糖蜜中水）的体积。

4. **顺序逻辑**：先用酵母数据求 $\Delta t$（发酵周期）→ 再用细菌 $\mu_b$ 反推 $N_1$ → 最后用灭菌方程求 $t_{st}$。

---

## 习题 2: 芽孢灭菌、Thiamine 热降解与故障分析

### 📝 题目

1500 L 发酵罐中批式发酵酵母。碳源糖蜜（69% 固体，58% 固体为糖），初始糖 40 g/L，Thiamine 200 ppm。125°C 灭菌 16 min（升温降温忽略）。糖蜜中芽孢浓度 10⁷ spores/g，目标污染概率 1/500 批。$Y_{X/S} = 0.674\ gX/g\ sugar$，$t_d = 4455\ sec$，Thiamine 在灭菌温度下降解常数 $K_d^T = 4.12\ hr^{-1}$。

| 参数 | 符号 | 数值 |
|------|------|------|
| 罐体积 | V | 1500 L |
| 糖初始浓度 | S₀ | 40 g/L |
| Thiamine 初始 | C₀ | 200 ppm = 0.2 g/L |
| 灭菌温度 | T | 125°C |
| 灭菌时间 | t_st | 16 min |
| 芽孢浓度 | N₀' | 10⁷ spores/g molasses |
| 污染目标 | N_f | 1/500 ferm |
| 酵母产率 | Y_X/S | 0.674 gX/g sugar |
| 倍增时间 | t_d | 4455 sec = 1.24 hr |
| Thiamine 降解常数 | $K_d^T$ | 4.12 hr⁻¹ |
| Thiamine 母液浓度 | C_T stock | 9% |

**A.** 求芽孢在灭菌温度下的死亡常数 $K_d$。 **(2.14 min⁻¹)**

**B.** 配制培养基时需加入多少 Thiamine 母液（9%）？ **(10 L)**

**C.** 糖为限制因子，发酵何时进入稳定期？ **(10 hr)**

---

**故障情景**：发酵 6 hr 后因电脑故障重新启动了灭菌，5 min 后操作员手动停止。酵母死亡系数 $K_d^X = 0.35\ min^{-1}$，之后经 1 hr 延迟期再进入对数生长。

**D.** 故障后酵母最终浓度？ **(17.62 gX/L)**

**E.** 从开始到稳定期的总时间？ **(~13.4 hr)**

**F.** 如何使最终浓度恢复正常水平？

---

### 🔢 解答

#### A. 计算 $K_d$

由灭菌方程：

$$
\ln\frac{N_f}{N_0} = -K_d \cdot t_{st}
$$

**Step 1**: 求 $N_0$（灭菌前芽孢总数）：

$$
N_0 = \frac{N_0' \times S_{0,sugar} \times V}{f_{solid} \times f_{sugar}} = \frac{10^7 \times 40 \times 1500}{0.69 \times 0.58} = 1.5 \times 10^{12}\ spores
$$

**Step 2**: $N_f = 1/500 = 0.002\ spores/ferm$：

$$
K_d = \frac{\ln(1.5 \times 10^{12} / 0.002)}{16} = \boxed{2.14\ min^{-1}}
$$

---

#### B. 计算 Thiamine 母液体积

**Step 1**: 灭菌后的 Thiamine 浓度（由降解方程，注意单位 hr→min）：

$$
\ln\frac{C_f}{C_0} = -K_d^T \cdot t_{st} \Rightarrow \ln\frac{0.2}{C_0} = -4.12 \times \frac{16}{60} \Rightarrow C_0 = 0.6\ g/L
$$

**Step 2**: 母液稀释：

$$
C_T^{stock} \times V_T = C_0 \times V \Rightarrow 90\ g/L \times V_T = 0.6 \times 1500
$$

$$
V_T = \boxed{10\ L}
$$

---

#### C. 计算正常发酵时间

**Step 1**: $\mu = \ln 2 / t_d = \ln 2 / 1.24 = 0.56\ hr^{-1}$

**Step 2**: $X_f$（糖完全消耗）由产率求出：

$$
Y_{X/S} = \frac{X_f - X_0}{S_0 - S_f} \Rightarrow 0.674 = \frac{X_f - 0.1}{40 - 0} \Rightarrow X_f = 27.06\ gX/L
$$

**Step 3**: 生长时间：

$$
\Delta t = \frac{\ln(27.06/0.1)}{0.56} = \boxed{10\ hr}
$$

---

#### D. 故障后酵母终浓度（Thiamine 成为限制因子）

**Step 1**: 故障前一刻菌浓（$X_0 = 0.1\ g/L$ 源自 100 ppm）：

$$
X_1 = 0.1 \times e^{0.56 \times 6} = 2.88\ gX/L
$$

**Step 2**: 灭菌后菌浓：

$$
\ln\frac{X_2}{X_1} = -K_d^X \cdot t_{st} \Rightarrow X_2 = 2.88 \times e^{-0.35 \times 5} = 0.5\ gX/L
$$

**Step 3**: 糖限制下的可能终浓度（残糖 $S_1 = 40 - (2.88-0.1)/0.674 = 35.88\ g/L$）：

$$
X_f^S = 0.5 + 0.674 \times 35.88 = 24.68\ gX/L
$$

**Step 4**: Thiamine 限制下的终浓度。正常发酵中 Thiamine 全部耗尽：

$$
Y_{X/T} = \frac{27.06 - 0.1}{0.2 - 0} = 134.8\ gX/gT
$$

故障前剩余 Thiamine：

$$
C_1 = 0.2 - \frac{2.88 - 0.1}{134.8} = 0.179\ g/L
$$

故障后（灭菌 + 降解）：

$$
\ln\frac{C_2}{C_1} = -K_d^T \cdot t_{st} \Rightarrow C_2 = 0.179 \times e^{-4.12 \times 5/60} = 0.127\ g/L
$$

Thiamine 耗尽时菌浓：

$$
X_f^T = 0.5 + 134.8 \times 0.127 = \boxed{17.62\ gX/L}
$$

$X_f^T < X_f^S$，**Thiamine 是限制因子**。

---

#### E. 总时间

$$
\Delta t_{log2} = \frac{\ln(17.62/0.5)}{0.56} = 6.4\ hr
$$
$$
t_T = 6 + 1 + 6.4 = \boxed{13.4\ hr}
$$

---

#### F. 恢复正常浓度

需添加 **糖蜜**和 **Thiamine**：

- 糖蜜：$\Delta S_{sugar} = (27.06 - 24.68)/0.674 = 3.53\ g/L \rightarrow 13.23\ kg$ 糖蜜
- Thiamine：$\Delta C = (27.06 - 17.62)/134.8 = 0.07\ g/L \rightarrow 1.17\ L$ 母液（9%）

---

### 🎯 做题技巧

1. **污染概率 $N_f$**：1/500 = 0.002（不是整数！），考试中要精确使用。

2. **Thiamine 的双重消耗**：灭菌降解 + 酵母消耗。故障情景下两者叠加，需分别计算。

3. **双限制因子判断**：分别按糖和 Thiamine 计算 $X_f$，较小者即为实际限制因子。

4. **热敏物质设计**：$C_0 > C_f$（灭菌后浓度 > 期望浓度），因为有热降解。

5. **故障恢复**：需分别补充糖和维生素才能恢复正常产量。

---

## 习题 3: 连续空气灭菌 + 尾气分析 + 换热器设计

### 📝 题目

工厂在 500 L 罐中批式发酵细菌。每周期 24 hr：清洗装料 6 hr + 灭菌 1 hr + 延迟期 1 hr + 对数生长 15 hr + 排料 1 hr。$t_d = 50.3\ min$，$Y_{X/O} = 1.2\ gX/gO_2$。

空气经连续高温灭菌器（$K_d = 17.39\ min^{-1}$，停留 88 sec）后进入发酵罐。空气初始污染 10⁶ cells/m³，可接受风险 1/1000 批。尾气氧含量发酵结束时 3.46%（进气 21%，25°C，1 atm）。

| 参数 | 符号 | 数值 |
|------|------|------|
| 罐体积 | V | 500 L |
| 倍增时间 | t_d | 50.3 min = 0.84 hr |
| 氧产率 | Y_X/O | 1.2 gX/gO₂ |
| 空气灭菌 $K_d$ | K_d | 17.39 min⁻¹ |
| 停留时间 | t_st | 88 sec = 1.47 min |
| 进气 O₂ | %O₂_in | 21% |
| 尾气 O₂ (终) | %O₂_out | 3.46% |
| 进气污染 | N₀' | 10⁶ cells/m³ |
| 目标污染 | N_f | 1/1000 ferm |

**A.** 发酵结束时细菌浓度？ **(5 g/L)**

**B.** 换热器截面积 73.35 cm²，求长度？ **(25 m)**

---

### 🔢 解答

#### A. 计算 $X_f$

**Step 1**: $\mu = \ln 2 / t_d = \ln 2 / 0.84 = 0.825\ hr^{-1}$

**Step 2**: 由空气灭菌数据反推进气量：

$$
\ln\frac{N_f}{N_0} = -K_d \cdot t_{st} \Rightarrow N_0 = \frac{1/1000}{\exp(-17.39 \times 1.47)} = 1.2 \times 10^8\ cells
$$

空气总体积：

$$
V_{air} = \frac{N_0}{N_0'} = \frac{1.2 \times 10^8}{10^6} = 120\ m^3
$$

空气流量（仅在 lag + log 期间通入）：

$$
\dot{V}_{air} = \frac{V_{air}}{t_{lag} + t_{log}} = \frac{120}{(1+15)} = 7.5\ m^3/hr = 7,500\ L/hr
$$

**Step 3**: 理想气体方程求出口氧流量差（= OUR）：

$$
OUR_f = \frac{\dot{V}_{air}}{V_{ferm}} \times (\%O_2^{in} - \%O_2^{out}) \times \frac{P \times MW_{O_2}}{R \times T}
$$

$$
OUR_f = \frac{7500}{500} \times (0.21 - 0.0346) \times \frac{1 \times 32}{0.082 \times 298} = 3.44\ \frac{gO_2}{L\cdot hr}
$$

**Step 4**: $OUR = \mu X_f / Y_{X/O}$：

$$
X_f = \frac{OUR_f \times Y_{X/O}}{\mu} = \frac{3.44 \times 1.2}{0.825} = \boxed{5.0\ gX/L}
$$

---

#### B. 计算换热器长度

**Step 1**: 流速 $U = \dot{V}_{air} / A$：

$$
U = \frac{7.5\ m^3/hr}{73.35\ cm^2 \times 10^{-4}\ m^2/cm^2} = 1022.5\ m/hr = 17\ m/min
$$

**Step 2**: 长度 $L = t_{st} \times U$：

$$
L = 1.47\ min \times 17\ m/min = \boxed{25\ m}
$$

---

### 🎯 做题技巧

1. **空气灭菌数据反推流量**：$N_f, K_d, t_{st} \rightarrow N_0 \rightarrow V_{air} \rightarrow \dot{V}$。这是连接灭菌与 OUR 的桥梁。

2. **OUR 与 $X_f$ 的互推**：$OUR = \mu X / Y_{X/O}$，已知三个中任意三个可求第四个。

3. **换热器设计**：$L = t_{st} \times U = t_{st} \times (\dot{V}/A)$，单位要统一（m, cm² → m²）。

4. **空气流量仅在生长阶段供给**：lag + log 阶段，不包括清洗和收获时间。

---

## 综合技巧总结 (Global Strategy Summary)

| 题型 | 核心公式 | 易错点 |
|------|---------|--------|
| **批式灭菌** | $\ln(N_f/N_0) = -K_d \cdot t_{st}$ | $N_0$ 是多来源污染之和 |
| **污染概率** | $N_f = 1/N$（N 批中出现 1 次） | 概率可以是小数！ |
| **热敏物质** | $\ln(C_f/C_0) = -K_d \cdot t_{st}$（一阶降解） | 灭菌后浓度低于配制浓度 |
| **故障分析** | 分别按各限制因子计算 $X_f$，取最小值 | 灭菌既杀死菌体又降解营养素 |
| **连续空气灭菌** | 由 $N_f/N_0$ 反推进气量 → 流量 | 流量仅在生长阶段通入 |
| **尾气 OUR** | $OUR = \dot{V}/V \cdot \Delta\%O_2 \cdot P \cdot MW/(R \cdot T)$ | 理想气体方程参数：R, T, P |
| **换热器长度** | $L = t_{st} \cdot \dot{V} / A$ | 截面单位 cm²→m² |
