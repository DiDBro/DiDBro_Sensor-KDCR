# Tutorial 5 — 完整习题·解答·做题技巧

> **来源**: Tutorial 5 with Solutions.pdf (35 pages)
> **对应章节**: Lectures 5–6 (Bentley Ch.7–8)
> **主讲**: Qilong Zhong, MSc, GTIIT

---

## 习题 1: 可靠性基本计算

### 题目

> 100 个相同热电偶在 12 周内测试，20 次故障，停机时间：5,6,7,8,4,7,8,10,5,4,8,5,4,5,6,5,4,9,8,6 小时。计算：
> (a) 平均停机时间 MDT
> (b) 平均故障间隔 MTBF
> (c) 平均故障率 $\bar{\lambda}$
> (d) 可用性 $A$

### 解答

**已知**：$N = 100$, $T = 12 \times 7 \times 24 = 2016$ h, $N_F = 20$

总停机时间：$\sum T_{D,j} = 124$ h

**(a) MDT**：$\frac{124}{20} = \boxed{6.2 \text{ h}}$

**(b) MTBF**：
总测试时间 $= N \times T = 100 \times 2016 = 201,600$ h
总正常运行时间 $= 201,600 - 124 = 201,476$ h
$$\text{MTBF} = \frac{201,476}{20} = \boxed{10,073.8 \text{ h}}$$

**(c) 平均故障率**：$\bar{\lambda} = \frac{1}{\text{MTBF}} = \boxed{9.93 \times 10^{-5} \text{ /h}}$

**(d) 可用性**：
$$A = \frac{\text{MTBF}}{\text{MTBF} + \text{MDT}} = \frac{10073.8}{10073.8 + 6.2} \approx \boxed{0.9994 \text{ (99.94\%)}}$$

### 🎯 技巧

**四步法**：总停机 → MDT → MTBF → $\bar{\lambda}$ / $A$

---

## 习题 2: 混合冗余系统可靠性

### 题目

> 3 个热电偶（$\lambda_1 = 1.1$）并联经中值选择器，再串联转换器（$\lambda_2 = 0.1$）和记录仪（$\lambda_3 = 0.1$）。求 $t = 0.5$ 年时的 $R$ 和 $F$。

### 解答

**Step 1: 并联热电偶等效**
单支 $F = 1 - e^{-1.1 \times 0.5} = 1 - e^{-0.55}$
三并联：$F_1 = (1 - e^{-0.55})^3 = 0.076$
$R_1 = 1 - 0.076 = \boxed{0.924}$

**Step 2: 串联组件**
$R_2 = R_3 = R_4 = e^{-0.1 \times 0.5} = e^{-0.05} = 0.951$

**Step 3: 总体**
$$\boxed{R_{OVERALL} = 0.924 \times 0.951^3 \approx 0.795}$$
$$\boxed{F_{OVERALL} = 0.205}$$

### 🎯 技巧

**混合系统分块法**：并联块先算 $F_{parallel} = \prod F_i$ → 再与串联块相乘 $R_{total} = R_{parallel} \times \prod R_{series}$。

---

## 习题 3: 流量测量系统 — 三种架构比较 ⭐⭐

### 题目

> 流量系统：孔板（$\lambda = 0.75$）、差压变送器（$\lambda = 1.0$）、开方器（$\lambda = 0.1$）、记录仪（$\lambda = 0.1$）。求 $t = 0.5$ 年时丢失测量的概率：
> (a) 单系统
> (b) 三套相同系统并联
> (c) 三套孔板+变送器并联经中值选择器（$\lambda = 0.1$），再串联单套开方器+记录仪

### 解答

**(a) 单系统（纯串联）**

$$\lambda_{sys} = 0.75 + 1.0 + 0.1 + 0.1 = 1.95 \text{ yr}^{-1}$$

$$R_a = e^{-1.95 \times 0.5} = e^{-0.975} \approx 0.3772$$

$$\boxed{F_a = 1 - 0.3772 = 0.6228 \text{ (62.28\%)}}$$

**(b) 三套并联**

$$\boxed{F_b = (F_a)^3 = 0.6228^3 \approx 0.2416 \text{ (24.16\%)}}$$

**(c) 混合冗余（中值选择器）**

前段并联：每个分支 $\lambda_{branch} = 0.75 + 1.0 = 1.75$
$F_{branch} = 1 - e^{-1.75 \times 0.5} = 1 - e^{-0.875} \approx 0.5831$
$F_{front} = 0.5831^3 \approx 0.1983$，$R_{front} = 0.8017$

后段串联：$\lambda_{back} = 0.1 + 0.1 + 0.1 = 0.3$
$R_{back} = e^{-0.3 \times 0.5} = 0.8607$

$$\boxed{R_c = 0.8017 \times 0.8607 \approx 0.6900}$$
$$\boxed{F_c = 0.3100 \text{ (31.00\%)}}$$

| 架构 | 失败概率 | 
|------|---------|
| 单系统 | 62.28% |
| 三并联 | 24.16% |
| 混合中值 | 31.00% |

> ✅ 三并联最可靠但成本最高；混合冗余在成本和可靠性间取得平衡。

### 🎯 技巧

1. **串联**：$\lambda_{sys} = \sum \lambda_i$，$R = e^{-\lambda t}$。
2. **并联**：$F_{sys} = \prod F_i$。
3. **混合系统**：分块 → 并联块转化 → 串联相乘。

---

## 习题 4: TLOC 比较

### 题目

> 比较两套液位测量系统（10 年寿命，仅故障维修，测量误差相同）：

| 参数 | 系统1 | 系统2 |
|------|-------|-------|
| 初始成本 | £1000 | £2000 |
| 材料/维修 | £20 | £15 |
| 人工 £/h | £10 | £10 |
| 过程损失 £/h | £100 | £100 |
| 维修时间 | 8 h | 12 h |
| 年故障率 | 2.0 | 1.0 |

### 解答

$$TLOC = C_1 + [C_R + (C_L + C_P) \times T_R] \times \lambda \times T$$

| | 系统1 | 系统2 |
|---|-------|-------|
| 单次故障成本 | $20+(10+100)\times8=£900$ | $15+(10+100)\times12=£1335$ |
| 10年故障次数 | $2.0\times10 = 20$ | $1.0\times10 = 10$ |
| 总维修成本 | $900\times20=£18,000$ | $1335\times10=£13,350$ |
| **TLOC** | **£19,000** | **£15,350** ✅ |

> ✅ 系统2初始贵一倍，但 TLOC 低 19%。**$C_P$（过程损失）是隐藏的巨人**。

### 🎯 技巧

$C_P$ 通常 >> $C_R$。降低 $\lambda$ 比降低初始成本更重要。

---

## 习题 5: 可变介质电容传感器 ⭐

### 题目

> 方形金属板 5 cm × 5 cm，间隙 1 mm。介质板（$\varepsilon_r = 4$）可在板间滑动。求 $x = 0, 2.5, 5.0$ cm 时的电容。空气 $\varepsilon_r = 1$，$\varepsilon_0 = 8.85$ pF/m。

### 解答

两并联电容：$C_{total} = C_{air} + C_{dielectric}$

$$C = \frac{\varepsilon_0 w}{d}[\varepsilon_1 x + \varepsilon_2(l - x)] = \frac{\varepsilon_0 w}{d}[x + 4(l-x)] = \frac{\varepsilon_0 w}{d}[4l - 3x]$$

常数：$\frac{\varepsilon_0 w}{d} = \frac{8.85 \times 10^{-12} \times 0.05}{0.001} = 442.5$ pF/m

| $x$ (cm) | $C$ (pF) |
|----------|----------|
| 0.0 | $442.5 \times 0.2 = \boxed{88.5}$ |
| 2.5 | $442.5 \times 0.125 = \boxed{55.3}$ |
| 5.0 | $442.5 \times 0.05 = \boxed{22.1}$ |

### 🎯 技巧

$C$ 随 $x$ **线性变化**（斜率 $-3\varepsilon_0 w/d$）。先算常数系数，再代入 $x$。

---

## 习题 6: 可变磁阻传感器

### 题目

> 钢芯（$\mu_C = 100$，直径 1 cm，弯成半圆 4 cm 直径），500 匝线圈。衔铁厚 0.5 cm，$\mu_A = 100$。求气隙 $d = 1$ mm 和 3 mm 时的电感。

### 解答

$$\mathcal{R}_{TOTAL} = \mathcal{R}_{CORE} + \mathcal{R}_{ARMATURE} + \mathcal{R}_{GAP}$$

$\mathcal{R}_0 = \mathcal{R}_{CORE} + \mathcal{R}_{ARMATURE} \approx 12.73 \times 10^6$ H⁻¹

$\mathcal{R}_{GAP}(d=1\text{mm}) \approx 20.26 \times 10^6$ H⁻¹

| $d$ | $\mathcal{R}_{GAP}$ | $\mathcal{R}_{TOTAL}$ | $L = N^2/\mathcal{R}$ |
|-----|---------------------|-----------------------|------------------------|
| 1 mm | $20.26 \times 10^6$ | $32.99 \times 10^6$ | **7.58 mH** |
| 3 mm | $60.79 \times 10^6$ | $73.53 \times 10^6$ | **3.40 mH** |

> ⚠️ 气隙从 1 mm → 3 mm，电感从 7.58 → 3.40 mH（**非线性**下降）。

### 🎯 技巧

1. $\mathcal{R} = l/(\mu_0\mu A)$，$L = N^2/\mathcal{R}_{total}$。
2. **气隙主导总磁阻**：虽然只有 1 mm，但 $\mu_{air} = 1 \ll \mu_{iron} = 100$。
3. $\mathcal{R}_{GAP} \propto d$，所以气隙翻倍 → 磁阻等比例增加。

---

## 习题 7: 有源电磁转速传感器 ⭐

### 题目

> 磁阻转速发电机，22 齿齿轮。磁链 $N(\theta) = 4.0 + 1.5\cos(22\theta)$ mWb。求 1000 rpm 和 10000 rpm 时的输出信号幅值和频率。

### 解答

法拉第定律：
$$E = -\frac{dN}{dt} = -\frac{dN}{d\theta} \cdot \frac{d\theta}{dt}$$

$$E = 1.5 \times 10^{-3} \times 22 \times \sin(22\theta) \times \omega_r = 0.033\omega_r \sin(22\omega_r t)$$

**幅值**：$\hat{E} = 0.033\omega_r$ (V)
**频率**：$f = \frac{22\omega_r}{2\pi} = \frac{RPM}{60} \times 22$ (Hz)

| RPM | $\omega_r$ (rad/s) | $\hat{E}$ (V) | $f$ (Hz) |
|-----|-------------------|---------------|----------|
| 1000 | 104.7 | **3.46** | **366.7** |
| 10000 | 1047.2 | **34.56** | **3666.7** |

> ✅ 幅值和频率均**正比**于转速。10 倍转速 → 10 倍幅值 + 10 倍频率。

### 🎯 技巧

1. **$E = -dN/dt = -(dN/d\theta) \cdot \omega_r$**（链式法则）。
2. **$f = RPM \times m / 60$**（快捷公式，$m$ = 齿数）。
3. **$\hat{E} \propto \omega_r$，$f \propto \omega_r$** — 两个正比关系。

---

## 习题 8: 应力应变 — 泊松效应

### 题目

> 钢棒 $A = 10^{-3}$ m²，$E = 2 \times 10^{11}$ Pa，$\nu = 0.4$。受压力 $F = -10^5$ N（负号 = 压缩）。求纵向和横向应变。

### 解答

$$\sigma = \frac{F}{A} = \frac{-10^5}{10^{-3}} = -10^8 \text{ Pa}$$

$$\boxed{e_L = \frac{\sigma}{E} = \frac{-10^8}{2 \times 10^{11}} = -5 \times 10^{-4}}$$

$$\boxed{e_T = -\nu \cdot e_L = -0.4 \times (-5 \times 10^{-4}) = +2 \times 10^{-4}}$$

> ✅ 纵向压缩 → $e_L < 0$；泊松效应 → 横向膨胀 → $e_T > 0$。

### 🎯 技巧

1. **$\sigma = F/A$**，注意**正负号**（拉伸 +，压缩 −）。
2. **$e_L = \sigma/E$**（胡克定律）。
3. **$e_T = -\nu e_L$** — 负号是关键！压缩 → $e_T$ 变正（鼓胀）。

---

## 习题 9: 加速度计设计 — 黄金阻尼比 ⭐⭐

### 题目

> 加速度计测量旋转搅拌容器的角加速度。容器角位置正弦变化：幅值 2.5 rad，周期 2 s。地震质量 0.1 kg，臂长 5 cm。弹簧扭转刚度 $2.5 \times 10^{-2}$ N·m/rad，阻尼比 $\xi = 1/\sqrt{2}$。用次级电位计传感器测量质量块的角位置。求该传感器的输入量程。

### 解答

**系统参数**：

转动惯量 $I = mr^2 = 0.1 \times 0.05^2 = 2.5 \times 10^{-4}$ kg·m²

$$\omega_n = \sqrt{\frac{c}{I}} = \sqrt{\frac{2.5 \times 10^{-2}}{2.5 \times 10^{-4}}} = \sqrt{100} = 10 \text{ rad/s}$$

激励频率 $\omega = \frac{2\pi}{T} = \pi$ rad/s

频率比 $x = \omega/\omega_n = \pi/10 \approx 0.3142$

**黄金阻尼比简化** ($\xi = 1/\sqrt{2}$)：

$$\frac{\hat{\theta}}{\hat{\phi}_i} = \frac{x^2}{\sqrt{1 + x^4}}$$

$$x^2 \approx 0.0987, \quad x^4 \approx 0.0097$$

$$\frac{\hat{\theta}}{\hat{\phi}_i} = \frac{0.0987}{\sqrt{1.0097}} \approx \frac{0.0987}{1.0048} \approx 0.0982$$

$$\boxed{\hat{\theta} = 2.5 \times 0.0982 \approx 0.246 \text{ rad}}$$

> ✅ **传感器输入量程至少应为 $\pm 0.25$ rad**（约 ±14.1°）。

### 🎯 技巧

1. **转动系统**：$I = mr^2$，$\omega_n = \sqrt{c/I}$。
2. **$\xi = 1/\sqrt{2}$ 时的简化**：分母 $= \sqrt{(1-x^2)^2 + 2\xi^2 x^2} = \sqrt{1 + x^4}$ → 计算量大幅减少！
3. **加速度计测量的是相对位移** $\theta$（质量块相对于外壳）。

---

## 综合技巧总结

| 题型 | 核心公式 | 易错点 |
|------|---------|--------|
| **可靠性** | MTBF = 总正常时间/N_F，$\bar{\lambda} = 1/$MTBF，$A =$ MTBF/(MTBF+MDT) | 单位统一（h/yr）；总测试时间 = N × T |
| **串/并联** | 串联 $\lambda = \sum \lambda_i$；并联 $F = \prod F_i$ | 混合系统先分块 |
| **TLOC** | $C_1 + [C_R+(C_L+C_P)T_R]\lambda T$ | $C_P$ 是隐藏巨人 |
| **电容** | $C = \varepsilon_0\varepsilon A/d$，并联叠加 | 先算常数系数 |
| **磁阻** | $\mathcal{R} = l/(\mu_0\mu A)$，$L = N^2/\mathcal{R}$ | 气隙磁阻主导 |
| **有源 EM** | $E = -dN/dt$，$\hat{E} \propto \omega_r$，$f \propto \omega_r$ | 链式法则别忘了 |
| **应力应变** | $e_L = \sigma/E$，$e_T = -\nu e_L$ | 负号！压缩时 $e_T$ 为正 |
| **加速度计** | $I=mr^2$，$\omega_n=\sqrt{c/I}$，$\xi=1/\sqrt{2}$ 简化分母 | 量程 = 相对位移峰值 |
