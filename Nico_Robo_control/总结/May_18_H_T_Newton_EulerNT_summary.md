# 第四章 §2.2 & §2.4：刚体惯性属性与 Newton-Euler 方程 — 课件总结

> 课件：May_18_H_T_Newton_EulerNT.pdf（15 页）
> 对应教材：MLS Chapter 4, §2.2（惯性属性）& §2.4（Newton-Euler 方程）

---

## §2.2 刚体的惯性属性（Inertial Properties of Rigid Bodies）

### 2.2.1 问题设定

考虑一个三维刚体，设：

- $G$ 为刚体的**质心（Centre of Mass）**
- 物体坐标系（Body frame）$B$ 的原点**位于 $G$**
- $R \in SO(3)$ 为 $B$ 相对于空间坐标系 $A$ 的姿态旋转矩阵
- $p \in \mathbb{R}^3$ 为 $B$ 原点（即质心 $G$）在空间坐标系中的位置

刚体上任意一点 $r$（在体坐标系中的坐标）的空间速度为（教材 p.161）：

$$
v_r^s = \dot{p} + \dot{R} r
$$

该点**相对于质心 $G$ 的速度**为（仅保留转动部分，$\dot{p}$ 被消掉）：

$$
v_{r/G}^s = \dot{R} r
$$

将其变换到体坐标系中：

$$
v_{r/G}^b = R^T v_{r/G}^s = R^T \dot{R} r = \hat{\omega} r
$$

其中 $\omega \in \mathbb{R}^3$ 是**在体坐标系中表示的刚体角速度**（教材 p.162 中部）。

> **直观理解**：$v_{r/G}^b = \hat{\omega} r = \omega \times r$，就是刚体绕质心转动的线速度公式（叉乘形式）。$\hat{\omega}$ 是 $\omega$ 的 $3 \times 3$ 反对称矩阵。

---

### 2.2.2 关于质心的角动量（Angular Momentum about $G$）

#### 体坐标系中的角动量

刚体上某点 $r$ 的微元质量 $\rho(r) dV$ 对质心 $G$ 的角动量（在体坐标中表示）为：

$$
d H_{G/G}^b = \rho(r) \, \hat{r} \, v_{r/G}^b \, dV
$$

> 这里 $\hat{r}$ 是位置向量 $r$ 的反对称矩阵，与叉乘等价：$\hat{r} v = r \times v$。

代入 $v_{r/G}^b = \hat{\omega} r = -\hat{r} \omega$：

$$
d H_{G/G}^b = \rho(r) \, \hat{r} (-\hat{r} \omega) \, dV = -\rho(r) \, \hat{r}^2 \omega \, dV
$$

对整个刚体积分，得到**总角动量**：

$$
\boxed{H_{G/G}^b = -\int_V \rho(r) \, \hat{r}^2 \, dV \; \omega = \mathcal{I} \, \omega}
$$

其中 $\mathcal{I}$ 是**惯性张量（Inertia Tensor）**，一个 $3 \times 3$ 的对称矩阵：

$$
\mathcal{I} = -\int_V \rho(r) \, \hat{r}^2 \, dV =
\begin{bmatrix}
I_{xx} & I_{xy} & I_{xz} \\
I_{yx} & I_{yy} & I_{yz} \\
I_{zx} & I_{zy} & I_{zz}
\end{bmatrix}
$$

| 元素 | 含义 | 公式 |
|------|------|------|
| $I_{xx}$ | 绕 $x$ 轴的转动惯量 | $\int \rho(r)(y^2+z^2) dV$ |
| $I_{yy}$ | 绕 $y$ 轴的转动惯量 | $\int \rho(r)(x^2+z^2) dV$ |
| $I_{zz}$ | 绕 $z$ 轴的转动惯量 | $\int \rho(r)(x^2+y^2) dV$ |
| $I_{xy}=I_{yx}$ | 惯性积（product of inertia） | $-\int \rho(r)xy \, dV$ |

> **物理直觉**：惯性张量 $\mathcal{I}$ 是转动中的"质量"——它描述刚体对绕不同轴转动的"抵抗"程度。对角元素越大，绕该轴越难加速转动；非对角元素（惯性积）表示质量分布的不对称程度。

#### 空间坐标系中的角动量

将体坐标系中的角动量变换到空间坐标系：

$$
H_{G/G}^s = R \, H_{G/G}^b = R \, \mathcal{I} \, \omega
$$

> 注意 $\omega$ 在这里是**体坐标系中表示**的角速度，而 $\omega_s = R\omega$ 是**空间坐标系中表示**的角速度。

代入 $\omega = R^T \omega_s$，并利用 $R R^T = I$ 做恒等变形：

$$
\begin{aligned}
H_{G/G}^s &= R \mathcal{I} \omega = R \mathcal{I} R^T R \omega \\
&= (R \mathcal{I} R^T)(R \omega) \\
&= \mathcal{I}' \, \omega_s
\end{aligned}
$$

其中：

$$
\boxed{\mathcal{I}' = R \mathcal{I} R^T}
$$

是**在空间坐标系中表示的惯性张量**（随姿态 $R$ 变化！）。

> ⚠️ **关键区别**：$\mathcal{I}$（体坐标系中的惯性张量）是**常量**——由刚体质量分布决定，不随运动改变。而 $\mathcal{I}' = R \mathcal{I} R^T$ 随姿态变化——刚体转动时，从空间坐标系"看"，惯性张量在变。这就是为什么在 §2.4 推导 Euler 方程时这个关系会用到（见教材 p.166）。

---

### 2.2.3 刚体的动能（Kinetic Energy）

#### 基本定义

刚体的**总动能**定义为：

$$
T = \frac{1}{2} \int_V \rho(r) \, \|v_r^s\|^2 \, dV
$$

将 $v_r^s = \dot{p} + \dot{R} r$ 代入：

$$
T = \frac{1}{2} \int_V \rho(r) \left( \|\dot{p}\|^2 + 2\dot{p}^T \dot{R} r + \|\dot{R} r\|^2 \right) dV
$$

#### 拆解三项

**第一项 — 平动动能：**

$$
\frac{1}{2} \int_V \rho(r) \|\dot{p}\|^2 \, dV
= \frac{1}{2} \left( \int_V \rho(r) dV \right) \|\dot{p}\|^2
= \boxed{\frac{1}{2} m \|\dot{p}\|^2}
$$

其中 $m = \int_V \rho(r) dV$ 是刚体的总质量。这项是**质心平动的动能**。

**第二项 — 交叉项：**

$$
\int_V \rho(r) \, \dot{p}^T \dot{R} r \, dV
= \dot{p}^T \dot{R} \int_V \rho(r) r \, dV
= 0
$$

> 因为 $\int_V \rho(r) r \, dV = 0$，这正是**质心定义**：在体坐标系中，以质心为原点的位置向量 $r$ 的加权平均为零。**这是选择 $B$ 原点在质心 $G$ 的好处：平动与转动解耦！**

**第三项 — 转动动能（需要进一步化简）：**

$$
T_{\text{rot}} = \frac{1}{2} \int_V \rho(r) \|\dot{R} r\|^2 \, dV
$$

#### 转动动能的化简

利用 $\dot{R} = R \hat{\omega}$（即 $\dot{R} r = R (\omega \times r)$）：

$$
\begin{aligned}
T_{\text{rot}} &= \frac{1}{2} \int_V \rho(r) (R \hat{\omega} r)^T (R \hat{\omega} r) \, dV \\
&= \frac{1}{2} \int_V \rho(r) (R \hat{r} \omega)^T (R \hat{r} \omega) \, dV \quad (\because \hat{\omega} r = -\hat{r} \omega) \\
&= \frac{1}{2} \int_V \rho(r) \, \omega^T \hat{r}^T R^T R \, \hat{r} \omega \, dV \\
&= \frac{1}{2} \omega^T \int_V \rho(r) \, \hat{r}^T \hat{r} \, dV \; \omega \\
&= -\frac{1}{2} \omega^T \int_V \rho(r) \, \hat{r}^2 \, dV \; \omega \\
&= \boxed{\frac{1}{2} \omega^T \mathcal{I} \, \omega}
\end{aligned}
$$

> **推导关键**：用了两步技巧——$\hat{\omega} r = -\hat{r} \omega$（反对称矩阵的交换性质），以及 $\hat{r}^T \hat{r} = -\hat{r}^2$。

#### 最终动能表达式

将三项合并：

$$
\boxed{T = \frac{1}{2} m \|\dot{p}\|^2 + \frac{1}{2} \omega^T \mathcal{I} \, \omega}
$$

- 第一项：质心平动动能
- 第二项：绕质心的转动动能
- 两项**完全解耦**，因为体坐标系原点选在质心

---

### 2.2.4 广义惯性矩阵（Generalized Inertia Matrix）

回顾体速度（body velocity）的定义（教材 eq. 2.55, p.55）：

$$
V^b = \begin{bmatrix} R^T \dot{p} \\ \omega \end{bmatrix} \in \mathbb{R}^6
$$

计算二次型：

$$
\begin{aligned}
V^{bT} \begin{bmatrix} mI & 0 \\ 0 & \mathcal{I} \end{bmatrix} V^b
&= m (R^T \dot{p})^T (R^T \dot{p}) + \omega^T \mathcal{I} \, \omega \\
&= m \|R^T \dot{p}\|^2 + \omega^T \mathcal{I} \, \omega \\
&= m \|\dot{p}\|^2 + \omega^T \mathcal{I} \, \omega
\end{aligned}
$$

> 因为旋转矩阵保范：$\|R^T \dot{p}\| = \|\dot{p}\|$。

这与动能恰好相差一个 $1/2$ 因子，因此：

$$
\boxed{T = \frac{1}{2} V^{bT} \mathcal{M} V^b} \tag{4.9}
$$

其中：

$$
\boxed{\mathcal{M} = \begin{bmatrix} mI & 0 \\ 0 & \mathcal{I} \end{bmatrix} \in \mathbb{R}^{6 \times 6}}
$$

是**在体坐标系中表示的广义惯性矩阵（Generalized Inertia Matrix）**。

> ✅ **重要性质**：$\mathcal{M}$ 是**对称正定**（symmetric and positive definite）的 —— 质量 $m > 0$，惯性张量 $\mathcal{I}$ 正定。

---

## §2.4 刚体的 Newton-Euler 方程

### 2.4.1 线运动：Newton 第二定律

刚体的**线动量**为 $m \dot{p}$。

Newton 第二定律：

$$
f = \frac{d}{dt} (m \dot{p})
$$

对于**质量恒定**的刚体（$m$ 不变）：

$$
\boxed{f = m \ddot{p}} \tag{4.12}
$$

其中 $f \in \mathbb{R}^3$ 是施加在质心上的合外力（在空间坐标系中表示）。

> ✅ **重要特点**：因为体坐标系原点在质心 $G$，线运动方程**与角运动完全解耦**。合外力只决定质心加速度 $\ddot{p}$，与转动无关。

---

### 2.4.2 角运动：Euler 方程（空间坐标系中）

**角动量定理**：外力矩等于角动量的时间变化率。

在空间（惯性）坐标系中，对于作用在质心处的力矩 $\tau \in \mathbb{R}^3$：

$$
\tau = \frac{d}{dt} H_{G/G}^s = \frac{d}{dt} (\mathcal{I}' \omega_s)
$$

代入 $\mathcal{I}' = R \mathcal{I} R^T$ 并用乘积法则求导：

$$
\begin{aligned}
\tau &= \frac{d}{dt} (R \mathcal{I} R^T \omega_s) \\
&= R \mathcal{I} R^T \dot{\omega}_s + \dot{R} \mathcal{I} R^T \omega_s + R \mathcal{I} \dot{R}^T \omega_s
\end{aligned}
$$

> 中间步骤（需要用到 $\dot{R} = \hat{\omega}_s R$ 和 $\dot{R}^T = -R^T \hat{\omega}_s$）：

$$
\begin{aligned}
\tau &= \mathcal{I}' \dot{\omega}_s + \dot{R} R^T R \mathcal{I} R^T \omega_s + R \mathcal{I} R^T R \dot{R}^T \omega_s \\
&= \mathcal{I}' \dot{\omega}_s + \hat{\omega}_s \mathcal{I}' \omega_s + \mathcal{I}' (-\hat{\omega}_s) \omega_s \\
&= \mathcal{I}' \dot{\omega}_s + \hat{\omega}_s \mathcal{I}' \omega_s - \mathcal{I}' \hat{\omega}_s \omega_s
\end{aligned}
$$

最后两项中，因为 $\hat{\omega}_s \omega_s = \omega_s \times \omega_s = 0$，$\mathcal{I}' \hat{\omega}_s \omega_s = 0$，所以：

$$
\boxed{\tau = \mathcal{I}' \dot{\omega}_s + \hat{\omega}_s \mathcal{I}' \omega_s} \tag{4.13}
$$

这就是**空间坐标系中的 Euler 方程**。

> **物理直觉**：
> - $\mathcal{I}' \dot{\omega}_s$ —— "加速力矩"，用于改变角速度大小
> - $\hat{\omega}_s \mathcal{I}' \omega_s = \omega_s \times (\mathcal{I}' \omega_s)$ —— "陀螺力矩/进动力矩"，用于维持角速度方向（陀螺效应）

---

### 2.4.3 重要提醒：这不是 Wrench 和 Twist！

课件特别强调：

> ⚠️ $(f, \tau) \in \mathbb{R}^6$ **不是**第 2 章意义上的 wrench！因为它不是作用在**空间坐标系原点 $A$**，而是作用在**质心 $G$** 处。
>
> ⚠️ $(\dot{p}, \omega_s) \in \mathbb{R}^6$ **不是**空间速度 twist！因为 $\dot{p}$ 是质心线速度，不是空间坐标系原点的线速度。

---

### 2.4.4 体坐标系中的 Newton-Euler 方程

为了用 twist 和 wrench 的形式表达动力学，需要使用体坐标系中的变量：

- **体线速度**：$v^b = R^T \dot{p}$
- **体力**：$f^b = R^T f$

#### 线运动（体坐标系）

从 $f = m \ddot{p}$ 出发，用 $v^b$ 表达：

$$
f = m \ddot{p} = m \frac{d}{dt} (\dot{p}) = m \frac{d}{dt} (R v^b) = m (R \dot{v}^b + \dot{R} v^b)
$$

左乘 $R^T$：

$$
\begin{aligned}
R^T f &= m (R^T R \dot{v}^b + R^T \dot{R} v^b) \\
f^b &= m (\dot{v}^b + \hat{\omega} v^b)
\end{aligned}
$$

$$
\boxed{f^b = m \dot{v}^b + \hat{\omega} m v^b} \tag{4.14}
$$

> **物理理解**：$\hat{\omega} m v^b = m (\omega \times v^b)$ 是**科里奥利力项**（Coriolis-like term），来自旋转参考系中 Newton 定律的形式。即使在体坐标系中不受外力，$v^b$ 也会因转动而变化。

#### 角运动（体坐标系）

将空间坐标系的 Euler 方程 (4.13) 变换到体坐标系：

$$
R^T \tau = R^T \mathcal{I}' R R^T \dot{\omega}_s + R^T \hat{\omega}_s R R^T \mathcal{I}' R R^T \omega_s
$$

利用以下恒等式：
- $R^T \mathcal{I}' R = R^T (R \mathcal{I} R^T) R = \mathcal{I}$（惯量变回常量！）
- $R^T \dot{\omega}_s = \dot{\omega}$（体坐标中的角加速度）
- $R^T \hat{\omega}_s R = \widehat{R^T \omega_s} = \hat{\omega}$（伴随映射的性质）

得：

$$
\boxed{\tau^b = \mathcal{I} \dot{\omega} + \hat{\omega} \mathcal{I} \omega} \tag{4.15}
$$

> ✅ **对比**：
> - 空间坐标系：$\tau = \mathcal{I}' \dot{\omega}_s + \hat{\omega}_s \mathcal{I}' \omega_s$（惯性张量 $\mathcal{I}'$ 随时间变化）
> - 体坐标系：$\tau^b = \mathcal{I} \dot{\omega} + \hat{\omega} \mathcal{I} \omega$（惯性张量 $\mathcal{I}$ 为常量）
>
> **体坐标系的优势**：惯性矩阵 $\mathcal{I}$ 是恒定矩阵（只由刚体自身质量分布决定），数值计算时无需每一步都更新。

---

### 2.4.5 体坐标系中的完整方程

将 (4.14) 和 (4.15) 合写为一个 6 维方程：

$$
\boxed{
F^b = \underbrace{\begin{bmatrix} mI & 0 \\ 0 & \mathcal{I} \end{bmatrix}}_{\mathcal{M}}
\begin{bmatrix} \dot{v}^b \\ \dot{\omega} \end{bmatrix}
+
\begin{bmatrix} \hat{\omega} m v^b \\ \hat{\omega} \mathcal{I} \omega \end{bmatrix}
} \tag{4.16}
$$

更紧凑的形式：

$$
F^b = \mathcal{M} \dot{V}^b + \begin{bmatrix} \hat{\omega} m v^b \\ \hat{\omega} \mathcal{I} \omega \end{bmatrix}
$$

其中：

| 符号 | 含义 | 说明 |
|------|------|------|
| $F^b = (f^b, \tau^b) \in \mathbb{R}^6$ | 体坐标系中的外部 wrench | 作用在质心 $G$ 处 |
| $V^b = (v^b, \omega) \in \mathbb{R}^6$ | 体速度 twist | 在 $B$ 坐标系中表示 |
| $\mathcal{M}$ | 广义惯性矩阵 | 对称正定，体坐标系中为常量 |
| $\hat{\omega} m v^b$ | 线运动的陀螺项 | 转动对线运动的影响 |
| $\hat{\omega} \mathcal{I} \omega$ | 角运动的陀螺项 | 陀螺效应：转动惯量与角速度的耦合 |

> 式 (4.16) 就是**体坐标系中的 Newton-Euler 方程**。$F^b$ 是作用在质心 $G$ 处、以体坐标系分量表示的**外部 wrench**。

---

## 核心公式速查表

| 概念 | 公式 | 编号 |
|------|------|------|
| 体坐标系角动量 | $H_{G/G}^b = \mathcal{I} \omega$ | — |
| 空间坐标系惯性张量 | $\mathcal{I}' = R \mathcal{I} R^T$ | — |
| 刚体动能 | $T = \frac{1}{2} m \|\dot{p}\|^2 + \frac{1}{2} \omega^T \mathcal{I} \omega$ | — |
| 广义动能 | $T = \frac{1}{2} V^{bT} \mathcal{M} V^b$ | (4.9) |
| 广义惯性矩阵 | $\mathcal{M} = \begin{bmatrix} mI & 0 \\ 0 & \mathcal{I} \end{bmatrix}$ | — |
| 线运动（空间） | $f = m \ddot{p}$ | (4.12) |
| 角运动（空间） | $\tau = \mathcal{I}' \dot{\omega}_s + \hat{\omega}_s \mathcal{I}' \omega_s$ | (4.13) |
| 线运动（体坐标） | $f^b = m \dot{v}^b + \hat{\omega} m v^b$ | (4.14) |
| 角运动（体坐标） | $\tau^b = \mathcal{I} \dot{\omega} + \hat{\omega} \mathcal{I} \omega$ | (4.15) |
| 完整方程（体坐标） | $F^b = \mathcal{M} \dot{V}^b + \begin{bmatrix} \hat{\omega} m v^b \\ \hat{\omega} \mathcal{I} \omega \end{bmatrix}$ | (4.16) |

---

## 主要知识点总结

### 1. 为什么把体坐标系原点选在质心？

- 使平动与转动**解耦**：交叉项 $\int \rho(r) r \, dV = 0$
- 惯量张量 $\mathcal{I}$ 在体坐标系中为**常量**，简化数值计算
- 线动量只与 $\dot{p}$ 有关，角动量只与 $\omega$ 和 $\mathcal{I}$ 有关

### 2. 惯性张量 $\mathcal{I}$ 的物理意义

- 是转动中的"质量"——表征刚体对绕各轴转动的惯性抵抗力
- 体坐标系中为常数矩阵（只取决于刚体质量分布）
- 空间坐标系中 $\mathcal{I}' = R \mathcal{I} R^T$ 随姿态变化

### 3. 动能的双重表达

- **分解形式**：平动 $+$ 转动，清晰直观
- **广义形式**：$T = \frac{1}{2} V^{bT} \mathcal{M} V^b$，与 twist-wrench 框架统一

### 4. Newton-Euler 方程的"陀螺项"

- $\hat{\omega} m v^b$ 和 $\hat{\omega} \mathcal{I} \omega$ 是**转动与平动/转动的耦合**项
- 这些项的存在意味着：即使没有外力作用，刚体的线速度和角速度在体坐标中也会变化（科里奥利效应 + 陀螺效应）
- 当 $\omega = 0$（无转动）时，方程退化为熟悉的 $f = m \ddot{p}$ 和 $\tau = \mathcal{I} \dot{\omega}$

### 5. 空间 vs 体坐标系的动力学表达

| 方面 | 空间坐标系 | 体坐标系 |
|------|----------|---------|
| $\mathcal{I}$ | 非恒定 ($\mathcal{I}'$) | 恒定 |
| 适用场景 | 理论分析 | 数值仿真/控制 |
| twist-wrench | 不完全匹配（$(\dot{p}, \omega_s)$ 不是 twist） | 完全匹配（$V^b, F^b$ 是 twist/wrench） |
