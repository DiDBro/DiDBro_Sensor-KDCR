# MLS 例 2.6 详解 — 笔记

> **Source**: MLS_ex_2_6_selfgen.pdf (9 pages)
> **作者**: NJ Theron, April 2026
> **主题**: MLS Example 2.6 (p.60) 的 Python/Sympy 逐步推导 — 二连杆空间速度的计算

---

## 问题描述

二连杆操作臂（两个旋转关节），用 Sympy 验证 MLS 例 2.6 (p.60) 中空间速度的计算。

### 物理参数

| 符号 | 含义 |
|------|------|
| $l_0$ | 第一个连杆沿 z 轴的偏移 |
| $l_1$ | 第二关节相对于第一关节的 y 向偏移 |
| $\theta_1(t)$ | 关节 1 的转角（绕 $z$ 轴） |
| $\theta_2(t)$ | 关节 2 的转角（绕 $z$ 轴） |
| $\mathbf{u} = [0, 0, 1]^T$ | 两个关节的旋转轴方向（均为 z 轴） |

---

## 步骤 1：旋转矩阵

两个关节均绕 $z$ 轴旋转：

$$e^{\hat{\mathbf{u}}\theta_1} = \begin{bmatrix} \cos\theta_1 & -\sin\theta_1 & 0 \\ \sin\theta_1 & \cos\theta_1 & 0 \\ 0 & 0 & 1 \end{bmatrix}, \quad e^{\hat{\mathbf{u}}\theta_2} = \begin{bmatrix} \cos\theta_2 & -\sin\theta_2 & 0 \\ \sin\theta_2 & \cos\theta_2 & 0 \\ 0 & 0 & 1 \end{bmatrix}$$

使用 Rodrigues 公式 (2.14) 计算。

---

## 步骤 2：初始构型

- B 系原点在 A 系中的初始位置：$p_{ab}(0) = [0, 0, l_0]^T$
- C 系原点在 B 系中的初始位置：$p_{bc}(0) = [0, l_1, 0]^T$

**初始构型矩阵**（$\theta_1 = \theta_2 = 0$ 时旋转矩阵均为 $I$）：

$$g_{ab}(0) = \begin{bmatrix} 1 & 0 & 0 & 0 \\ 0 & 1 & 0 & 0 \\ 0 & 0 & 1 & l_0 \\ 0 & 0 & 0 & 1 \end{bmatrix}, \quad g_{bc}(0) = \begin{bmatrix} 1 & 0 & 0 & 0 \\ 0 & 1 & 0 & l_1 \\ 0 & 0 & 1 & 0 \\ 0 & 0 & 0 & 1 \end{bmatrix}$$

---

## 步骤 3：构建关节旋量

关节构型由指数映射给出（式 (2.45), p.49）：

$$g_{ab}(\theta_1) = e^{\hat{\xi}_1\theta_1}\,g_{ab}(0), \quad g_{bc}(\theta_2) = e^{\hat{\xi}_2\theta_2}\,g_{bc}(0)$$

对于**旋转关节**（$h = 0$）：

$$\mathbf{v}_1 = -\hat{\boldsymbol{\omega}}_1\mathbf{q}_1, \quad \mathbf{v}_2 = -\hat{\boldsymbol{\omega}}_2\mathbf{q}_2$$

- $\mathbf{q}_1 = [0, 0, 0]^T$：关节 1 轴上一点（在 A 系中）
- $\mathbf{q}_2 = [0, l_1, 0]^T$：关节 2 轴上一点（在 B 系中）
- $\boldsymbol{\omega}_1 = \boldsymbol{\omega}_2 = \mathbf{u} = [0, 0, 1]^T$

**计算**：

$$\mathbf{v}_1 = -\hat{\mathbf{u}}\,\mathbf{q}_1 = \begin{bmatrix} 0 \\ 0 \\ 0 \end{bmatrix}, \quad \mathbf{v}_2 = -\hat{\mathbf{u}}\,\mathbf{q}_2 = \begin{bmatrix} l_1 \\ 0 \\ 0 \end{bmatrix}$$

**关节旋量坐标**：

$$\boxed{\xi_1 = \begin{bmatrix} 0 \\ 0 \\ 0 \\ 0 \\ 0 \\ 1 \end{bmatrix}, \quad \xi_2 = \begin{bmatrix} l_1 \\ 0 \\ 0 \\ 0 \\ 0 \\ 1 \end{bmatrix}}$$

---

## 步骤 4：指数映射 $e^{\hat{\xi}\theta}$

对于 $h = 0$（旋转关节），利用 (2.36) 和 (2.40)，可以简化为：

$$\boxed{e^{\hat{\xi}\theta} = \begin{bmatrix} e^{\hat{\boldsymbol{\omega}}\theta} & (I - e^{\hat{\boldsymbol{\omega}}\theta})\mathbf{q} \\ \mathbf{0} & 1 \end{bmatrix}}$$

（推导见 March_16 讲义：当 $h = 0$ 时 $\omega\omega^T v\theta = 0$。）

**关节 1**（$\mathbf{q}_1 = [0,0,0]^T$）：

$$e^{\hat{\xi}_1\theta_1} = \begin{bmatrix} \cos\theta_1 & -\sin\theta_1 & 0 & 0 \\ \sin\theta_1 & \cos\theta_1 & 0 & 0 \\ 0 & 0 & 1 & 0 \\ 0 & 0 & 0 & 1 \end{bmatrix}$$

**关节 2**（$\mathbf{q}_2 = [0, l_1, 0]^T$）：

$$e^{\hat{\xi}_2\theta_2} = \begin{bmatrix} \cos\theta_2 & -\sin\theta_2 & 0 & l_1\sin\theta_2 \\ \sin\theta_2 & \cos\theta_2 & 0 & l_1(1 - \cos\theta_2) \\ 0 & 0 & 1 & 0 \\ 0 & 0 & 0 & 1 \end{bmatrix}$$

---

## 步骤 5：当前构型

$$g_{ab} = e^{\hat{\xi}_1\theta_1}g_{ab}(0) = \begin{bmatrix} \cos\theta_1 & -\sin\theta_1 & 0 & 0 \\ \sin\theta_1 & \cos\theta_1 & 0 & 0 \\ 0 & 0 & 1 & l_0 \\ 0 & 0 & 0 & 1 \end{bmatrix}$$

$$g_{bc} = e^{\hat{\xi}_2\theta_2}g_{bc}(0) = \begin{bmatrix} \cos\theta_2 & -\sin\theta_2 & 0 & 0 \\ \sin\theta_2 & \cos\theta_2 & 0 & l_1 \\ 0 & 0 & 1 & 0 \\ 0 & 0 & 0 & 1 \end{bmatrix}$$

---

## 步骤 6：计算空间速度

### 方法 1：直接求导 $V^s = (\dot{g}g^{-1})^{\vee}$

#### $V_{ab}^s$

$$\hat{V}_{ab}^s = \dot{g}_{ab}g_{ab}^{-1} = \begin{bmatrix} 0 & -\dot{\theta}_1 & 0 & 0 \\ \dot{\theta}_1 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{bmatrix}$$

取 vee：

$$\boxed{V_{ab}^s = \begin{bmatrix} 0 \\ 0 \\ 0 \\ 0 \\ 0 \\ \dot{\theta}_1 \end{bmatrix}}$$

#### $V_{bc}^s$

$$\hat{V}_{bc}^s = \dot{g}_{bc}g_{bc}^{-1} = \begin{bmatrix} 0 & -\dot{\theta}_2 & 0 & l_1\dot{\theta}_2 \\ \dot{\theta}_2 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{bmatrix}$$

取 vee：

$$\boxed{V_{bc}^s = \begin{bmatrix} l_1\dot{\theta}_2 \\ 0 \\ 0 \\ 0 \\ 0 \\ \dot{\theta}_2 \end{bmatrix}}$$

> 📖 $V_{bc}^s$ 是"空间"速度仅表示它在 B 系中表达，B 系被当作"空间系"——但 B 系并非惯性系！它相对于 A 系在运动。

### 方法 2（MLS p.58 暗示的方法）：用螺旋运动公式

对于螺旋运动：$\hat{V}^s = \hat{\xi}\,\dot{\theta}$

$$\hat{V}_{ab}^s = \hat{\xi}_1\dot{\theta}_1, \quad \hat{V}_{bc}^s = \hat{\xi}_2\dot{\theta}_2$$

验证（Sympy 输出 $4\times 4$ 零矩阵 ✓）。

---

## 步骤 7：计算 $V_{ac}^s$

### 方法 A：速度变换公式（命题 2.14）

$$\boxed{V_{ac}^s = V_{ab}^s + \mathrm{Ad}_{g_{ab}} V_{bc}^s}$$

先计算 $\mathrm{Ad}_{g_{ab}}$：

$$\mathrm{Ad}_{g_{ab}} = \begin{bmatrix} R_{ab} & \hat{p}_{ab}R_{ab} \\ \mathbf{0} & R_{ab} \end{bmatrix} = \begin{bmatrix} \cos\theta_1 & -\sin\theta_1 & 0 & -l_0\sin\theta_1 & -l_0\cos\theta_1 & 0 \\ \sin\theta_1 & \cos\theta_1 & 0 & l_0\cos\theta_1 & -l_0\sin\theta_1 & 0 \\ 0 & 0 & 1 & 0 & 0 & 0 \\ 0 & 0 & 0 & \cos\theta_1 & -\sin\theta_1 & 0 \\ 0 & 0 & 0 & \sin\theta_1 & \cos\theta_1 & 0 \\ 0 & 0 & 0 & 0 & 0 & 1 \end{bmatrix}$$

代入：

$$\boxed{V_{ac}^s = \begin{bmatrix} l_1\cos\theta_1\,\dot{\theta}_2 \\ l_1\sin\theta_1\,\dot{\theta}_2 \\ 0 \\ 0 \\ 0 \\ \dot{\theta}_1 + \dot{\theta}_2 \end{bmatrix}}$$

### 方法 B：直接求导 $\hat{V}_{ac}^s = \dot{g}_{ac}g_{ac}^{-1}$

由复合规则 $g_{ac} = g_{ab}g_{bc}$ (2.24)，计算 $\dot{g}_{ac}g_{ac}^{-1}$：

$$\hat{V}_{ac}^s = \begin{bmatrix} 0 & -(\dot{\theta}_1+\dot{\theta}_2) & 0 & l_1\cos\theta_1\,\dot{\theta}_2 \\ \dot{\theta}_1+\dot{\theta}_2 & 0 & 0 & l_1\sin\theta_1\,\dot{\theta}_2 \\ 0 & 0 & 0 & 0 \\ 0 & 0 & 0 & 0 \end{bmatrix}$$

取 vee，结果与方法 A 一致 ✓。

### 方法 C：命题 2.14 的 $\mathrm{Ad}_g$ 形式

$$V_{ac}^s = V_{ab}^s + \mathrm{Ad}_{g_{ab}} V_{bc}^s$$

结果相同 ✓。

---

## 📊 三种计算路径的对比

| 方法 | 公式 | 适用场景 |
|------|------|----------|
| 直接求导 | $V^s = (\dot{g}g^{-1})^{\vee}$ | 通用，但有 $g$ 的显式时 |
| 螺旋运动 | $V^s = \xi\,\dot{\theta}$ | 当构型按 $e^{\hat{\xi}\theta}g(0)$ 演化时 |
| 速度变换 | $V_{ac}^s = V_{ab}^s + \mathrm{Ad}_{g_{ab}}V_{bc}^s$ | 链式多体系统的最实用方法 |

---

## 📊 关键结果汇总

| 量 | 表达式 |
|----|--------|
| $\xi_1$ | $[0, 0, 0, 0, 0, 1]^T$ |
| $\xi_2$ | $[l_1, 0, 0, 0, 0, 1]^T$ |
| $V_{ab}^s$ | $[0, 0, 0, 0, 0, \dot{\theta}_1]^T$ |
| $V_{bc}^s$ | $[l_1\dot{\theta}_2, 0, 0, 0, 0, \dot{\theta}_2]^T$ |
| $V_{ac}^s$ | $[l_1\cos\theta_1\,\dot{\theta}_2,\; l_1\sin\theta_1\,\dot{\theta}_2,\; 0,\; 0,\; 0,\; \dot{\theta}_1 + \dot{\theta}_2]^T$ |

---

## 🔑 关键要点

1. **旋转关节的简化指数映射**：当 $h = 0$，$e^{\hat{\xi}\theta} = \begin{bmatrix} e^{\hat{\omega}\theta} & (I - e^{\hat{\omega}\theta})\mathbf{q} \\ \mathbf{0} & 1 \end{bmatrix}$，比 (2.36) 更简洁。
2. **$\mathbf{v} = -\hat{\boldsymbol{\omega}}\mathbf{q}$ 是关键**：对于旋转关节，$\mathbf{v}$ 不一定是零——取决于 $\mathbf{q}$ 的选择（轴上任意点）。
3. **"空间"是相对的**：$V_{bc}^s$ 是"空间"速度但以 B 为参考——B 不是惯性系！用命题 2.14 变换到 A 系才是真正的空间速度。
4. **命题 2.14 是链式系统的核心**：$V_{ac}^s = V_{ab}^s + \mathrm{Ad}_{g_{ab}}V_{bc}^s$ 提供了计算多体系统末端速度的递推公式——这是后续 Jacobian 的基础。
5. **三种方法等价，各有适用场景**：螺旋公式最快（关节速度直接乘 $\xi$），变换公式最有结构（适合编程），直接求导最通用但计算量大。
