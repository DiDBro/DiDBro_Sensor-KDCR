# Tutorial 11 -- 完整习题解答与做题技巧

> **来源**: Tutorial 11 with Solutions.pdf (19 pages)
> **对应章节**: Inductive Sensors, Capacitive Sensors, Strain Gauges (Bentley Ch.8-9)
> **主讲**: Qilong Zhong, MSc, GTIIT

---
---

# 习题 1: 变气隙电感传感器 -- $\Delta L$ 怎么算

## 题目锁定

**关键词**: "变气隙电感传感器", "$S=1.5$ cm²", "$L=20$ cm", "$\mu_r=5000$", "$\delta_0=0.5$ cm", "$\Delta\delta = \pm 0.1$ mm", "$W=3000$ 匝", "灵敏度 $K = \Delta L/\Delta\delta$", "单端 vs 差动"

**知识点**: 变气隙电感传感器的核心公式 $L = \frac{\mu_0 S W^2}{2\delta}$（有两个气隙时）。气隙变化 $\Delta\delta$ → 电感变化 $\Delta L$ → 灵敏度 $K = \Delta L/\Delta\delta$。差动结构灵敏度翻倍。

**你问的**：$\Delta L$ 怎么算？很简单——先算 $L_0$（初始电感），再算气隙变化后的 $L'$，两者一减。

## 物理原理：为什么 $L = \mu_0 S W^2/(2\delta)$？

从磁路最基础的两个公式出发。

**磁阻 (Reluctance)** = 磁路的"电阻"：

$$
R_m = \frac{l}{\mu_0 \mu_r S}
$$

铁芯的 $\mu_r = 5000$，气隙的 $\mu_r = 1$（空气）。气隙的磁阻是铁芯的 **5000 倍**——所以即使气隙只有几毫米，总磁阻也几乎全由气隙决定。铁芯磁阻可以忽略。

对于有两个气隙（衔铁上、下各一个）的传感器，总气隙长度 = $2\delta$，所以气隙磁阻：

$$
R_m \approx \frac{2\delta}{\mu_0 \cdot 1 \cdot S} = \frac{2\delta}{\mu_0 S}
$$

**电感 (Inductance)** = $W^2$ / 磁阻：

$$
L = \frac{W^2}{R_m} = \frac{W^2}{2\delta/(\mu_0 S)} = \frac{\mu_0 S W^2}{2\delta}
$$

$$
\boxed{L = \frac{\mu_0 S W^2}{2\delta}}
$$

> 📖 物理直觉：匝数 $W$ 越多 → 电感越大（平方关系）。气隙 $\delta$ 越窄 → 电感越大（反比）。截面积 $S$ 越大 → 电感越大。这就是传感器的基本原理——被测物移动改变气隙 $\delta$，电感跟着变。

---

## $\Delta L$ 的计算方法

气隙从 $\delta_0$ 变成 $\delta_0 + \Delta\delta$（衔铁远离）或 $\delta_0 - \Delta\delta$（衔铁靠近）。

**初始电感**（$\delta = \delta_0 = 0.5$ cm）：

$$
L_0 = \frac{\mu_0 S W^2}{2\delta_0}
$$

**变化后的电感**（$\delta = \delta_0 \pm \Delta\delta$）：

$$
L' = \frac{\mu_0 S W^2}{2(\delta_0 \pm \Delta\delta)}
$$

**$\Delta L = L' - L_0$**。两者一减即得结果。不是重新推导一个新公式，就是**同一个 $L(\delta)$ 公式，代入两个不同的 $\delta$ 值**。

> 📖 $L' < L_0$（$\Delta L$ 为负）= 气隙增大，电感减小。$L' > L_0$（$\Delta L$ 为正）= 气隙减小，电感增大。

**灵敏度定义**：单位气隙变化引起的电感变化。

$$
\boxed{K = \frac{\Delta L}{\Delta\delta}}
$$

---

## 套数计算

**给定参数**（先全部转 SI）：

| 参数 | 原值 | SI |
|------|------|-----|
| $S$ | 1.5 cm² | $1.5 \times 10^{-4}$ m² |
| $L$（磁路长度） | 20 cm | 0.2 m |
| $\mu_r$（铁芯） | 5000 | — |
| $\delta_0$（初始气隙） | 0.5 cm | $0.5 \times 10^{-2} = 0.005$ m |
| $\Delta\delta$ | ±0.1 mm | $\pm 0.1 \times 10^{-3} = \pm 10^{-4}$ m |
| $W$（匝数） | 3000 | — |
| $\mu_0$ | — | $4\pi \times 10^{-7}$ H/m |

---

**Step 1: 计算初始电感 $L_0$**

先算分子：$\mu_0 S W^2 = (4\pi\times10^{-7}) \times (1.5\times10^{-4}) \times (3000^2)$

$= 4\pi \times 1.5 \times 9 \times 10^{-7-4+6} = 4\pi \times 13.5 \times 10^{-5} \approx 1.6965 \times 10^{-3}$

分母：$2\delta_0 = 2 \times 0.005 = 0.01$ m。

$$
L_0 = \frac{1.6965 \times 10^{-3}}{0.01} = 0.16965 \ \mathrm{H} \approx \boxed{169.6 \ \mathrm{mH}}
$$

---

**Step 2: 计算气隙变化 $\pm 0.1$ mm 后的电感 $L'$**

气隙变为 $\delta = 0.005 \pm 0.0001$ m。

以 $\Delta\delta = +0.1$ mm（气隙增大到 0.0051 m）为例：

$$
L' = \frac{1.6965 \times 10^{-3}}{2 \times 0.0051} = \frac{1.6965 \times 10^{-3}}{0.0102} \approx 0.1663 \ \mathrm{H} = 166.3 \ \mathrm{mH}
$$

以 $\Delta\delta = -0.1$ mm（气隙减小到 0.0049 m）为例：

$$
L' = \frac{1.6965 \times 10^{-3}}{2 \times 0.0049} = \frac{1.6965 \times 10^{-3}}{0.0098} \approx 0.1731 \ \mathrm{H} = 173.1 \ \mathrm{mH}
$$

---

**Step 3: $\Delta L$ = 变化后的 $L'$ 减初始 $L_0$**

$$
\Delta L \approx |L' - L_0| \approx \boxed{3.5 \ \mathrm{mH}}
$$

> $\Delta\delta$ 为正（气隙增大）→ $\Delta L \approx -3.3$ mH。$\Delta\delta$ 为负（气隙减小）→ $\Delta L \approx +3.5$ mH。两者不完全对称是因为 $L \propto 1/\delta$ 本身是非线性的。在微小位移下近似对称，教材取 $|\Delta L| \approx 3.5$ mH。

---

**Step 4: 灵敏度**

$$
\boxed{K = \frac{\Delta L}{\Delta\delta} = \frac{3.5 \times 10^{-3}}{0.1 \times 10^{-3}} = 35 \ \mathrm{H/m}}
$$

含义：气隙每变化 1 m，电感变化 35 H。实际位移通常远小于 1 m（微米级），所以 $\Delta L$ 在 mH 量级。

---

**Step 5: 差动结构灵敏度**

两个线圈反向变化，取差。输出 = $\Delta L_{diff} = L(\delta_0 - \Delta\delta) - L(\delta_0 + \Delta\delta)$。

在小位移下：$\Delta L_{diff} \approx 2\Delta L_{single}$（翻倍）。

$$
\boxed{K_{diff} = 2 \times 35 = 70 \ \mathrm{H/m}}
$$

---

## 总结：$\Delta L$ 算起来就三步

| 步骤 | 做什么 | 公式 |
|------|--------|------|
| 1 | 算 $L_0$ | $L_0 = \frac{\mu_0 S W^2}{2\delta_0}$ |
| 2 | 算气隙变化后的 $L'$ | $L' = \frac{\mu_0 S W^2}{2(\delta_0 \pm \Delta\delta)}$ |
| 3 | $\Delta L = L' - L_0$ | 两数相减 |

> **不是新公式，就是同一个 $L(\delta)$ 代入两个不同的 $\delta$！**

## 做题技巧

1. **单位转换是最大的坑**：cm² → ×10⁻⁴, mm → ×10⁻³, cm → ×10⁻²。SI 算完再转回 mH。
2. **$\Delta L$ 不是线性**：$L \propto 1/\delta$，所以 $+\Delta\delta$ 和 $-\Delta\delta$ 对应的 $|\Delta L|$ 不完全相等。小位移时近似对称。
3. **灵敏度 $K = \Delta L/\Delta\delta$**：单位是 H/m，数值大（35 H/m）是因为气隙变化量（0.1 mm）很小。
4. **差动 = 灵敏度×2**：两个线圈反向变化取差，原理和电桥差分一样。

---
---

# 习题 2: 单端 vs 差动 -- 灵敏度与线性度

## 题目锁定

**关键词**: "单端结构", "差动结构", "灵敏度翻倍", "偶次谐波抵消"

**知识点**: 接续习题 1 的计算结果。刚才算出的单端灵敏度 $K_{single} = 35$ H/m。差动结构 = 两个相同线圈反向变化，输出取差 → 灵敏度翻倍至 $K_{diff} = 70$ H/m。同时，差动结构将 $L \propto 1/\delta$ 的非线性展开中的偶次项（$\Delta\delta^2, \Delta\delta^4, \ldots$）全部抵消。

## 物理原理

**单端**：一个线圈，衔铁移动改变一个气隙。输出 $\Delta L_{single} \approx L_0 \cdot \Delta\delta/\delta_0$（微小位移近似），灵敏度 $K_{single} = L_0/\delta_0$。

**差动**：两个完全相同线圈。衔铁移动时：上线圈气隙 $\delta_0 - \Delta\delta$ → $L_1$ 增大；下线圈气隙 $\delta_0 + \Delta\delta$ → $L_2$ 减小。输出取差：

$$
\boxed{\Delta L_{diff} = L_1 - L_2 \approx 2L_0 \frac{\Delta\delta}{\delta_0}}
$$

$$
\boxed{K_{diff} = 2K_{single} = 70 \ \mathrm{H/m}}
$$

**线性度改善**：差动消掉 $L \propto 1/\delta$ 的泰勒展开中所有 $\Delta\delta^2, \Delta\delta^4, \ldots$ 偶次项。剩下来的奇次项在小位移下近似线性。

> 📖 这和电桥差分的数学原理完全一致——两个相同元件反向变化，差值为两倍变化量，同时抵消偶次非线性项和共模温漂。

## 做题技巧

1. 差动 = 灵敏度×2 + 偶次非线性抵消 + 温补。
2. 原理和电桥差分完全一样。

---
---

# 习题 3: 电容传感器 -- 三种变体分析

## 题目锁定

**关键词**: "$C = \varepsilon_0\varepsilon_r A/d$", "变极距", "变面积", "变介质", "线性 vs 非线性"

**知识点**: 电容传感器三种类型的输出特性。

## 物理原理

| 类型 | 变化量 | 输出特性 | 线性度 |
|------|--------|---------|--------|
| 变极距 | $d$ | $C \propto 1/d$ | **非线性** |
| 变面积 | $A$ | $C \propto A$ | **严格线性** |
| 变介质 | $\varepsilon_r$ | $C \propto \varepsilon_r$ | **严格线性** |

## 套数计算

**圆柱电容液位计**（变介质的经典应用）：

$C_{total} = C_{liquid} + C_{air} = C_0 + K \cdot h$（**完全线性**）。

## 做题技巧

1. 三种类型来自 $C = \varepsilon_0\varepsilon_r A/d$ 的三个参数。
2. 变极距非线性但对微位移极灵敏（$1/d$ 超线性）。
3. 变面积/变介质 = 线性, 适合大量程。

---
---

# 习题 4: 电容传感器具体计算 -- 变介质位移量 ⭐⭐

## 题目锁定

**关键词**: "two square metal plates of side 5 cm", "separated by 1 mm", "dielectric sheet thickness 1 mm", "$\varepsilon_r$ of air = 1.0, dielectric = 4.0", "capacitance for displacements $x$ = 0.0, 2.5, 5.0 cm"

**知识点**: **变介质型电容传感器**的线性输出特性。$C \propto \varepsilon_r$，被介质部分填充时等效为两个电容并联。这是电容传感器三种变体中唯一"既精确又不需要差动结构"的类型。

## 物理原理

两正方形极板，间距 $d = 1$ mm，半边宽 $w = 5$ cm。介质片从侧面插入，插入深度为 $x$。

**关键建模**：被介质覆盖的区域和未被覆盖的区域是**并联**关系（共用同一对极板）。

$$
C_{total} = C_{air} + C_{dielectric}
$$

其中：
- $C_{air}$ = 空气段贡献 = $\varepsilon_0 \cdot 1.0 \cdot w(w-x) / d$
- $C_{dielectric}$ = 介质段贡献 = $\varepsilon_0 \cdot 4.0 \cdot w \cdot x / d$

合并得线性插值公式：

$$
\boxed{C(x) = \frac{\varepsilon_0 w}{d}\Big[\varepsilon_{r1}(w-x) + \varepsilon_{r2} \cdot x\Big] = \frac{\varepsilon_0 w}{d}\Big[\varepsilon_{r1} \cdot w + (\varepsilon_{r2} - \varepsilon_{r1})x\Big]}
$$

> 📖 当介质 $\varepsilon_{r2}=4.0$ 逐渐取代空气时，等效介电常数从 1.0 线性过渡到 4.0。$C(x)$ 与 $x$ 成正比，**天生线性**——不像变极距型需要差动结构来消除非线性。

## 套数计算

全部转 SI：$w = 5\ \mathrm{cm} = 0.05\ \mathrm{m}$，$d = 1\ \mathrm{mm} = 0.001\ \mathrm{m}$，$\varepsilon_0 = 8.85 \times 10^{-12}\ \mathrm{F/m}$。

**前置系数**（三个情况共用）：

$$
\frac{\varepsilon_0 w}{d} = \frac{8.85\times10^{-12} \times 0.05}{0.001} = 4.425 \times 10^{-10} \ \mathrm{F}
$$

**通式**（代入 $\varepsilon_{r1}=1.0$, $\varepsilon_{r2}=4.0$）：

$$
\boxed{C(x) = 4.425\times10^{-10} \times \big(3x + 0.05\big) \ \mathrm{F}}
$$

---

**Case 1：$x = 0.0$ cm（全部为空气，$\varepsilon_{r,eff} = 1.0$）**

$$
C = 4.425\times10^{-10} \times (0 + 0.05) = 2.2125 \times 10^{-11} \ \mathrm{F} = \boxed{22.13 \ \mathrm{pF}}
$$

验证——用最简单的平板公式：$C = \varepsilon_0 \cdot 1.0 \cdot (0.05)^2 / 0.001 = 22.125\ \mathrm{pF}$ ✓（微小舍入误差）。

---

**Case 2：$x = 2.5$ cm = 0.025 m（一半空气、一半介质）**

$$
C = 4.425\times10^{-10} \times (3 \times 0.025 + 0.05) = 4.425\times10^{-10} \times 0.125 = 5.53125 \times 10^{-11} \ \mathrm{F} = \boxed{55.31 \ \mathrm{pF}}
$$

> $55.31 \approx (22.13 + 88.50)/2 = 55.32\ \mathrm{pF}$ — 线性插值的中点，符合预期。

---

**Case 3：$x = 5.0$ cm = 0.05 m（全部为介质，$\varepsilon_{r,eff} = 4.0$）**

$$
C = 4.425\times10^{-10} \times (3 \times 0.05 + 0.05) = 4.425\times10^{-10} \times 0.20 = 8.85 \times 10^{-11} \ \mathrm{F} = \boxed{88.50 \ \mathrm{pF}}
$$

验证——全介质的平板公式：$C = \varepsilon_0 \cdot 4.0 \cdot (0.05)^2 / 0.001 = 88.50\ \mathrm{pF}$ ✓。

---

### 结果汇总

| 位移 $x$ (cm) | 电容 (pF) | $\varepsilon_{r,eff}$ |
|---------------|-----------|----------------------|
| 0.0 | 22.13 | 1.0（全空气） |
| 2.5 | 55.31 | 2.5（半半） |
| 5.0 | 88.50 | 4.0（全介质） |

> $C$ 随 $x$ 严格线性增长——$C$ 和 $x$ 成正比例，灵敏度 $K_C = \Delta C/\Delta x = (88.50-22.13)/5.0 \approx 13.27\ \mathrm{pF/cm}$，恒定不变。

---

### 附加题：圆形极板初始电容

**题目**：两圆形极板（直径 2 cm）间距 1 mm 空气，求初始电容。这是**最简单**的电容传感器计算——什么都不变，只算初始值。

半径 $r = 0.01$ m，$A = \pi r^2 = 3.1416 \times 10^{-4}$ m²。

$$
\boxed{C_0 = \frac{\varepsilon_0 \varepsilon_r A}{d} = \frac{8.85\times10^{-12} \times 1.0 \times 3.1416\times10^{-4}}{0.001} \approx 2.78 \ \mathrm{pF}}
$$

## 做题技巧

1. **电容并联而不是串联**——介质片覆盖区的两个区域共享同一对极板，所以是并联。
2. **变介质 = 天生线性**：$C(x) \propto x$，不像变极距型 $C \propto 1/d$ 那样需要差动结构。
3. **前置系数 $\varepsilon_0 w/d$ 一次算完**——三个位移值共用，只需带入 $3x+0.05$ 即可。
4. **极端值验证法**：$x=0$ 用全空气平板公式、$x=5$ 用全介质平板公式，与通用公式结果吻合。

---
---

# 习题 5: 应变片完整测量链

## 题目锁定

**关键词**: "力→应力→应变→$\Delta R/R$", "$K=2.0$", "$\mu\varepsilon=10^{-6}$", "桥路输出"

**知识点**: 应变片完整测量链 + 三种桥路灵敏度。

## 物理原理

$\sigma = F/A \to \varepsilon = \sigma/E \to \Delta R/R = K\varepsilon \to$ 桥路输出。

微应变 $\mu\varepsilon = 10^{-6}$（百万分之一）。

三种桥路输出（$U_{ex}$ = 桥压）：

| 配置 |输出 |
|------|------|
| 1/4 桥 | $\frac{1}{4}U_{ex}K\varepsilon$ |
| 半桥差分 | $\frac{1}{2}U_{ex}K\varepsilon$ |
| 全桥差分 | $U_{ex}K\varepsilon$ |

## 做题技巧

1. $E$ 用 Pa（GPa → ×10⁹）。
2. $\mu\varepsilon = 10^{-6}$。
3. 桥路输出 mV 级, 需放大。

---
---

# 习题 6: 应变片布片与桥路完成

## 题目锁定

**关键词**: "布片策略", "温度补偿片", "桥路完成"

**知识点**: 实际布片 + 接线。温度补偿片（同材料同温不受力）接邻臂。

## 物理原理

温度变化使应变片阻值同向漂移。**补偿片**贴在相同材料上、处于相同温度、但不受应变。接入邻臂 → 温漂同向抵消，只保留受力信号。

## 做题技巧

1. 工作片：测应变。补偿片：只提供温度基准。
2. 工作片和补偿片接邻臂。

---
---

# 综合技巧总结

**电感传感器**
- $L_0 = \mu_0 S_0 W^2 / (2\delta_0)$
- 差动：灵敏度×2 + 偶次非线性抵消
- $\mu_0 = 4\pi\times10^{-7}$ H/m

**电容传感器**
- $C = \varepsilon_0\varepsilon_r A/d$
- 变极距(非线性) / 变面积(线性) / 变介质(线性)
- $\varepsilon_0 = 8.85\times10^{-12}$ F/m

**应变片**
- $F \to \sigma \to \varepsilon \to \Delta R/R = K\varepsilon$
- 微应变 $\mu\varepsilon = 10^{-6}$
- 1/4桥(1×)/半桥(2×,线性)/全桥(4×,线性+温补)
