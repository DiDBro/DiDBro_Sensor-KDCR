# Tutorial 3 — 完整习题·解答·做题技巧

> **来源**: Tutorial 3 w solutions - 2026.pdf (16 pages)
> **对应章节**: Lecture 3 — Growth and Production, Productivity, Monod Model and OUR
> **主题**: Monod 方程、产率与生产速率、氧吸收速率 (OUR)、批式补料策略

---

## 习题 1: 酵母蛋白生产 — 糖重与维护时间

### 📝 题目

工厂在 2.5 m³ 批式发酵罐中生产酵母分泌蛋白。酵母最大生长速率 $\mu_{max} = 0.55\ hr^{-1}$，Monod 常数 $K_S = 800\ mg/L$。生产罐中体积生产率为 0.27 gP/L·hr，比生产速率 $q_P = 0.127\ gP/gX·hr$。糖最大允许浓度 4%（超过则不产目标蛋白）。生产罐中世代时间比最小世代时间长 30%。Starter 在 100 L 小罐中培养（相同培养基），菌浓达 6 g/L 时停止，此时生长速率为 0.45 hr⁻¹。将整个 starter 接入生产罐后立即进入对数生长，持续 10 hr。

| 参数 | 符号 | 数值 |
|------|------|------|
| 生产罐体积 | V_P | 2.5 m³ = 2500 L |
| 最大生长速率 | μ_max | 0.55 hr⁻¹ |
| Monod 常数 | K_S | 800 mg/L = 0.8 g/L |
| 体积生产率 | Pr | 0.27 gP/L·hr |
| 比生产速率 | q_P | 0.127 gP/gX·hr |
| 糖最大浓度 | S₀_max | 4% = 40 g/L |
| Starter 体积 | V_inc | 100 L |
| Starter 终菌浓 | X_inc | 6 g/L |
| Starter 终生长速率 | μ_inc | 0.45 hr⁻¹ |
| 对数期 | t_log | 10 hr |

**A.** 接种前需加入多少糖（kg）？ **(99.64 kg)**

**B.** 每个发酵周期的清洗准备时间（hr）？ **(8 hr)**

---

### 🔢 解答

#### A. 计算初始加糖量

**Step 1**: 计算最大允许总糖量：

$$
W_{S_0}^P = S_{0max} \times V_P = 40\ \frac{g}{L} \times 2500\ L = 100,000\ gS = 100\ kgS
$$

**Step 2**: 求 starter 带来的糖量。先用 Monod 方程求 starter 中残糖浓度：

$$
\mu = \mu_{max} \times \frac{S}{K_S + S} \Rightarrow 0.45 = 0.55 \times \frac{S_{inc}}{0.8 + S_{inc}}
$$

$$
0.818 \times (0.8 + S_{inc}) = S_{inc} \Rightarrow S_{inc} = 3.6\ g/L
$$

**Step 3**: Starter 带来的糖重：

$$
W_{S_{inc}} = S_{inc} \times V_{inc} = 3.6 \times 100 = 360\ gS = 0.36\ kgS
$$

**Step 4**: 接种前需加入的糖：

$$
W_{S_0}^{P'} = W_{S_0}^P - W_{S_{inc}} = 100 - 0.36 = \boxed{99.64\ kgS}
$$

---

#### B. 计算维护时间

**Step 1**: 求生产罐中的实际生长速率。世代时间比最小值大 30%：

$$
t_d = 1.3 \times t_{d_{min}} \Rightarrow \mu = \frac{\ln 2}{1.3 \times t_{d_{min}}} = \frac{\mu_{max}}{1.3} = \frac{0.55}{1.3} = 0.423\ hr^{-1}
$$

**Step 2**: 计算产物产率 $Y_{P/X}$：

$$
Y_{P/X} = \frac{q_P}{\mu} = \frac{0.127}{0.423} = 0.3\ \frac{gP}{gX}
$$

**Step 3**: 计算初始菌浓 $X_0$（由 starter 接入后稀释）：

$$
X_0 = \frac{X_{inc} \times V_{inc}}{V_P} = \frac{6 \times 100}{2500} = 0.24\ gX/L
$$

**Step 4**: 对数生长方程求最终菌浓 $X_f$：

$$
X_f = X_0 \times e^{\mu \cdot t_{log}} = 0.24 \times e^{0.423 \times 10} = 16.5\ gX/L
$$

**Step 5**: 求每批产蛋白量 $\Delta P$：

$$
\Delta P = Y_{P/X} \times (X_f - X_0) = 0.3 \times (16.5 - 0.24) = 4.876\ gP/L
$$

**Step 6**: 由体积生产率求总周期时间：

$$
Pr = \frac{\Delta P}{t_T} \Rightarrow t_T = \frac{4.876}{0.27} = 18\ hr
$$

**Step 7**: 维护时间：

$$
t_{maint} = t_T - t_{log} = 18 - 10 = \boxed{8\ hr}
$$

---

### 🎯 做题技巧

1. **Monod 方程** $\mu = \mu_{max} \frac{S}{K_S+S}$：已知 $\mu$ 和 $K_S$ 反求 $S$ 是常见考法，代数移项要熟练。

2. **世代时间与生长速率的关系**：$\mu = \ln 2 / t_d$。$t_d = 1.3 t_{d_{min}} \Rightarrow \mu = \mu_{max}/1.3$，直接一步到位。

3. **$q_P \rightarrow Y_{P/X}$**：$Y_{P/X} = q_P / \mu$，这是连接比速率和产率的关键公式。

4. **总糖 = 加入糖 + starter 带糖**：别忘记 starter 中的残糖也是总糖的一部分。

---

## 习题 2: 最小氧溶解度计算（氧消耗方程 + OUR）

### 📝 题目

细菌经验式 C₁.₀₅H₁.₈₃N₀.₃₂O₀.₆₁S₀.₀₁（灰分 8%）在甘油（C₃H₈O₃）为碳源、(NH₄)₂SO₄ 为氮源的培养基中生长。$\mu = 0.467\ hr^{-1}$，产物为生长激素（量少可忽略），$Y_{X/S} = 0.6\ gX/gS$。通入富氧空气（42% O₂），流量 100 L/hr，温度 22°C，压力 1.5 atm。发酵罐体积 1 L。

**求**：达到 20 gX/L 终浓度所需的最小氧溶解度（%）。 **(12%)**

| 参数 | 符号 | 数值 |
|------|------|------|
| 细菌经验式 | — | C₁.₀₅H₁.₈₃N₀.₃₂O₀.₆₁S₀.₀₁ |
| 灰分 | Ash | 8% |
| 生长速率 | μ | 0.467 hr⁻¹ |
| 产率 | Y_X/S | 0.6 gX/gS |
| 甘油 | — | C₃H₈O₃ (MW=92) |
| 空气流量 | Q_air | 100 L/hr |
| 氧含量 | %O₂_in | 42% |
| 温度 | T | 22°C = 295 K |
| 压力 | P | 1.5 atm |
| 罐体积 | V_ferm | 1 L |
| 终菌浓 | X_f | 20 gX/L |

---

### 🔢 解答

**Step 1**: 计算细菌分子量（扣除灰分）

无灰分分子量：
$$
MW_X(base) = 1.05\times12 + 1.83\times1 + 0.61\times16 + 0.32\times14 + 0.01\times32 = 27.42
$$

$$
MW_X = \frac{27.42}{(100-8)\%} = 31.51\ \frac{gX}{moleX}
$$

**Step 2**: 计算各元素质量百分比

| 元素 | 公式 | 百分比 |
|------|------|--------|
| O' | 0.61×16 / 31.51 | 30.97% |
| C' | 1.05×12 / 31.51 | 39.99% |
| N' | 0.32×14 / 31.51 | 14.22% |
| H' | 1.83×1 / 31.51 | 5.81% |

**Step 3**: 使用氧气消耗方程求 $Y_O$（条件全部满足：已知菌体组成、明确碳源、氨盐氮源、仅生长生物质）

$$
Y_O = \frac{32\cdot C + 8\cdot H - 16\cdot O}{Y_X \cdot MW_S} + 0.01O' - 0.0267C' + 0.01714N' - 0.08H'
$$

$$
Y_O = \frac{32\times3 + 8\times8 - 16\times3}{0.6 \times 92} + 0.01(30.97) - 0.0267(39.99) + 0.01714(14.22) - 0.08(5.81)
$$

$$
Y_O = 1.059\ \frac{gO_2}{gX}
$$

**Step 4**: 计算最大 OUR（发酵结束时）：

$$
OUR_{max} = \mu \times X_f \times Y_O = 0.467 \times 20 \times 1.059 = 10\ \frac{gO_2}{L\cdot hr}
$$

**Step 5**: 计算进氧速率（理想气体方程）：

$$
\dot{V}_{O_2}^{in} = \frac{Q_{air} \times \%O_2^{in}}{V_{ferm}} \times \frac{P \times MW_{O_2}}{T \times R}
$$

$$
\dot{V}_{O_2}^{in} = \frac{100 \times 0.42}{1} \times \frac{1.5 \times 32}{295 \times 0.082} = 83.34\ \frac{gO_2}{L\cdot hr}
$$

**Step 6**: 最小溶解度：

$$
\text{Solubility}_{\min} = \frac{OUR_{max}}{\dot{V}_{O_2}^{in}} \times 100\% = \frac{10}{83.34} \times 100\% = \boxed{12\%}
$$

---

### 🎯 做题技巧

1. **灰分处理**：$MW_X(true) = MW_X(base) / (1 - Ash\%)$。灰分不参与元素平衡，但影响分子量计算。

2. **氧气消耗方程四条件**：必须在计算前逐一确认（已知菌体组成、明确碳源、氨盐氮源、仅生长）。

3. **理想气体方程**：$\dot{n} = \frac{PV}{RT}$，再乘以 MW → 质量流量。$R = 0.082\ L\cdot atm/(mol\cdot K)$。

4. **最大 OUR**：在发酵结束时出现（$X_f$ 最大），$OUR_{max} = \mu X_f Y_O$。

---

## 习题 3: 尾气分析反推产率与菌浓

### 📝 题目

工厂在 1000 L 发酵罐中批式发酵细菌。接种 165 g 细菌后立即对数生长 16 hr。通入常压空气（21% O₂），压力 1.5 atm，温度 31°C，恒流量 2 VVM。尾气氧浓度监控：开始时 20.97%，结束时 17.53%。

| 参数 | 符号 | 数值 |
|------|------|------|
| 发酵罐体积 | V_ferm | 1000 L |
| 接种量 | W_X₀ | 165 gX |
| 对数期 | t_log | 16 hr |
| 空气流量 | Q | 2 VVM |
| 进氧百分比 | %O₂_in | 21% |
| 尾气 O₂ (t=0) | %O₂_out(t₀) | 20.97% |
| 尾气 O₂ (t=f) | %O₂_out(t_f) | 17.53% |
| 压力 | P | 1.5 atm |
| 温度 | T | 31°C = 304 K |

**A.** 求 $Y_{X/O}$ (gX/gO₂)。 **(0.707 gX/gO₂)**

**B.** 求发酵结束时菌浓 $X_f$ (g/L)。 **(19.1 g/L)**

---

### 🔢 解答

#### A. 计算 $Y_{X/O}$

**Step 1**: 计算进口气体中的氧供给速率。2 VVM = 2 L_air/(L_ferm·min)：

$$
\dot{V}_{O_2}^{in} = Q \times V_{ferm} \times \%O_2^{in} \times \frac{P \times MW_{O_2}}{T \times R} \times 60
$$

$$
\dot{V}_{O_2}^{in} = 2 \times 1 \times 0.21 \times \frac{1.5 \times 32}{304 \times 0.082} \times 60 = 48.524\ \frac{gO_2}{L\cdot hr}
$$

**Step 2**: 计算出口氧流量（开始和结束）：

$$
\dot{V}_{O_2}^{out}(t_0) = 2 \times 1 \times 0.2097 \times \frac{1.5 \times 32}{304 \times 0.082} \times 60 = 48.454\ \frac{gO_2}{L\cdot hr}
$$

$$
\dot{V}_{O_2}^{out}(t_f) = 2 \times 1 \times 0.1753 \times \frac{1.5 \times 32}{304 \times 0.082} \times 60 = 40.506\ \frac{gO_2}{L\cdot hr}
$$

**Step 3**: OUR = 进口 − 出口：

$$
OUR(t_0) = 48.524 - 48.454 = 0.070\ \frac{gO_2}{L\cdot hr}
$$

$$
OUR(t_f) = 48.524 - 40.506 = 8.018\ \frac{gO_2}{L\cdot hr}
$$

**Step 4**: OUR 比值 = 菌浓比值（$q_{O_2}$ 不变）：

$$
\frac{X_f}{X_0} = \frac{OUR(t_f)}{OUR(t_0)} = \frac{8.018}{0.070} = 114.54
$$

**Step 5**: 由对数生长方程求 $\mu$：

$$
\mu = \frac{\ln(114.54)}{16} = 0.296\ hr^{-1}
$$

**Step 6**: $X_0 = 165\ gX / 1000\ L = 0.165\ gX/L$。由 $OUR(t_0)$ 求 $Y_{X/O}$：

$$
OUR = \frac{\mu X}{Y_{X/O}} \Rightarrow Y_{X/O} = \frac{\mu X_0}{OUR(t_0)} = \frac{0.296 \times 0.165}{0.070} = \boxed{0.698\ \frac{gX}{gO_2}}
$$

---

#### B. 计算最终菌浓

$$
X_f = 114.54 \times X_0 = 114.54 \times 0.165 = \boxed{18.9\ gX/L \approx 19.1\ gX/L}
$$

---

### 🎯 做题技巧

1. **VVM 的概念**：2 VVM = 每分钟每升发酵液通入 2 L 空气。$Q_{total} = VVM \times V_{ferm}$。

2. **尾气分析法的核心**：$OUR = O_2^{in} - O_2^{out}$。这是一种非侵入式监测菌体生长的方法。

3. **$q_{O_2}$ 恒定假设**：当比氧消耗速率不变时，$OUR \propto X$，比值直接反映生长。

4. **单位陷阱**：VVM 给的流量是 min⁻¹，需 ×60 转 hr⁻¹。

---

## 习题 4: 赖氨酸批式补料 — 实际产率与补料时间表

### 📝 题目

细菌在葡萄糖上生产赖氨酸。葡萄糖浓度不能超过 5%。$\mu = 0.1\ hr^{-1}$，$q_P = 0.2\ gP/gX·hr$。初始 $X_0 = 2\ g/L$，初始 $S_0 = 5\%$。目标 $P_f = 50\ gP/L$。

类似菌株在仅生长模式下 $Y_{X/S}^* = 0.5\ gX/gS$。

| 参数 | 符号 | 数值 |
|------|------|------|
| 生长速率 | μ | 0.1 hr⁻¹ |
| 比生产速率 | q_P | 0.2 gP/gX·hr |
| 初始菌浓 | X₀ | 2 g/L |
| 糖最大浓度 | S_max | 5% = 50 g/L |
| 目标赖氨酸浓度 | P_f | 50 gP/L |
| 理论生长产率 | $Y_{X/S}^*$ | 0.5 gX/gS |

**A.** 求本发酵中实际细菌对葡萄糖的产率。 **(0.167 gX/gS)**

**B.** 每次葡萄糖耗尽时将浓度恢复至 5%，求补料时间表。 **(16.44 hr, 22.36 hr)**

---

### 🔢 解答

#### A. 计算实际 $Y_{X/S}$

**Step 1**: 求产物产率 $Y_{P/X}$：

$$
Y_{P/X} = \frac{q_P}{\mu} = \frac{0.2}{0.1} = 2\ \frac{gP}{gX}
$$

**Step 2**: 求产物对底物的产率 $Y_{P/S}$（假设碳含量比例相似）：

$$
Y_{P/S} = Y_{P/X} \times Y_{X/S}^* = 2 \times 0.5 = 1.0\ \frac{gP}{gS}
$$

**Step 3**: 底物被分为生长（1/3）和生产（2/3）两部分：

$$
\frac{1}{Y_{X/S}} = \frac{1}{Y_{X/S}^*} + \frac{Y_{P/X}}{Y_{X/S}^*} \Rightarrow Y_{X/S} = \frac{Y_{X/S}^*}{1 + Y_{P/X}} = \frac{0.5}{1+2} = \boxed{0.167\ \frac{gX}{gS}}
$$

> **直觉解释**：每 1 gX 产生同时产生 2 gP，共需 3 g 产物对应的葡萄糖。碳比例相同时，只有 1/3 的葡萄糖用于生长，因此实际 $Y_{X/S} = Y_{X/S}^*/3$。

---

#### B. 计算补料时间表

**Step 1**: 求所需最终菌浓（$P_0 = 0$，胞外产物）：

$$
Y_{P/X} = \frac{P_f - P_0}{X_f - X_0} \Rightarrow X_f = \frac{50 - 0}{2} + 2 = 27\ gX/L
$$

**Step 2**: 第一次达到糖耗尽的菌浓（初始糖 50 g/L）：

$$
X_1 = X_0 + Y_{X/S} \times S_0 = 2 + 0.167 \times 50 = 10.35\ gX/L
$$

第一次补料时间：

$$
t_1 = \frac{\ln(10.35/2)}{0.1} = \boxed{16.44\ hr}
$$

**Step 3**: 第二次补料后菌浓（再加 50 g/L 糖）：

$$
X_2 = X_1 + 0.167 \times 50 = 10.35 + 8.35 = 18.70\ gX/L
$$

第二次补料时间：

$$
\Delta t_2 = \frac{\ln(18.70/10.35)}{0.1} = 5.92\ hr
$$

$$
t_2 = t_1 + \Delta t_2 = 16.44 + 5.92 = \boxed{22.36\ hr}
$$

**Step 4**: 第三次补料后：

$$
X_3 = 18.70 + 8.35 = 27.05 \approx 27\ gX/L \ ✓
$$

刚好达到目标菌浓，无需第三次补料！

---

### 🎯 做题技巧

1. **实际产率与理论产率的区别**：当产物也含碳时，$Y_{X/S}$ 会显著低于 $Y_{X/S}^*$。$Y_{X/S} = Y_{X/S}^*/(1 + Y_{P/X})$。

2. **补料时间计算**：$X_{new} = X_{old} + Y_{X/S} \times S_{pulse}$，再由对数生长求 $\Delta t$。

3. **验证最后一次补料**：计算 $X_{after}$ 是否超过 $X_f$。若刚好达到或略超，则无需再补。

4. **关键假设**：碳含量在菌体和产物中比例相似，这样才能用 $Y_{X/S}^*$ 直接推 $Y_{P/S}$。

---

## 综合技巧总结 (Global Strategy Summary)

| 题型 | 核心公式 | 易错点 |
|------|---------|--------|
| **Monod 反求** | $S = \frac{\mu K_S}{\mu_{max}-\mu}$ | $K_S$ 与 $S$ 单位要一致（mg/L 还是 g/L）|
| **世代时间** | $\mu = \ln 2/t_d$，$t_d = 1.3 t_{d_{min}} \Rightarrow \mu = \mu_{max}/1.3$ | 注意是 $t_d$ 更大 30%，不是 $\mu$ 更小 |
| **$q_P \to Y_{P/X}$** | $Y_{P/X} = q_P/\mu$ | 区分比速率 ($q_P$) 和产率 ($Y_{P/X}$) |
| **氧气消耗方程** | $Y_O = \frac{32C+8H-16O}{Y_X MW_S} + corrigenda$ | 四条件必须全部满足；灰分处理 |
| **尾气法 OUR** | $OUR = O_2^{in} - O_2^{out}$；$OUR = \mu X Y_O$ | VVM→实际流量换算；理想气体方程 |
| **最小溶解度** | $\%_{min} = OUR_{max}/\dot{V}_{O_2}^{in}$ | 最大 OUR 在发酵结束时 |
| **实际 vs 理论产率** | $Y_{X/S} = Y_{X/S}^*/(1+Y_{P/X})$ | 碳分配比例决定实际产率 |
| **批式补料表** | $X_{n+1} = X_n + Y_{X/S}\cdot S_{pulse}$ | 最后一批是否刚好到达 $X_f$ |
