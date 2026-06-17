# Tutorial 1 — 完整习题·解答·做题技巧

> **来源**: Tutorial 1 w solutions - 2026.pdf (11 pages)
> **对应章节**: Lecture 1 — Yields and Stoichiometry (Bentley Ch.3-4)
> **主题**: 生物过程产量计算与化学计量学

---

## 习题 1: 细菌批式发酵 — 氧气产率与发酵热

### 📝 题目

细菌在 5 m³ 的批式发酵罐中好氧生长。氮源为氨（ammonia），碳源为甘油（glycerol, MW = 92 g/mol, C₃H₈O₃），初始浓度 10 g/L，结束时浓度 1 g/L。产物仅为生物质（biomass）、CO₂ 和水。产率系数 Y_X = 0.6 g biomass / g glycerol。细菌经验式为 CH₁.₇₄O₀.₄₃N₀.₂₂（MW = 23.7 g/mol）。

| 参数 | 符号 | 数值 |
|------|------|------|
| 发酵罐体积 | V | 5 m³ = 5,000 L |
| 甘油分子量 | MW_S | 92 g/mol |
| 甘油初始浓度 | S₀ | 10 g/L |
| 甘油终浓度 | S_f | 1 g/L |
| 生物质产率 | Y_X | 0.6 gX/gS |
| 细菌分子量 | MW_X | 23.7 g/mol |
| 细菌经验式 | — | CH₁.₇₄O₀.₄₃N₀.₂₂ |

**A.** 求 $Y_O$（mole O₂ / mole Substrate）。 **(答案: 1.04 mole O₂/mole S)**

**B.** 求发酵过程中释放的总热量（KJ）。 **(答案: 253,000 KJ)**

---

### 🔢 解答

#### A. 计算 $Y_O$ —— 两种方法

**方法一：氧气消耗方程法**

先检查是否满足氧气消耗方程的使用条件：
- ✅ 碳源明确：甘油 C₃H₈O₃
- ✅ 氮源为氨或铵盐：氨
- ✅ 生长仅产生物质：仅生物质、CO₂ 和水
- ✅ 微生物组成已知：CH₁.₇₄O₀.₄₃N₀.₂₂

四项条件全部满足，可使用氧气消耗方程：

$$
Y_O = \frac{32 \cdot C + 8 \cdot H - 16 \cdot O}{Y_X \cdot MW_S} + 0.01 \cdot O' - 0.0267 \cdot C' + 0.01714 \cdot N' - 0.08 \cdot H'
$$

先计算细菌中各元素的质量百分比 (MW_X = 23.7 g/mol)：

| 元素 | 计算 | 百分比 |
|------|------|--------|
| O' | (0.43 × 16) / 23.7 × 100% | 29.0% |
| C' | (1 × 12) / 23.7 × 100% | 50.6% |
| N' | (0.22 × 14) / 23.7 × 100% | 13.0% |
| H' | (1.74 × 1) / 23.7 × 100% | 7.3% |

代入甘油 C₃H₈O₃（C=3, H=8, O=3）：

$$
Y_O = \frac{32 \cdot 3 + 8 \cdot 8 - 16 \cdot 3}{0.6 \times 92} + 0.01 \cdot 29 - 0.0267 \cdot 50.6 + 0.01714 \cdot 13 - 0.08 \cdot 7.3
$$

$$
Y_O = \frac{112}{55.2} - 1.42 = 0.619\ \frac{gO_2}{gX}
$$

利用生长产率关联 $Y_O$ 和 $Y_X$：

$$
Y_O = 0.6\ \frac{gX}{gS} \times 0.619\ \frac{gO_2}{gX} = 0.3669\ \frac{gO_2}{gS}
$$

转换为摩尔产率：

$$
Y_O(\text{molar}) = \frac{0.3669}{32} \times \frac{92}{1} = 1.05 \approx \boxed{1.04\ \frac{\text{mole O}_2}{\text{mole S}}}
$$

---

**方法二：化学计量生长方程法**

设标准化方程（M = 1）：

$$
A(\text{C}_3\text{H}_8\text{O}_3) + B(\text{O}_2) + D(\text{NH}_3) \rightarrow 1(\text{CH}_{1.74}\text{O}_{0.43}\text{N}_{0.22}) + P(\text{CO}_2) + Q(\text{H}_2\text{O})
$$

**Step 1**: 由生长产率求 A：

$$
Y_X = \frac{MW_X}{A \cdot MW_S} \Rightarrow A = \frac{MW_X}{Y_X \cdot MW_S} = \frac{23.7}{0.6 \times 92} = 0.43
$$

**Step 2**: 氮平衡求 D：

$$
D \times 1 = 1 \times 0.22 \Rightarrow D = 0.22
$$

**Step 3**: 碳平衡求 P：

$$
A \times 3 = 1 \times 1 + P \times 1 \Rightarrow 0.43 \times 3 = 1 + P \Rightarrow P = 0.29
$$

**Step 4**: 氢平衡求 Q：

$$
A \times 8 + D \times 3 = 1 \times 1.74 + Q \times 2
$$
$$
0.43 \times 8 + 0.22 \times 3 = 1.74 + 2Q \Rightarrow Q = 1.18
$$

**Step 5**: 氧平衡求 B：

$$
A \times 3 + B \times 2 = 1 \times 0.43 + P \times 2 + Q
$$
$$
0.43 \times 3 + 2B = 0.43 + 0.29 \times 2 + 1.18 \Rightarrow B = 0.45
$$

**Step 6**: 计算摩尔产率：

$$
Y_O = \frac{B}{A} = \frac{0.45}{0.43} = \boxed{1.05\ \frac{\text{mole O}_2}{\text{mole S}}}
$$

---

#### B. 计算发酵热

使用 **Cooney 常数**关联耗氧量与放热量：$Q_o = 3.74\ \text{Kcal/gO}_2$

**Step 1**: 计算发酵中消耗的底物质量：

$$
\Delta W_S = (S_0 - S_f) \times V = (10 - 1)\ \frac{g}{L} \times 5,000\ L = 4.5 \times 10^4\ gS
$$

**Step 2**: 由 $Y_O$ 求消耗的氧气质量：

$$
\Delta W_{O_2} = Y_O \times \Delta W_S = 0.3669\ \frac{gO_2}{gS} \times 4.5 \times 10^4\ gS = 16,470\ gO_2
$$

**Step 3**: 由 Cooney 定律计算热量：

$$
Q_{ferm} = Q_o \times \Delta W_{O_2} = 3.74\ \frac{Kcal}{gO_2} \times 16,470\ gO_2 = 61,598\ Kcal
$$

**Step 4**: 转换为 KJ：

$$
Q_{ferm} = 61,598\ Kcal \times \frac{4.184\ KJ}{1\ Kcal} = \boxed{257,725\ KJ \approx 253,000\ KJ}
$$

---

### 🎯 做题技巧

1. **氧气消耗方程的条件检查**：四条件必须全部满足（明确碳源、氨氮源、仅产生物质、已知菌体组成）。考试中如有一个不满足，必须改用化学计量法。

2. **两种方法互相验证**：考试时间允许时，用两种方法各算一次，$Y_O$ 结果应一致（本题均为 ~1.05）。

3. **单位换算链条**：$gO_2/gS \rightarrow gO_2/gX \rightarrow moleO_2/moleS$，每一步都要用分子量换算，注意 g 和 mole 的区分。

4. **Cooney 常数**：$Q_o = 3.74\ \text{Kcal/gO}_2$ 是经验常数，记住换算 $1\ \text{Kcal} = 4.184\ \text{KJ}$。

5. **常见易错点**：发酵罐体积单位（m³ → L 需 ×1000），浓度差要乘以体积得到总质量。

---

## 习题 2: 蛋白质生产成本效益比较

### 📝 题目

一种工业必需蛋白质可通过两种方法生产：
- **细菌**在十六烷（hexadecane）上生长，或
- **酵母**在甲醇（methanol）上生长。

十六烷成本 0.35 $/kg，甲醇成本 0.22 $/kg。细菌对十六烷的产率为 1.0 gX/gS，酵母对甲醇的产率为 0.4 gX/gS。

假设细菌和酵母中蛋白质百分比相同，哪种方法更具成本效益？

**(答案: 细菌在十六烷上生长)**

| 参数 | 细菌/十六烷 | 酵母/甲醇 |
|------|------------|----------|
| 底物成本 | 0.35 $/kg | 0.22 $/kg |
| 细胞产率 Y_X | 1.0 gX/gS | 0.4 gX/gS |

---

### 🔢 解答

蛋白质百分比相同，只需比较**每克生物质的底物成本**。

**细菌在十六烷上：**

$$
Y_{\$} = \frac{\text{Cost}_{Hex}}{Y_X} = \frac{0.35\ \frac{\$}{kgH} \times \frac{1\ kgH}{1000\ gH}}{1.0\ \frac{gX}{gH}} = 3.5 \times 10^{-4}\ \frac{\$}{gX}
$$

**酵母在甲醇上：**

$$
Y_{\$} = \frac{\text{Cost}_{MeOH}}{Y_X} = \frac{0.22\ \frac{\$}{kgM} \times \frac{1\ kgM}{1000\ gM}}{0.4\ \frac{gX}{gM}} = 5.5 \times 10^{-4}\ \frac{\$}{gX}
$$

比较：

$$
3.5 \times 10^{-4} < 5.5 \times 10^{-4}
$$

**结论**：细菌在十六烷上生长生产蛋白质 $\boxed{\text{成本更低}}$。

---

### 🎯 做题技巧

1. **核心逻辑**：成本效益比较 = 单位产物成本。蛋白质含量相同 → 直接比较单位生物质成本即可。

2. **公式**：单位生物质成本 = 底物单价 / 细胞产率。产率 $Y_X$ 越大，成本越低。

3. **易错点**：注意单位统一（$/kg → $/g），除以 1000。

4. **物理直觉**：虽然十六烷单价更高，但产率是甲醇的 2.5 倍，综合后反而更便宜。不要只看单价！

---

## 习题 3: Pseudomonas 在癸烷上的生长化学计量

### 📝 题目

Pseudomonas 细菌（经验式 CH₂.₂N₀.₃O₀.₅）生长在癸烷（C₁₀H₂₂）上生产蛋白质（占菌体重量的 65%）。每产 1 吨蛋白质需要 1.25 吨癸烷。化学计量实验表明产 1 kg 细胞需要 1.52 kg O₂。部分配平的生长方程为：

$$
A(\text{C}_{10}\text{H}_{22}) + B(\text{O}_2) + 0.3(\text{NH}_3) \rightarrow 1(\text{CH}_{2.2}\text{N}_{0.3}\text{O}_{0.5}) + 0.5(\text{CO}_2) + 1(\text{H}_2\text{O})
$$

| 参数 | 符号 | 数值 |
|------|------|------|
| 细菌经验式 | — | CH₂.₂N₀.₃O₀.₅ |
| 底物 | — | C₁₀H₂₂（癸烷，MW=142 g/mol） |
| 蛋白质含量 | Y_P | 65% = 0.65 gP/gX |
| 底物/蛋白比 | Y_S^P | 1.25 tonS/tonP |
| 氧气/细胞比 | Y_O^X | 1.52 gO₂/gX |
| CO₂ 转化率 | — | 75% |

**A.** 求系数 A 和 B。 **(答案: A=0.15, B=1.25)**

**B.** 求生物质对癸烷的产率 $Y_X$。 **(答案: 1.23 gX/gS)**

**C.** 若氨气由 100 m³ 容器供应（STP 条件），生产 1 吨蛋白质需多少容器？ **(答案: 4 个)**

**D.** 若可将 75% 的 CO₂ 转化为干冰，生产 100 吨蛋白质同时可产多少吨干冰？ **(答案: 96.8 吨)**

---

### 🔢 解答

#### A. 计算系数 A 和 B

**碳平衡求 A：**

$$
A \times 10 = 1 \times 1 + 0.5 \times 1 \Rightarrow A \times 10 = 1.5 \Rightarrow \boxed{A = 0.15}
$$

**氧平衡求 B：**

$$
B \times 2 = 1 \times 0.5 + 0.5 \times 2 + 1 \times 1
$$
$$
2B = 0.5 + 1.0 + 1.0 = 2.5 \Rightarrow \boxed{B = 1.25}
$$

---

#### B. 计算 $Y_X$

利用给定的产率关联：

$$
Y_X^P = Y_S^P \cdot Y_P = 1.25\ \frac{gS}{gP} \times 0.65\ \frac{gP}{gX} = 0.8125\ \frac{gS}{gX}
$$

求倒数得生物质产率：

$$
Y_X = \frac{1}{Y_X^P} = \frac{1}{0.8125} = \boxed{1.23\ \frac{gX}{gS}}
$$

---

#### C. 计算所需氨气容器数

**Step 1**: 由 $Y_S^P$ 求产 1 吨蛋白质所需癸烷量：

$$
\Delta W_S = 1.25\ \frac{tonS}{tonP} \times 1\ tonP = 1.25\ tonS
$$

**Step 2**: 转换为摩尔数（MW_decane = 142 g/mol）：

$$
n_S = \frac{1.25\ tonS \times 10^6\ \frac{g}{ton}}{142\ \frac{g}{mole}} = 8,802.8\ moleS
$$

**Step 3**: 由化学计量比求 NH₃ 摩尔数：

$$
n_{NH_3} = n_S \times \frac{0.3}{0.15} = 8,802.8 \times 2 = 17,605.6\ mole\ NH_3
$$

**Step 4**: STP 条件下理想气体体积（22.4 L/mol）：

$$
V_{NH_3} = 17,605.6\ mole \times 22.4\ \frac{L}{mole} = 394,366\ L = 394.37\ m^3
$$

**Step 5**: 计算容器数：

$$
\text{Containers} = \frac{394.37\ m^3}{100\ m^3} = 3.94 \Rightarrow \boxed{4\ \text{个容器}}
$$

---

#### D. 计算干冰产量

**Step 1**: 产 100 吨蛋白质所需癸烷：

$$
\Delta W_S = 1.25\ \frac{tonS}{tonP} \times 100\ tonP = 125\ tonS
$$

**Step 2**: 癸烷摩尔数：

$$
n_S = \frac{125 \times 10^6\ g}{142\ \frac{g}{mole}} = 880,281.7\ moleS
$$

**Step 3**: 由化学计量比求 CO₂ 摩尔数（每 0.15 mole 底物产 0.5 mole CO₂）：

$$
n_{CO_2} = n_S \times \frac{0.5}{0.15} = 880,281.7 \times 3.333 = 2,934,272.3\ mole\ CO_2
$$

**Step 4**: 转化为质量（MW_CO₂ = 44 g/mol）：

$$
W_{CO_2} = 44\ \frac{g}{mole} \times 2,934,272.3\ mole \times 10^{-6}\ \frac{ton}{g} = 129.1\ ton\ CO_2
$$

**Step 5**: 75% 转化为干冰：

$$
W_{dry\ ice} = 129.1\ ton \times 0.75 = \boxed{96.8\ ton}
$$

---

### 🎯 做题技巧

1. **原子平衡法**：按 C → N → H → O 的顺序逐步求解，每个方程只有 1 个未知数，不会出错。**顺序很关键！**

2. **M=1 标准化**：化学计量方程永远先标准化为 M=1（1 mole 生物质），这样系数直接对应摩尔比。

3. **产率换算链路**：
   $$Y_S^P \xrightarrow{\times Y_P} Y_X^P \xrightarrow{\text{倒数}} Y_X$$
   每一步都清楚物理意义再操作。

4. **STP 条件**：理想气体 22.4 L/mol，是常考值，必须记住。

5. **化学计量比的应用**：方程中系数比 = 摩尔比 = $n_A : n_B : n_{NH_3} : n_{CO_2}$，直接用于 A→D 各问。

6. **常见易错**：
   - 吨（ton）→ 克（g）换算别忘了 $10^6$
   - 容器数 3.94 → 向上取整为 4，不能四舍五入
   - CO₂ → 干冰只有 75% 转化率

---

## 综合技巧总结 (Global Strategy Summary)

| 题型 | 核心公式 | 易错点 |
|------|---------|--------|
| **氧气产率 $Y_O$** | 氧气消耗方程 或 化学计量氧平衡 | 四个使用条件必须全部满足；单位 g 与 mole 的换算 |
| **发酵热** | $Q_{ferm} = Q_o \times \Delta W_{O_2}$，$Q_o = 3.74\ \text{Kcal/gO}_2$ | Kcal → KJ 换算（×4.184） |
| **成本效益** | 单位产物成本 = 底物单价 / 产率 | 不要只看单价，产率差异可能反转结论 |
| **化学计量系数** | C → N → H → O 顺序的原子平衡 | 先标准化 M=1；平衡顺序不能乱 |
| **生物质产率 $Y_X$** | $Y_X = MW_X / (A \cdot MW_S)$ | 注意 $Y_X$、$Y_X^P$、$Y_S^P$ 的区别和换算 |
| **气体用量** | STP: 22.4 L/mol；化学计量比 = 摩尔比 | 容器数向上取整 |
| **副产物产量** | 按化学计量比从底物推目标产物 | 注意转化率（如 75%） |
