# Tutorial 2 — 完整习题·解答·做题技巧

> **来源**: Tutorial 2 w solutions - 2026.pdf (14 pages)
> **对应章节**: Lecture 2 — Growth Medium and Growth Kinetics (Bentley Ch.5-6)
> **主题**: 生长动力学、对数生长期、产率换算与发酵罐设计

---

## 习题 1: 两种细菌菌株的比较 — 生长速率、发酵体积与底物消耗

### 📝 题目

某制药厂测试了两种能产生药用物质的细菌菌株，数据如下：

| 参数 | 菌株 A | 菌株 B |
|------|--------|--------|
| 初始细胞数 (/L) | 100 | 100 |
| 最终细胞数 (/L) | 1×10⁹ | 5×10⁸ |
| 对数生长期 (hr) | 10 | 9 |
| $Y_{X/S}$ (g biomass/g substrate) | 0.48 | 0.42 |
| $Y_{P/X}$ (mg product/g biomass) | 150 | 120 |

假设 1 g 生物质 = 5×10⁷ 个细菌细胞。

**A.** 求每种菌株的生长速率 $\mu$。 **(A: 1.61 hr⁻¹, B: 1.71 hr⁻¹)**

**B.** 若每个发酵周期生产 1 kg 产物，求各菌株所需的发酵罐工作体积。 **(A: 333.33 L, B: 833.33 L)**

**C.** 各菌株每发酵周期消耗多少葡萄糖？ **(A: 13.88 kg, B: 19.84 kg)**

---

### 🔢 解答

#### A. 计算生长速率 $\mu$

由对数生长方程：

$$
\ln\left(\frac{X_f}{X_0}\right) = \mu \cdot \Delta t
$$

**菌株 A：**

$$
\ln\left(\frac{1 \times 10^9}{100}\right) = \mu_A \times 10 \Rightarrow \mu_A = \frac{\ln(10^7)}{10} = \frac{16.12}{10} = \boxed{1.61\ \text{hr}^{-1}}
$$

**菌株 B：**

$$
\ln\left(\frac{5 \times 10^8}{100}\right) = \mu_B \times 9 \Rightarrow \mu_B = \frac{\ln(5 \times 10^6)}{9} = \frac{15.42}{9} = \boxed{1.71\ \text{hr}^{-1}}
$$

---

#### B. 计算发酵罐工作体积

**Step 1**: 由 $Y_{P/X}$ 求所需生物质量：

$$
Y_{P/X} = \frac{\Delta W_P}{\Delta W_X} \Rightarrow \Delta W_X = \frac{\Delta W_P}{Y_{P/X}}
$$

**菌株 A：** $\Delta W_{XA} = \frac{1\ kgP \times 10^6\ mg/kg}{150\ mgP/gX} = 6,666.67\ gX$

**菌株 B：** $\Delta W_{XB} = \frac{1\ kgP \times 10^6\ mg/kg}{120\ mgP/gX} = 8,333.33\ gX$

**Step 2**: 利用细胞密度求体积：

细胞浓度增量 $\Delta X = (X_f - X_0) \times \frac{1}{5 \times 10^7\ cells/gX}$

**菌株 A：**

$$
V_A = \frac{6,666.67\ gX \times 5 \times 10^7\ cells/gX}{(1\times 10^9 - 100)\ cells/L} = \boxed{333.3\ L}
$$

**菌株 B：**

$$
V_B = \frac{8,333.33\ gX \times 5 \times 10^7\ cells/gX}{(5\times 10^8 - 100)\ cells/L} = \boxed{833.3\ L}
$$

---

#### C. 计算葡萄糖消耗量

由生长产率 $Y_{X/S}$：

$$
\Delta W_S = \frac{\Delta W_X}{Y_{X/S}}
$$

**菌株 A：** $\Delta W_S = \frac{6,666.67\ gX}{0.48} = 13,888.9\ gS = \boxed{13.88\ kgS}$

**菌株 B：** $\Delta W_S = \frac{8,333.33\ gX}{0.42} = 19,841.3\ gS = \boxed{19.84\ kgS}$

---

### 🎯 做题技巧

1. **对数生长方程** $\ln(X_f/X_0) = \mu\Delta t$ 是核心，$\mu$ 直接由已知时间和细胞数比值求解。

2. **三步产率链**：$W_P \xrightarrow{Y_{P/X}} W_X \xrightarrow{Y_{X/S}} W_S$。每步都搞清楚"已知什么，求什么"。

3. **细胞数与质量的换算**：$1\ gX = 5 \times 10^7\ cells$ 是本题的关键桥梁，考试中常给出类似数据。

4. **单位换算**：mg → g → kg，注意 $10^3$ 和 $10^6$ 的跳跃。

5. **菌株 B 生长快但产率低**：$\mu_B > \mu_A$ 但 $Y_{X/S}^B < Y_{X/S}^A$，产物产量相同情况下 B 需要更多底物和更大体积。

---

## 习题 2: 双碳源批式发酵 — 葡萄糖 + 甲醇

### 📝 题目

工厂在 1 m³ 发酵罐中进行批式发酵生产生物质。培养基含两种碳源：葡萄糖（初始 2% w/v）和甲醇。用 10 L 含 1% 细菌的 starter 接种后细菌立即进入对数生长。细菌先利用葡萄糖（$Y_{X/S} = 50\%$），10 小时后转向甲醇（$Y_{X/S} = 0.639\ gX/gM$）。16 小时后发酵结束，细菌浓度达 39.75 g/L。甲醇密度 769 kg/m³，细菌可利用 93% 的甲醇。甲醇上的生长速率是葡萄糖上的一半。

| 参数 | 符号 | 数值 |
|------|------|------|
| 发酵罐体积 | V | 1 m³ = 1000 L |
| Starter 体积 | V_starter | 10 L |
| Starter 菌浓 | X_starter | 1% = 10 g/L |
| 葡萄糖初始浓度 | S₀_G | 2% = 20 g/L |
| 葡萄糖产率 | Y_G | 50% = 0.5 gX/gG |
| 甲醇产率 | Y_M | 0.639 gX/gM |
| 甲醇利用率 | — | 93% |
| 甲醇密度 | ρ_M | 769 kg/m³ |
| 最终菌浓 | X_f | 39.75 g/L |
| 葡萄糖生长期 | Δt_G | 10 hr |
| 总发酵时间 | Δt_ferm | 16 hr |

**A.** 求甲醇上的生长速率 $\mu_M$。 **(0.23 hr⁻¹)**

**B.** 发酵结束时葡萄糖浓度？ **(0.3 g/L)**

**C.** 培养基配制时需加入多少升甲醇？ **(65.21 L)**

---

### 🔢 解答

#### A. 计算 $\mu_M$

**Step 1**: 求初始生物质浓度（来自 starter）：

$$
X_0 = \frac{X_{starter} \cdot V_{starter}}{V} = \frac{10\ g/L \times 10\ L}{1000\ L} = 0.1\ g/L
$$

**Step 2**: 建立方程组。已知：
- $\mu_M = 0.5 \mu_G$
- 甲醇生长期：$\Delta t_M = 16 - 10 = 6\ hr$

对葡萄糖阶段：
$$
\ln(X_{10hr}) - \ln(0.1) = \mu_G \times 10 \quad \text{(1)}
$$

对甲醇阶段：
$$
\ln(39.75) - \ln(X_{10hr}) = \mu_M \times 6 = 0.5\mu_G \times 6 \quad \text{(2)}
$$

**Step 3**: (1) + (2) 消去 $X_{10hr}$：

$$
\ln(39.75) - \ln(0.1) = \mu_G \times 10 + \mu_G \times 3 = 13\mu_G
$$

$$
\mu_G = \frac{\ln(397.5)}{13} = \frac{5.985}{13} = 0.46\ hr^{-1}
$$

**Step 4**: 求 $\mu_M$：

$$
\mu_M = 0.5 \times 0.46 = \boxed{0.23\ hr^{-1}}
$$

---

#### B. 计算最终葡萄糖浓度 $S_{fG}$

**Step 1**: 先求 $X_{10hr}$（葡萄糖阶段结束时的菌浓）：

$$
\ln(X_{10hr}) - \ln(0.1) = 0.46 \times 10 \Rightarrow X_{10hr} = 0.1 \times e^{4.6} = 9.95\ g/L
$$

**Step 2**: 由葡萄糖生长产率求 $S_{fG}$：

$$
Y_G = \frac{X_{10hr} - X_0}{S_{0G} - S_{fG}}
$$

$$
0.5 = \frac{9.95 - 0.1}{20 - S_{fG}} \Rightarrow 20 - S_{fG} = \frac{9.85}{0.5} = 19.7
$$

$$
S_{fG} = 20 - 19.7 = \boxed{0.3\ g/L}
$$

---

#### C. 计算初始甲醇体积 $V_M$

**Step 1**: 由甲醇生长产率求初始甲醇浓度 $S_{0M}$：

$$
Y_M = \frac{X_f - X_{10hr}}{0.93 \cdot S_{0M}}
$$

$$
0.639 = \frac{39.75 - 9.95}{0.93 \cdot S_{0M}} \Rightarrow S_{0M} = \frac{29.8}{0.639 \times 0.93} = 50.14\ gM/L
$$

**Step 2**: 求甲醇质量：

$$
W_{S_{0M}} = V \times S_{0M} = 1000\ L \times 50.14\ g/L = 50.14\ kgM
$$

**Step 3**: 由密度求体积：

$$
V_M = \frac{W_{S_{0M}}}{\rho_M} = \frac{50.14\ kgM \times 1000\ g/kg}{769\ kg/m^3 \times 1000\ g/kg} = \boxed{65.21\ L}
$$

---

### 🎯 做题技巧

1. **双碳源系统的分阶段处理**：先葡萄糖 ($\Delta t_G$) 后甲醇 ($\Delta t_M$)，关键是 $X_{10hr}$ 同时是两个阶段的衔接变量。

2. **方程组消元法**：两个方程两个未知数 ($\mu_G$ 和 $X_{10hr}$)，通过相加消去 $X_{10hr}$ 直接得 $\mu_G$。这是考试的常用技巧。

3. **不能假设底物耗尽**：葡萄糖阶段结束时 $S_{fG} = 0.3 \neq 0$，题目并未说葡萄糖被完全消耗！考试中不要隐式假设 $S_f \approx 0$。

4. **甲醇利用率 93%**：在计算 $S_{0M}$ 时注意放分母，不是乘分子（$0.93 S_{0M}$ 才是消耗量）。

5. **密度换单位链**：$\rho_M = 769\ kg/m^3$，需要注意 $m^3 \to L \to g$ 的单位转换。

---

## 习题 3: 酵母胞外蛋白生产 — 盐溶液体积设计

### 📝 题目

工厂在 2.2 m³ 工作体积的发酵罐中通过批式发酵生产胞外蛋白。培养基由糖蜜（molasses, 碳源）和盐溶液组成。灭菌后加入 starter 至最终工作体积。延迟期 1 hr 后酵母对数生长 10 hr，该阶段倍增时间 1.5 hr。发酵结束后排出、清洗、灭菌共需 3 hr。分离产率 75.75%，每周产 20 kg 纯蛋白。工厂 7×24 连续运行。

| 参数 | 符号 | 数值 |
|------|------|------|
| 发酵罐总体积 | V_T | 2.2 m³ = 2200 L |
| Starter 体积 | V_starter | 200 L |
| Starter 菌浓 | X_starter | 4 g/L |
| 延迟期 | t_lag | 1 hr |
| 对数期 | t_log | 10 hr |
| 倍增时间 | t_d | 1.5 hr |
| 周转时间 | t_turn | 3 hr |
| 酵母对糖产率 | $Y_{X/S}$ | 0.52 gX/g sugar |
| 蛋白产率 | $Y_{P/X}$ | 0.04 gP/gX (40 mg/g) |
| 分离产率 | $\eta$ | 75.75% |
| 糖蜜固体含量 | — | 67.8% |
| 固体中糖含量 | — | 78% |
| 每周纯蛋白产量 | — | 20 kg/week |

**求**：灭菌前应加入多少盐溶液？ **(1998.9 L)**

---

### 🔢 解答

**总体积方程：**

$$
V_T = V_{molasses} + V_{salt} + V_{starter}
$$

已知 $V_T = 2200\ L$，需依次求出 $V_{molasses}$ 和 $V_{starter}$。

---

**Step 1**: 求每个发酵周期的时间

$$
t_{ferm} = t_{lag} + t_{log} + t_{turn} = 1 + 10 + 3 = 14\ hr
$$

---

**Step 2**: 求每周发酵批次数

$$
n = \frac{24\ hr/day \times 7\ day/week}{14\ hr/ferm} = 12\ \text{ferm/week}
$$

---

**Step 3**: 求每批产蛋白量

$$
W_{P_{ferm}} = \frac{W_{P_{pure}}/week}{n \times \eta} = \frac{20\ kgP/week}{12 \times 0.7575} = 2.2\ kgP/ferm
$$

---

**Step 4**: 由 $Y_{P/X}$ 求所需生物质量（胞外蛋白 $P_0 = 0$）

$$
Y_{P/X} = \frac{W_{P_f} - W_{P_0}}{\Delta W_X} \Rightarrow \Delta W_X = \frac{2.2 - 0}{0.04} = 55\ kgX
$$

---

**Step 5**: 由 $Y_{X/S}$ 求所需糖量（糖完全消耗 $S_f=0$）

$$
Y_{X/S} = \frac{\Delta W_X}{W_{S_0} - W_{S_f}} \Rightarrow W_{S_0} = \frac{55}{0.52} = 105.77\ kg\ sugar
$$

---

**Step 6**: 由糖蜜组成求所需糖蜜量

糖蜜 → 固体 (67.8%) → 糖 (78% of solids)：

$$
W_{molasses} = \frac{105.77\ kg\ sugar}{0.78 \times 0.678} = 200\ kg\ molasses
$$

---

**Step 7**: 求糖蜜体积（仅有水含量贡献体积，水分 32.2%）

$$
V_{molasses} = \frac{W_{molasses} \times 0.322}{\rho_{water}} = \frac{200 \times 0.322}{1\ kg/L} = 64.4\ L
$$

---

**Step 8**: 求 starter 体积

先求 $\mu$（由倍增时间）：

$$
\mu = \frac{\ln 2}{t_d} = \frac{0.693}{1.5} = 0.464\ hr^{-1}
$$

由对数生长方程：

$$
\frac{W_{X_f}}{W_{X_0}} = e^{\mu \cdot t_{log}} = e^{0.464 \times 10} = 101.49
$$

又 $\Delta W_X = W_{X_f} - W_{X_0} = 55\ kgX$：

$$
101.49 W_{X_0} - W_{X_0} = 55 \Rightarrow W_{X_0} = \frac{55}{100.49} = 0.547\ kgX = 547\ gX
$$

Starter 体积：

$$
V_{starter} = \frac{W_{X_0}}{X_{starter}} = \frac{547\ gX}{4\ gX/L} = 136.7\ L
$$

---

**Step 9**: 求盐溶液体积

$$
V_{salt} = V_T - (V_{molasses} + V_{starter}) = 2200 - (64.4 + 136.7) = \boxed{1998.9\ L}
$$

---

### 🎯 做题技巧

1. **倒推法**：$V_{salt}$ ← 总积 − 其他 ← 每个组分体积 ← 质量 ← 产率 ← 蛋白需求。从最终产量往回逐层计算。

2. **倍增时间 ↔ 生长速率**：$\mu = \ln 2 / t_d$ 是核心转换。

3. **$W_{X_0}$ 的巧妙求解**：已知比值 $W_{X_f}/W_{X_0}$ 和差值 $\Delta W_X$，用 $101.49X_0 - X_0 = 55$ 一步解出。

4. **每周批次数**：$7 \times 24 / 14 = 12$，注意工厂 24/7 运行且每个周期 14 hr。

5. **糖蜜体积仅计水分**：固体溶解后不占体积，这是发酵工程中的常见假设。

6. **分离产率**：实际纯蛋白 = 粗蛋白 × 分离产率，倒推时要**除以**产率而非乘。

---

## 综合技巧总结 (Global Strategy Summary)

| 题型 | 核心公式 | 易错点 |
|------|---------|--------|
| **对数生长** | $\ln(X_f/X_0) = \mu\Delta t$, $\mu = \ln 2/t_d$ | 初始浓度 $X_0$ 要考虑 starter 稀释 |
| **产率换算链** | $W_P \xrightarrow{Y_{P/X}} W_X \xrightarrow{Y_{X/S}} W_S$ | 每步方向（乘还是除）要搞清楚 |
| **双碳源分阶段** | 分 $\Delta t_1$、$\Delta t_2$，衔接处 $X_{mid}$ 为共同变量 | 不能假设第一阶段底物耗尽 |
| **发酵体积设计** | $V_T = \sum V_i$；$V_i = W_i/\rho$ | 糖蜜固体不占体积，只算水分 |
| **批量生产计算** | 批次数 = 总时间/单批时间 | 注意分离产率 $\eta$ 的位置 |
| **细胞数-质量换算** | $W_X = N \times m_{cell}$ | 题目给定的换算因子（如 $5\times10^7$ cells/g） |
