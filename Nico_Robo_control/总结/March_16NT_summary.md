# 第2讲：螺旋 (Screws) — 旋量的几何描述 — 笔记

> **Source**: March_16NT.pdf (20 pages)
> **Textbook**: MLS Chapter 2, §3.3
> **主题**: 螺旋运动的几何描述、Chasles 定理、旋量与螺旋的等价关系、单位旋量

---

## §3.3 螺旋：旋量的几何描述

### 3.3.1 螺旋运动的定义

**螺旋 (Screw)** 由三个要素定义：

| 要素 | 符号 | 含义 |
|------|------|------|
| 轴 (axis) | $l$ | 空间中的一条直线 |
| 螺距 (pitch) | $h$ | 沿轴方向的平移量与旋转量的比值 |
| 幅值 (magnitude) | $M$ | 运动的大小 |

一个**螺旋运动 (screw motion)** 表示：
1. 绕轴 $l$ 旋转 $\theta = M$ 弧度
2. 沿轴 $l$ 平移 $h\theta$

> ⚠️ **工程术语注意**：在机械工程中，螺杆的导程 (lead) 是 $2\pi h$（螺杆相对于螺母旋转一圈时螺母沿轴向移动的距离）。对于单头螺纹，导程也称为 pitch，但这里的 $h$ **不等于**工程上的螺距。详见 Shigley p.422。

**特殊情况**：若 $h = \infty$，则对应沿轴的**纯平移**，平移距离为 $M$。

---

### 3.3.2 螺旋的数学表示

螺旋轴 $l$ 用参数方程表示为（MLS Figure 2.8）：

$$\boxed{l = \left\{ \mathbf{q} + \lambda \boldsymbol{\omega} : \lambda \in \mathbb{R} \right\}} \tag{2.39}$$

其中 $\mathbf{q}$ 是轴上一点，$\boldsymbol{\omega} \in \mathbb{R}^3$ 是单位方向向量 ($\|\boldsymbol{\omega}\| = 1$)。

刚体上一点 $\mathbf{p}$ 经螺旋运动后的新位置（在固定系 A 中表示）：

$$g\mathbf{p} = \mathbf{q} + e^{\hat{\boldsymbol{\omega}}\theta}(\mathbf{p} - \mathbf{q}) + h\boldsymbol{\omega}\theta$$

> 📖 **几何分解**：三项分别对应：
> 1. $\mathbf{q}$ — 平移到轴上的参考点
> 2. $e^{\hat{\omega}\theta}(\mathbf{p} - \mathbf{q})$ — 绕轴旋转（Rodrigues 公式）
> 3. $h\boldsymbol{\omega}\theta$ — 沿轴方向平移 $h\theta$

---

### 3.3.3 螺旋运动的齐次形式

将上述螺旋变换写成齐次矩阵：

$$\boxed{g \begin{bmatrix} \mathbf{p} \\ 1 \end{bmatrix} = \begin{bmatrix} e^{\hat{\boldsymbol{\omega}}\theta} & (I - e^{\hat{\boldsymbol{\omega}}\theta})\mathbf{q} + h\boldsymbol{\omega}\theta \\ \mathbf{0} & 1 \end{bmatrix} \begin{bmatrix} \mathbf{p} \\ 1 \end{bmatrix}}$$

因此，与螺旋运动对应的刚体变换矩阵为：

$$\boxed{g = \begin{bmatrix} e^{\hat{\boldsymbol{\omega}}\theta} & (I - e^{\hat{\boldsymbol{\omega}}\theta})\mathbf{q} + h\boldsymbol{\omega}\theta \\ \mathbf{0} & 1 \end{bmatrix}} \tag{2.40}$$

> ✅ 该矩阵将刚体上的点从初始坐标（$\theta = 0$）映射到最终坐标，所有坐标均在**固定系 A** 中表示。

---

### 3.3.4 螺旋 ↔ 旋量之间的桥梁

回顾上一讲的指数映射公式 (2.36)：

$$e^{\hat{\xi}\theta} = \begin{bmatrix} e^{\hat{\boldsymbol{\omega}}\theta} & (I - e^{\hat{\boldsymbol{\omega}}\theta})\hat{\boldsymbol{\omega}}\mathbf{v} + \boldsymbol{\omega}\boldsymbol{\omega}^T\mathbf{v}\,\theta \\ \mathbf{0} & 1 \end{bmatrix}$$

比较 (2.40) 与 (2.36) 的右上角 $3\times 1$ 子块，关键在于：

> **若取 $\mathbf{v} = -\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega}$，则 $\xi = (v, \omega)$ 生成的螺旋运动恰好就是方程 (2.40) 描述的运动。**

---

### 3.3.5 等价性证明

我们需要证明：当 $\mathbf{v} = -\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega}$ 时，

$$(I - e^{\hat{\boldsymbol{\omega}}\theta})\hat{\boldsymbol{\omega}}\mathbf{v} + \boldsymbol{\omega}\boldsymbol{\omega}^T\mathbf{v}\,\theta = (I - e^{\hat{\boldsymbol{\omega}}\theta})\mathbf{q} + h\theta\boldsymbol{\omega}$$

**证明步骤**：

令左边为 $\beta$，代入 $\mathbf{v} = -\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega}$：

$$\beta = \left[(I - e^{\hat{\boldsymbol{\omega}}\theta})\hat{\boldsymbol{\omega}} + \boldsymbol{\omega}\boldsymbol{\omega}^T\theta\right](-\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega})$$

展开：

$$\beta = \underbrace{-(I - e^{\hat{\boldsymbol{\omega}}\theta})\hat{\boldsymbol{\omega}}^2\mathbf{q}}_{\text{项1}} - \underbrace{\boldsymbol{\omega}\boldsymbol{\omega}^T\hat{\boldsymbol{\omega}}\mathbf{q}\,\theta}_{\text{项2}} + \underbrace{(I - e^{\hat{\boldsymbol{\omega}}\theta})\hat{\boldsymbol{\omega}}\boldsymbol{\omega}h}_{\text{项3} = 0} + \underbrace{\boldsymbol{\omega}\boldsymbol{\omega}^T\boldsymbol{\omega}h\theta}_{\text{项4}}$$

**项1 的处理**（利用 Lemma 2.3, p.28：$\hat{\boldsymbol{\omega}}^2 = \boldsymbol{\omega}\boldsymbol{\omega}^T - I$）：

$$
\begin{aligned}
-(I - e^{\hat{\boldsymbol{\omega}}\theta})\hat{\boldsymbol{\omega}}^2\mathbf{q}
&= -(I - e^{\hat{\boldsymbol{\omega}}\theta})(\boldsymbol{\omega}\boldsymbol{\omega}^T - I)\mathbf{q} \\
&= (I - e^{\hat{\boldsymbol{\omega}}\theta})\mathbf{q} - (I - e^{\hat{\boldsymbol{\omega}}\theta})\boldsymbol{\omega}\boldsymbol{\omega}^T\mathbf{q} \\
&= (I - e^{\hat{\boldsymbol{\omega}}\theta})\mathbf{q} - (\boldsymbol{\omega}\boldsymbol{\omega}^T - e^{\hat{\boldsymbol{\omega}}\theta}\boldsymbol{\omega}\boldsymbol{\omega}^T)\mathbf{q} \\
&= (I - e^{\hat{\boldsymbol{\omega}}\theta})\mathbf{q} - (\boldsymbol{\omega}\boldsymbol{\omega}^T - \boldsymbol{\omega}\boldsymbol{\omega}^T)\mathbf{q} \quad (\text{因 } e^{\hat{\boldsymbol{\omega}}\theta}\boldsymbol{\omega} = \boldsymbol{\omega}) \\
&= (I - e^{\hat{\boldsymbol{\omega}}\theta})\mathbf{q}
\end{aligned}
$$

这里用到了关键性质：**旋转轴 $\boldsymbol{\omega}$ 被自身的旋转矩阵保持不变**，即 $e^{\hat{\boldsymbol{\omega}}\theta}\boldsymbol{\omega} = \boldsymbol{\omega}$。（这也是 Euler 定理的直接推论。）

**项3**：$\hat{\boldsymbol{\omega}}\boldsymbol{\omega} = \boldsymbol{\omega} \times \boldsymbol{\omega} = \mathbf{0}$，故该项为零。

**项2 + 项4 的合并**（利用 $\hat{\boldsymbol{\omega}}^2\boldsymbol{\omega} = \hat{\boldsymbol{\omega}}(\boldsymbol{\omega} \times \boldsymbol{\omega}) = \mathbf{0}$ 和 $\hat{\boldsymbol{\omega}}^3 = -\hat{\boldsymbol{\omega}}$）：

$$\boldsymbol{\omega}\boldsymbol{\omega}^T\boldsymbol{\omega}h\theta - \boldsymbol{\omega}\boldsymbol{\omega}^T\hat{\boldsymbol{\omega}}\mathbf{q}\theta = (\hat{\boldsymbol{\omega}}^2 + I)\boldsymbol{\omega}h\theta - (\hat{\boldsymbol{\omega}}^2 + I)\hat{\boldsymbol{\omega}}\mathbf{q}\theta = \boldsymbol{\omega}h\theta - (\hat{\boldsymbol{\omega}}^3 + \hat{\boldsymbol{\omega}})\mathbf{q}\theta = \boldsymbol{\omega}h\theta$$

最终结果：

$$\beta = (I - e^{\hat{\boldsymbol{\omega}}\theta})\mathbf{q} + \boldsymbol{\omega}h\theta$$

这正是 (2.40) 的右上角 $3\times 1$ 子块。**证毕。** ✓

> ✅ 这一等价性建立了**代数描述（旋量）** 与**几何描述（螺旋）** 之间的完全对应。

---

### 3.3.6 旋转轴被旋转后不变

Euler 定理指出：任何姿态 $R \in SO(3)$ 等效于绕固定轴 $\boldsymbol{\omega}$ 旋转角度 $\theta \in [0, 2\pi)$（MLS p.31）。

一个重要性质：

$$\boxed{\boldsymbol{\omega} = e^{\hat{\boldsymbol{\omega}}\theta}\,\boldsymbol{\omega}}$$

即旋转轴在自身的旋转下保持不变。这可以通过 MATLAB 实验验证（见 `rot of axis.pdf`）。

---

## 从旋量到螺旋：纯旋转 vs 纯平移

| 属性 | 含旋转 | 纯平移 |
|------|--------|--------|
| 条件 | $\|\boldsymbol{\omega}\| = 1$ | $\|\boldsymbol{\omega}\| = 0$ |
| $\mathbf{v}$ | $\mathbf{v} = -\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega}$ | $\|\mathbf{v}\| = 1$ |
| 轴 $l$ 的方向 | 沿 $\boldsymbol{\omega}$ | 沿 $\mathbf{d}$ 或 $\mathbf{v}$ |
| 幅值 $M$ | $M = \theta$（旋转角，rad） | $M = \theta = \|\mathbf{d}\|$ |
| 位移 $\mathbf{d}$ | $\mathbf{d} = h\theta\,\boldsymbol{\omega}$ | $\mathbf{d} = M\mathbf{v}$ |
| 螺距 $h$ | 有限值 | $h = \infty$ |
| 变换矩阵 | (2.40) | $g = \begin{bmatrix} I & \theta\mathbf{v} \\ \mathbf{0} & 1 \end{bmatrix} = e^{\hat{\xi}\theta}$，$\xi = (v, 0)$ |

---

## 反向关系：从旋量到螺旋

我们已经证明任何螺旋都可以表示为旋量。现在证明**反向也成立**：任何旋量 $\hat{\xi} \in \mathfrak{se}(3)$（坐标为 $\xi = (v, \omega) \in \mathbb{R}^6$）都对应一个螺旋。**此处不假设 $\|\boldsymbol{\omega}\| = 1$**。

### 螺旋三要素的提取

给定 $\xi = (v, \omega)$：

**1. 螺距 (Pitch)**：

$$\boxed{h = \frac{\boldsymbol{\omega}^T\mathbf{v}}{\|\boldsymbol{\omega}\|^2}} \tag{2.42}$$

**2. 轴 (Axis)**：

$$\boxed{l = \begin{cases}
\left\{ \dfrac{\hat{\boldsymbol{\omega}}\mathbf{v}}{\|\boldsymbol{\omega}\|^2} + \lambda\boldsymbol{\omega} : \lambda \in \mathbb{R} \right\}, & \text{if } \boldsymbol{\omega} \neq \mathbf{0} \\[12pt]
\left\{ \mathbf{0} + \lambda\mathbf{v} : \lambda \in \mathbb{R} \right\}, & \text{if } \boldsymbol{\omega} = \mathbf{0}
\end{cases}} \tag{2.43}$$

**3. 幅值 (Magnitude)**（与 MLS (2.44) 略有不同）：

$$M = \begin{cases}
\theta, & \text{if } \boldsymbol{\omega} \neq \mathbf{0} \\
\|\mathbf{d}\|, & \text{if } \boldsymbol{\omega} = \mathbf{0}
\end{cases}$$

分别指示净旋转量（$\boldsymbol{\omega} \neq 0$）或净平移量（$\boldsymbol{\omega} = 0$）。

---

### 3.3.7 螺距公式的验证

若 $\mathbf{v} = -\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega}$，则：

$$
\begin{aligned}
\boldsymbol{\omega}^T\mathbf{v}
&= -\boldsymbol{\omega}^T\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega}^T\boldsymbol{\omega} \\
&= \boldsymbol{\omega}^T\hat{\boldsymbol{\omega}}^T\mathbf{q} + h\|\boldsymbol{\omega}\|^2 \quad (\text{因 } \hat{\boldsymbol{\omega}}^T = -\hat{\boldsymbol{\omega}}) \\
&= (\hat{\boldsymbol{\omega}}\boldsymbol{\omega})^T\mathbf{q} + h\|\boldsymbol{\omega}\|^2 \\
&= 0 + h\|\boldsymbol{\omega}\|^2 = h\|\boldsymbol{\omega}\|^2
\end{aligned}
$$

因此 $h = \dfrac{\boldsymbol{\omega}^T\mathbf{v}}{\|\boldsymbol{\omega}\|^2}$，与 (2.42) 一致。 ✓

---

### 3.3.8 轴的几何含义验证

我们需要确认：$\mathbf{q} = \dfrac{\hat{\boldsymbol{\omega}}\mathbf{v}}{\|\boldsymbol{\omega}\|^2}$ 确实是轴上一点，且 $\mathbf{v} = -\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega}$。

利用向量恒等式（对单位向量 $\hat{\boldsymbol{\omega}}$ 和任意向量 $\boldsymbol{\tau}$）：

$$\boxed{(\hat{\boldsymbol{\omega}}\boldsymbol{\tau}) \times \hat{\boldsymbol{\omega}} + (\hat{\boldsymbol{\omega}} \cdot \boldsymbol{\tau})\hat{\boldsymbol{\omega}} = \boldsymbol{\tau}}$$

或用分量形式：

$$(\hat{\boldsymbol{\omega}}\boldsymbol{\tau})^{\wedge}\boldsymbol{\omega} + (\boldsymbol{\omega}^T\boldsymbol{\tau})\boldsymbol{\omega} = \boldsymbol{\tau}$$

（见 MATLAB 验证文件 `ident4MLS Theor2 17.pdf`）

令 $\hat{\boldsymbol{\omega}} = \frac{\boldsymbol{\omega}}{\|\boldsymbol{\omega}\|}$（单位向量），验证：

设 $\mathbf{q} = \dfrac{\hat{\boldsymbol{\omega}}\mathbf{v}}{\|\boldsymbol{\omega}\|^2}$ 和 $h = \dfrac{\boldsymbol{\omega}^T\mathbf{v}}{\|\boldsymbol{\omega}\|^2}$，则：

$$
\begin{aligned}
-\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega}
&= \left(\frac{\hat{\boldsymbol{\omega}}\mathbf{v}}{\|\boldsymbol{\omega}\|^2}\right)^{\wedge}\boldsymbol{\omega} + \frac{\boldsymbol{\omega}^T\mathbf{v}}{\|\boldsymbol{\omega}\|^2}\boldsymbol{\omega} \\
&= -\frac{\hat{\boldsymbol{\omega}}\hat{\boldsymbol{\omega}}\mathbf{v}}{\|\boldsymbol{\omega}\|^2} + \frac{\boldsymbol{\omega}^T\mathbf{v}}{\|\boldsymbol{\omega}\|^2}\boldsymbol{\omega}
\end{aligned}
$$

利用 $\hat{\boldsymbol{\omega}} = \frac{\hat{\boldsymbol{\omega}}}{\|\boldsymbol{\omega}\|}$，代入并应用向量恒等式可得：

$$-\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega} = \mathbf{v}$$

**结论**：旋量 $\xi = (v, \omega)$（$\|\boldsymbol{\omega}\| \neq 1$）确实对应一个螺旋，参数为：

$$\mathbf{q} = \frac{\hat{\boldsymbol{\omega}}\mathbf{v}}{\|\boldsymbol{\omega}\|^2}, \quad h = \frac{\boldsymbol{\omega}^T\mathbf{v}}{\|\boldsymbol{\omega}\|^2}, \quad l = \frac{\hat{\boldsymbol{\omega}}\mathbf{v}}{\|\boldsymbol{\omega}\|^2} + \lambda\boldsymbol{\omega}$$

> ✅ 这确立了**螺旋与旋量之间的完全双向等价**。

---

## Chasles 定理

**定理 2.11 (Chasles)**：

> 🔑 **任何一个刚体运动都可以实现为绕某轴的旋转加上沿该轴的平移。**

换言之：**每个刚体运动都是一个螺旋运动。**

### 推论

每个刚体变换 $g_{ab} \in SE(3)$ 都可以表示为：

$$g_{ab} = \begin{bmatrix} R_{ab} & p_{ab} \\ \mathbf{0} & 1 \end{bmatrix}$$

由命题 2.9 (p.42)，存在旋量 $\xi = [v \;\; \omega]^T$ 使得 $g_{ab} = e^{\hat{\xi}\theta}$，其中 $v, \omega, \theta$ 可以由 $R_{ab}$ 和 $p_{ab}$ 确定。

> ⚠️ 当 $\|\boldsymbol{\omega}\| \neq 0$ 时，可能 $\|\boldsymbol{\omega}\| \neq 1$。已知 $\xi$ 后，对应的螺旋可通过 (2.42) 和 (2.43) 计算。

---

## 单位旋量 (Unit Twist)

（MLS 第一段 p.49）

**定义**：若旋量 $\xi$ 满足：
- 当 $\boldsymbol{\omega} \neq \mathbf{0}$ 时，$\|\boldsymbol{\omega}\| = 1$（或 $\theta$ 适当缩放使然）
- 当 $\boldsymbol{\omega} = \mathbf{0}$ 时，$\|\mathbf{v}\| = 1$

则称 $\xi$ 为**单位旋量**。

> ✅ 单位旋量的好处：$\theta$ 直接等于运动的大小 $M$（旋转角或平移距离），几何含义最清晰。

---

## 📊 公式速查表

| 概念 | 公式 | 编号 |
|------|------|------|
| 螺旋轴 | $l = \{\mathbf{q} + \lambda\boldsymbol{\omega} : \lambda \in \mathbb{R}\}$ | (2.39) |
| 螺旋变换矩阵 | $g = \begin{bmatrix} e^{\hat{\omega}\theta} & (I-e^{\hat{\omega}\theta})\mathbf{q}+h\boldsymbol{\omega}\theta \\ \mathbf{0} & 1 \end{bmatrix}$ | (2.40) |
| 纯平移旋量的指数 | $g = \begin{bmatrix} I & \theta\mathbf{v} \\ \mathbf{0} & 1 \end{bmatrix} = e^{\hat{\xi}\theta}, \xi=(v,0)$ | (2.41)/(2.32) |
| 螺距 | $h = \dfrac{\boldsymbol{\omega}^T\mathbf{v}}{\|\boldsymbol{\omega}\|^2}$ | (2.42) |
| 螺旋轴（从旋量） | $l = \frac{\hat{\boldsymbol{\omega}}\mathbf{v}}{\|\boldsymbol{\omega}\|^2} + \lambda\boldsymbol{\omega}$ (若 $\omega \neq 0$) | (2.43) |
| 旋量与螺旋的桥梁 | $\mathbf{v} = -\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega}$ | — |

---

## 🔗 与前后讲的联系

| 前置知识 | 本讲 | 后续应用 |
|----------|------|----------|
| §3.2 指数坐标、$\mathfrak{se}(3)$、Wedge/Vee | §3.3 螺旋的几何解释 | 正运动学中关节旋量的构建 |
| 命题 2.8（指数映射计算） | 命题 2.9（逆映射） | 操作臂 Jacobian 的几何推导 |
| Rodrigues 公式 (2.14) | Chasles 定理 (2.11) | 末端执行器速度分析 |

---

## 🔑 关键要点

1. **螺旋 = 旋量的几何"画像"**：每个旋量 $\xi = (v, \omega)$ 都对应一个螺旋（轴 + 螺距 + 幅值），反之亦然。
2. **Chasles 定理是机器人学的基础**：任何刚体运动 = 绕某轴的旋转 + 沿该轴的平移。这为用"关节旋量"描述操作臂奠定了理论基础。
3. **$\mathbf{v} = -\hat{\boldsymbol{\omega}}\mathbf{q} + h\boldsymbol{\omega}$ 是核心桥梁**：它将螺旋的几何参数 $(l, h)$ 与旋量的代数表示 $(v, \omega)$ 联系起来。
4. **螺距 $h = \frac{\boldsymbol{\omega}^T\mathbf{v}}{\|\boldsymbol{\omega}\|^2}$** 度量了旋转与平移的"混合程度"：$h=0$ 纯旋转，$h=\infty$ 纯平移。
5. **注意 $\|\boldsymbol{\omega}\| \neq 1$ 的情况**：在一般旋量中 $\omega$ 不一定是单位向量，需要缩放 $\theta$ 或归一化。
