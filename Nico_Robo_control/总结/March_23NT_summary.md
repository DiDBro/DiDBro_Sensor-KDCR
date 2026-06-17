# 第3讲：刚体速度 — 笔记

> **Source**: March_23NT.pdf (11 pages)
> **Textbook**: MLS Chapter 2, §§4.1–4.4
> **主题**: 旋转速度、空间速度与物体速度、伴随变换、速度的坐标变换

---

## §4.1 旋转速度 (Rotational Velocity)

### 问题设定

考虑刚体带有固连坐标系 B，其原点与惯性系 A 的原点重合，**只旋转不平移**。点 $q$ 在 B 系中坐标为 $\mathbf{q}_b$（不随时间变化），在 A 系中坐标为 $\mathbf{q}_a(t) = R_{ab}(t) \mathbf{q}_b$。

对时间求导：

$$\mathbf{v}_{\mathbf{q}_a}(t) = \frac{d}{dt}\mathbf{q}_a(t) = \dot{R}_{ab}(t)\,\mathbf{q}_b \tag{2.46}$$

将 $\mathbf{q}_b = R_{ab}^{-1}\mathbf{q}_a$ 代入：

$$\mathbf{v}_{\mathbf{q}_a}(t) = \dot{R}_{ab}(t) R_{ab}^{-1}(t)\,\mathbf{q}_a(t) \tag{2.47}$$

> 📖 **Lemma 2.12** (p.51)：给定 $R(t) \in SO(3)$，$\dot{R}(t)R^{-1}(t)$ 和 $R^{-1}(t)\dot{R}(t)$ 都是**反对称矩阵**，属于 $\mathfrak{so}(3)$。

---

### 空间角速度

**瞬时空间角速度** $\boldsymbol{\omega}_{ab}^s \in \mathbb{R}^3$：

$$\boxed{\hat{\boldsymbol{\omega}}_{ab}^s = \dot{R}_{ab}R_{ab}^{-1}} \tag{2.48}$$

> 📖 在**惯性系 A** 中观察到的刚体角速度。

点 $q$ 在 A 系中的速度：

$$\mathbf{v}_{\mathbf{q}_a}(t) = \hat{\boldsymbol{\omega}}_{ab}^s(t)\,\mathbf{q}_a(t) \tag{2.51}$$

即 $\vec{v}_q = \vec{\omega} \times \vec{q}$。

### 物体角速度

**瞬时物体角速度** $\boldsymbol{\omega}_{ab}^b \in \mathbb{R}^3$：

$$\boxed{\hat{\boldsymbol{\omega}}_{ab}^b = R_{ab}^{-1}\dot{R}_{ab}} \tag{2.49}$$

> 📖 在**体坐标系 B** 中观察到的刚体角速度，相当于"坐在刚体上感受到的旋转"。

空间与物体角速度的关系：

$$\boxed{\hat{\boldsymbol{\omega}}_{ab}^b = R_{ab}^{-1}\,\hat{\boldsymbol{\omega}}_{ab}^s\,R_{ab} \quad\text{或}\quad \boldsymbol{\omega}_{ab}^b = R_{ab}^{-1}\,\boldsymbol{\omega}_{ab}^s} \tag{2.50}$$

点 $q$ 在 B 系中的速度（但表示为 B 系中的分量）：

$$\mathbf{v}_{\mathbf{q}_b}(t) = \hat{\boldsymbol{\omega}}_{ab}^b(t)\,\mathbf{q}_b \tag{2.52}$$

---

## §4.2 刚体速度 (Rigid Body Velocity)

现在考虑刚体做**一般运动**（既有旋转也有平移），其构型由单参数曲线 $g_{ab}(t) \in SE(3)$ 描述：

$$g_{ab}(t) = \begin{bmatrix} R_{ab}(t) & p_{ab}(t) \\ \mathbf{0} & 1 \end{bmatrix}$$

### 空间速度 (Spatial Velocity)

$$\boxed{\dot{g}_{ab}\,g_{ab}^{-1} = \hat{V}_{ab}^s}$$

这是一个旋量矩阵 $\in \mathfrak{se}(3)$，称为**空间速度**。其旋量坐标为：

$$\boxed{V_{ab}^s = \begin{bmatrix} \mathbf{v}_{ab}^s \\ \boldsymbol{\omega}_{ab}^s \end{bmatrix} = \begin{bmatrix} -\dot{R}_{ab}R_{ab}^T p_{ab} + \dot{p}_{ab} \\ (\dot{R}_{ab}R_{ab}^T)^{\vee} \end{bmatrix}} \tag{2.53}$$

> 📖 **物理分解**：
> - $\boldsymbol{\omega}_{ab}^s = (\dot{R}_{ab}R_{ab}^T)^{\vee}$：空间角速度（与纯旋转时一致）
> - $\mathbf{v}_{ab}^s = -\dot{R}_{ab}R_{ab}^T p_{ab} + \dot{p}_{ab}$：**不是简单的 $\dot{p}_{ab}$！** 包含了一个修正项 $-\hat{\omega}_{ab}^s p_{ab}$，实质上是"固定在 B 系原点处的假想点在 A 系中的速度"

### 齐次形式的速度关系

点 $q$ 在 A 系中的速度（齐次形式 $4\times 1$）：

$$\boxed{\mathbf{v}_{\mathbf{q}_a} = \hat{V}_{ab}^s\,\mathbf{q}_a} \quad\text{(齐次形式)} \tag{2.54}$$

展开为 $3\times 1$：

$$\mathbf{v}_{\mathbf{q}_a} = \hat{\boldsymbol{\omega}}_{ab}^s\,\mathbf{q}_a + \mathbf{v}_{ab}^s$$

---

### 物体速度 (Body Velocity)

$$\boxed{g_{ab}^{-1}\,\dot{g}_{ab} = \hat{V}_{ab}^b}$$

称为**物体速度**。其旋量坐标为：

$$\boxed{V_{ab}^b = \begin{bmatrix} \mathbf{v}_{ab}^b \\ \boldsymbol{\omega}_{ab}^b \end{bmatrix} = \begin{bmatrix} R_{ab}^T\,\dot{p}_{ab} \\ (R_{ab}^T\,\dot{R}_{ab})^{\vee} \end{bmatrix}} \tag{2.55}$$

> 📖 **物理分解**：
> - $\boldsymbol{\omega}_{ab}^b = (R_{ab}^T\dot{R}_{ab})^{\vee}$：物体角速度
> - $\mathbf{v}_{ab}^b = R_{ab}^T\dot{p}_{ab}$：B 系原点速度在 B 系分量中的表示

点 $q$ 在 B 系中的速度（齐次形式）：

$$\mathbf{v}_{\mathbf{q}_b} = \hat{V}_{ab}^b\,\mathbf{q}_b \quad\text{(齐次形式)} \tag{2.56}$$

展开为 $3\times 1$：

$$\mathbf{v}_{\mathbf{q}_b} = \hat{\boldsymbol{\omega}}_{ab}^b\,\mathbf{q}_b + \mathbf{v}_{ab}^b$$

---

### 伴随变换 (Adjoint Transformation)

**定义**（MLS (2.58), p.55）：

$$\boxed{\mathrm{Ad}_g = \begin{bmatrix} R & \hat{p}R \\ \mathbf{0} & R \end{bmatrix}} \tag{2.58}$$

其中 $g = (p, R) \in SE(3)$。$\mathrm{Ad}_g$ 是一个 $6 \times 6$ 矩阵。

**性质**：
- $\mathrm{Ad}_g^{-1} = \mathrm{Ad}_{g^{-1}}$（p.56 顶部）
- **Lemma 2.13** (p.56)：若 $\hat{\xi} \in \mathfrak{se}(3)$ 是一个旋量，则对任意 $g \in SE(3)$，$g\,\hat{\xi}\,g^{-1}$ 也是旋量，其旋量坐标为 $\mathrm{Ad}_g\,\xi \in \mathbb{R}^6$。

### 空间速度与物体速度的关系

$$\boxed{V^s = \mathrm{Ad}_g\,V^b} \tag{2.61}$$

> 📖 $V^s$ 和 $V^b$ 是**同一物理运动**在**不同观察视角**下的描述：$V^s$ 在惯性系中观察，$V^b$ 在体坐标系中观察。伴随变换 $\mathrm{Ad}_g$ 把它们联系起来。

---

## §4.3 螺旋运动的速度

对于由指数映射参数化的运动 $g_{ab}(\theta) = e^{\hat{\xi}\theta}\,g_{ab}(0)$（式 (2.45), p.49）：

**空间速度**：
$$\boxed{\hat{V}_{ab}^s = \hat{\xi}\,\dot{\theta}}$$

**物体速度**：
$$\boxed{\hat{V}_{ab}^b = \left(\mathrm{Ad}_{g_{ab}^{-1}(0)}\,\xi\right)^{\wedge}\,\dot{\theta}}$$

> 📖 当构型按照 $e^{\hat{\xi}\theta}$ 演化时，空间速度就是 $\hat{\xi}$ 乘以角速率 $\dot{\theta}$。物体速度则需要将 $\xi$ 用初始构型的逆伴随变换"拉回"到体坐标系。

---

## §4.4 速度的坐标变换

### 命题 2.14：空间速度的变换

考虑三个坐标系 A, B, C：

$$\boxed{V_{ac}^s = V_{ab}^s + \mathrm{Ad}_{g_{ab}}\,V_{bc}^s}$$

> 📖 **直觉**：C 相对于 A 的空间速度 = B 相对于 A 的空间速度 + （将 C 相对于 B 的空间速度从 B 系"搬运"到 A 系中表达）。

### 命题 2.15：物体速度的变换

$$\boxed{V_{ac}^b = \mathrm{Ad}_{g_{bc}^{-1}}\,V_{ab}^b + V_{bc}^b}$$

> 📖 C 相对于 A 的物体速度 = （将 B 相对于 A 的物体速度从 B 系"搬运"到 C 系）+ C 相对于 B 的物体速度。

### Lemma 2.16 (p.61)

$$\boxed{V_{ab}^b = -V_{ba}^s}$$

$$\boxed{V_{ab}^b = -\mathrm{Ad}_{g_{ba}}\,V_{ba}^b}$$

> 📖 速度的"反向"关系：从 B 看 A 的运动 = 从 A 看 B 的运动的负（经适当变换）。

---

## 📊 公式速查表

| 概念 | 公式 | 编号 |
|------|------|------|
| 空间角速度 | $\hat{\omega}_{ab}^s = \dot{R}_{ab}R_{ab}^{-1}$ | (2.48) |
| 物体角速度 | $\hat{\omega}_{ab}^b = R_{ab}^{-1}\dot{R}_{ab}$ | (2.49) |
| 角速度转换 | $\omega_{ab}^b = R_{ab}^{-1}\omega_{ab}^s$ | (2.50) |
| 点的速度 (空间) | $\mathbf{v}_{\mathbf{q}_a} = \hat{\omega}_{ab}^s\mathbf{q}_a$ | (2.51) |
| 点的速度 (物体) | $\mathbf{v}_{\mathbf{q}_b} = \hat{\omega}_{ab}^b\mathbf{q}_b$ | (2.52) |
| 空间速度 | $V_{ab}^s = \begin{bmatrix} -\dot{R}_{ab}R_{ab}^T p_{ab}+\dot{p}_{ab} \\ (\dot{R}_{ab}R_{ab}^T)^{\vee} \end{bmatrix}$ | (2.53) |
| 物体速度 | $V_{ab}^b = \begin{bmatrix} R_{ab}^T\dot{p}_{ab} \\ (R_{ab}^T\dot{R}_{ab})^{\vee} \end{bmatrix}$ | (2.55) |
| 伴随变换 | $\mathrm{Ad}_g = \begin{bmatrix} R & \hat{p}R \\ \mathbf{0} & R \end{bmatrix}$ | (2.58) |
| $V^s$ ↔ $V^b$ | $V^s = \mathrm{Ad}_g V^b$ | (2.61) |
| 空间速度变换 | $V_{ac}^s = V_{ab}^s + \mathrm{Ad}_{g_{ab}} V_{bc}^s$ | Prop 2.14 |
| 物体速度变换 | $V_{ac}^b = \mathrm{Ad}_{g_{bc}^{-1}} V_{ab}^b + V_{bc}^b$ | Prop 2.15 |
| 速度反向 | $V_{ab}^b = -V_{ba}^s$ | Lemma 2.16 |

---

## 🔑 关键要点

1. **空间 vs 物体视角**：$V^s$ 是从惯性系看刚体的速度，$V^b$ 是从刚体自身看的速度。物理上是同一运动，数学上通过 $\mathrm{Ad}_g$ 关联。
2. **$\dot{g}g^{-1}$ vs $g^{-1}\dot{g}$**：对偶关系——前者给出空间速度，后者给出物体速度。这是 $SE(3)$ 上左不变 vs 右不变向量场的区别。
3. **伴随变换 $\mathrm{Ad}_g$ 是核心桥梁**：它将速度从一个坐标系"运输"到另一个坐标系，在后继的 Jacobian 推导和动力学中反复出现。
4. **速度变换满足叠加原理**：命题 2.14/2.15 给出了链式坐标系之间速度的加法规则——类似于"相对速度的加法"。
5. **螺旋运动的速度特别简单**：若运动由 $\xi$ 生成，$V^s = \xi\,\dot{\theta}$——空间速度直接就是归一化旋量乘以关节速率。
