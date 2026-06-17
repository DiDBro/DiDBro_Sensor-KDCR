# 第4讲：力旋量 (Wrenches) — 笔记

> **Source**: March_30NT.pdf (14 pages)
> **Textbook**: MLS Chapter 2, §§5.1–5.2
> **主题**: 广义力 / 力旋量、等效力旋量、力旋量的坐标变换、力旋量的螺旋坐标、Poinsot 定理

---

## §5.1 力旋量 (Wrenches)

### 定义

**广义力**表示为一个 $6 \times 1$ 向量（$\in \mathbb{R}^6$），称为**力旋量**：

$$\boxed{\mathcal{F} = \begin{bmatrix} \mathbf{f} \\ \boldsymbol{\tau} \end{bmatrix} \quad \begin{aligned} \mathbf{f} &\in \mathbb{R}^3 \quad \text{线性力分量 (linear component)} \\ \boldsymbol{\tau} &\in \mathbb{R}^3 \quad \text{旋转力 / 力矩分量 (rotational component)} \end{aligned}}$$

> 📖 **命名**：力旋量 (wrench) 是速度旋量 (twist) 的对偶概念。Twist 描述运动（线速度 + 角速度），Wrench 描述力（力 + 力矩）。

### 无穷小功 (Infinitesimal Work)

力旋量 $\mathcal{F}_b$ 作用于体坐标系 B 的原点，刚体按 $g_{ab}(t)$ 运动（A 为惯性系）。产生的无穷小功为：

$$\boxed{\delta W = {V_{ab}^b}^T \mathcal{F}_b = {\mathbf{v}_{ab}^b}^T \mathbf{f}_b + {\boldsymbol{\omega}_{ab}^b}^T \boldsymbol{\tau}_b}$$

> 📖 功 = 物体速度 $V^b$ 与力旋量 $\mathcal{F}_b$ 的内积。线速度 $\cdot$ 力 + 角速度 $\cdot$ 力矩。

### 等效力旋量

> 🔑 **定义**：两个力旋量若对**任意可能的刚体运动**产生相同的功，则称它们**等效**。

---

### 力旋量在不同施加点的等效变换

**问题设定**（MLS Figure 2.13）：
- B 系：接触坐标系原点（力施加点），也是体坐标系
- C 系：另一体坐标系
- $\mathcal{F}_b$：施加在 B 原点处的力旋量
- 目标：求施加在 C 原点处的等效力旋量 $\mathcal{F}_c$

**推导思路**：

由于 B 和 C 都固定在同一个刚体上，$\dot{g}_{bc} = \mathbf{0}$（B 和 C 之间无相对运动）。

由 (2.53) (p.54)：$V_{bc}^s = (\dot{g}_{bc}g_{bc}^{-1})^{\vee} = \mathbf{0}$

由命题 2.14 (p.59)：$V_{ac}^s = V_{ab}^s$

由 (2.55) (p.55)：$V_{bc}^b = (g_{bc}^{-1}\dot{g}_{bc})^{\vee} = \mathbf{0}$

由命题 2.15 (p.59)：$V_{ac}^b = \mathrm{Ad}_{g_{bc}^{-1}} V_{ab}^b \;\Rightarrow\; V_{ab}^b = \mathrm{Ad}_{g_{bc}} V_{ac}^b$

**功的等价性**：

$$\delta W = {V_{ac}^b}^T \mathcal{F}_c = {V_{ab}^b}^T \mathcal{F}_b = (\mathrm{Ad}_{g_{bc}} V_{ac}^b)^T \mathcal{F}_b = {V_{ac}^b}^T \mathrm{Ad}_{g_{bc}}^T \mathcal{F}_b$$

因此：

$$\boxed{\mathcal{F}_c = \mathrm{Ad}_{g_{bc}}^T \,\mathcal{F}_b} \tag{2.65}$$

---

### 展开形式

$$\boxed{\begin{bmatrix} \mathbf{f}_c \\ \boldsymbol{\tau}_c \end{bmatrix} = \begin{bmatrix} R_{bc}^T & \mathbf{0} \\ -R_{bc}^T\,\hat{p}_{bc} & R_{bc}^T \end{bmatrix} \begin{bmatrix} \mathbf{f}_b \\ \boldsymbol{\tau}_b \end{bmatrix}} \tag{2.66}$$

> 📖 **分块解读**：
> - $\mathbf{f}_c = R_{bc}^T\,\mathbf{f}_b$：力的方向随坐标系旋转
> - $\boldsymbol{\tau}_c = -R_{bc}^T\,\hat{p}_{bc}\,\mathbf{f}_b + R_{bc}^T\,\boldsymbol{\tau}_b$：力矩 = 原力矩（旋转后） + 力因作用点偏移产生的附加力矩
> - 附加项 $-\hat{p}_{bc}\mathbf{f}_b$ 是 $\mathbf{f}_b$ 对 C 原点产生的力矩：$\vec{r} \times \vec{F}$ 当 $\vec{r} = -p_{bc}$

> ⚠️ **注意负号**：$-\hat{p}_{bc}\mathbf{f}_b$（不是 $+\hat{p}_{bc}\mathbf{f}_b$），因为 $p_{bc}$ 是从 B 指向 C 的向量，而力 $\mathbf{f}_b$ 作用在 B 点，对 C 产生的力矩是 $(-p_{bc}) \times \mathbf{f}_b$。

---

### 多个力旋量的叠加

施加在刚体上的多个力旋量可通过以下步骤合成：
1. 将每个力旋量等效地变换到**同一点**
2. 将所有等效旋量向量**直接相加**

---

### 空间力旋量 vs 物体力旋量

设 $g \in SE(3)$ 描述刚体构型，$\mathcal{F}_b$ 和 $\mathcal{F}_s$ 分别为**物体力旋量**和**空间力旋量**（p.63）：

$$\boxed{\mathcal{F}_b = \mathrm{Ad}_g^T\,\mathcal{F}_s} \tag{2.67}$$

> 📖 **推导链**：$\mathcal{F}_c = \mathrm{Ad}_{g_{bc}}^T \mathcal{F}_b$ (2.65) $\Rightarrow$ $\mathcal{F}_a = \mathrm{Ad}_{g_{ba}}^T \mathcal{F}_b \;\Rightarrow\; \mathcal{F}_b = \mathrm{Ad}_{g_{ab}}^T \mathcal{F}_a$

### 速度与力旋量的对偶关系

| | 速度 | 力旋量 |
|---|------|--------|
| 空间 ↔ 物体 | $V^s = \mathrm{Ad}_g V^b$ (2.61) | $\mathcal{F}_b = \mathrm{Ad}_g^T \mathcal{F}_s$ (2.67) |
| 逆向 | $V^b = \mathrm{Ad}_g^{-1} V^s$ | $\mathcal{F}_s = \mathrm{Ad}_g^{-T} \mathcal{F}_b$ |

**功的不变性验证**：

$$\delta W = {V^b}^T \mathcal{F}_b = (\mathrm{Ad}_g^{-1} V^s)^T (\mathrm{Ad}_g^T \mathcal{F}_s) = {V^s}^T \mathrm{Ad}_g^{-T} \mathrm{Ad}_g^T \mathcal{F}_s = {V^s}^T \mathcal{F}_s$$

> ✅ **功在两个参考系中相同**！这体现了物理量对坐标选取的不变性。

---

## §5.2 力旋量的螺旋坐标 (Screw Coordinates of a Wrench)

### 由螺旋构造力旋量

设相对于空间系 A，螺旋 $S$ 有：
- 轴 $l = \{\mathbf{q} + \lambda\boldsymbol{\omega} : \lambda \in \mathbb{R}\}$，其中 $\|\boldsymbol{\omega}\| = 1$
- 螺距 $h$
- 幅值 $M$

**有限螺距** ($h$ 有限)：

$$\boxed{\mathcal{F} = M \begin{bmatrix} \boldsymbol{\omega} \\ -\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega} \end{bmatrix}} \tag{2.68}$$

**无穷螺距** ($h = \infty$，纯力矩)：

$$\mathcal{F} = M \begin{bmatrix} \mathbf{0} \\ \boldsymbol{\omega} \end{bmatrix}$$

> 📖 **物理含义**：力旋量的前三个分量是**纯力**（沿螺旋轴方向），后三个分量是力矩（包括力对原点的矩 $-\hat{\omega}\mathbf{q}M$ 和沿轴的扭矩 $h\boldsymbol{\omega}M$）。

---

### Poinsot 定理 (Theorem 2.17)

> 🔑 **任何一个施加在刚体上的力旋量集合都等效于一个沿固定轴施加的力加上一个绕该轴的力矩。**

设 $\mathcal{F} = (\mathbf{f}, \boldsymbol{\tau})$ 为施加在刚体上的**净力旋量**。

#### 情况 1：纯力矩 ($\mathbf{f} = \mathbf{0}$)

令 $M = \|\boldsymbol{\tau}\|$，$\boldsymbol{\omega} = \boldsymbol{\tau}/M$，$h = \infty$。由 (2.68) 验证。

#### 情况 2：$\mathbf{f} \neq \mathbf{0}$

令 $M = \|\mathbf{f}\|$，$\boldsymbol{\omega} = \mathbf{f}/M$。需要解：

$$M(\hat{\mathbf{q}}\boldsymbol{\omega} + h\boldsymbol{\omega}) = \boldsymbol{\tau}$$

即：

$$M(-\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega}) = \boldsymbol{\tau}$$

**解**：

$$h = \frac{\mathbf{f}^T\boldsymbol{\tau}}{\|\mathbf{f}\|^2}, \quad \mathbf{q} = \frac{\hat{\mathbf{f}}\,\boldsymbol{\tau}}{\|\mathbf{f}\|^2}$$

**验证**（代入 $M = \|\mathbf{f}\|$ 和 $\boldsymbol{\omega} = \mathbf{f}/M$）：

$$
\begin{aligned}
M\left(\frac{\widehat{(\hat{\mathbf{f}}\boldsymbol{\tau}/M^2)}\mathbf{f}}{M} + \frac{\mathbf{f}^T\boldsymbol{\tau}}{M^2}\frac{\mathbf{f}}{M}\right)
&= \widehat{(\hat{\boldsymbol{\omega}}\boldsymbol{\tau})}\,\boldsymbol{\omega} + (\boldsymbol{\omega}^T\boldsymbol{\tau})\boldsymbol{\omega}
\end{aligned}
$$

利用向量恒等式（当 $\|\boldsymbol{\omega}\| = 1$）：

$$\boxed{\widehat{(\hat{\boldsymbol{\omega}}\boldsymbol{\tau})}\,\boldsymbol{\omega} + (\boldsymbol{\omega}^T\boldsymbol{\tau})\boldsymbol{\omega} = \boldsymbol{\tau}}$$

（此恒等式在 `ident4MLS Theor2 17.pdf` 中有 MATLAB 验证。）

**证毕** ✓

---

### 力旋量的螺旋坐标

利用 Poinsot 定理，定义力旋量 $\mathcal{F} = (\mathbf{f}, \boldsymbol{\tau})$ 的螺旋坐标：

**1. 螺距 (Pitch)**：

$$\boxed{h = \frac{\mathbf{f}^T\boldsymbol{\tau}}{\|\mathbf{f}\|^2}} \tag{2.69}$$

> 📖 $h$ = 角向力与线向力矩之比。若 $\mathbf{f} = \mathbf{0}$，则 $h = \infty$。

**2. 轴 (Axis)**：

$$\boxed{l = \begin{cases}
\left\{ \dfrac{\hat{\mathbf{f}}\boldsymbol{\tau}}{\|\mathbf{f}\|^2} + \lambda\mathbf{f} : \lambda \in \mathbb{R} \right\}, & \text{if } \mathbf{f} \neq \mathbf{0} \\[12pt]
\left\{ \mathbf{0} + \lambda\boldsymbol{\tau} : \lambda \in \mathbb{R} \right\}, & \text{if } \mathbf{f} = \mathbf{0}
\end{cases}} \tag{2.70}$$

**3. 幅值 (Magnitude)**：

$$\boxed{M = \begin{cases}
\|\mathbf{f}\|, & \text{if } \mathbf{f} \neq \mathbf{0} \\
\|\boldsymbol{\tau}\|, & \text{if } \mathbf{f} = \mathbf{0}
\end{cases}} \tag{2.71}$$

> ✅ $M$ = 净线性力（若运动含线性分量），否则为净扭矩。

---

## 🔗 螺旋 vs 力旋量：完全对偶

| 属性 | 运动旋量 (Twist) $\xi$ | 力旋量 (Wrench) $\mathcal{F}$ |
|------|------------------------|-------------------------------|
| 前 3 分量 | 线速度 $\mathbf{v}$ | 力 $\mathbf{f}$ |
| 后 3 分量 | 角速度 $\boldsymbol{\omega}$ | 力矩 $\boldsymbol{\tau}$ |
| 螺距 | $h = \frac{\boldsymbol{\omega}^T\mathbf{v}}{\|\boldsymbol{\omega}\|^2}$ (2.42) | $h = \frac{\mathbf{f}^T\boldsymbol{\tau}}{\|\mathbf{f}\|^2}$ (2.69) |
| 轴 | $l = \frac{\hat{\boldsymbol{\omega}}\mathbf{v}}{\|\boldsymbol{\omega}\|^2} + \lambda\boldsymbol{\omega}$ (2.43) | $l = \frac{\hat{\mathbf{f}}\boldsymbol{\tau}}{\|\mathbf{f}\|^2} + \lambda\mathbf{f}$ (2.70) |
| 变换律 | $V^s = \mathrm{Ad}_g V^b$ | $\mathcal{F}_b = \mathrm{Ad}_g^T \mathcal{F}_s$ |
| 功 | 速度分量 | 力分量 |

> 🔑 **核心对偶**：Twist 和 Wrench 通过功 $\delta W = V^T \mathcal{F}$ 配对。它们的变换律差一个转置——速度用 $\mathrm{Ad}_g$，力旋量用 $\mathrm{Ad}_g^T$。

---

## 📊 公式速查表

| 概念 | 公式 | 编号 |
|------|------|------|
| 功 | $\delta W = {V^b}^T \mathcal{F}_b = {\mathbf{v}^b}^T \mathbf{f}_b + {\boldsymbol{\omega}^b}^T \boldsymbol{\tau}_b$ | — |
| 等效力旋量 | $\mathcal{F}_c = \mathrm{Ad}_{g_{bc}}^T \mathcal{F}_b$ | (2.65) |
| 展开式 | $\begin{bmatrix} \mathbf{f}_c \\ \boldsymbol{\tau}_c \end{bmatrix} = \begin{bmatrix} R_{bc}^T & 0 \\ -R_{bc}^T\hat{p}_{bc} & R_{bc}^T \end{bmatrix} \begin{bmatrix} \mathbf{f}_b \\ \boldsymbol{\tau}_b \end{bmatrix}$ | (2.66) |
| 空间-物体力旋量 | $\mathcal{F}_b = \mathrm{Ad}_g^T \mathcal{F}_s$ | (2.67) |
| 螺旋 → 力旋量 | $\mathcal{F} = M \begin{bmatrix} \boldsymbol{\omega} \\ -\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega} \end{bmatrix}$ | (2.68) |
| 力旋量螺距 | $h = \dfrac{\mathbf{f}^T\boldsymbol{\tau}}{\|\mathbf{f}\|^2}$ | (2.69) |
| 力旋量轴 | $l = \dfrac{\hat{\mathbf{f}}\boldsymbol{\tau}}{\|\mathbf{f}\|^2} + \lambda\mathbf{f}$ (若 $\mathbf{f} \neq \mathbf{0}$) | (2.70) |
| 力旋量幅值 | $M = \|\mathbf{f}\|$ (若 $\mathbf{f} \neq \mathbf{0}$) 否则 $M = \|\boldsymbol{\tau}\|$ | (2.71) |
| $\boldsymbol{\tau}$ 的分解 | $\boldsymbol{\tau} = M\hat{\mathbf{q}}\boldsymbol{\omega} + Mh\boldsymbol{\omega}$ | — |
| 互易积 | $V^T\mathcal{F} = M_1 M_2[(h_1+h_2)\cos\alpha - d\sin\alpha]$ | (2.72) |
| 互易积 (一般 twist) | $V_1 \circ V_2 = v_1^T\omega_2 + v_2^T\omega_1$ | — |

---

---

## 📝 补充笔记：§5 深度解析

> **Source**: `notes/on_MLS_Chapter_2_Section_5.pdf` (N.J. Theron, March 2026)
> 本节补充式 (2.65) 的完整推导链、"绕同一轴的力矩"是什么意思、命题 2.18（互易积）的证明细节。

---

### A. 式 (2.65) 推导的完整步骤

课本 p.62 的推导比较跳跃，这里把中间步骤补全。设 B 和 C 固连于同一刚体，$g_{bc}$ 为常矩阵。

1. $V_{bc}^s = (\dot{g}_{bc}g_{bc}^{-1})^{\vee} = \mathbf{0}$ （无相对运动，式 (2.53)）
2. 由命题 2.14：$V_{ac}^s = V_{ab}^s$
3. $V_{bc}^b = (g_{bc}^{-1}\dot{g}_{bc})^{\vee} = \mathbf{0}$ （式 (2.55)）
4. 由命题 2.15：$V_{ac}^b = \mathrm{Ad}_{g_{bc}^{-1}}\,V_{ab}^b \;\Rightarrow\; V_{ab}^b = \mathrm{Ad}_{g_{bc}}\,V_{ac}^b$
5. 功的等价性：

$$\boxed{{V_{ac}^b}^T \mathcal{F}_c = {V_{ab}^b}^T \mathcal{F}_b = (\mathrm{Ad}_{g_{bc}} V_{ac}^b)^T \mathcal{F}_b = {V_{ac}^b}^T \mathrm{Ad}_{g_{bc}}^T \mathcal{F}_b}$$

6. 因这对**任意** $V_{ac}^b$ 成立，故 $\mathcal{F}_c = \mathrm{Ad}_{g_{bc}}^T \mathcal{F}_b$ ✓

### B. 功的框架不变性 —— 更简洁的证明

功在空间系和物体系中相等。从 (2.61) $V^s = \mathrm{Ad}_g V^b$ 和 (2.67) $\mathcal{F}_b = \mathrm{Ad}_g^T \mathcal{F}_s$ 出发：

$$V^b = \mathrm{Ad}_g^{-1} V^s$$

$$\delta W = {V^b}^T \mathcal{F}_b = (\mathrm{Ad}_g^{-1}V^s)^T(\mathrm{Ad}_g^T\mathcal{F}_s) = {V^s}^T \underbrace{\mathrm{Ad}_g^{-T}\mathrm{Ad}_g^T}_{=I} \mathcal{F}_s = {V^s}^T \mathcal{F}_s$$

$$\boxed{\delta W = {V^b}^T \mathcal{F}_b = {V^s}^T \mathcal{F}_s}$$

> ✅ 同一物理量（功）不依赖于观察坐标系——这在后续动力学中用于在任何方便的坐标系中计算虚功。

---

### C. Poinsot 定理 Case 2 的深入理解

#### C1. "绕同一轴的力矩"到底指什么？

Poinsot 定理说"加上一个绕同一轴的力矩 (torque about the same axis)"。**不能理解为 $\boldsymbol{\tau}$ 与 $\mathbf{f}$ 同方向**。正确理解是将 $\boldsymbol{\tau}$ 分解：

$$\boxed{\boldsymbol{\tau} = \underbrace{M\,\hat{\mathbf{q}}\,\boldsymbol{\omega}}_{\text{垂直于 } \mathbf{f}} + \underbrace{Mh\,\boldsymbol{\omega}}_{\text{平行于 } \mathbf{f}}}$$

- **分量 ①** $Mh\boldsymbol{\omega}$：沿 $\mathbf{f}$ 方向的力矩分量。由于 $M = \|\mathbf{f}\|$ 及 $h = \mathbf{f}^T\boldsymbol{\tau}/\|\mathbf{f}\|^2$，标量 $Mh = \boldsymbol{\omega}^T\boldsymbol{\tau}$ 正是 $\boldsymbol{\tau}$ 在单位向量 $\boldsymbol{\omega} = \mathbf{f}/M$ 上的投影。

- **分量 ②** $M\hat{\mathbf{q}}\boldsymbol{\omega}$：**垂直于** $\mathbf{f}$ 的分量。可以通过点积验证：

  $$\boldsymbol{\omega}^T M\hat{\mathbf{q}}\boldsymbol{\omega} = -M\boldsymbol{\omega}^T\hat{\boldsymbol{\omega}}\mathbf{q} = M\boldsymbol{\omega}^T\hat{\boldsymbol{\omega}}^T\mathbf{q} = M(\hat{\boldsymbol{\omega}}\boldsymbol{\omega})^T\mathbf{q} = 0$$

  这是因为 $\hat{\boldsymbol{\omega}}\boldsymbol{\omega} = \boldsymbol{\omega} \times \boldsymbol{\omega} = \mathbf{0}$。

> 📖 **物理图像**：力 $\mathbf{f} = M\boldsymbol{\omega}$ 作用在螺旋轴上，对原点产生的矩 = $\mathbf{q} \times \mathbf{f} = -M\hat{\boldsymbol{\omega}}\mathbf{q}$（垂直于 $\boldsymbol{\omega}$），再加上沿轴方向的纯扭矩 $Mh\boldsymbol{\omega}$。

#### C2. 证明 $h$ 和 $\mathbf{q}$ 确实是解

将 $h = \frac{\mathbf{f}^T\boldsymbol{\tau}}{\|\mathbf{f}\|^2}$ 和 $\mathbf{q} = \frac{\hat{\mathbf{f}}\boldsymbol{\tau}}{\|\mathbf{f}\|^2}$ 代入 $M(-\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega})$，注意 $M = \|\mathbf{f}\|$ 和 $\boldsymbol{\omega} = \mathbf{f}/M$：

$$
\begin{aligned}
M(-\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega})
&= M\left(-\hat{\boldsymbol{\omega}}\frac{\hat{\mathbf{f}}\boldsymbol{\tau}}{M^2} + \frac{\mathbf{f}^T\boldsymbol{\tau}}{M^2}\frac{\mathbf{f}}{M}\right) \\
&= \widehat{\left(\frac{\hat{\mathbf{f}}\boldsymbol{\tau}}{M}\right)}\frac{\mathbf{f}}{M} + \frac{\mathbf{f}^T\boldsymbol{\tau}}{M^2}\mathbf{f} \\
&= \widehat{(\hat{\boldsymbol{\omega}}\boldsymbol{\tau})}\,\boldsymbol{\omega} + (\boldsymbol{\omega}^T\boldsymbol{\tau})\boldsymbol{\omega} \\
&= \boldsymbol{\tau} \quad \text{(当 } \|\boldsymbol{\omega}\| = 1 \text{)}
\end{aligned}
$$

最后一步用了恒等式 $(\hat{\boldsymbol{\omega}}\boldsymbol{\tau}) \times \boldsymbol{\omega} + (\boldsymbol{\omega}\cdot\boldsymbol{\tau})\boldsymbol{\omega} = \boldsymbol{\tau}$（已在螺旋理论中证明，见 March_16 讲义及 `ident4MLS Theor2 17.pdf`）。

---

### D. 命题 2.18 的互易积证明（详析）

MLS p.66–67 的命题 2.18 证明了两个螺旋之间的**互易积 (reciprocal product)** 的显式公式。课本的证明较含糊，Theron 重构如下。

#### D1. 设定

两个旋量用螺旋参数写出（注意这里 $\boldsymbol{\omega}_1, \boldsymbol{\omega}_2$ **都是单位向量**——这是关键前提）：

$$\boxed{V = M_1 \begin{bmatrix} \hat{\mathbf{q}}_1\boldsymbol{\omega}_1 + h_1\boldsymbol{\omega}_1 \\ \boldsymbol{\omega}_1 \end{bmatrix}, \quad \mathcal{F} = M_2 \begin{bmatrix} \boldsymbol{\omega}_2 \\ \hat{\mathbf{q}}_2\boldsymbol{\omega}_2 + h_2\boldsymbol{\omega}_2 \end{bmatrix}}$$

（注意：$V$ 是 twist 螺旋，$\mathcal{F}$ 是 wrench 螺旋。两者在结构上的对偶——$V$ 的上块有 $\hat{\mathbf{q}}_1\boldsymbol{\omega}_1$，$\mathcal{F}$ 的下块有 $\hat{\mathbf{q}}_2\boldsymbol{\omega}_2$。）

两个螺旋轴的几何关系（MLS Fig 2.14）：最短距离 $d$ 沿公共法线 $\mathbf{n}$，夹角 $\alpha$。

#### D2. 互易积的计算

$$\begin{aligned}
V^T \mathcal{F}
&= M_1 M_2 \left[ \boldsymbol{\omega}_2^T(\hat{\mathbf{q}}_1\boldsymbol{\omega}_1 + h_1\boldsymbol{\omega}_1) + \boldsymbol{\omega}_1^T(\hat{\mathbf{q}}_2\boldsymbol{\omega}_2 + h_2\boldsymbol{\omega}_2) \right] \\
&= M_1 M_2 \left[ \boldsymbol{\omega}_2^T(\hat{\mathbf{q}}_1\boldsymbol{\omega}_1) + h_1\boldsymbol{\omega}_1^T\boldsymbol{\omega}_2 + \boldsymbol{\omega}_1^T(\hat{\mathbf{q}}_2\boldsymbol{\omega}_2) + h_2\boldsymbol{\omega}_1^T\boldsymbol{\omega}_2 \right]
\end{aligned}$$

#### D3. 两个关键向量恒等式

**恒等式 ①**（轴的几何，Theron 手写证明，见 `dot_cross_ident2.pdf`）：

$$\boxed{\boldsymbol{\omega}_2^T(\hat{\mathbf{q}}_1\boldsymbol{\omega}_1) + \boldsymbol{\omega}_1^T(\hat{\mathbf{q}}_1\boldsymbol{\omega}_2) = 0}$$

即 $\vec{\omega}_2 \cdot (\vec{q}_1 \times \vec{\omega}_1) + \vec{\omega}_1 \cdot (\vec{q}_1 \times \vec{\omega}_2) = 0$，源于标量三重积的性质。

**恒等式 ②**（螺旋轴间距与夹角）：

$$\boxed{\boldsymbol{\omega}_1^T(\hat{\mathbf{n}}\,\boldsymbol{\omega}_2) = -\sin\alpha}$$

其中 $\mathbf{n}$ 是从轴 1 指向轴 2 的单位公法线向量。注意 $\mathbf{q}_2 = \mathbf{q}_1 + d\mathbf{n}$。

#### D4. 代入与化简

利用 $\mathbf{q}_2 = \mathbf{q}_1 + d\mathbf{n}$ 展开 $\boldsymbol{\omega}_1^T(\hat{\mathbf{q}}_2\boldsymbol{\omega}_2)$：

$$\boldsymbol{\omega}_1^T(\hat{\mathbf{q}}_2\boldsymbol{\omega}_2) = \boldsymbol{\omega}_1^T((\hat{\mathbf{q}}_1 + d\hat{\mathbf{n}})\boldsymbol{\omega}_2) = \boldsymbol{\omega}_1^T(\hat{\mathbf{q}}_1\boldsymbol{\omega}_2) + d\,\boldsymbol{\omega}_1^T(\hat{\mathbf{n}}\boldsymbol{\omega}_2)$$

代入互易积表达式：

$$\begin{aligned}
V^T \mathcal{F}
&= M_1 M_2 \Big[ (h_1+h_2)\cos\alpha + \underbrace{\boldsymbol{\omega}_2^T(\hat{\mathbf{q}}_1\boldsymbol{\omega}_1) + \boldsymbol{\omega}_1^T(\hat{\mathbf{q}}_1\boldsymbol{\omega}_2)}_{\text{恒等式① = 0}} + d\,\underbrace{\boldsymbol{\omega}_1^T(\hat{\mathbf{n}}\boldsymbol{\omega}_2)}_{\text{恒等式② = } -\sin\alpha} \Big] \\
&= M_1 M_2 \left[ (h_1+h_2)\cos\alpha - d\sin\alpha \right]
\end{aligned}$$

即得 MLS 的最终公式 (2.72)。

#### D5. $\boldsymbol{\omega}_1, \boldsymbol{\omega}_2$ 必须是单位向量吗？

**是的**，在命题 2.18 的证明中 $\boldsymbol{\omega}_1$ 和 $\boldsymbol{\omega}_2$ 都必须是**单位向量**。原因：

- $\boldsymbol{\omega}_2$（wrench 的旋转部分）在 Poinsot 定理 (2.68) 中被明确定义为 $\mathbf{f}/\|\mathbf{f}\|$，即单位向量
- $\boldsymbol{\omega}_1$ 是 twist 螺旋参数化中的方向轴——虽然一般 twist 的 $\boldsymbol{\omega}$ 可以不是单位向量（通过缩放 $\theta$），但在此证明中使用的是归一化后的螺旋轴，因此 $\|\boldsymbol{\omega}_1\| = 1$

> ⚠️ **重要**：p.67 底部无编号式子 $V_1 \circ V_2 = v_1^T\omega_2 + v_2^T\omega_1$ 中的 $\omega_1, \omega_2$ 是**一般 twist 坐标中的角速度分量**（不必是单位向量），**与命题 2.18 证明中的螺旋参数 $\boldsymbol{\omega}_1, \boldsymbol{\omega}_2$ 不是同一概念**！这是 MLS 中符号重用造成的混淆。

#### D6. 无编号式子的统一形式

$$\boxed{V_1 \circ V_2 = v_1^T \boldsymbol{\omega}_2 + v_2^T \boldsymbol{\omega}_1}$$

若 twist 参数化使得 $\|\boldsymbol{\omega}_i\| = 1$（单位旋量），则此式与 (2.72) 一致（只是表达式形式不同）。两种理解等价，但 $\|\boldsymbol{\omega}_i\| = 1$ 是使公式简洁的前提。

---

### E. MLS 文本勘误

**定义 2.3 后第一段** (p.66)：MLS 在描述螺旋 $S_i$ 时使用参数 $\lambda \in \mathbb{R}^1$，但不同螺旋的 $\lambda$ 值并非相同变量。**应写作** $\lambda_i$，即：

> "...screw with axis $l_i = \{ \mathbf{q}_i + \lambda_i \boldsymbol{\omega}_i : \lambda_i \in \mathbb{R}^1 \}$..."

**$\alpha$ 的更简洁表达** (p.66)：由于 $\|\boldsymbol{\omega}_1\| = \|\boldsymbol{\omega}_2\| = 1$（本节中），夹角 $\alpha$ 可直接从叉积和点积获取：

$$\boxed{\sin\alpha = [\hat{\boldsymbol{\omega}}_1\boldsymbol{\omega}_2]^T \mathbf{n}, \quad \cos\alpha = \boldsymbol{\omega}_1^T\boldsymbol{\omega}_2}$$

从而用 `atan2` 表达 $\alpha = \mathrm{atan2}\left([\hat{\omega}_1\omega_2]^T n,\; \omega_1^T\omega_2\right)$。

---

## 🔑 关键要点

1. **力旋量是速度旋量的对偶**：功 $\delta W = V^T \mathcal{F}$ 将它们配对。
2. **变换律差一个转置**：$V^s = \mathrm{Ad}_g V^b$，但 $\mathcal{F}_b = \mathrm{Ad}_g^T \mathcal{F}_s$。这个转置保证了功在不同坐标系中的不变性。
3. **力作用点平移产生附加力矩**：$\boldsymbol{\tau}_c = \boldsymbol{\tau}_b - \hat{p}_{bc}\mathbf{f}_b$（经旋转后）。
4. **Poinsot 定理 = 力旋量的 Chasles 定理**：任何力旋量系统都等效于一个螺旋力（沿轴的力 + 绕轴的力矩）。
5. **螺旋描述的统一性**：Twist 和 Wrench 共享完全相同的螺旋几何结构（轴、螺距、幅值），只是物理含义不同。
6. **"绕同一轴的力矩"有歧义**：Poinsot 定理说 $\boldsymbol{\tau}$ 含沿 $\mathbf{f}$ 方向的分量 $Mh\boldsymbol{\omega}$ 和垂直于 $\mathbf{f}$ 的分量 $M\hat{\mathbf{q}}\boldsymbol{\omega}$——并非 $\boldsymbol{\tau} \parallel \mathbf{f}$。
7. **互易积的几何含义**：$V^T\mathcal{F} = M_1 M_2[(h_1+h_2)\cos\alpha - d\sin\alpha]$——两个螺旋之间的"虚功"由螺距之和、轴间距、轴夹角共同决定。
8. **命题 2.18 中 $\boldsymbol{\omega}_1, \boldsymbol{\omega}_2$ 是单位向量**：这与 p.67 底无编号式子中一般 twist 的角速度向量概念不同，注意区分。
