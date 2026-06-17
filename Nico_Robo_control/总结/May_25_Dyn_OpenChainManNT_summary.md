# 第四章：开链机械臂的 Lagrangian 动力学 — 课件总结

> 课件：May_25_Dyn_OpenChainManNT.pdf（19 页）
> 对应教材：MLS Chapter 4, §4（Lagrangian for Open-Chain Manipulators）

---

## 一、开链机械臂的 Lagrangian 建立

### 1.1 各连杆的体速度与 Jacobian

对机械臂的第 $i$ 个连杆，定义**物体坐标系 $L_i$**（体坐标），其原点位于第 $i$ 根连杆的**质心(CoM)** 处。

从基座到 $L_i$ 的正向运动学：

$$
g_{sl_i}(\theta) = e^{\hat{\xi}_1 \theta_1} \, e^{\hat{\xi}_2 \theta_2} \, \cdots \, e^{\hat{\xi}_i \theta_i} \, g_{sl_i}(0)
$$

其中 $g_{sl_i}(0)$ 是连杆 $i$ 在机械臂零位（$\theta = 0$）时的初始位姿。

$L_i$ 的**体速度**通过其对应的体 Jacobian $J_i(\theta)$ 与关节速度关联：

$$
V_{sl_i}^b = J_{sl_i}^b(\theta) \, \dot{\theta} \quad \text{或简写为} \quad V_i^b = J_i(\theta) \, \dot{\theta}
$$

#### Jacobian $J_i(\theta)$ 的列结构

$$
J_i(\theta) = \begin{bmatrix} \xi_1^{\dagger} & \cdots & \xi_i^{\dagger} & 0 & \cdots & 0 \end{bmatrix}
$$

> **为什么后面全是零？** 因为只有前 $i$ 个关节会影响连杆 $i$ 的运动（第 $i+1$ 到 $n$ 个关节在连杆 $i$ 的"下游"，不影响 $L_i$ 的位姿）。

其中第 $j$ 列（$j \leq i$）：

$$
\xi_j^{\dagger} = \operatorname{Ad}^{-1}_{\left(e^{\hat{\xi}_j \theta_j} \cdots e^{\hat{\xi}_i \theta_i} g_{sl_i}(0)\right)} \, \xi_j \qquad j \leq i
$$

> **几何含义**：先将第 $j$ 个关节的 twist $\xi_j$ 通过从该关节到连杆 $i$ 的刚体变换"传递"到 $L_i$，再用伴随映射的逆变到 $L_i$ 的体坐标系中表示。

#### ⚠️ 课件关于教材公式的勘误

课件指出 MLS 教材 p.168 上对 $\xi_j^{\dagger}$ 的写法**可能有误**。教材写的是：

$$
\xi_j^{\dagger} = \operatorname{Ad}^{-1}_{\left(e^{\hat{\xi}_j \theta_j} \cdots e^{\hat{\xi}_i \theta_i} g_{sl_i}(0)\right)} \xi_j
$$

课件认为正确的表达应为：

$$
\xi_j^{\dagger} =
\begin{cases}
\operatorname{Ad}^{-1}_{\left(e^{\hat{\xi}_{j+1} \theta_{j+1}} \cdots e^{\hat{\xi}_i \theta_i} g_{sl_i}(0)\right)} \, \xi_j, & j < i \\[8pt]
\operatorname{Ad}^{-1}_{g_{sl_i}(0)} \, \xi_j, & j = i
\end{cases}
$$

> 📖 **为什么？** 课件指出这个修正与 MLS 教材 p.176 上 $J_i(\theta)$ 的写法以及 $A_{ij}$ 的定义 (4.27) 是一致的。而 p.168 的原始表述与 p.176 的内容**不兼容**。

---

### 1.2 单连杆动能 → 总动能

**第 $i$ 根连杆的动能**，使用其广义惯性矩阵 $\mathcal{M}_i$（见教材 eq. (4.9) p.162）：

$$
\boxed{T_i(\theta, \dot{\theta}) = \frac{1}{2} V_i^{bT} \mathcal{M}_i V_i^b
= \frac{1}{2} \dot{\theta}^T J_i^T(\theta) \mathcal{M}_i J_i(\theta) \dot{\theta}} \tag{4.17}
$$

其中 $\mathcal{M}_i = \begin{bmatrix} m_i I & 0 \\ 0 & \mathcal{I}_i \end{bmatrix}$ 是第 $i$ 根连杆在**体坐标系**中的广义惯性矩阵（对称正定）。

**机械臂总动能**：将所有连杆的动能求和：

$$
\boxed{T(\theta, \dot{\theta}) = \sum_{i=1}^{n} T_i(\theta, \dot{\theta})
= \frac{1}{2} \dot{\theta}^T M(\theta) \dot{\theta}} \tag{4.18}
$$

其中**机械臂惯性矩阵** $M(\theta) \in \mathbb{R}^{n \times n}$：

$$
\boxed{M(\theta) = \sum_{i=1}^{n} J_i^T(\theta) \, \mathcal{M}_i \, J_i(\theta)} \tag{4.19}
$$

| 符号 | 含义 | 维度 |
|------|------|------|
| $J_i(\theta)$ | 第 $i$ 连杆的体 Jacobian | $\mathbb{R}^{6 \times n}$ |
| $\mathcal{M}_i$ | 第 $i$ 连杆的广义惯性矩阵（体坐标中恒定） | $\mathbb{R}^{6 \times 6}$ |
| $M(\theta)$ | 机械臂惯性矩阵 | $\mathbb{R}^{n \times n}$ |

> **物理直觉**：$M(\theta)$ 是构型 $\theta$ 的函数——机械臂伸直时和收拢时的"有效惯性"完全不同。$M(\theta)$ 是**对称正定**的（因为每个 $\mathcal{M}_i$ 都是正定的）。

---

### 1.3 势能与 Lagrangian

**第 $i$ 根连杆的势能**（仅考虑重力，选高度方向）：

$$
V_i(\theta) = m_i g \, h_i(\theta)
$$

其中 $h_i(\theta)$ 是第 $i$ 连杆质心在重力方向上的高度。

**总势能**：

$$
V(\theta) = \sum_{i=1}^{n} V_i(\theta) = \sum_{i=1}^{n} m_i g \, h_i(\theta)
$$

**Lagrangian**（动能 $-$ 势能）：

$$
\boxed{\mathcal{L}(\theta, \dot{\theta}) = \sum_{i=1}^{n} \left[ T_i(\theta, \dot{\theta}) - V_i(\theta) \right]
= \frac{1}{2} \dot{\theta}^T M(\theta) \dot{\theta} - V(\theta)} \tag{4.20}
$$

展开为分量形式：

$$
\mathcal{L}(\theta, \dot{\theta}) = \frac{1}{2} \sum_{i,j=1}^{n} M_{ij}(\theta) \, \dot{\theta}_i \dot{\theta}_j - V(\theta)
$$

---

## 二、运动方程（Equations of Motion）的推导

### 2.1 Euler-Lagrange 方程

对每个关节坐标 $\theta_i$，Euler-Lagrange 方程为：

$$
\frac{d}{dt} \frac{\partial \mathcal{L}}{\partial \dot{\theta}_i} - \frac{\partial \mathcal{L}}{\partial \theta_i} = \Upsilon_i, \qquad i = 1, 2, \dots, n
$$

其中 $\Upsilon_i$（大写 upsilon）是第 $i$ 关节的**驱动力矩**及其他非保守广义力。

---

### 2.2 第一项：$\frac{d}{dt} \frac{\partial \mathcal{L}}{\partial \dot{\theta}_i}$

只有 Lagrangian 中的动能项（含 $\dot{\theta}$ 的二次型）对此项有贡献。对 $\dot{\theta}_i$ 求偏导（$M_{ij}$ 是 $M(\theta)$ 的对称元素，$M_{ij} = M_{ji}$）：

$$
\frac{\partial \mathcal{L}}{\partial \dot{\theta}_i} = \sum_{j=1}^{n} M_{ij}(\theta) \, \dot{\theta}_j
$$

对时间求全导数：

$$
\begin{aligned}
\frac{d}{dt} \frac{\partial \mathcal{L}}{\partial \dot{\theta}_i}
&= \frac{d}{dt} \sum_{j=1}^{n} M_{ij}(\theta) \, \dot{\theta}_j \\
&= \sum_{j=1}^{n} \left[ M_{ij}(\theta) \, \ddot{\theta}_j + \dot{M}_{ij}(\theta) \, \dot{\theta}_j \right]
\end{aligned}
$$

利用链式法则展开 $\dot{M}_{ij} = \sum_{k=1}^{n} \frac{\partial M_{ij}}{\partial \theta_k} \dot{\theta}_k$：

$$
\boxed{\frac{d}{dt} \frac{\partial \mathcal{L}}{\partial \dot{\theta}_i}
= \sum_{j=1}^{n} M_{ij} \, \ddot{\theta}_j
+ \sum_{j,k=1}^{n} \frac{\partial M_{ij}(\theta)}{\partial \theta_k} \, \dot{\theta}_j \dot{\theta}_k}
$$

---

### 2.3 第二项：$\frac{\partial \mathcal{L}}{\partial \theta_i}$

动能项对 $\theta_i$ 的偏导（$M_{kj}$ 不依赖于 $\dot{\theta}$）减去势能项：

$$
\frac{\partial \mathcal{L}}{\partial \theta_i}
= \frac{1}{2} \sum_{k,j=1}^{n} \frac{\partial M_{kj}}{\partial \theta_i} \dot{\theta}_k \dot{\theta}_j
- \frac{\partial V}{\partial \theta_i}
$$

---

### 2.4 完整运动方程

将两项合并得（对每个 $i$）：

$$
\sum_{j=1}^{n} M_{ij} \ddot{\theta}_j
+ \sum_{j,k=1}^{n} \frac{\partial M_{ij}}{\partial \theta_k} \dot{\theta}_j \dot{\theta}_k
- \frac{1}{2} \sum_{k,j=1}^{n} \frac{\partial M_{kj}}{\partial \theta_i} \dot{\theta}_k \dot{\theta}_j
+ \frac{\partial V}{\partial \theta_i}
= \Upsilon_i
$$

> 注意第二项和第三项中求和指标的命名不同，但它们都是对 $j,k$ 的双重求和。我们将其合并为一组更紧凑的表达式。

---

### 2.5 Christoffel 符号

定义**第一类 Christoffel 符号**（Christoffel Symbols of the First Kind）：

$$
\boxed{\Gamma_{ijk} = \frac{1}{2} \left(
\frac{\partial M_{ij}(\theta)}{\partial \theta_k}
+ \frac{\partial M_{ik}(\theta)}{\partial \theta_j}
- \frac{\partial M_{kj}(\theta)}{\partial \theta_i}
\right)} \tag{4.22}
$$

利用 $\Gamma_{ijk}$，可以将第二和第三项合并（推导见附录），得到**紧凑形式**的运动方程：

$$
\boxed{\sum_{j=1}^{n} M_{ij}(\theta) \, \ddot{\theta}_j
+ \sum_{j,k=1}^{n} \Gamma_{ijk}(\theta) \, \dot{\theta}_j \dot{\theta}_k
+ \frac{\partial V}{\partial \theta_i}
= \Upsilon_i} \tag{4.21}
$$

---

### 2.6 各项的物理含义

式 (4.21) 是一个关于 $\theta$ 的**非线性二阶常微分方程**，四项分别对应：

| 项 | 表达式 | 物理含义 |
|----|--------|----------|
| **惯性力** | $\sum M_{ij} \ddot{\theta}_j$ | 各轴加速度耦合产生的力矩 |
| **离心力** | $\Gamma_{ijk} \dot{\theta}_j^2$（当 $j=k$） | 单关节速度"甩出去"的效应 |
| **科里奥利力** | $\Gamma_{ijk} \dot{\theta}_j \dot{\theta}_k$（当 $j \neq k$） | 两个关节速度的交叉耦合 |
| **有势力** | $\frac{\partial V}{\partial \theta_i}$ | 重力等保守力的影响 |
| **外力** | $\Upsilon_i$ | 关节驱动力矩 + 其他非保守力 |

---

### 2.7 最终标准形式：$M \ddot{\theta} + C \dot{\theta} + N = \tau$

将外力 $\Upsilon_i$ 拆成两部分：**关节驱动力矩 $\tau_i$** 和 **"其余"**。把"其余"与负的有势力合并为 $-N_i$：

$$
-N_i(\theta, \dot{\theta}) = -\frac{\partial V}{\partial \theta_i} - \beta_i \dot{\theta}_i
$$

> 其中 $\beta_i \dot{\theta}_i$ 是**粘性阻尼**（viscous damping）模型，用于描述关节轴承摩擦。

定义 **Coriolis-离心矩阵** $C(\theta, \dot{\theta}) \in \mathbb{R}^{n \times n}$：

$$
\boxed{C_{ij}(\theta, \dot{\theta}) = \sum_{k=1}^{n} \Gamma_{ijk}(\theta) \, \dot{\theta}_k
= \sum_{k=1}^{n} \frac{1}{2} \left(
\frac{\partial M_{ij}}{\partial \theta_k}
+ \frac{\partial M_{ik}}{\partial \theta_j}
- \frac{\partial M_{kj}}{\partial \theta_i}
\right) \dot{\theta}_k} \tag{4.23}
$$

最终，运动方程写为**标准机器人动力学形式**：

$$
\boxed{M(\theta) \, \ddot{\theta} + C(\theta, \dot{\theta}) \, \dot{\theta} + N(\theta, \dot{\theta}) = \tau} \tag{4.24}
$$

| 矩阵 | 符号 | 含义 | 结构 |
|------|------|------|------|
| 惯性矩阵 | $M(\theta)$ | 构型依赖的有效惯性 | 对称正定 |
| Coriolis-离心矩阵 | $C(\theta, \dot{\theta})$ | 速度乘积项 | 与 $\dot{\theta}$ 线性相关 |
| 非线性项 | $N(\theta, \dot{\theta})$ | 重力 + 阻尼 + 其他 | — |
| 关节力矩 | $\tau$ | 控制输入 | — |

---

## 三、Proposition 4.3：$M(\theta)$ 的显式结构

### 3.1 惯性矩阵的逐列/逐行表示

重新审视 $M(\theta)$ 的组合结构（教材 p.176）：

$$
M(\theta) = \sum_{i=1}^{n} J_i^T(\theta) \, \mathcal{M}_i \, J_i(\theta) \tag{4.19}
$$

其中 $J_i(\theta)$ 可进一步写为：

$$
J_i(\theta) = \operatorname{Ad}_{g^{-1}_{sl_i(0)}} \,
\begin{bmatrix} A_{i1} \xi_1 & \cdots & A_{ii} \xi_i & 0 & \cdots & 0 \end{bmatrix}
$$

其中 $A_{ij}$ 是关键的**变换项**（见 eq. 4.27, p.176）：

$$
A_{ij} = \operatorname{Ad}^{-1}_{\left(e^{\hat{\xi}_{j+1} \theta_{j+1}} \cdots e^{\hat{\xi}_i \theta_i}\right)} \qquad (i \geq j)
$$

> **物理含义**：$A_{ij}$ 将关节 $j$ 的 twist "传播"到连杆 $i$ 的体坐标系。只有经过 $j$ 之后、在 $i$ 之前的那些关节会影响这个变换。

将第 $i$ 根连杆的惯性矩阵**反映到空间坐标系**（reflected inertia）：

$$
\boxed{\mathcal{M}_i' = \operatorname{Ad}_{g^{-1}_{sl_i(0)}}^T \, \mathcal{M}_i \, \operatorname{Ad}_{g^{-1}_{sl_i(0)}}} \tag{4.28}
$$

最终，**Proposition 4.3** 给出 $M_{ij}(\theta)$ 的显式公式：

$$
\boxed{M_{ij}(\theta) = \sum_{l = \max(i,j)}^{n} \xi_i^T A_{li}^T \, \mathcal{M}_l' \, A_{lj} \, \xi_j} \tag{4.29}
$$

> **关键观察**：$M_{ij}$ 的求和中 $l$ 从 $\max(i,j)$ 开始——即只有**同时与关节 $i$ 和关节 $j$ 的连杆都相关**的连杆才会贡献。这意味着 $M_{ij}$ 具有"稀疏性"，当两个关节相距较远时耦合较小。

---

### 3.2 对 $\theta_k$ 的偏导：式 (4.30) 的推导

对式 (4.29) 求 $\theta_k$ 的偏导（乘积法则）：

$$
\frac{\partial M_{ij}}{\partial \theta_k}
= \sum_{l=\max(i,j)}^{n} \left[
\frac{\partial (\xi_i^T A_{li}^T)}{\partial \theta_k} \mathcal{M}_l' A_{lj} \xi_j
+ \xi_i^T A_{li}^T \mathcal{M}_l' \frac{\partial (A_{lj} \xi_j)}{\partial \theta_k}
\right]
$$

若能证明核心关系式：

$$
\boxed{\frac{\partial (A_{lj} \xi_j)}{\partial \theta_k} = A_{lk} \, [A_{kj} \xi_j, \, \xi_k]}
$$

则式 (4.30) 得证：

$$
\boxed{\frac{\partial M_{ij}}{\partial \theta_k}
= \sum_{l=\max(i,j)}^{n} \left\{
[A_{ki} \xi_i, \xi_l]^T A_{lk}^T \mathcal{M}_l' A_{lj} \xi_j
+ \xi_i^T A_{li}^T \mathcal{M}_l' A_{lk} [A_{kj} \xi_j, \xi_l]
\right\}}
$$

---

### 3.3 核心引理的证明（教材 p.177）

**目标**：证明 $\displaystyle \frac{\partial (A_{lj} \xi_j)}{\partial \theta_k} = A_{lk} [A_{kj} \xi_j, \xi_k]$，对 $l \geq k \geq j$。

#### 预备知识

引入中间变量（教材 p.177）：

- $g_{ji} = e^{\hat{\xi}_{j+1} \theta_{j+1}} \cdots e^{\hat{\xi}_i \theta_i}$（正变换，从关节 $i$"往回"到 $j+1$）
- $g_{ij} = g_{ji}^{-1} = e^{-\hat{\xi}_i \theta_i} \cdots e^{-\hat{\xi}_{j+1} \theta_{j+1}}$（逆变换）
- 对于 $i \geq k \geq j$：$g_{ij} = g_{ik} \, g_{kj}$

$A_{ij}$ 与 $g_{ij}$ 的关系（教材 eq. 4.27）：

$$
A_{ij} = \operatorname{Ad}_{g_{ji}}^{-1} = \operatorname{Ad}_{g_{ij}}
$$

因此 $A_{lj} \xi_j$ 的逆伴随形式等价于：

$$
A_{lj} \xi_j = \operatorname{Ad}_{g_{lj}} \xi_j = \left( g_{lj} \, \hat{\xi}_j \, g_{lj}^{-1} \right)^{\vee}
$$

#### 求导

利用乘积法则：

$$
\frac{\partial (A_{lj} \xi_j)}{\partial \theta_k}
= \left( \frac{\partial}{\partial \theta_k} \left[ g_{lj} \hat{\xi}_j g_{lj}^{-1} \right] \right)^{\vee}
= \left( \frac{\partial g_{lj}}{\partial \theta_k} \hat{\xi}_j g_{lj}^{-1}
+ g_{lj} \hat{\xi}_j \frac{\partial g_{lj}^{-1}}{\partial \theta_k} \right)^{\vee}
$$

**关键步骤** — 分别求两个偏导（利用指数映射的导数性质）：

$$
g_{lj} = e^{-\hat{\xi}_l \theta_l} \cdots e^{-\hat{\xi}_{j+1} \theta_{j+1}}
$$

对 $\theta_k$ 求导（只有 $e^{-\hat{\xi}_k \theta_k}$ 这项依赖于 $\theta_k$）：

$$
\frac{\partial g_{lj}}{\partial \theta_k}
= -e^{-\hat{\xi}_l \theta_l} \cdots \hat{\xi}_k e^{-\hat{\xi}_k \theta_k} \cdots e^{-\hat{\xi}_{j+1} \theta_{j+1}}
= -g_{lk} \, \hat{\xi}_k \, g_{kj}
$$

类似地：

$$
\frac{\partial g_{lj}^{-1}}{\partial \theta_k}
= e^{\hat{\xi}_{j+1} \theta_{j+1}} \cdots e^{\hat{\xi}_k \theta_k} \hat{\xi}_k \cdots e^{\hat{\xi}_l \theta_l}
= g_{kj}^{-1} \, \hat{\xi}_k \, g_{lk}^{-1}
$$

#### 代入与化简

$$
\begin{aligned}
\frac{\partial}{\partial \theta_k} \left[ g_{lj} \hat{\xi}_j g_{lj}^{-1} \right]
&= (-g_{lk} \hat{\xi}_k g_{kj}) \hat{\xi}_j g_{lj}^{-1}
+ g_{lj} \hat{\xi}_j (g_{kj}^{-1} \hat{\xi}_k g_{lk}^{-1}) \\
&= -g_{lk} \hat{\xi}_k g_{kj} \hat{\xi}_j g_{kj}^{-1} g_{lk}^{-1}
+ g_{lk} g_{kj} \hat{\xi}_j g_{kj}^{-1} \hat{\xi}_k g_{lk}^{-1} \quad (\because g_{lj} = g_{lk} g_{kj}) \\
&= g_{lk} \left( -\hat{\xi}_k \, g_{kj} \hat{\xi}_j g_{kj}^{-1}
+ g_{kj} \hat{\xi}_j g_{kj}^{-1} \, \hat{\xi}_k \right) g_{lk}^{-1} \quad (\text{提取公因子 } g_{lk} \text{ 和 } g_{lk}^{-1}) \\
&= g_{lk} \left[ g_{kj} \hat{\xi}_j g_{kj}^{-1},\; \hat{\xi}_k \right] g_{lk}^{-1}
\end{aligned}
$$

> 最后一步利用了李括号的定义：$[X, Y] = XY - YX$，这里取 $X = g_{kj} \hat{\xi}_j g_{kj}^{-1}$ 和 $Y = \hat{\xi}_k$。

取 $\vee$（逆-hat 展开为向量）并用伴随映射表示：

$$
\begin{aligned}
\frac{\partial (A_{lj} \xi_j)}{\partial \theta_k}
&= \left( g_{lk} \left[ g_{kj} \hat{\xi}_j g_{kj}^{-1},\; \hat{\xi}_k \right] g_{lk}^{-1} \right)^{\vee} \\
&= \operatorname{Ad}_{g_{lk}} \left( \left[ g_{kj} \hat{\xi}_j g_{kj}^{-1},\; \hat{\xi}_k \right]^{\vee} \right) \\
&= A_{lk} \, [A_{kj} \xi_j, \, \xi_k]
\end{aligned}
$$

$\blacksquare$ **证毕（QED）**

---

## 核心公式速查表

| 概念 | 公式 | 编号 |
|------|------|------|
| 单连杆动能 | $T_i = \frac{1}{2} \dot{\theta}^T J_i^T(\theta) \mathcal{M}_i J_i(\theta) \dot{\theta}$ | (4.17) |
| 机械臂总动能 | $T = \frac{1}{2} \dot{\theta}^T M(\theta) \dot{\theta}$ | (4.18) |
| 机械臂惯性矩阵 | $M(\theta) = \sum_{i=1}^{n} J_i^T(\theta) \mathcal{M}_i J_i(\theta)$ | (4.19) |
| Lagrangian | $\mathcal{L} = \frac{1}{2} \dot{\theta}^T M(\theta) \dot{\theta} - V(\theta)$ | (4.20) |
| Christoffel 符号 | $\Gamma_{ijk} = \frac{1}{2} \left(\frac{\partial M_{ij}}{\partial \theta_k} + \frac{\partial M_{ik}}{\partial \theta_j} - \frac{\partial M_{kj}}{\partial \theta_i}\right)$ | (4.22) |
| 运动方程（展开） | $\sum_j M_{ij} \ddot{\theta}_j + \sum_{j,k} \Gamma_{ijk} \dot{\theta}_j \dot{\theta}_k + \frac{\partial V}{\partial \theta_i} = \Upsilon_i$ | (4.21) |
| Coriolis 矩阵 | $C_{ij} = \sum_k \Gamma_{ijk} \dot{\theta}_k$ | (4.23) |
| 标准动力学方程 | $M(\theta) \ddot{\theta} + C(\theta, \dot{\theta}) \dot{\theta} + N(\theta, \dot{\theta}) = \tau$ | (4.24) |
| 惯性矩阵元素 | $M_{ij}(\theta) = \sum_{l=\max(i,j)}^{n} \xi_i^T A_{li}^T \mathcal{M}_l' A_{lj} \xi_j$ | (4.29) |
| 关键导数关系 | $\frac{\partial (A_{lj} \xi_j)}{\partial \theta_k} = A_{lk} [A_{kj} \xi_j, \xi_k]$ | — |

---

## 主要知识点总结

### 1. 从单连杆到整体：逐层构建

- $J_i(\theta)$ 描述"关节速度 → 第 $i$ 连杆体速度"的映射
- 每个连杆在关节空间中的"有效惯性"为 $J_i^T \mathcal{M}_i J_i$
- 总惯性矩阵是各连杆贡献的**和**：$M(\theta) = \sum_i J_i^T \mathcal{M}_i J_i$

### 2. Lagrangian 方法的威力

- 只需写出动能 $T$ 和势能 $V$，自动获得运动方程
- Euler-Lagrange 方程的繁琐偏导可以通过 Christoffel 符号 $\Gamma_{ijk}$ 统一处理
- 最终获得**对任何 $n$ 自由度开链机械臂都成立**的标准形式

### 3. 动力学方程的物理结构

| 项 | 依赖于 | 物理本质 |
|----|--------|----------|
| $M(\theta) \ddot{\theta}$ | $\theta, \ddot{\theta}$ | 惯性力——加速度所需的力矩 |
| $C(\theta, \dot{\theta}) \dot{\theta}$ | $\theta, \dot{\theta}$ | 科氏力 + 离心力——速度耦合效应 |
| $N(\theta, \dot{\theta})$ | $\theta, \dot{\theta}$ | 重力 + 阻尼——外部有势力和耗散力 |

### 4. Proposition 4.3 的深层含义

- $M_{ij}$ 显式依赖于 twist $\xi$ 和伴随变换的链式乘积
- 元素 $M_{ij}$ 有**稀疏耦合结构**：只有同时作用于关节 $i$ 和 $j$ 的连杆才贡献
- 偏导关系 $\frac{\partial (A_{lj} \xi_j)}{\partial \theta_k} = A_{lk} [A_{kj} \xi_j, \xi_k]$ 是计算 $\Gamma_{ijk}$ 的核心——它将惯性矩阵对构型的导数**用李括号表达**，反映了 $SE(3)$ 的非交换几何结构

### 5. 课件勘误提醒

课件特别指出 MLS 教材 p.168 对 $J_i$ 中 $\xi_j^{\dagger}$ 的表达式**与 p.176 的写法不一致**。正确的表达式应区分 $j < i$（需要变换 $j+1$ 到 $i$ 的关节）和 $j = i$（只需初始位姿的逆伴随）。在阅读教材时请注意这一差异。
