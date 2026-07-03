# +robo 函数库完整指南

> 基于 MLS (*A Mathematical Introduction to Robotic Manipulation*) 的 MATLAB 机器人学工具箱，
> 涵盖李群 SE(3)/SO(3) 的全部基础运算，从运动学到动力学，从 wrench 到控制。

---

## 目录

1. [概述与依赖关系](#概述与依赖关系)
2. [第一部分：基本李代数运算](#第一部分基本李代数运算)
3. [第二部分：SO(3) 旋转运算](#第二部分so3-旋转运算)
4. [第三部分：SE(3) 刚体运动](#第三部分se3-刚体运动)
5. [第四部分：雅可比](#第四部分雅可比)
6. [第五部分：Paden-Kahan 逆运动学子问题](#第五部分paden-kahan-逆运动学子问题)
7. [第六部分：旋转辅助函数](#第六部分旋转辅助函数)
8. [第七部分：力旋量与力变换](#第七部分力旋量与力变换) ← **NEW**
9. [第八部分：单刚体动力学](#第八部分单刚体动力学) ← **NEW**
10. [第九部分：关节空间动力学](#第九部分关节空间动力学) ← **NEW**
11. [第十部分：控制](#第十部分控制) ← **NEW**
12. [函数调用关系图](#函数调用关系图)
13. [典型使用流程](#典型使用流程)

---

## 概述与依赖关系

`+robo` 是一个 MATLAB **package**。所有函数需通过 `robo.xxx()` 调用，或在文件内用 `import robo.*` 后直接调用。

### 数学背景速览

| 符号 | 含义 |
|------|------|
| $\mathfrak{so}(3)$ | 3×3 反对称矩阵空间（李代数） |
| $\mathfrak{se}(3)$ | 4×4 twist 矩阵空间（李代数） |
| $SO(3)$ | 3×3 旋转矩阵群 |
| $SE(3)$ | 4×4 齐次变换矩阵群 |
| $\hat{\omega}$ | 反对称矩阵 (hat map / wedge) |
| $(\cdot)^\vee$ | 反对称矩阵 → 向量 (vee) |
| $\xi = [v;\, \omega]$ | 6×1 twist 坐标（运动旋量） |
| $F = [f;\, \tau]$ | 6×1 wrench 坐标（力旋量） |
| $Ad_g$ | 6×6 twist 伴随变换 |
| $Ad_g^{-T}$ | 6×6 wrench 伴随变换 (co-adjoint) |
| $ad_\xi$ | 6×6 李括号伴随矩阵 |

### Twist 与 Wrench 的对偶性

```
        运动学 (Kinematics)              力 (Statics/Dynamics)
        ─────────────────────           ──────────────────────
        Twist:  ξ = [v; ω]              Wrench: F = [f; τ]
        V_a = Ad_{g_ab} · V_b           F_a = Ad_{g_ab}^{-T} · F_b
        V = J · θ̇                        τ = J^T · F
```

### 完整函数速查表

| 函数 | 输入 → 输出 | 一句话 | 类别 |
|------|------------|--------|------|
| `hatm` | ω(3×1) → ω̂(3×3) | 构建反对称矩阵 | 李代数 |
| `vee_so3` | ω̂(3×3) → ω(3×1) | so(3) vee 算子 | 李代数 |
| `vee` | ξ̂(4×4) → ξ(6×1) | se(3) vee 算子 | 李代数 |
| `wedge` | ξ(6×1) → ξ̂(4×4) | se(3) wedge 算子 | 李代数 |
| `twist` | ω, v → ξ̂(4×4) | 构建 se(3) 矩阵 | 李代数 |
| `rodrigues` | ω, θ → R(3×3) | 旋转向量 → 旋转矩阵 | SO(3) |
| `iRodrigues` | R(3×3) → ω, θ | 旋转矩阵 → 旋转向量 | SO(3) |
| `gmat` | R, p → g(4×4) | 构建齐次变换 | SE(3) |
| `gtwist` | ξ, θ → g(4×4) | twist 指数映射 e^{ξ̂θ} | SE(3) |
| `G2twist` | g(4×4) → ξ, θ | 齐次变换 → twist（对数映射） | SE(3) |
| `adjoint` | g(4×4) → Ad_g(6×6) | twist 伴随变换 | SE(3) |
| `coadjoint` | g(4×4) → Ad_g^{-T}(6×6) | **wrench 伴随变换** | Wrench |
| `pitch` | ω, v → h | 螺旋节距 | SE(3) |
| `ad` | ξ(6×1) → ad_ξ(6×6) | **李括号伴随矩阵** | 李代数 |
| `jacobian` | ξ_i, θ_i, g_st0 → J_s, J_b | 空间/体雅可比 | 运动学 |
| `Rx/Ry/Rz` | θ → R(3×3) | 绕坐标轴旋转 | SO(3) |
| `PK1` | ξ, p, q → θ | 单轴旋转使点重合 | IK |
| `PK2` | ξ₁, ξ₂, p, q → θ₁, θ₂ | 双轴旋转使点重合 | IK |
| `PK3` | ξ, p, q, δ → θ | 旋转使距离等于给定值 | IK |
| `newtonEuler` | I, ω, α → τ | **刚体 Newton-Euler 方程** | 动力学 |
| `inertiaTransform` | M_b, g → M_s | **空间惯性矩阵变换** | 动力学 |
| `gravityWrench` | g, dir? → G(6×1) | **重力旋量构造** | 动力学 |
| `jointTorque` | J, F → τ | **力旋量 → 关节力矩 τ=JᵀF** | Wrench |
| `inertiaMatrix` | ξ, M_l, … → M, C, N | **关节空间动力学矩阵组装** | 动力学 |
| `inverseDynamics` | θ̈_d, θ̇, θ, … → τ | **逆动力学 τ=Mθ̈+Cθ̇+N** | 动力学 |
| `forwardDynamics` | τ, θ̇, θ, … → θ̈ | **正动力学 θ̈=M⁻¹(τ-Cθ̇-N)** | 动力学 |
| `computedTorque` | θ_d, θ, … → τ | **CTC 计算力矩控制** | 控制 |

---

## 第一部分：基本李代数运算

这些是最底层的工具函数，被其他所有函数调用。

### `hatm(omega)` — hat map (∧)

```
K = hatm(omega)
```

构建 3×3 反对称矩阵（so(3) 的 hat 算子）：

$$K = \hat{\omega} = \begin{bmatrix} 0 & -\omega_3 & \omega_2 \\ \omega_3 & 0 & -\omega_1 \\ -\omega_2 & \omega_1 & 0 \end{bmatrix}$$

**性质：** $\hat{\omega} \cdot v = \omega \times v$（叉积等价于反对称矩阵乘向量）

### `vee_so3(omega_hat)` — so(3) vee 算子 (∨)

```
w = vee_so3(omega_hat)
```

从 3×3 反对称矩阵提取 3×1 向量：

$$(\hat{\omega})^\vee = \begin{bmatrix} \hat{\omega}_{3,2} \\ \hat{\omega}_{1,3} \\ \hat{\omega}_{2,1} \end{bmatrix} = \omega$$

### `vee(xi_wedge)` — se(3) vee 算子 (∨)

```
xi = vee(xi_wedge)
```

从 4×4 twist 矩阵提取 6×1 twist 坐标：

$$\begin{bmatrix} \hat{\omega} & v \\ 0 & 0 \end{bmatrix}^\vee = \begin{bmatrix} v \\ \omega \end{bmatrix}$$

### `wedge(xi)` — se(3) wedge 算子 (∧)

```
xi_wedge = wedge(xi)
```

从 6×1 twist 坐标构建 4×4 twist 矩阵：

$$\hat{\xi} = \begin{bmatrix} \hat{\omega} & v \\ 0_{1\times 4} \end{bmatrix}$$

### `twist(omega, v)` — 构建 se(3) 矩阵

```
zeta = twist(omega, v)
```

等价于 `wedge([v; omega])`。构建 4×4 的 twist 矩阵。

### `ad(xi)` — se(3) 李括号伴随矩阵 （NEW）

```
ad_xi = ad(xi)
```

从 6×1 twist $\xi = [v; \omega]$ 构建 6×6 李括号矩阵：

$$ad_\xi = \begin{bmatrix} \hat{\omega} & \hat{v} \\ 0 & \hat{\omega} \end{bmatrix}$$

**性质：**
- $ad_{\xi_1} \cdot \xi_2 = [\xi_1, \xi_2]$（李括号）
- $e^{ad_\xi \cdot \theta} = Ad_{e^{\hat{\xi}\theta}}$（与伴随的关系）
- **核心用途：** 计算科氏矩阵 $\partial M_{ij}/\partial \theta_k$ 时需要 $ad_\xi$

---

## 第二部分：SO(3) 旋转运算

### `rodrigues(omega, theta)` — Rodrigues 公式（指数映射）

$$R = e^{\hat{\omega}\theta} = I + \sin\theta \cdot \hat{\omega} + (1 - \cos\theta) \cdot \hat{\omega}^2$$

```
R = rodrigues(omega, theta)
```

### `iRodrigues(R)` — 逆 Rodrigues（对数映射）

```
[omega, theta] = iRodrigues(R)
```

$$R = e^{\hat{\omega}\theta} \quad\Rightarrow\quad \theta = \arccos\left(\frac{\mathrm{tr}(R)-1}{2}\right),\quad \hat{\omega} = \frac{R - R^T}{2\sin\theta}$$

| 情况 | 条件 | 处理 |
|------|------|------|
| $\theta \approx 0$ | $\theta < 10^{-6}$ | 返回 $\theta=0$，$\omega$ 任意 |
| $\theta \approx \pi$ | $|\theta - \pi| < 10^{-6}$ | 用 $(R-I)/2$ 提取 $\omega$ 分量并确认符号 |
| 一般情况 | 否则 | 标准公式 $\hat{\omega} = (R-R^T)/(2\sin\theta)$ |

---

## 第三部分：SE(3) 刚体运动

### `gmat(R, p)` — 构建齐次变换矩阵

```
g = gmat(R, p)
```

$$g = \begin{bmatrix} R & p \\ 0 & 1 \end{bmatrix} \in SE(3)$$

### `gtwist(xi, theta)` — twist 指数映射 $e^{\hat{\xi}\theta}$

```
g = gtwist(xi, theta)
```

$$e^{\hat{\xi}\theta} = \begin{bmatrix} e^{\hat{\omega}\theta} & (I - e^{\hat{\omega}\theta})\hat{\omega}v + \omega\omega^T v\theta \\ 0 & 1 \end{bmatrix}$$

| 情况 | 平移部分 |
|------|---------|
| $\|\omega\| \approx 0$（纯平移） | $p = v \cdot \theta$ |
| 一般情况 | $p = (I-R)\hat{\omega}v + \omega\omega^T v \theta$ |

**这是 POE 正运动学的核心：** 单关节变换 $g_i(\theta_i) = e^{\hat{\xi}_i \theta_i}$。

### `G2twist(G)` — 从齐次矩阵反解 twist（对数映射）

```
[xi, theta] = G2twist(G)
```

**两步求解：**
1. **旋转部分：** 用 `iRodrigues(R)` 提取 $\omega, \theta$
2. **平移部分：** 反解 $A \cdot v = p$，其中 $A = (I - R)\hat{\omega} + \omega\omega^T\theta$

### `adjoint(g)` — twist 伴随变换 $Ad_g$

```
Ad_g = adjoint(g)
```

$$V_a = Ad_{g_{ab}} \cdot V_b, \qquad Ad_g = \begin{bmatrix} R & \hat{p}R \\ 0 & R \end{bmatrix} \in \mathbb{R}^{6\times 6}$$

### `pitch(omega, v)` — 螺旋节距

```
h = pitch(omega, v)
```

$$h = \frac{\omega^T v}{\|\omega\|^2}$$

- $h = 0$ → 纯旋转（转动关节）
- $h = \infty$ → 纯平移（移动关节）

---

## 第四部分：雅可比

### `jacobian(xis, thetas, gst0)` — 空间雅可比与体雅可比

```
[Js, Jb] = jacobian(xis, thetas, gst0)
```

$$J_s = \begin{bmatrix} \xi_1' & \xi_2' & \cdots & \xi_n' \end{bmatrix}, \quad \xi_i' = Ad_{g_{s,i-1}} \cdot \xi_i$$

$$J_b = Ad_{g_{st}^{-1}} \cdot J_s$$

- **$J_s$：** 将关节速度 → **空间坐标系**末端速度
- **$J_b$：** 将关节速度 → **末端体坐标系**末端速度

---

## 第五部分：Paden-Kahan 逆运动学子问题

### `PK1(xi, p, q, tol)` — 子问题 1：绕单轴旋转

**问题：** 求解 $\theta$ 满足 $e^{\hat{\xi}\theta} \cdot p = q$

```
theta = PK1(xi, p, q, tol)
```

**约束检查：**
1. $\|u_\perp\| \approx \|v_\perp\|$（到轴距离相等）
2. $\omega^T(p-r) = \omega^T(q-r)$（沿轴投影相等）

约束不满足时返回 `[]` 并 `warning`。

### `PK2(xi1, xi2, p, q)` — 子问题 2：绕双轴旋转

**问题：** $e^{\hat{\xi}_1\theta_1} \cdot e^{\hat{\xi}_2\theta_2} \cdot p = q$

```
[theta1, theta2] = PK2(xi1, xi2, p, q)
```

**前提：** 两轴必须**相交且不平行**。返回两组解（±γ）。

### `PK3(xi, p, q, delta)` — 子问题 3：旋转到指定距离

**问题：** $\|q - e^{\hat{\xi}\theta} \cdot p\| = \delta$

```
theta = PK3(xi, p, q, delta)
```

返回 2×1 列向量 $[\theta_0 + \phi;\, \theta_0 - \phi]$。

---

## 第六部分：旋转辅助函数

| 函数 | 公式 | 用途 |
|------|------|------|
| `Rx(theta)` | $R_x(\theta)$ | 绕 x 轴旋转 |
| `Ry(theta)` | $R_y(\theta)$ | 绕 y 轴旋转 |
| `Rz(theta)` | $R_z(\theta)$ | 绕 z 轴旋转 |

---

## 第七部分：力旋量与力变换 （NEW）

本部分函数实现 wrench（力旋量）的表示与坐标变换。与 twist 变换形成对偶关系。

### `coadjoint(g)` — 力旋量伴随变换 $Ad_g^{-T}$

```
Ad_invT = coadjoint(g)
```

将力旋量从 B 系变换到 A 系（MLS eq. 2.67）：

$$F_a = Ad_{g_{ab}}^{-T} \cdot F_b$$

其中 $F = [f; \tau]$，$f$ 为力，$\tau$ 为力矩。

$$Ad_g^{-T} = \begin{bmatrix} R & 0 \\ \hat{p}R & R \end{bmatrix}$$

**与 twist 伴随的对比：**

| | Twist 变换 | Wrench 变换 |
|---|---|---|
| 矩阵 | $Ad_g = \begin{bmatrix} R & \hat{p}R \\ 0 & R \end{bmatrix}$ | $Ad_g^{-T} = \begin{bmatrix} R & 0 \\ \hat{p}R & R \end{bmatrix}$ |
| 变换方向 | $V_a = Ad_{g_{ab}} \cdot V_b$ | $F_a = Ad_{g_{ab}}^{-T} \cdot F_b$ |
| 物理意义 | 速度/角速度变换 | 力/力矩变换（满足功率不变） |

**功率不变性：** $F^T \cdot V = (Ad_g^{-T}F)^T \cdot (Ad_g \cdot V)$

---

### `jointTorque(J, F, type)` — 力旋量 → 关节力矩

```
tau = jointTorque(J, F)           % 默认空间形式
tau = jointTorque(J, F, 'body')   % 体力旋量形式
```

**核心公式（MLS §3.4, eq. 3.59）：**

$$\tau = J^T \cdot F$$

具体而言：
- $\tau = J_s^T \cdot F_s$（空间雅可比 + 空间力旋量）
- $\tau = J_b^T \cdot F_b$（体雅可比 + 体力旋量）

两种形式给出相同的 $\tau$（因 $F_s = Ad_g^{-T} \cdot F_b$ 且 $J_b = Ad_{g}^{-1} \cdot J_s$）。

**物理意义：** 末端施加的力/力矩通过雅可比的转置**反射**到各关节。

---

## 第八部分：单刚体动力学 （NEW）

### `newtonEuler(I, omega, alpha, g_wrench)` — Newton-Euler 方程

```
[tau, tau_euler, tau_gyro] = newtonEuler(I, omega, alpha)
[tau, tau_euler, tau_gyro] = newtonEuler(I, omega, alpha, g_wrench)
```

**刚体动力学核心公式：**

**纯旋转 (3×3 转动惯量)：**

$$\tau = I \cdot \alpha + \omega \times (I \cdot \omega)$$

- $\tau_{euler} = I \cdot \alpha$（欧拉项：角加速引起的力矩）
- $\tau_{gyro} = \omega \times (I \cdot \omega)$（陀螺项：角速度方向变化引起的力矩）

**完整 6×6 空间惯性矩阵形式：**

$$F = I \cdot \dot{V} - ad_V^T \cdot I \cdot V$$

**典型例题 (Homework 6)：** 飞机螺旋桨的陀螺力矩分析。

```matlab
% 两叶螺旋桨: I = diag([I, I, 0])，绕 y 轴自转 + 绕 z 轴进动
omega = [0; omega_s; 0] + R_y(-theta)' * [0; 0; omega_p];
alpha = -hatm([0; omega_s; 0]) * R_y(-theta)' * [0; 0; omega_p];
tau   = I * alpha + hatm(omega) * I * omega;
```

---

### `inertiaTransform(M_b, g)` — 空间惯性矩阵变换

```
M_s = inertiaTransform(M_b, g)
```

**变换公式 (MLS §4.3 eq. 4.14)：**

$$M_s = Ad_g^{-T} \cdot M_b \cdot Ad_g^{-1}$$

**6×6 广义惯性矩阵结构 (body frame)：**

$$M_b = \begin{bmatrix} m \cdot I_3 & m \cdot \hat{c}^T \\ m \cdot \hat{c} & I_b \end{bmatrix}$$

其中 $m$ = 质量，$c$ = 质心在 body frame 中的位置，$I_b$ = 绕质心的转动惯量。

**物理意义：** 将惯量从连杆自身坐标系变换到空间坐标系（平行轴定理的 6D 推广）。

---

### `gravityWrench(g, g_dir, g_mag)` — 重力旋量

```
G = gravityWrench(eye(4))                    % 空间坐标系, 默认 g=[0;0;-9.81]
G = gravityWrench(g_tool, [0;0;-1], 9.81)   % 指定方向和大小
```

**空间坐标系中的重力旋量（恒定向下的纯力）：**

$$G_0 = \begin{bmatrix} m \cdot g_{dir} \cdot g_{mag} \\ 0_{3\times 1} \end{bmatrix}$$

重力是纯力，无力矩（力作用线通过质心时不产生力矩）。

---

## 第九部分：关节空间动力学 （NEW）

### `inertiaMatrix(xi, calMp, lM, beta, theta, thetad)` — 组装 M, C, N

```
[M, C, N] = inertiaMatrix(xi, calMp, lM, beta, theta, thetad)
```

这是动力学计算的核心引擎。一次性组装全部三个动力学矩阵：

**1. 惯性矩阵 M (n×n, 正定对称)**

$$M_{ij} = \sum_{l=\max(i,j)}^n \xi_i^T \cdot A_{l,i}^T \cdot M_l \cdot A_{l,j} \cdot \xi_j$$

其中 $A_{l,i} = Ad_{g_{i,l}}^{-1}$ 将 twist 从关节 i 变换到连杆 l 的坐标系。

**2. 科氏/离心力矩阵 C (n×n)**

$$C_{ij} = \sum_{k=1}^n \Gamma_{ijk} \cdot \dot{\theta}_k$$

$$\Gamma_{ijk} = \frac{1}{2}\left(\frac{\partial M_{ij}}{\partial \theta_k} + \frac{\partial M_{ik}}{\partial \theta_j} - \frac{\partial M_{kj}}{\partial \theta_i}\right)$$

$\Gamma_{ijk}$ 为 Christoffel 符号。该构造方式保证 $\dot{M} - 2C$ 为反对称矩阵（能量守恒）。

**3. 重力/摩擦项 N (n×1)**

$$N_i = -\frac{\partial V}{\partial \theta_i} + \beta_i \cdot \dot{\theta}_i$$

其中势能力梯度：
$$\frac{\partial V}{\partial \theta_i} = \sum_{l=i}^n \xi_i^T \cdot (Ad_{g_{0l}}^{-1})^T \cdot M_l \cdot G_0$$

---

### `inverseDynamics(thetadd, thetad, theta, xi, calMp, lM, beta)` — 逆动力学

```
tau = inverseDynamics(thetadd, thetad, theta, xi, calMp, lM, beta)
```

**计算给定运动所需的关节力矩（Feedforward）：**

$$\tau = M(\theta) \cdot \ddot{\theta} + C(\theta, \dot{\theta}) \cdot \dot{\theta} + N(\theta, \dot{\theta})$$

**用途：**
- 前馈控制中的力矩计算
- 轨迹规划中的力矩可行性检查
- CTC 控制器中的模型部分

---

### `forwardDynamics(tau, thetad, theta, xi, calMp, lM, beta)` — 正动力学

```
thetadd = forwardDynamics(tau, thetad, theta, xi, calMp, lM, beta)
```

**给定关节力矩，计算关节加速度（Simulation）：**

$$\ddot{\theta} = M(\theta)^{-1} \cdot \big(\tau - C(\theta, \dot{\theta}) \cdot \dot{\theta} - N(\theta, \dot{\theta})\big)$$

**用途：**
- 动力学仿真（Simulink plant 模型）
- 前向积分 $\theta_{k+1} = \theta_k + \dot{\theta}_k \Delta t + \frac{1}{2}\ddot{\theta}_k \Delta t^2$

---

## 第十部分：控制 （NEW）

### `computedTorque(theta_d, thetad_d, thetadd_d, theta, thetad, xi, calMp, lM, beta, Kp, Kv)` — CTC

```
tau = computedTorque(theta_d, thetad_d, thetadd_d, theta, thetad, ...
                     xi, calMp, lM, beta, Kp, Kv)
```

**计算力矩控制律：**

$$\tau = M(\theta) \cdot \ddot{\theta}^* + C(\theta, \dot{\theta}) \cdot \dot{\theta} + N(\theta, \dot{\theta})$$

其中：
$$\ddot{\theta}^* = \ddot{\theta}_d + K_v \cdot (\dot{\theta}_d - \dot{\theta}) + K_p \cdot (\theta_d - \theta)$$

**控制结构：**
- **前馈项：** $M\ddot{\theta}_d + C\dot{\theta} + N$（模型的逆动力学）
- **反馈项：** $M(K_v \dot{e} + K_p e)$（PD 误差修正）

**误差动力学（模型精确时）：**

$$\ddot{e} + K_v \dot{e} + K_p e = 0$$

**增益设计（临界阻尼 $\zeta=1$）：**

$$K_p = \omega_n^2, \quad K_v = 2\omega_n$$

常用值：$\omega_n = 50 \Rightarrow K_p = 2500, K_v = 100$。

---

## 函数调用关系图

```
                              ┌─────────┐
                              │  hatm   │ ◄── 最底层，被几乎所有函数调用
                              └────┬────┘
                                   │
          ┌────────────────────────┼──────────────────────────┐
          ▼                        ▼                           ▼
    ┌──────────┐            ┌──────────┐                ┌──────────┐
    │  wedge   │            │ rodrigues│                │  twist   │
    └────┬─────┘            └────┬─────┘                └────┬─────┘
         │                       │                           │
     ┌───▼───┐              ┌───▼──────┐                ┌───▼───┐
     │  vee  │              │iRodrigues│                │ adjoint│
     └───────┘              └────┬─────┘                └───┬───┘
                                 │                          │
                            ┌────▼─────┐               ┌────▼────┐
                            │ G2twist  │               │ jacobian│
                            └──────────┘               └────┬────┘
                                                            │
                            ┌───────────────────────────────┤
                            ▼                               ▼
                      ┌──────────┐                   ┌───────────┐
                      │  gtwist  │                   │ coadjoint │
                      └──────────┘                   └─────┬─────┘
                                                            │
    ┌───────────────────────────────────────────────────────┤
    │                  动力学层 (NEW)                        │
    │  ┌──────┐  ┌──────────────┐  ┌───────────────┐       │
    │  │  ad  │  │newtonEuler   │  │inertiaTransform│      │
    │  └──┬───┘  └──────────────┘  └───────────────┘       │
    │     │                                                  │
    │     └──────────┬───────────────────────────────────────┘
    │                ▼
    │  ┌─────────────────────────────┐
    │  │       inertiaMatrix         │  ← 组装 M, C, N
    │  └──────────────┬──────────────┘
    │                 │
    │     ┌───────────┼───────────┐
    │     ▼           ▼           ▼
    │ ┌────────┐ ┌────────┐ ┌──────────────┐
    │ │inverse │ │forward │ │computedTorque│
    │ │Dynamics│ │Dynamics│ │    (CTC)     │
    │ └────────┘ └────────┘ └──────────────┘
    │
    │  ┌──────────┐     ┌──────────┐     ┌──────────┐
    │  │   PK1    │     │   PK2    │     │   PK3    │
    │  └──────────┘     └──────────┘     └──────────┘
    │
    │  ┌────┐ ┌────┐ ┌────┐  ┌──────┐ ┌───────┐ ┌───────────┐
    │  │ Rx │ │ Ry │ │ Rz │  │ gmat │ │ pitch │ │ jointTorque│
    │  └────┘ └────┘ └────┘  └──────┘ └───────┘ └───────────┘
```

---

## 典型使用流程

### 1. 正运动学（POE 公式）

```matlab
import robo.*
xi1 = [v1; omega1];  xi2 = [v2; omega2];
g = gtwist(xi1, theta1) * gtwist(xi2, theta2) * gst0;
```

### 2. 速度分析与雅可比

```matlab
[Js, Jb] = jacobian(xis, thetas, gst0);
Vs = Js * theta_dot;     % 空间末端速度
Vb = Jb * theta_dot;     % 体末端速度
```

### 3. 力分析与关节力矩

```matlab
% 末端受力 F_b (体坐标系)，求关节力矩
tau = Jb' * F_b;                      % 直接法
tau = jointTorque(Jb, F_b, 'body');   % 用包装函数

% 力旋量坐标变换
Fs = coadjoint(gst)' * F_b;           % 体 → 空间
tau_check = Js' * Fs;                 % 应与 tau 相等
```

### 4. 逆运动学（PK 子问题分解）

```matlab
theta3 = PK3(xi3, p, q, delta);       % 先满足距离约束
theta1 = PK1(xi1, p', q');            % 再满足位置约束
[theta4, theta5] = PK2(xi4, xi5, pw, qw);  % 双轴问题
```

### 5. 刚体动力学（Newton-Euler）

```matlab
% 陀螺力矩: 螺旋桨绕 y 轴自转, 绕 z 轴进动
omega = [0; omega_s; 0] + R_y(-theta)' * [0; 0; omega_p];
alpha = -hatm([0; omega_s; 0]) * R_y(-theta)' * [0; 0; omega_p];
I = diag([I_diam, I_diam, 0]);        % 两叶桨（细杆）
[tau, tau_euler, tau_gyro] = newtonEuler(I, omega, alpha);
```

### 6. 完整动力学仿真回路

```matlab
% 初始化参数
xi = [xi1, xi2, xi3, xi4];           % 6×n
calMp = ...;  lM = ...;  beta = ...;  % 惯量参数

% 逆动力学: 给定运动 → 求力矩
theta = [0.2; 0.5; -0.3; 0.01];
thetad = [0.1; -0.2; 0.15; 0];
thetadd = [0; 0; 0; 0];
tau = inverseDynamics(thetadd, thetad, theta, xi, calMp, lM, beta);

% 正动力学: 给定力矩 → 求加速度
thetadd_sim = forwardDynamics(tau, thetad, theta, xi, calMp, lM, beta);
```

### 7. 计算力矩控制 (CTC)

```matlab
% 轨迹跟踪
theta_d = ...;  thetad_d = ...;  thetadd_d = ...;  % 期望轨迹
theta = ...;  thetad = ...;                          % 当前状态

tau_ctrl = computedTorque(theta_d, thetad_d, thetadd_d, ...
                          theta, thetad, xi, calMp, lM, beta);

% 应用 tau_ctrl 到正动力学得到实际加速度
thetadd_actual = forwardDynamics(tau_ctrl, thetad, theta, xi, calMp, lM, beta);
```

### 8. 重力补偿

```matlab
% 仅重力补偿 (静止保持)
g_accel = [0; 0; -9.81];
G0 = [g_accel; zeros(3,1)];            % 空间重力旋量
[M, ~, N] = inertiaMatrix(xi, calMp, lM, beta, theta, zeros(n,1));
tau_gravity_only = N;                   % 仅需克服重力 (θ̇=0 时)
```

---

## 关键公式速查

### 运动学

| 公式 | 名称 | MLS 参考 |
|------|------|----------|
| $R = I + \sin\theta\hat{\omega} + (1-\cos\theta)\hat{\omega}^2$ | Rodrigues | §2.2 |
| $\theta = \arccos((\mathrm{tr}(R)-1)/2)$ | 逆 Rodrigues | §2.2 |
| $e^{\hat{\xi}\theta} = \begin{bmatrix} e^{\hat{\omega}\theta} & (I-e^{\hat{\omega}\theta})\hat{\omega}v + \omega\omega^T v\theta \\ 0 & 1 \end{bmatrix}$ | Twist 指数映射 | eq. 2.36 |
| $Ad_g = \begin{bmatrix} R & \hat{p}R \\ 0 & R \end{bmatrix}$ | Twist 伴随 | §2.3 |
| $Ad_g^{-T} = \begin{bmatrix} R & 0 \\ \hat{p}R & R \end{bmatrix}$ | Wrench 伴随 | eq. 2.67 |
| $ad_\xi = \begin{bmatrix} \hat{\omega} & \hat{v} \\ 0 & \hat{\omega} \end{bmatrix}$ | 李括号伴随 | §2.3 |
| $J_i^s = Ad_{g_{s,i-1}} \cdot \xi_i$ | 空间雅可比 | eq. 3.54 |
| $J^b = Ad_{g_{st}^{-1}} \cdot J^s$ | 体雅可比 | eq. 3.55 |
| $h = \frac{\omega^T v}{\|\omega\|^2}$ | 螺旋节距 | eq. 2.42 |

### 动力学

| 公式 | 名称 | MLS 参考 |
|------|------|----------|
| $\tau = I\alpha + \omega \times (I\omega)$ | Newton-Euler (旋转) | §4.3 |
| $F = M\dot{V} - ad_V^T M V$ | Newton-Euler (空间) | §4.3 |
| $M_s = Ad_g^{-T} M_b Ad_g^{-1}$ | 惯性矩阵变换 | eq. 4.14 |
| $M_{ij} = \sum_{l} \xi_i^T A_{li}^T M_l A_{lj} \xi_j$ | 关节惯性矩阵 | §4.3 |
| $\Gamma_{ijk} = \frac{1}{2}(\partial_i M_{jk} + \partial_j M_{ik} - \partial_k M_{ij})$ | Christoffel 符号 | §4.3 |
| $\tau = M\ddot{\theta} + C\dot{\theta} + N$ | 逆动力学 | §4.2 |
| $\ddot{\theta} = M^{-1}(\tau - C\dot{\theta} - N)$ | 正动力学 | §4.2 |
| $\tau = J^T F$ | 力旋量 → 关节力矩 | eq. 3.59 |

---

## Twist 与 Wrench 对偶性总结

```
┌──────────────────────────────────────────────────────────────┐
│                    MLS 对偶性框架                             │
├──────────────────────────────────────────────────────────────┤
│                                                              │
│   运动学 (Twist)              静力学/动力学 (Wrench)          │
│   ───────────────             ──────────────────────          │
│                                                              │
│   ξ = [v; ω]  (6×1)          F = [f; τ]  (6×1)              │
│   V_a = Ad_g · V_b            F_a = Ad_g^{-T} · F_b          │
│   V = J · θ̇                   τ = J^T · F                    │
│                                                              │
│   功率:  P = F^T · V = τ^T · θ̇   (坐标不变)                  │
│                                                              │
│   Ad_g = [R,  p̂R; 0, R]      Ad_g^{-T} = [R, 0; p̂R, R]     │
│                                                              │
│   ad_ξ = [ω̂, v̂; 0, ω̂]        ad_ξ^T = [−ω̂, 0; −v̂, −ω̂]    │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

---

## 注意事项

1. **齐次坐标兼容：** `PK1`, `PK2`, `PK3` 都接受 3×1 或 4×1 的输入点，内部自动取前 3 行。
2. **单位约定：** 所有角度均为**弧度**（rad）。
3. **旋转轴归一化：** `rodrigues`, `gtwist` 期望 $\omega$ 已经归一化为单位向量。
4. **Twist 顺序：** 所有 6×1 向量采用 $[v_{1:3}; \omega_{4:6}]$ 的顺序（线速度在前，角速度在后）。
5. **Wrench 顺序：** 所有 6×1 力旋量采用 $[f_{1:3}; \tau_{4:6}]$ 的顺序（力在前，力矩在后）。
6. **重力坐标系：** `gravityWrench` 默认重力沿空间坐标系 $-z$ 方向。
7. **惯性矩阵格式：** `calMp` 为 6×6×n 数组，每页为连杆在自身体坐标系中的广义惯性矩阵。
8. **PK 约束检查：** PK1 在约束不满足时返回 `[]` 并发出 `warning`，不抛异常。
9. **Package 机制：** 所有函数位于 `+robo` 文件夹下，外部调用需 `robo.xxx()`，内部互相调用使用 `import robo.*`。
10. **符号支持：** `adjoint`, `vee`, `coadjoint` 支持符号变量（`sym` 类型）。
