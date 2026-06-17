# 第1讲：刚体运动与指数坐标 — 笔记

> **Source**: March_9NT.pdf (29 pages)
> **Textbook**: MLS Chapter 2, §§3–3.2
> **主题**: 三维空间中的刚体运动 (Rigid Motion in R³)、齐次表示 (Homogeneous Representation)、指数坐标与旋量 (Exponential Coordinates & Twists)

---

## §3 三维空间中的刚体运动

### 3.1 特殊欧几里得群 SE(3)

刚体在三维空间中的构型（configuration）由两个量完全确定：
- **位置** $\mathbf{p}_{AB} \in \mathbb{R}^3$：坐标系 B 原点在坐标系 A 中的坐标
- **姿态** $R_{AB} \in SO(3)$：坐标系 B 相对于坐标系 A 的旋转矩阵

**定义 — 特殊欧几里得群 SE(3)**：

$$\boxed{SE(3) = \left\{ (p, R) : p \in \mathbb{R}^3,\; R \in SO(3) \right\} = \mathbb{R}^3 \times SO(3)} \tag{2.21}$$

> ✅ **关键理解**：$(p, R) \in SE(3)$ 具有双重身份：
> 1. **构型描述符** — 指定刚体在空间中的位置与姿态
> 2. **坐标变换算子** — 将一个坐标系中的坐标变换到另一个坐标系

---

### 3.2 刚体变换

设 $\mathbf{q}_a, \mathbf{q}_b \in \mathbb{R}^3$ 分别为点 $q$ 在坐标系 A 和坐标系 B 中的坐标，则：

$$\boxed{\mathbf{q}_a = \mathbf{p}_{ab} + R_{ab}\,\mathbf{q}_b} \tag{2.22}$$

其中 $g_{ab} = (p_{ab}, R_{ab}) \in SE(3)$ 指定了坐标系 B 相对于坐标系 A 的构型。

为简洁起见，将变换作用记为：

$$\mathbf{q}_a = \mathbf{p}_{ab} + R_{ab}\,\mathbf{q}_b = g_{ab}(\mathbf{q}_b)$$

> 📖 **几何直觉**：这是一个**仿射变换**（旋转 + 平移）。先用 $R_{ab}$ 旋转向量 $\mathbf{q}_b$ 使其方向与 A 系对齐，再平移 $\mathbf{p}_{ab}$ 使其原点与 A 系原点重合。

---

## §3.1 齐次表示 (Homogeneous Representation)

### 3.1.1 点与向量的齐次坐标

为了将仿射变换写成**线性形式**，引入齐次坐标。

**点的齐次坐标**（第四分量为 1）：

$$\bar{\mathbf{q}} = \begin{bmatrix} q_1 \\ q_2 \\ q_3 \\ 1 \end{bmatrix} \in \mathbb{R}^4$$

**向量的齐次坐标**（第四分量为 0）：

$$\bar{\mathbf{v}} = \begin{bmatrix} v_1 \\ v_2 \\ v_3 \\ 0 \end{bmatrix} \in \mathbb{R}^4$$

> ✅ **直觉**：第四分量区分"点"和"方向"。点有位置（1），向量只有方向（0）。这反映了平移对向量无影响的几何事实——向量的起点无关紧要。

### 齐次坐标的语法规则

| 操作 | 结果 | 解释 |
|------|------|------|
| $\mathbf{v}_1 \pm \mathbf{v}_2$ | 向量 | 向量的线性组合仍是向量 |
| $\mathbf{q} + \mathbf{v}$ | 点 | 点沿向量方向移动得到新点 |
| $\mathbf{q}_1 - \mathbf{q}_2$ | 向量 | 两点之差是从一点指向另一点的方向 |
| $\mathbf{q}_1 + \mathbf{q}_2$ | **无意义** | 两个点相加没有几何意义 |

### 3.1.2 齐次变换矩阵

利用齐次坐标，仿射变换 $\mathbf{q}_a = g_{ab}(\mathbf{q}_b)$ 可写成线性形式：

$$\boxed{\bar{\mathbf{q}}_a = \begin{bmatrix} \mathbf{q}_a \\ 1 \end{bmatrix} = \begin{bmatrix} R_{ab} & p_{ab} \\ \mathbf{0} & 1 \end{bmatrix} \begin{bmatrix} \mathbf{q}_b \\ 1 \end{bmatrix} = \bar{g}_{ab}\,\bar{\mathbf{q}}_b}$$

其中 $\bar{g}_{ab} \in \mathbb{R}^{4 \times 4}$ 称为 $g_{ab} \in SE(3)$ 的**齐次表示**。

> 📖 **记法约定**：MLS 课本后续省去上划线，直接写 $g q$ 和 $g v$，分别表示 $\bar{g}\bar{\mathbf{q}}$ 和 $\bar{g}^*\bar{\mathbf{v}}$。

---

### 3.1.3 变换的复合规则

设 $g_{bc} \in SE(3)$ 为 C 系相对于 B 系的构型，$g_{ab} \in SE(3)$ 为 B 系相对于 A 系的构型。则 C 系相对于 A 系的构型可由齐次矩阵乘法得到：

$$\boxed{\bar{g}_{ac} = \bar{g}_{ab}\,\bar{g}_{bc} = \begin{bmatrix} R_{ab}R_{bc} & R_{ab}p_{bc} + p_{ab} \\ \mathbf{0} & 1 \end{bmatrix}} \tag{2.24}$$

> ⚠️ **重要前提**：
> - $R_{ab}$ 和 $p_{ab}$ 的分量必须在**坐标系 A** 中表示
> - $R_{bc}$ 和 $p_{bc}$ 的分量必须在**坐标系 B** 中表示
> - 矩阵乘法的顺序 = 从右到左依次施加变换

> ✅ **物理解释**：先旋转 C 系在 B 系中的坐标 $p_{bc}$ 到 A 系方向 ($R_{ab}p_{bc}$)，再加上 B 系原点在 A 系中的位置 ($p_{ab}$)。旋转部分直接相乘 $R_{ab}R_{bc}$。

### 3.1.4 刚体变换构成群

SE(3) 具有群结构，满足：
1. **封闭性**：$g_1, g_2 \in SE(3) \Rightarrow g_1 g_2 \in SE(3)$
2. **结合律**：$(g_1 g_2) g_3 = g_1 (g_2 g_3)$
3. **单位元**：$g = (I, 0)$
4. **逆元**：$g^{-1} = (R^T, -R^T p) \in SE(3)$

> 📖 See MLS p.37 for the group axioms verification.

---

### 3.1.5 齐次变换作用于向量

向量 $\mathbf{v} = \mathbf{s} - \mathbf{r}$（两点之差）的齐次变换：

$$\bar{g}^* \bar{\mathbf{v}} = \bar{g}(\bar{\mathbf{s}}) - \bar{g}(\bar{\mathbf{r}}) = \begin{bmatrix} R & p \\ \mathbf{0} & 1 \end{bmatrix} \begin{bmatrix} v_1 \\ v_2 \\ v_3 \\ 0 \end{bmatrix}$$

> ✅ 结果第四分量仍是 $0$，确认了"向量的齐次变换保持向量的向量属性"。

---

## §3.2 刚体运动的指数坐标与旋量 (Twists)

### 3.2.1 旋转关节的运动学

考虑一个绕轴 $\boldsymbol{\omega} \in \mathbb{R}^3$ ($\|\boldsymbol{\omega}\| = 1$) 以单位角速度旋转的**旋转关节 (revolute joint)**。设轴上一点为 $\mathbf{q}$。

轴上任意一点 $\mathbf{p}$ 的速度为：

$$\dot{\mathbf{p}}(t) = \hat{\boldsymbol{\omega}}\big(\mathbf{p}(t) - \mathbf{q}\big) \tag{2.25}$$

> 📖 **物理直觉**：$\hat{\boldsymbol{\omega}}$ 是叉乘矩阵，$\hat{\boldsymbol{\omega}}\mathbf{x} = \boldsymbol{\omega} \times \mathbf{x}$。上式即 $\dot{\mathbf{p}} = \boldsymbol{\omega} \times (\mathbf{p} - \mathbf{q})$——刚体旋转时，任意点的线速度 = 角速度叉乘该点相对转轴上某点的位置向量。

### 3.2.2 旋量矩阵 $\hat{\xi}$ 的定义

定义 $4 \times 4$ 矩阵：

$$\boxed{\hat{\xi} = \begin{bmatrix} \hat{\boldsymbol{\omega}} & \mathbf{v} \\ \mathbf{0} & 0 \end{bmatrix}} \tag{2.26}$$

其中 $\mathbf{v} = -\hat{\boldsymbol{\omega}}\mathbf{q}$（即 $-\boldsymbol{\omega} \times \mathbf{q}$）。

这样 (2.25) 可以写成齐次形式：

$$\begin{bmatrix} \dot{\mathbf{p}} \\ 0 \end{bmatrix} = \begin{bmatrix} \hat{\boldsymbol{\omega}} & -\hat{\boldsymbol{\omega}}\mathbf{q} \\ \mathbf{0} & 0 \end{bmatrix} \begin{bmatrix} \mathbf{p} \\ 1 \end{bmatrix} = \hat{\xi} \begin{bmatrix} \mathbf{p} \\ 1 \end{bmatrix} \quad\Rightarrow\quad \dot{\bar{\mathbf{p}}} = \hat{\xi}\,\bar{\mathbf{p}}$$

> ✅ 这是一阶线性常微分方程 $\dot{\bar{\mathbf{p}}} = \hat{\xi}\,\bar{\mathbf{p}}$。

---

### 3.2.3 指数映射

ODE $\dot{\bar{\mathbf{p}}} = \hat{\xi}\,\bar{\mathbf{p}}$ 的解为：

$$\boxed{\bar{\mathbf{p}}(t) = e^{\hat{\xi}t}\,\bar{\mathbf{p}}(0)}$$

其中矩阵指数定义为：

$$e^{\hat{\xi}t} = I + \hat{\xi}t + \frac{(\hat{\xi}t)^2}{2!} + \frac{(\hat{\xi}t)^3}{3!} + \cdots$$

> ✅ **核心理解**：$e^{\hat{\xi}t}$ 将一个点从初始位置（$t=0$ 时）映射到旋转 $t$ 弧度后的位置。这与 $SO(3)$ 中 $e^{\hat{\omega}\theta}$ 将向量旋转 $\theta$ 弧度完全类似，只是现在映射的是**点**（包含平移效果）。

---

### 3.2.4 移动关节 (Prismatic Joint)

对于以单位速度运动的**移动关节**：

$$\dot{\mathbf{p}}(t) = \mathbf{v} \tag{2.27}$$

齐次形式同样可写为 $\dot{\bar{\mathbf{p}}} = \hat{\xi}\,\bar{\mathbf{p}}$，其中：

$$\hat{\xi} = \begin{bmatrix} \mathbf{0}_{3\times 3} & \mathbf{v} \\ \mathbf{0}_{1\times 3} & 0 \end{bmatrix} \tag{2.28}$$

解同样为 $\bar{\mathbf{p}}(t) = e^{\hat{\xi}t}\,\bar{\mathbf{p}}(0)$，$t$ 为总平移量。

> ✅ 旋转与平移在齐次框架下获得了**统一的描述**——都是一阶 ODE $\dot{\bar{\mathbf{p}}} = \hat{\xi}\bar{\mathbf{p}}$ 的解，区别仅在于 $\hat{\xi}$ 的结构。

---

### 3.2.5 Lie 代数 $\mathfrak{se}(3)$

**定义**：

$$\boxed{\mathfrak{se}(3) := \left\{ (v, \hat{\omega}) : v \in \mathbb{R}^3,\; \hat{\omega} \in \mathfrak{so}(3) \right\}} \tag{2.29}$$

在齐次坐标中，$\hat{\xi} \in \mathfrak{se}(3)$ 写为：

$$\hat{\xi} = \begin{bmatrix} \hat{\boldsymbol{\omega}} & \mathbf{v} \\ \mathbf{0} & 0 \end{bmatrix} \in \mathbb{R}^{4\times 4}$$

$\mathfrak{se}(3)$ 的元素称为 **旋量 (twist)**。

> 📖 **类比**：$\mathfrak{se}(3)$ 之于 $SE(3)$，正如 $\mathfrak{so}(3)$ 之于 $SO(3)$。$\hat{\xi}$ 是"广义角速度"，描述了刚体运动的无穷小生成元。

### 3.2.6 Vee 与 Wedge 算子

建立 $\mathfrak{se}(3)$ 矩阵与 $\mathbb{R}^6$ 向量之间的同构：

$$\boxed{\begin{bmatrix} \hat{\boldsymbol{\omega}} & \mathbf{v} \\ \mathbf{0} & 0 \end{bmatrix}^{\vee} = \begin{bmatrix} \mathbf{v} \\ \boldsymbol{\omega} \end{bmatrix}} \quad\text{(vee)} \tag{2.30}$$

$$\boxed{\begin{bmatrix} \mathbf{v} \\ \boldsymbol{\omega} \end{bmatrix}^{\wedge} = \begin{bmatrix} \hat{\boldsymbol{\omega}} & \mathbf{v} \\ \mathbf{0} & 0 \end{bmatrix}} \quad\text{(wedge)} \tag{2.31}$$

右端 $\xi \in \mathbb{R}^6$ 称为旋量 $\hat{\xi} \in \mathfrak{se}(3)$ 的**旋量坐标 (twist coordinates)**。

> ⚠️ **注意顺序**：$\xi = (v, \omega)$，**线速度分量在前，角速度分量在后**。这是 MLS 的约定。

---

### 3.2.7 指数映射的计算：关键结果

**命题 2.8** (p.41)：给定 $\hat{\xi} \in \mathfrak{se}(3)$ 和 $\theta \in \mathbb{R}$，$e^{\hat{\xi}\theta} \in SE(3)$。

下面分两种情况计算 $e^{\hat{\xi}\theta}$。

#### 情况 1：纯平移 ($\boldsymbol{\omega} = \mathbf{0}$)

$$\boxed{e^{\hat{\xi}\theta} = \begin{bmatrix} I & \mathbf{v}\theta \\ \mathbf{0} & 1 \end{bmatrix}} \quad \omega = 0 \tag{2.32}$$

推导：$\hat{\xi}^2 = 0$（幂零矩阵），因此 $e^{\hat{\xi}\theta} = I + \hat{\xi}\theta$。

#### 情况 2：含旋转 ($\boldsymbol{\omega} \neq \mathbf{0}$)

通过相似变换简化计算。定义辅助矩阵：

$$g = \begin{bmatrix} I & \hat{\boldsymbol{\omega}}\mathbf{v} \\ \mathbf{0} & 1 \end{bmatrix} \tag{2.33}$$

计算 $\hat{\xi}' = g^{-1}\hat{\xi}g$（假设 $\|\boldsymbol{\omega}\| = 1$）：

$$\hat{\xi}' = \begin{bmatrix} \hat{\boldsymbol{\omega}} & \boldsymbol{\omega}\boldsymbol{\omega}^T\mathbf{v} \\ \mathbf{0} & 0 \end{bmatrix} = \begin{bmatrix} \hat{\boldsymbol{\omega}} & h\boldsymbol{\omega} \\ \mathbf{0} & 0 \end{bmatrix}$$

其中 $h := \boldsymbol{\omega}^T\mathbf{v}$（利用 Lemma 2.3, p.28）。

> 📖 **为什么这样做？** $\hat{\xi}'$ 具有好性质：$\hat{\boldsymbol{\omega}}\boldsymbol{\omega} = \mathbf{0}$，因此 $(\hat{\xi}')^2 = \begin{bmatrix} \hat{\boldsymbol{\omega}}^2 & \mathbf{0} \\ \mathbf{0} & 0 \end{bmatrix}$，$(\hat{\xi}')^3 = \begin{bmatrix} \hat{\boldsymbol{\omega}}^3 & \mathbf{0} \\ \mathbf{0} & 0 \end{bmatrix}$ 等等——幂次计算极为简单。

于是：

$$e^{\hat{\xi}'\theta} = \begin{bmatrix} e^{\hat{\boldsymbol{\omega}}\theta} & h\boldsymbol{\omega}\theta \\ \mathbf{0} & 1 \end{bmatrix}$$

利用恒等式 $e^{\hat{\xi}\theta} = g e^{\hat{\xi}'\theta} g^{-1}$（证明见下），得：

$$\boxed{e^{\hat{\xi}\theta} = \begin{bmatrix} e^{\hat{\boldsymbol{\omega}}\theta} & (I - e^{\hat{\boldsymbol{\omega}}\theta})\hat{\boldsymbol{\omega}}\mathbf{v} + \boldsymbol{\omega}\boldsymbol{\omega}^T\mathbf{v}\,\theta \\ \mathbf{0} & 1 \end{bmatrix} \in SE(3)} \quad \omega \neq 0 \tag{2.36}$$

> ✅ **实用价值**：$e^{\hat{\omega}\theta}$ 可用 Rodrigues 公式 (2.14, p.28) 快速计算，因此 (2.36) 给出了一个**计算 $e^{\hat{\xi}\theta}$ 的实用公式**。

---

### 3.2.8 恒等式 $e^{\hat{\xi}\theta} = g e^{\hat{\xi}'\theta} g^{-1}$ 的证明

若 $\hat{\xi}' = g^{-1}\hat{\xi}g$（即 $\hat{\xi} = g\hat{\xi}'g^{-1}$），则：

$$e^{\hat{\xi}\theta} = e^{g\hat{\xi}'g^{-1}\theta} = e^{g(\hat{\xi}'\theta)g^{-1}}$$

展开矩阵指数：

$$
\begin{aligned}
e^{g(\hat{\xi}'\theta)g^{-1}}
&= I + g\hat{\xi}'\theta g^{-1} + \frac{(g\hat{\xi}'\theta g^{-1})^2}{2!} + \frac{(g\hat{\xi}'\theta g^{-1})^3}{3!} + \cdots \\
&= I + g\hat{\xi}'\theta g^{-1} + g\frac{(\hat{\xi}'\theta)^2}{2!}g^{-1} + g\frac{(\hat{\xi}'\theta)^3}{3!}g^{-1} + \cdots \\
&= g\left[I + \hat{\xi}'\theta + \frac{(\hat{\xi}'\theta)^2}{2!} + \frac{(\hat{\xi}'\theta)^3}{3!} + \cdots\right] g^{-1} \\
&= g\,e^{\hat{\xi}'\theta}\,g^{-1}
\end{aligned}
$$

> ✅ 关键步骤：$(g\hat{\xi}'g^{-1})^n = g(\hat{\xi}')^n g^{-1}$，因为中间所有 $g^{-1}g = I$ 全部消去。

---

### 3.2.9 指数映射的两种用法

公式 (2.36) 给出了 $e^{\hat{\xi}\theta}$，其应用有两种视角：

| 用法 | 公式 | 含义 |
|------|------|------|
| **点映射** | $\mathbf{p}(\theta) = e^{\hat{\xi}\theta}\,\mathbf{p}(0)$ | 将点的坐标从初始位置映射到转动 $\theta$ 弧度后的位置（**同一坐标系中**） |
| **构型映射** | $g_{ab}(\theta) = e^{\hat{\xi}\theta}\,g_{ab}(0)$ | 将刚体从初始构型映射到转动 $\theta$ 弧度后的构型（**坐标系 A 中观察**） |

> ⚠️ **重要**：$g_{ab}(\theta) = e^{\hat{\xi}\theta}\,g_{ab}(0)$ (2.37)，指数映射**左乘**初始构型。

---

### 3.2.10 逆问题：从构型求旋量坐标（命题 2.9, p.42）

**命题 2.9**：给定 $g \in SE(3)$，存在 $\hat{\xi} \in \mathfrak{se}(3)$ 和 $\theta \in \mathbb{R}$ 使得 $g = e^{\hat{\xi}\theta}$。

设 $g = (R, p)$，$R \in SO(3)$，$p \in \mathbb{R}^3$。

**平凡情况**：$(R, p) = (I, 0) \Rightarrow \theta = 0$，$\hat{\xi}$ 任意。

**情况 1：纯平移** ($R = I$)

$$\hat{\xi} = \begin{bmatrix} \mathbf{0} & \frac{p}{\|p\|} \\ \mathbf{0} & 0 \end{bmatrix}, \quad \theta = \|p\|$$

验证：$e^{\hat{\xi}\theta} = I + \hat{\xi}\theta = (I, p) = g$。

**情况 2：含旋转** ($R \neq I$)

由 (2.36) 对比 $g$ 的块结构：

$$e^{\hat{\xi}\theta} = \begin{bmatrix} e^{\hat{\boldsymbol{\omega}}\theta} & (I - e^{\hat{\boldsymbol{\omega}}\theta})\hat{\boldsymbol{\omega}}\mathbf{v} + \boldsymbol{\omega}\boldsymbol{\omega}^T\mathbf{v}\,\theta \\ \mathbf{0} & 1 \end{bmatrix} = \begin{bmatrix} R & p \\ \mathbf{0} & 1 \end{bmatrix}$$

1. **求 $\boldsymbol{\omega}$ 和 $\theta$**：由 $e^{\hat{\omega}\theta} = R$，利用命题 2.5 (p.29) 求解
2. **求 $\mathbf{v}$**：解线性方程组

   $$A\mathbf{v} = p, \quad A = (I - e^{\hat{\omega}\theta})\hat{\omega} + \omega\omega^T\theta$$

   可以证明当 $R \neq I$ 且 $\theta \neq 0$ 时，$|A| \neq 0$，因此 $\mathbf{v}$ 有唯一解。

> 📖 **这建立了 $SE(3)$ ←→ $\mathfrak{se}(3)$ 之间的指数映射关系**：每个刚体变换都可以表示为一个旋量的指数。这正是 Chasles 定理的数学基础（下一讲详述）。

---

## 📊 公式速查表

| 概念 | 公式 | 编号 |
|------|------|------|
| SE(3) 定义 | $SE(3) = \mathbb{R}^3 \times SO(3)$ | (2.21) |
| 刚体变换 | $\mathbf{q}_a = p_{ab} + R_{ab}\,\mathbf{q}_b$ | (2.22) |
| 齐次变换矩阵 | $\bar{g}_{ab} = \begin{bmatrix} R_{ab} & p_{ab} \\ \mathbf{0} & 1 \end{bmatrix}$ | — |
| 复合规则 | $\bar{g}_{ac} = \bar{g}_{ab}\,\bar{g}_{bc}$ | (2.24) |
| 旋量矩阵 | $\hat{\xi} = \begin{bmatrix} \hat{\omega} & v \\ \mathbf{0} & 0 \end{bmatrix}$ | (2.26) |
| se(3) 定义 | $\mathfrak{se}(3) := \{(v, \hat{\omega}) : v \in \mathbb{R}^3, \hat{\omega} \in \mathfrak{so}(3)\}$ | (2.29) |
| Vee 算子 | $\hat{\xi}^{\vee} = (v, \omega)$ | (2.30) |
| Wedge 算子 | $(v, \omega)^{\wedge} = \hat{\xi}$ | (2.31) |
| 指数映射（纯平移） | $e^{\hat{\xi}\theta} = \begin{bmatrix} I & v\theta \\ \mathbf{0} & 1 \end{bmatrix}$ | (2.32) |
| 指数映射（含旋转） | $e^{\hat{\xi}\theta} = \begin{bmatrix} e^{\hat{\omega}\theta} & (I-e^{\hat{\omega}\theta})\hat{\omega}v + \omega\omega^T v\theta \\ \mathbf{0} & 1 \end{bmatrix}$ | (2.36) |
| 构型映射 | $g_{ab}(\theta) = e^{\hat{\xi}\theta}g_{ab}(0)$ | (2.37) |

---

## 🔑 关键要点

1. **SE(3) 同时是构型空间和变换群**：$(p, R)$ 既可以描述"刚体在哪里"，也可以用于"把一个坐标变换到另一个坐标"。
2. **齐次坐标统一了点与向量的处理**：第四分量 $1$ = 点（受平移影响），$0$ = 向量（不受平移影响）。
3. **$\mathfrak{se}(3)$ 是 $SE(3)$ 的 Lie 代数**：旋量 $\hat{\xi}$ 是刚体运动的"无穷小生成元"，其指数 $e^{\hat{\xi}\theta}$ 是有限运动。
4. **Wedge/Vee 算子建立了矩阵与向量的桥梁**：$\hat{\xi} \in \mathbb{R}^{4\times 4} \leftrightarrow \xi = (v, \omega) \in \mathbb{R}^6$。
5. **指数映射的计算技巧**：通过相似变换 $g^{-1}\hat{\xi}g$ 将 $\hat{\xi}$ 化为"好算"的形式，再变回去。

