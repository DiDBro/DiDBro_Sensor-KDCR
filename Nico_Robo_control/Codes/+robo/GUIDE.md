# +robo 函数库完整指南

> 基于 MLS (*A Mathematical Introduction to Robotic Manipulation*) 的 MATLAB 机器人学工具箱，
> 涵盖李群 SE(3)/SO(3) 的全部基础运算，从运动学到动力学，从 wrench 到控制。

---

## 目录

1. [概述与对偶性框架](#概述与对偶性框架)
2. [第一部分：基本李代数运算](#第一部分基本李代数运算)
3. [第二部分：SO(3) 旋转运算](#第二部分so3-旋转运算)
4. [第三部分：SE(3) 刚体运动](#第三部分se3-刚体运动)
5. [第四部分：Twist 分解与构造](#第四部分twist-分解与构造)
6. [第五部分：雅可比](#第五部分雅可比)
7. [第六部分：Paden-Kahan 逆运动学子问题](#第六部分paden-kahan-逆运动学子问题)
8. [第七部分：力旋量与力变换](#第七部分力旋量与力变换)
9. [第八部分：单刚体动力学](#第八部分单刚体动力学)
10. [第九部分：关节空间动力学](#第九部分关节空间动力学)
11. [第十部分：控制](#第十部分控制)
12. [函数调用关系图](#函数调用关系图)
13. [典型使用流程](#典型使用流程)
14. [关键公式速查](#关键公式速查)

---

## 概述与对偶性框架

`+robo` 是一个 MATLAB **package**。外部调用 `robo.xxx()`，内部用 `import robo.*`。

### 核心对偶性

```
        运动学 (Kinematics)              力 (Statics/Dynamics)
        ─────────────────────           ──────────────────────
        Twist:  ξ = [v; ω]              Wrench: F = [f; τ]
        V_a = Ad_{g_ab} · V_b           F_a = Ad_{g_ab}^{-T} · F_b
        V = J · θ̇                        τ = J^T · F
        功率不变: P = F^T·V = τ^T·θ̇
```

### 完整函数速查表 (32 个函数)

| 函数 | 输入 → 输出 | 一句话 | 类别 |
|------|------------|--------|------|
| `hatm` | ω(3×1) → ω̂(3×3) | 构建反对称矩阵 | 李代数 |
| `vee_so3` | ω̂(3×3) → ω(3×1) | so(3) vee 算子 | 李代数 |
| `vee` | ξ̂(4×4) → ξ(6×1) | se(3) vee 算子 | 李代数 |
| `wedge` | ξ(6×1) → ξ̂(4×4) | se(3) wedge 算子 | 李代数 |
| `twist` | ω, v → ξ̂(4×4) | 构建 se(3) 矩阵 | 李代数 |
| `ad` | ξ(6×1) → ad_ξ(6×6) | 李括号伴随矩阵 | 李代数 |
| `rodrigues` | ω, θ → R(3×3) | 旋转向量 → 旋转矩阵 | SO(3) |
| `iRodrigues` | R(3×3) → ω, θ | 旋转矩阵 → 旋转向量 | SO(3) |
| `Rx/Ry/Rz` | θ → R(3×3) | 绕坐标轴旋转 | SO(3) |
| `gmat` | R, p → g(4×4) | 构建齐次变换 | SE(3) |
| `gtwist` | ξ, θ → g(4×4) | twist 指数映射 | SE(3) |
| `G2twist` | g(4×4) → ξ, θ | 齐次变换 → twist(对数映射) | SE(3) |
| `twistExp` | ω, v, θ → R, p | **指数映射分量形式** | SE(3) |
| `buildTwist` | v, ω → ξ(6×1) | **v+ω 组装为 twist** | SE(3) |
| `twistDecompose` | ξ,θ 或 g → ω, v, θ | **twist 拆分为三分量** | SE(3) |
| `adjoint` | g(4×4) → Ad_g(6×6) | twist 伴随变换 | SE(3) |
| `coadjoint` | g(4×4) → Ad_g^{-T}(6×6) | wrench 伴随变换 | Wrench |
| `pitch` | ω, v → h | 螺旋节距 | SE(3) |
| `jacobian` | ξ_i, θ_i, g_st0 → J_s, J_b | 空间/体雅可比 | 运动学 |
| `PK1` | ξ, p, q → θ | 单轴旋转使点重合 | IK |
| `PK2` | ξ₁, ξ₂, p, q → θ₁, θ₂ | 双轴旋转使点重合 | IK |
| `PK3` | ξ, p, q, δ → θ | 旋转使距离等于给定值 | IK |
| `newtonEuler` | I, ω, α → τ | 刚体 Newton-Euler 方程 | 动力学 |
| `inertiaTransform` | M_b, g → M_s | 空间惯性矩阵变换 | 动力学 |
| `gravityWrench` | dir? → G(6×1) | 重力旋量构造 | 动力学 |
| `jointTorque` | J, F → τ | 力旋量 → 关节力矩 τ=JᵀF | Wrench |
| `inertiaMatrix` | ξ, M_l, … → M, C, N | 关节空间动力学矩阵组装 | 动力学 |
| `inverseDynamics` | θ̈_d, θ̇, θ, … → τ | 逆动力学 τ=Mθ̈+Cθ̇+N | 动力学 |
| `forwardDynamics` | τ, θ̇, θ, … → θ̈ | 正动力学 θ̈=M⁻¹(τ-Cθ̇-N) | 动力学 |
| `computedTorque` | θ_d, θ, … → τ | CTC 计算力矩控制 | 控制 |

---

## 第一部分：基本李代数运算

### `hatm(omega)` — hat map (∧)

```
K = hatm(omega)
```

$$\hat{\omega} = \begin{bmatrix} 0 & -\omega_3 & \omega_2 \\ \omega_3 & 0 & -\omega_1 \\ -\omega_2 & \omega_1 & 0 \end{bmatrix}, \qquad \hat{\omega} \cdot v = \omega \times v$$

### `vee_so3(omega_hat)` — so(3) vee (∨)

```
w = vee_so3(omega_hat)
```

$$(\hat{\omega})^\vee = [\hat{\omega}_{3,2},\; \hat{\omega}_{1,3},\; \hat{\omega}_{2,1}]^T = \omega$$

### `vee(xi_wedge)` — se(3) vee (∨)

```
xi = vee(xi_wedge)
```

$$\begin{bmatrix} \hat{\omega} & v \\ 0 & 0 \end{bmatrix}^\vee = \begin{bmatrix} v \\ \omega \end{bmatrix}$$

### `wedge(xi)` — se(3) wedge (∧)

```
xi_wedge = wedge(xi)
```

$$\hat{\xi} = \begin{bmatrix} \hat{\omega} & v \\ 0_{1\times 4} \end{bmatrix}, \quad \xi = [v_1, v_2, v_3, \omega_1, \omega_2, \omega_3]^T$$

### `twist(omega, v)` — 构建 se(3) 矩阵

等价于 `wedge([v; omega])`。

### `ad(xi)` — se(3) 李括号伴随矩阵

```
ad_xi = ad(xi)
```

$$ad_\xi = \begin{bmatrix} \hat{\omega} & \hat{v} \\ 0 & \hat{\omega} \end{bmatrix}$$

**核心用途：** $ad_{\xi_1} \cdot \xi_2 = [\xi_1, \xi_2]$ (李括号)，计算 $\partial M/\partial\theta_k$ 时必需。

---

## 第二部分：SO(3) 旋转运算

### `rodrigues(omega, theta)` — Rodrigues 公式

$$R = e^{\hat{\omega}\theta} = I + \sin\theta \cdot \hat{\omega} + (1 - \cos\theta) \cdot \hat{\omega}^2$$

### `iRodrigues(R)` — 逆 Rodrigues

```
[omega, theta] = iRodrigues(R)
```

$$\theta = \arccos\left(\frac{\mathrm{tr}(R)-1}{2}\right), \quad \hat{\omega} = \frac{R - R^T}{2\sin\theta}$$

| 情况 | 条件 | 处理 |
|------|------|------|
| θ≈0 | θ < 1e-6 | θ=0, ω 任意 |
| θ≈π | |θ−π| < 1e-6 | 用 (R−I)/2 提取 ω |
| 一般 | 否则 | 标准公式 |

### `Rx/Ry/Rz(theta)` — 绕坐标轴旋转

$$R_x = \begin{bmatrix}1&0&0\\0&c&-s\\0&s&c\end{bmatrix}, \quad R_y = \begin{bmatrix}c&0&s\\0&1&0\\-s&0&c\end{bmatrix}, \quad R_z = \begin{bmatrix}c&-s&0\\s&c&0\\0&0&1\end{bmatrix}$$

---

## 第三部分：SE(3) 刚体运动

### `gmat(R, p)` — 构建齐次变换

$$g = \begin{bmatrix} R & p \\ 0 & 1 \end{bmatrix}$$

### `gtwist(xi, theta)` — twist 指数映射 (MLS eq. 2.36)

```
g = gtwist(xi, theta)
```

$$e^{\hat{\xi}\theta} = \begin{bmatrix} e^{\hat{\omega}\theta} & (I - e^{\hat{\omega}\theta})\hat{\omega}v + \omega\omega^T v\theta \\ 0 & 1 \end{bmatrix}$$

| 情况 | 平移部分 p |
|------|-----------|
| ‖ω‖≈0 (纯平移) | p = v·θ |
| 一般情况 | $p = (I-R)\hat{\omega}v + \omega\omega^T v \theta$ |

### `G2twist(G)` — 对数映射 (gtwist 的逆)

```
[xi, theta] = G2twist(G)
```

1. 旋转部分: `iRodrigues(R)` → ω, θ
2. 平移部分: 解 $A \cdot v = p$, 其中 $A = (I-R)\hat{\omega} + \omega\omega^T\theta$

### `adjoint(g)` — twist 伴随 $Ad_g$

$$V_a = Ad_{g_{ab}} \cdot V_b, \quad Ad_g = \begin{bmatrix} R & \hat{p}R \\ 0 & R \end{bmatrix}$$

### `pitch(omega, v)` — 螺旋节距

$$h = \frac{\omega^T v}{\|\omega\|^2}$$

h=0 → 纯旋转(转动关节), h=∞ → 纯平移(移动关节)

---

## 第四部分：Twist 分解与构造

这三个函数是考试手算时最实用的——把 twist 的各个分量拆开/组合。

### `buildTwist(v, omega)` — 组装 twist

```
xi = buildTwist(v, omega)
```

将 $v$ (3×1) 和 $\omega$ (3×1) 拼成 6×1 twist 坐标:

$$\xi = \begin{bmatrix} v \\ \omega \end{bmatrix}$$

与 `twistDecompose` 互为逆操作。

### `twistDecompose` — 拆分 twist 为三分量

```
[omega, v, theta] = twistDecompose(xi, theta)   % 用法 1: 从 twist 拆分
[omega, v, theta] = twistDecompose(G)            % 用法 2: 从 SE(3) 矩阵拆分
```

**用法 1：** 给定 $\xi = [v; \omega]$ 和 $\theta$，拆出 $\omega, v, \theta$ 三个独立分量。

**用法 2：** 给定 4×4 的 $g$，内部调用 `G2twist` 再拆出三分量。

### `twistExp(omega, v, theta)` — 指数映射分量形式

```
[R, p] = twistExp(omega, v, theta)
```

直接输入 $\omega, v, \theta$，返回 $R$ (3×3) 和 $p$ (3×1)，等价于 `gtwist` 的内部计算但不组装 4×4 矩阵：

$$R = e^{\hat{\omega}\theta} \quad\text{(Rodrigues)}$$
$$p = (I-R)\hat{\omega}v + \omega\omega^T v\theta \quad (\|\omega\| \neq 0)$$
$$p = v\theta \quad (\|\omega\| = 0,\ \text{纯平移})$$

**三者关系：**
```
buildTwist(v,ω) → ξ ─┐
                      ├─→ gtwist(ξ,θ) → g (4×4)
omega, v, θ ─────────┘
                      └─→ twistExp(ω,v,θ) → R, p

g (4×4) → G2twist(g) → ξ, θ → twistDecompose → ω, v, θ
```

---

## 第五部分：雅可比

### `jacobian(xis, thetas, gst0)` — 空间与体雅可比

```
[Js, Jb] = jacobian(xis, thetas, gst0)
```

$$J_s = [\xi_1', \xi_2', \ldots, \xi_n'], \quad \xi_i' = Ad_{g_{s,i-1}} \cdot \xi_i$$

$$J_b = Ad_{g_{st}^{-1}} \cdot J_s$$

- $J_s$: 关节速度 → **空间坐标系**末端速度
- $J_b$: 关节速度 → **末端体坐标系**末端速度

---

## 第六部分：Paden-Kahan 逆运动学子问题

### `PK1(xi, p, q, tol)` — 子问题 1: 绕单轴旋转使点重合

求解 $e^{\hat{\xi}\theta} \cdot p = q$

**约束条件（不满足则无解返回 `[]`）：**
1. $\|u_\perp\| = \|v_\perp\|$（到轴距离相等）
2. $\omega^T(p-r) = \omega^T(q-r)$（沿轴投影相等）

$$\theta = \arctan2\left(\omega^T(u_\perp \times v_\perp),\; u_\perp^T v_\perp\right)$$

### `PK2(xi1, xi2, p, q)` — 子问题 2: 绕双轴旋转使点重合

求解 $e^{\hat{\xi}_1\theta_1} \cdot e^{\hat{\xi}_2\theta_2} \cdot p = q$

**前提：** 两轴必须相交且不平行。返回两组解 (±γ)。

### `PK3(xi, p, q, delta)` — 子问题 3: 旋转到指定距离

求解 $\|q - e^{\hat{\xi}\theta} \cdot p\| = \delta$

返回 2×1 列向量 $[\theta_0 + \phi;\, \theta_0 - \phi]$。

---

## 第七部分：力旋量与力变换

### `coadjoint(g)` — wrench 伴随 $Ad_g^{-T}$ (MLS eq. 2.67)

$$F_a = Ad_{g_{ab}}^{-T} \cdot F_b, \quad Ad_g^{-T} = \begin{bmatrix} R & 0 \\ \hat{p}R & R \end{bmatrix}$$

**与 twist 伴随的对比：**

| | Twist 变换 | Wrench 变换 |
|---|---|---|
| 矩阵 | $Ad_g = \begin{bmatrix}R&\hat{p}R\\0&R\end{bmatrix}$ | $Ad_g^{-T} = \begin{bmatrix}R&0\\\hat{p}R&R\end{bmatrix}$ |
| 方向 | $V_a = Ad_{g_{ab}} \cdot V_b$ | $F_a = Ad_{g_{ab}}^{-T} \cdot F_b$ |
| 功率不变 | $F^T \cdot V = (Ad_g^{-T}F)^T \cdot (Ad_g \cdot V)$ |

### `jointTorque(J, F)` — 力旋量 → 关节力矩 (MLS eq. 3.59)

$$\tau = J^T \cdot F$$

$\tau = J_s^T \cdot F_s = J_b^T \cdot F_b$（两种形式等价）。

---

## 第八部分：单刚体动力学

### `newtonEuler(I, omega, alpha)` — Newton-Euler 方程

```
[tau, tau_euler, tau_gyro] = newtonEuler(I, omega, alpha)
```

**纯旋转 (3×3 惯量)：**

$$\tau = I \cdot \alpha + \omega \times (I \cdot \omega)$$

- `tau_euler` = $I\alpha$（欧拉项）
- `tau_gyro` = $\omega \times (I\omega)$（陀螺项）

**典型应用 (Homework 6)：** 飞机螺旋桨陀螺力矩
```matlab
omega = omega_self + R_y(-theta)' * omega_precession;
alpha = -hatm(omega_self) * R_y(-theta)' * omega_precession;
tau   = I * alpha + hatm(omega) * I * omega;
```

### `inertiaTransform(M_b, g)` — 空间惯性矩阵变换 (MLS eq. 4.14)

$$M_s = Ad_g^{-T} \cdot M_b \cdot Ad_g^{-1}$$

6×6 广义惯性矩阵: $M_b = \begin{bmatrix} mI_3 & m\hat{c}^T \\ m\hat{c} & I_b \end{bmatrix}$

### `gravityWrench(g_dir, g_mag)` — 重力旋量

$$G_0 = \begin{bmatrix} m \cdot g_{dir} \cdot g_{mag} \\ 0_{3\times 1} \end{bmatrix}$$

重力是纯力，无力矩分量。

---

## 第九部分：关节空间动力学

### `inertiaMatrix(xi, calMp, lM, beta, theta, thetad)` — 组装 M, C, N

```
[M, C, N] = inertiaMatrix(xi, calMp, lM, beta, theta, thetad)
```

**M (惯性矩阵, 正定对称):**

$$M_{ij} = \sum_{l=\max(i,j)}^n \xi_i^T \cdot A_{l,i}^T \cdot M_l \cdot A_{l,j} \cdot \xi_j$$

**C (科氏矩阵, 满足 Ṁ−2C 反对称):**

$$C_{ij} = \sum_{k=1}^n \Gamma_{ijk} \dot{\theta}_k, \quad \Gamma_{ijk} = \frac{1}{2}\left(\frac{\partial M_{ij}}{\partial\theta_k} + \frac{\partial M_{ik}}{\partial\theta_j} - \frac{\partial M_{kj}}{\partial\theta_i}\right)$$

**N (重力 + 摩擦):**

$$N_i = -\frac{\partial V}{\partial\theta_i} + \beta_i \dot{\theta}_i$$

### `inverseDynamics(thetadd, thetad, theta, ...)` — 逆动力学

$$\tau = M(\theta) \cdot \ddot{\theta} + C(\theta,\dot{\theta}) \cdot \dot{\theta} + N(\theta,\dot{\theta})$$

### `forwardDynamics(tau, thetad, theta, ...)` — 正动力学

$$\ddot{\theta} = M(\theta)^{-1} \cdot \big(\tau - C(\theta,\dot{\theta}) \cdot \dot{\theta} - N(\theta,\dot{\theta})\big)$$

---

## 第十部分：控制

### `computedTorque(...)` — 计算力矩控制器 (CTC)

```
tau = computedTorque(theta_d, thetad_d, thetadd_d, theta, thetad, ...
                     xi, calMp, lM, beta, Kp, Kv)
```

**控制律：**
$$\tau = M(\theta) \cdot \ddot{\theta}^* + C(\theta,\dot{\theta}) \cdot \dot{\theta} + N(\theta,\dot{\theta})$$
$$\ddot{\theta}^* = \ddot{\theta}_d + K_v(\dot{\theta}_d - \dot{\theta}) + K_p(\theta_d - \theta)$$

**误差动力学：** $\ddot{e} + K_v \dot{e} + K_p e = 0$

**增益设计 (ζ=1)：** $K_p = \omega_n^2, \; K_v = 2\omega_n$（常用 ωₙ=50 → Kp=2500, Kv=100）

---

## 函数调用关系图

```
                          ┌─────────┐
                          │  hatm   │ ◄── 最底层
                          └────┬────┘
                               │
      ┌────────────────────────┼──────────────────────────┐
      ▼                        ▼                           ▼
┌──────────┐            ┌──────────┐                ┌──────────┐
│  wedge   │            │ rodrigues│                │  twist   │
│  vee     │            │iRodrigues│                │  ad      │
└──────────┘            └────┬─────┘                └────┬─────┘
                             │                           │
                        ┌────▼─────┐                ┌───▼──────┐
                        │ G2twist  │                │ adjoint  │
                        │ gtwist   │                │coadjoint │
                        │ twistExp │                └───┬──────┘
                        └──────────┘                    │
                                                        ▼
                        buildTwist ◄──► twistDecompose  │
                                                        │
              ┌─────────────────────────────────────────┤
              │            动力学层                      │
              │  newtonEuler  inertiaTransform          │
              │  gravityWrench  jointTorque             │
              │  inertiaMatrix → inverseDynamics        │
              │               → forwardDynamics         │
              │               → computedTorque          │
              └─────────────────────────────────────────┘
```

---

## 典型使用流程

### 1. 正运动学 (POE)
```matlab
g = gtwist(xi1, theta1) * gtwist(xi2, theta2) * gst0;
% 或用分量形式
[R1, p1] = twistExp(omega1, v1, theta1);
g1 = [R1, p1; 0 0 0 1];
```

### 2. 拆解 twist 分量
```matlab
[omega, v, theta] = twistDecompose(G);          % 从 SE(3) 拆
[omega, v, theta] = twistDecompose(xi, theta);  % 从 twist 拆
xi = buildTwist(v, omega);                      % 反向组装
```

### 3. 速度与雅可比
```matlab
[Js, Jb] = jacobian(xis, thetas, gst0);
Vs = Js * theta_dot;   % 空间末端速度
Vb = Jb * theta_dot;   % 体末端速度
```

### 4. 力分析
```matlab
tau = jointTorque(Jb, F_b);              % 体 wrench → 关节力矩
tau = jointTorque(Js, F_s);              % 空间 wrench → 关节力矩 (结果相同)
Fs = coadjoint(gst)' * F_b;             % 体 wrench → 空间 wrench
```

### 5. 刚体陀螺力矩 (Homework 6)
```matlab
omega = omega_spin + R_ship' * omega_precession;
alpha = -hatm(omega_spin) * R_ship' * omega_precession;
I = diag([I_diam, I_diam, 0]);              % 两叶桨 (细杆)
[tau, tau_euler, tau_gyro] = newtonEuler(I, omega, alpha);
```

### 6. 动力学仿真
```matlab
% 逆动力学: 运动 → 力矩
tau = inverseDynamics(thetadd_d, thetad, theta, xi, calMp, lM, beta);
% 正动力学: 力矩 → 加速度
thetadd = forwardDynamics(tau, thetad, theta, xi, calMp, lM, beta);
```

### 7. CTC 控制
```matlab
tau = computedTorque(theta_d, thetad_d, thetadd_d, theta, thetad, ...
                     xi, calMp, lM, beta);
```

---

## 关键公式速查

### 运动学

| 公式 | MLS 参考 |
|------|----------|
| $R = I + \sin\theta\hat{\omega} + (1-\cos\theta)\hat{\omega}^2$ | §2.2 |
| $\theta = \arccos((\mathrm{tr}(R)-1)/2)$ | §2.2 |
| $e^{\hat{\xi}\theta} = \begin{bmatrix} e^{\hat{\omega}\theta} & (I-R)\hat{\omega}v + \omega\omega^T v\theta \\ 0 & 1 \end{bmatrix}$ | eq. 2.36 |
| $Ad_g = \begin{bmatrix} R & \hat{p}R \\ 0 & R \end{bmatrix}$ | §2.3 |
| $Ad_g^{-T} = \begin{bmatrix} R & 0 \\ \hat{p}R & R \end{bmatrix}$ | eq. 2.67 |
| $ad_\xi = \begin{bmatrix} \hat{\omega} & \hat{v} \\ 0 & \hat{\omega} \end{bmatrix}$ | §2.3 |
| $J_i^s = Ad_{g_{s,i-1}} \cdot \xi_i$ | eq. 3.54 |
| $h = \frac{\omega^T v}{\|\omega\|^2}$ | eq. 2.42 |

### 动力学与控制

| 公式 | MLS 参考 |
|------|----------|
| $\tau = I\alpha + \omega \times (I\omega)$ | §4.3 |
| $M_s = Ad_g^{-T} M_b Ad_g^{-1}$ | eq. 4.14 |
| $\tau = J^T F$ | eq. 3.59 |
| $\tau = M\ddot{\theta} + C\dot{\theta} + N$ | §4.2 |
| $\ddot{\theta} = M^{-1}(\tau - C\dot{\theta} - N)$ | §4.2 |
| $\ddot{\theta}^* = \ddot{\theta}_d + K_v\dot{e} + K_pe$ | CTC |
| $\ddot{e} + K_v\dot{e} + K_p e = 0$ | CTC 误差动力学 |

---

## 注意事项

1. **角度单位：** 所有角度均为**弧度**（rad）。
2. **Twist 顺序：** 6×1 向量采用 $[v_{1:3}; \omega_{4:6}]$（线速度在前，角速度在后）。
3. **Wrench 顺序：** 6×1 力旋量采用 $[f_{1:3}; \tau_{4:6}]$（力在前，力矩在后）。
4. **旋转轴归一化：** `rodrigues`, `gtwist`, `twistExp` 期望 ω 已归一化。
5. **容差值：** 大部分函数使用 `1e-12` 附近的阈值判断退化情况。
6. **PK 约束检查：** 约束不满足时返回 `[]` 并 `warning`，不抛异常。
7. **Package 机制：** 外部 `robo.xxx()`，内部 `import robo.*`。
8. **齐次坐标兼容：** PK1/PK2/PK3 接受 3×1 或 4×1 的点输入。
