# 第0讲：课程引言与旋转运动基础 — 笔记

> **Source**: March_2NT.pdf (28 pages)
> **Textbook**: MLS Chapter 2, §§1–2.2
> **主题**: 运动学/动力学/控制概览、刚体变换、旋转矩阵与 SO(3)、Rodrigues 公式

---

## 课程概述

机器人学核心三部分：

| 领域 | 定义 | 在本课程中的位置 |
|------|------|------------------|
| **运动学 (Kinematics)** | 研究运动的几何学，不涉及力或 Newton 定律 | 前几周重点 |
| **动力学 (Dynamics)** | 研究运动 + Newton 定律（= Kinetics） | 学期中段 |
| **控制 (Control)** | 驱动机器人按期望方式运动 | 学期末段 |

---

## §1 刚体变换的基本概念

（MLS Chapter 2 §1, p.20）

### 质点 vs 刚体

- **质点**的轨迹：曲线 $\mathbf{p}(t) = (x(t), y(t), z(t)) \in \mathbb{R}^3$
- **刚体**（机器人学的研究对象）：任意两点间距离保持不变

$$\boxed{\|\mathbf{p}(t) - \mathbf{q}(t)\| = \|\mathbf{p}(0) - \mathbf{q}(0)\| = \text{constant}}$$

> ✅ **核心含义**：刚体不会变形。任意时刻，其上任意两点间的距离等于初始时刻的距离。

### 刚体位移

刚体的一般位移由两部分组成：

$$\text{刚体位移} = \text{平移 (translation)} + \text{旋转 (rotation)}$$

### 刚体运动的数学描述

设 $O \subset \mathbb{R}^3$ 定义一个物体。刚体运动定义为映射族：

$$g(t) : O \rightarrow \mathbb{R}^3$$

（MLS 最后一段 p.20）

### 跟踪刚体运动的方法

要完整描述刚体运动，需要同时跟踪：

1. **一个质点的运动**（3 个自由度：位置）
2. **刚体绕该质点的旋转**（3 个自由度：姿态）

→ 总计 **6 个自由度**。

### 点与向量的区别

> ⚠️ MLS 区分**点 (point)** 和**向量 (vector)**（p.21 顶部）。点有位置，向量只有方向和大小。这在后续齐次坐标中有重要体现。

---

## 旋转可以视为向量吗？

### 有限旋转的不可交换性

通过一个经典实验：对一个方块依次施加三次 $90^\circ$ 旋转。

**情况 1**：绕 x → 绕 y → 绕 z

```
初始姿态 → Rx(90°) → Ry(90°) → Rz(90°) → 最终姿态 A
```

**情况 2**：**交换第一次和第二次旋转的顺序**

```
初始姿态 → Rz(90°) → Ry(90°) → Rx(90°) → 最终姿态 B ≠ 最终姿态 A
```

### 结论

> 🔑 **有限旋转不是向量！** 三次有限旋转的结果取决于旋转的施加顺序（旋转不满足交换律）。

> ✅ **但是**：角速度（无穷小旋转）**是**向量。无穷小旋转是可交换的（到一阶），这是旋量理论的基础。

---

## §2 三维空间中的旋转运动

（MLS Chapter 2 §2, p.22）

### 坐标系设定

- **惯性系 (Inertial Frame) A**：固定不动的参考坐标系
- **体坐标系 (Body Frame) B**：固连在刚体上的坐标系

### 旋转矩阵

体坐标系 B 的三个坐标轴在惯性系 A 中的方向向量：

$$\mathbf{x}_{ab}, \mathbf{y}_{ab}, \mathbf{z}_{ab} \in \mathbb{R}^3$$

将它们作为列向量排成 $3 \times 3$ 矩阵，即得**旋转矩阵**：

$$\boxed{R_{ab} = \begin{bmatrix} \mathbf{x}_{ab} & \mathbf{y}_{ab} & \mathbf{z}_{ab} \end{bmatrix}}$$

> 📖 **含义**：$R_{ab}$ 的每一列是 B 系的一个坐标轴在 A 系中的分量表示。

---

## §2.1 旋转矩阵的性质

### 正交性

记 $R$ 的列为 $\mathbf{r}_1, \mathbf{r}_2, \mathbf{r}_3 \in \mathbb{R}^3$，则：

$$\mathbf{r}_i^T \mathbf{r}_j = \begin{cases} 0, & i \neq j \\ 1, & i = j \end{cases}$$

各列相互正交且为单位向量。矩阵形式：

$$\boxed{R^T R = I} \tag{2.1}$$

由此推出：

$$R^T = R^{-1}, \quad R R^T = I$$

### 行列式

一般地 $|R| = \pm 1$。

用列向量表示行列式（比 MLS p.23 更好的写法）：

$$|R| = \mathbf{r}_1^T (\hat{\mathbf{r}}_2 \mathbf{r}_3)$$

若体坐标系为**右手系**，则 $\hat{\mathbf{r}}_2 \mathbf{r}_3 = \mathbf{r}_2 \times \mathbf{r}_3 = \mathbf{r}_1$，因此：

$$|R| = \mathbf{r}_1^T \mathbf{r}_1 = +1$$

> ⚠️ 若 $|R| = -1$，则矩阵包含反射（将右手系变为左手系），**不是纯粹的旋转**。

---

### 特殊正交群 SO(3)

$$\boxed{SO(n) = \left\{ R \in \mathbb{R}^{n \times n} : R R^T = I,\; |R| = +1 \right\}} \tag{2.2}$$

- **SO** = Special Orthogonal（特殊正交）
- 本课程主要关注 $SO(3)$ 和 $SO(2)$
- $SO(3)$ 在矩阵乘法下构成**群**（MLS p.24 有证明）
- 旋转矩阵的乘积仍是旋转矩阵

### 构型空间

- 刚体相对于 A 系的每一种姿态都对应于 $SO(3)$ 中唯一的 $R$
- $SO(3)$ 是系统的**构型空间 (configuration space)**
- 系统的轨迹是 $SO(3)$ 中的一条曲线 $R(t) \in SO(3),\; t \in [0, T]$

---

### 叉乘的矩阵形式：Hat 算子

> 📖 MLS 在稍后章节 (2.4)-(2.5) 引入此记号，讲义在此提前介绍。

叉乘 $\vec{c} = \vec{a} \times \vec{b}$ 在计算机上计算时，可将向量表示为 $3\times 1$ 列向量，用矩阵乘法实现：

$$\boxed{\mathbf{c} = \hat{\mathbf{a}}\,\mathbf{b}, \quad \hat{\mathbf{a}} = \begin{bmatrix} 0 & -a_3 & a_2 \\ a_3 & 0 & -a_1 \\ -a_2 & a_1 & 0 \end{bmatrix}}$$

即：

$$\begin{bmatrix} c_1 \\ c_2 \\ c_3 \end{bmatrix} = \begin{bmatrix} 0 & -a_3 & a_2 \\ a_3 & 0 & -a_1 \\ -a_2 & a_1 & 0 \end{bmatrix} \begin{bmatrix} b_1 \\ b_2 \\ b_3 \end{bmatrix}$$

> ⚠️ **书写规范**：正确的写法是 $\mathbf{c} = \hat{\mathbf{a}}\mathbf{b}$，而不是 $\mathbf{c} = \mathbf{a} \times \mathbf{b}$（后者被视为不严谨）。MLS 有时会混用，但我们应该尽量使用 hat 记号。

---

### 旋转矩阵作为坐标变换

设点 $q$：
- 在 B 系中的坐标为 $(x_b, y_b, z_b)$，写为列向量 $\mathbf{q}_b = [x_b \; y_b \; z_b]^T$
- 在 A 系中的坐标为列向量 $\mathbf{q}_a$

由于 $R_{ab} = [\mathbf{x}_{ab} \; \mathbf{y}_{ab} \; \mathbf{z}_{ab}]$：

$$\mathbf{q}_a = x_b \mathbf{x}_{ab} + y_b \mathbf{y}_{ab} + z_b \mathbf{z}_{ab} = R_{ab}\,\mathbf{q}_b$$

> ✅ **物理解释**：$x_b \mathbf{x}_{ab}$ 是 B 系的 x 分量在 A 系中的表示（方向 = $\mathbf{x}_{ab}$，大小 = $x_b$），三项相加即得到 B 系中向量在 A 系中的完整表示。

### 基底变换 (Change of Basis) — 补充笔记

> 📖 **Source**: `notes/on_change_of_basis.pdf` (N.J. Theron, March 2026)
> 澄清 $R_{ab}$ 的双重角色：旋转算子 vs 坐标变换。

#### $R_{ab}$ 的两种用法

这是 MLS 没有明说但极易混淆的地方。旋转矩阵 $R_{ab}$ 扮演着两种不同的角色：

| 角色 | 公式 | 含义 |
|------|------|------|
| **① 旋转算子** | $\mathbf{q}_a = R_{ab}\,\mathbf{h}_a$ | 将**一个点** $\mathbf{h}$ 绕某轴旋转，得到**另一个新点** $\mathbf{q}$。两点坐标均在 A 系。 |
| **② 坐标变换** | $\mathbf{q}_a = R_{ab}\,\mathbf{q}_b$ | **同一个点** $\mathbf{q}$ 在 A 系和 B 系中的坐标之间的转换。 |

> ⚠️ **关键区分**：① 是"点变了"（两个不同的点），② 是"视角变了"（同一个点，两个坐标系）。

#### 一阶张量（点 / 向量）的基底变换

考虑两个坐标系 A 和 B，B 系由 A 系通过旋转 $R_{ab}$ 得到。

若对 A 系中坐标为 $\mathbf{h}_a$ 的点施加**与产生 B 系完全相同的旋转**，得到新点 $\mathbf{q}$：

$$\mathbf{q}_a = R_{ab}\,\mathbf{h}_a \tag{1}$$

由于这个旋转与产生 B 系的旋转相同，新点 $\mathbf{q}$ **在 B 系中的坐标等于原点 $\mathbf{h}$ 在 A 系中的坐标**。因此：

$$\boxed{\mathbf{q}_b = \mathbf{h}_a = R_{ab}^T\,\mathbf{q}_a} \tag{2}$$

$$\boxed{\mathbf{q}_a = R_{ab}\,\mathbf{q}_b} \tag{3}$$

方程 (2) 和 (3) 称为**一阶张量的标准正交基底变换方程**。它们与 MLS p.25 的变换方程在形式和含义上完全一致。

> ✅ **命名**："基底变换" (change of basis)，因为它描述了**同一个点/向量**在两个不同标准正交基（坐标系）下分量的关系。

#### 二阶张量的基底变换

考虑两个向量 $\vec{v}$ 和 $\vec{w}$，在 B 系中的分量分别为 $\mathbf{v}_b$ 和 $\mathbf{w}_b$。其**外积 (outer product)** 构成一个二阶张量（在 B 系分量中）：

$$\mathbf{H}_b = \mathbf{w}_b \mathbf{v}_b^T = \begin{bmatrix} w_{b1}v_{b1} & w_{b1}v_{b2} & w_{b1}v_{b3} \\ w_{b2}v_{b1} & w_{b2}v_{b2} & w_{b2}v_{b3} \\ w_{b3}v_{b1} & w_{b3}v_{b2} & w_{b3}v_{b3} \end{bmatrix} \tag{5}$$

利用一阶张量的基底变换式 (3)：$\mathbf{v}_a = R_{ab}\mathbf{v}_b$，$\mathbf{w}_a = R_{ab}\mathbf{w}_b$：

$$\mathbf{H}_b = \mathbf{w}_b \mathbf{v}_b^T = (R_{ab}^T\mathbf{w}_a)(\mathbf{v}_a^T R_{ab}) = R_{ab}^T\,\mathbf{H}_a\,R_{ab}$$

其中 $\mathbf{H}_a = \mathbf{w}_a\mathbf{v}_a^T$ 是**同一**二阶张量在 A 系分量中的表示。

由此得二阶张量的基底变换方程：

$$\boxed{\mathbf{H}_a = R_{ab}\,\mathbf{H}_b\,R_{ab}^T} \tag{7}$$

$$\boxed{\mathbf{H}_b = R_{ab}^T\,\mathbf{H}_a\,R_{ab}} \tag{8}$$

> 🔑 **关键联系**：这与 **Lemma 2.1 (2.7)** 完全相同——$R\,\hat{\mathbf{w}}\,R^T = \widehat{R\mathbf{w}}$，叉乘矩阵 $\hat{\mathbf{w}}$ 作为一个二阶张量按 (7) 进行基底变换。
>
> **惯性矩阵** $\mathcal{I}$ 也是二阶张量，它的坐标系变换规律同样是 $\mathcal{I}_a = R_{ab}\,\mathcal{I}_b\,R_{ab}^T$，这在后续动力学中非常重要。

#### 一阶 vs 二阶变换速查

| 张量阶数 | 例 | A → B | B → A |
|----------|-----|--------|--------|
| 一阶 | 向量 $\mathbf{v}$ | $\mathbf{v}_b = R_{ab}^T\mathbf{v}_a$ | $\mathbf{v}_a = R_{ab}\mathbf{v}_b$ |
| 二阶 | 惯性 $\mathcal{I}$ | $\mathcal{I}_b = R_{ab}^T\,\mathcal{I}_a\,R_{ab}$ | $\mathcal{I}_a = R_{ab}\,\mathcal{I}_b\,R_{ab}^T$ |

---

### 旋转的复合规则

若 C 系相对于 B 系的姿态为 $R_{bc}$，B 系相对于 A 系的姿态为 $R_{ab}$，则 C 系相对于 A 系的姿态为：

$$\boxed{R_{ac} = R_{ab}\,R_{bc}} \tag{2.3}$$

**前提**：$R_{ab}$ 的分量在 A 系中表示，$R_{bc}$ 的分量在 B 系中表示。

---

### Lemma 2.1：旋转与叉乘的关系

（MLS p.26）

给定 $R \in SO(3)$ 和 $\mathbf{v}, \mathbf{w} \in \mathbb{R}^3$：

$$\boxed{R(\hat{\mathbf{v}}\mathbf{w}) = \widehat{(R\mathbf{v})}\,R\mathbf{w}} \tag{2.6}$$

$$\boxed{R\,\hat{\mathbf{w}}\,R^T = \widehat{R\mathbf{w}}} \tag{2.7}$$

> 📖 **含义** (2.6)：先叉乘再旋转 = 先旋转两个向量再叉乘。旋转保持叉乘结构。
>
> 📖 **含义** (2.7)：对叉乘矩阵做相似变换 = 先旋转向量再做叉乘。这是伴随变换在 $SO(3)$ 中的雏形。

（另见命题 2.2, p.26）

---

## §2.2 旋转的指数坐标

（MLS p.27）

### 问题设定

- $\boldsymbol{\omega} \in \mathbb{R}^3$，$\|\boldsymbol{\omega}\| = 1$：旋转轴方向
- $\theta \in \mathbb{R}$：旋转角度（弧度）
- 目标：用 $\boldsymbol{\omega}$ 和 $\theta$ 表示旋转矩阵 $R$

### 旋转的运动学方程

考虑刚体以**单位角速度**绕轴 $\boldsymbol{\omega}$ 旋转。附着于刚体上一点 $\mathbf{q}$ 的速度：

$$\boxed{\dot{\mathbf{q}} = \hat{\boldsymbol{\omega}}\,\mathbf{q}} \tag{2.8}$$

> 📖 **物理直觉**：$\dot{\mathbf{q}} = \boldsymbol{\omega} \times \mathbf{q}$，刚体上任意点的线速度 = 角速度向量叉乘该点的位置向量。

### 指数映射

ODE $\dot{\mathbf{q}} = \hat{\boldsymbol{\omega}}\,\mathbf{q}$ 是线性时不变系统，其解为（参考状态空间控制理论）：

$$\mathbf{q}(t) = e^{\hat{\boldsymbol{\omega}}t}\,\mathbf{q}(0)$$

其中 $\mathbf{q}(0)$ 是点的初始位置，$e^{\hat{\boldsymbol{\omega}}t}$ 是矩阵 $\hat{\boldsymbol{\omega}}t$ 的**矩阵指数**：

$$e^{\hat{\boldsymbol{\omega}}t} = I + \hat{\boldsymbol{\omega}}t + \frac{(\hat{\boldsymbol{\omega}}t)^2}{2!} + \frac{(\hat{\boldsymbol{\omega}}t)^3}{3!} + \cdots$$

当 $\|\boldsymbol{\omega}\| = 1$ 且旋转时间为 $\theta$ 单位时间：

$$\boxed{R(\boldsymbol{\omega}, \theta) = e^{\hat{\boldsymbol{\omega}}\theta}} \tag{2.9}$$

---

### Rodrigues 公式

$e^{\hat{\boldsymbol{\omega}}\theta}$ 直接数值计算很困难（无穷级数），MLS 利用 **Lemma 2.3**（可用 Sympy 或 MATLAB Symbolics 验证）推导出闭合形式。

**Lemma 2.3**：对于 $\|\boldsymbol{\omega}\| = 1$，
$$\hat{\boldsymbol{\omega}}^2 = \boldsymbol{\omega}\boldsymbol{\omega}^T - I, \quad \hat{\boldsymbol{\omega}}^3 = -\hat{\boldsymbol{\omega}}$$

利用此引理化简矩阵指数的无穷级数，得 **Rodrigues 公式**：

$$\boxed{e^{\hat{\boldsymbol{\omega}}\theta} = I + \hat{\boldsymbol{\omega}}\sin\theta + \hat{\boldsymbol{\omega}}^2(1 - \cos\theta)} \tag{2.14}$$

> ✅ **实用价值**：只需计算 $\sin\theta$ 和 $\cos\theta$，无需截断无穷级数。这是在 MATLAB 中实现旋转计算的基础。

---

### 两个核心命题

**命题 2.4** (p.28)：所有单位反对称矩阵的指数都是正交矩阵，因而是旋转矩阵。即：$e^{\hat{\boldsymbol{\omega}}\theta} \in SO(3)$ 对任意 $\|\boldsymbol{\omega}\|=1, \theta\in\mathbb{R}$ 成立。

**命题 2.5** (p.29)：给定 $R \in SO(3)$，存在 $\boldsymbol{\omega} \in \mathbb{R}^3$（$\|\boldsymbol{\omega}\| = 1$）和 $\theta \in \mathbb{R}$，使得 $R = e^{\hat{\boldsymbol{\omega}}\theta}$。

> 🔑 这两个命题合在一起，建立了 **SO(3) ↔ 指数坐标 $(\boldsymbol{\omega}, \theta)$ 之间的双射关系**（模 $2\pi$ 等价）。

---

### 从旋转矩阵提取轴和角（命题 2.5 的构造性部分）

$$\boxed{\theta = \cos^{-1}\left(\frac{\text{trace}(R) - 1}{2}\right)} \tag{2.17}$$

若 $\theta \neq 0$（即 $R \neq I$）：

$$\boxed{\boldsymbol{\omega} = \frac{1}{2\sin\theta} \begin{bmatrix} r_{32} - r_{23} \\ r_{13} - r_{31} \\ r_{21} - r_{12} \end{bmatrix}} \tag{2.18}$$

> 📖 **MATLAB 实现**：`rotm2axang` 函数。

---

### Euler 定理

**定理 2.6 (Euler)**：

> 🔑 **任何姿态 $R \in SO(3)$ 都等效于绕某个固定轴 $\boldsymbol{\omega} \in \mathbb{R}^3$ 旋转某个角度 $\theta \in [0, 2\pi)$。**

这是命题 2.5 的直接推论，也是 Chasles 定理（下一讲）在纯旋转情况下的特例。

---

## 📊 公式速查表

| 概念 | 公式 | 编号 |
|------|------|------|
| SO(n) 定义 | $SO(n) = \{R \in \mathbb{R}^{n\times n} : RR^T=I, \|R\|=+1\}$ | (2.2) |
| Hat 算子 | $\hat{\mathbf{a}} = \begin{bmatrix} 0 & -a_3 & a_2 \\ a_3 & 0 & -a_1 \\ -a_2 & a_1 & 0 \end{bmatrix}$ | (2.4)/(2.5) |
| 坐标变换 | $\mathbf{q}_a = R_{ab}\,\mathbf{q}_b$ | — |
| 一阶基底变换 | $\mathbf{q}_b = R_{ab}^T\,\mathbf{q}_a$ | (2) |
| 二阶基底变换 | $\mathbf{H}_a = R_{ab}\,\mathbf{H}_b\,R_{ab}^T$ | (7) |
| 旋转复合 | $R_{ac} = R_{ab}\,R_{bc}$ | (2.3) |
| 旋转与叉乘 | $R(\hat{\mathbf{v}}\mathbf{w}) = \widehat{(R\mathbf{v})}R\mathbf{w}$ | (2.6) |
| 叉乘的相似变换 | $R\,\hat{\mathbf{w}}\,R^T = \widehat{R\mathbf{w}}$ | (2.7) |
| 旋转运动学 ODE | $\dot{\mathbf{q}} = \hat{\boldsymbol{\omega}}\,\mathbf{q}$ | (2.8) |
| 指数映射 | $R(\boldsymbol{\omega}, \theta) = e^{\hat{\boldsymbol{\omega}}\theta}$ | (2.9) |
| Rodrigues 公式 | $e^{\hat{\boldsymbol{\omega}}\theta} = I + \hat{\boldsymbol{\omega}}\sin\theta + \hat{\boldsymbol{\omega}}^2(1-\cos\theta)$ | (2.14) |
| 提取旋转角 | $\theta = \cos^{-1}((\text{tr}(R)-1)/2)$ | (2.17) |
| 提取旋转轴 | $\boldsymbol{\omega} = \frac{1}{2\sin\theta}[r_{32}-r_{23},\; r_{13}-r_{31},\; r_{21}-r_{12}]^T$ | (2.18) |
| Lemma 2.3 | $\hat{\boldsymbol{\omega}}^2 = \boldsymbol{\omega}\boldsymbol{\omega}^T - I,\; \hat{\boldsymbol{\omega}}^3 = -\hat{\boldsymbol{\omega}}$ (当 $\|\boldsymbol{\omega}\|=1$) | — |

---

## 🔑 关键要点

1. **有限旋转不是向量**：旋转顺序不同导致不同结果。但角速度（无穷小旋转）是向量。
2. **旋转矩阵 $R \in SO(3)$ 具有双重角色**：既是**旋转算子**（将点旋转为新点），又是**坐标变换**（同一向量在不同基底下的表示）。这是初学者最易混淆之处。
3. **$SO(3)$ 是构型空间**：轨迹 $R(t) \in SO(3)$ 描述刚体姿态随时间的演化。
4. **Hat 算子将叉乘变为矩阵乘法**：$\mathbf{a} \times \mathbf{b} = \hat{\mathbf{a}}\mathbf{b}$，这是计算机实现和理论推导的关键工具。
5. **二阶张量（如惯性矩阵）按相似变换转系**：$\mathbf{H}_a = R_{ab}\,\mathbf{H}_b\,R_{ab}^T$，比一阶多一个 $R$。这是 Lemma 2.1 的推广。
6. **Rodrigues 公式给出指数映射的闭合形式**：无需截断无穷级数，只需 $\sin\theta$ 和 $\cos\theta$。
7. **Euler 定理保证每个旋转都可表示为绕某轴转某角**：这是指数坐标 $(\boldsymbol{\omega}, \theta)$ 完备性的理论基础。
