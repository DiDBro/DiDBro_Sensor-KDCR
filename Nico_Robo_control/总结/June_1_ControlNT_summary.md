# 第五章：开链机械臂的控制 — Computed Torque 方法 — 课件总结

> 课件：June_1_ControlNT.pdf（11 页）
> 对应教材：MLS Chapter 5, §5.1–§5.2（轨迹跟踪与 Computed Torque 控制）

---

## 一、控制问题的基本框架

### 1.1 Plant（被控对象）模型

第四章导出的开链机械臂动力学方程为我们的**物理模型**（plant）：

$$
M(\theta) \, \ddot{\theta} + C(\theta, \dot{\theta}) \, \dot{\theta} + N(\theta, \dot{\theta}) = \tau \tag{4.47}
$$

- 这是关于 $\theta(t)$ 的**非线性 ODE**
- 给定力矩输入 $\tau(t)$，可以解出关节轨迹 $\theta(t)$（正动力学）
- 这个模型用于在仿真中**代表真实机械臂**（plant）

### 1.2 仿真中的"双重身份"

> ⚠️ **重要概念区分**：在仿真中，同一个数学模型会出现**两次**，但扮演不同的角色：
>
> | 角色 | 含义 | 输入/输出 |
> |------|------|----------|
> | **Plant（被控对象）** | "真实"机械臂的数学模型 | 输入 $\tau$，输出 $\theta$ |
> | **Controller（控制器）** | 基于模型计算控制力矩的算法 | 输入 $\theta_d, \theta, \dot{\theta}$，输出 $\tau$ |

> 真正的物理机械臂是 plant，控制器只是算法。但在仿真中两者都用同一套方程来描述，这是产生混淆的常见原因。

---

## 二、开环控制（Open-Loop Control）

### 2.1 基本思路

设 $\theta_d(t)$ 是我们希望跟踪的**期望关节轨迹**（至少二阶可导）。一个最直接的想法是：

> 将期望轨迹代入动力学方程，算出"理论上"需要的力矩。

**开环控制律**（教材 §5.1, p.190）：

$$
\boxed{\tau = M(\theta_d) \, \ddot{\theta}_d + C(\theta_d, \dot{\theta}_d) \, \dot{\theta}_d + N(\theta_d, \dot{\theta}_d)}
$$

### 2.2 开环控制的局限性

| 优点 | 缺点 |
|------|------|
| 结构简单，易于实现 | **不鲁棒（not robust）**：对初始误差、参数不确定性、外部扰动无抵抗力 |
| 计算量小（只需给定轨迹） | 一旦偏离 $\theta_d$，没有任何修正机制 |
| 适用于精确建模的系统 | 实际系统中摩擦、建模误差、扰动不可避免 |

> 开环控制就像蒙着眼睛走路——你心里知道每一步该迈多大，但一旦走偏，就无法纠正。

---

## 三、Computed Torque 控制（§5.2, p.191）

### 3.1 核心思想

**Computed Torque**（计算力矩控制）是开环控制的**反馈增强版**。思想很简单：

1. 用**实际的** $\theta, \dot{\theta}$（而非期望的 $\theta_d, \dot{\theta}_d$）来计算惯性补偿、科氏力、重力
2. 用**PD 反馈**来修正跟踪误差

### 3.2 控制律

$$
\boxed{\tau = M(\theta) \left( \ddot{\theta}_d - K_v \dot{e} - K_p e \right) + C(\theta, \dot{\theta}) \, \dot{\theta} + N(\theta, \dot{\theta})} \tag{4.49}
$$

其中：

| 符号 | 含义 | 维度 |
|------|------|------|
| $e = \theta - \theta_d$ | 跟踪误差 | $\mathbb{R}^n$ |
| $\dot{e} = \dot{\theta} - \dot{\theta}_d$ | 跟踪误差速度 | $\mathbb{R}^n$ |
| $K_p$ | 位置反馈增益矩阵（正定对称） | $\mathbb{R}^{n \times n}$ |
| $K_v$ | 速度反馈增益矩阵（正定对称） | $\mathbb{R}^{n \times n}$ |

> **直觉理解**：$M(\theta)(\ddot{\theta}_d - K_v \dot{e} - K_p e)$ 就像用 PD 控制来修改期望加速度——如果实际位置落后于期望（$e > 0$），就"加大油门"增加加速度指令。

### 3.3 前馈 + 反馈的分解

将控制律 (4.49) 拆解为**前馈（feedforward）**和**反馈（feedback）**两个分量：

$$
\begin{aligned}
\tau &= \underbrace{M(\theta) \, \ddot{\theta}_d + C(\theta, \dot{\theta}) \, \dot{\theta} + N(\theta, \dot{\theta})}_{\tau_{ff} \text{ — 前馈分量}}
+ \underbrace{M(\theta) \left( -K_v \dot{e} - K_p e \right)}_{\tau_{fb} \text{ — 反馈分量}}
\end{aligned}
$$

| 分量 | 作用 | 物理含义 |
|------|------|----------|
| $\tau_{ff}$ | 补偿已知动力学 | "按照模型，维持这条轨迹需要多少力矩" |
| $\tau_{fb}$ | 消除跟踪误差 | "如果偏了，修正回来需要多少额外力矩" |

> ✅ **分离原则**：前馈负责"干活"（跟随轨迹），反馈负责"纠偏"（消除误差）。如果跟踪完美（$e = \dot{e} = 0$），反馈分量为零，退化为开环控制。

---

## 四、误差动力学（Error Dynamics）

### 4.1 闭环误差方程

将控制律 (4.49) 代入 plant 方程 (4.47)：

$$
\begin{aligned}
M(\theta) \, \ddot{\theta} + C(\theta, \dot{\theta}) \, \dot{\theta} + N(\theta, \dot{\theta})
&= M(\theta) \left( \ddot{\theta}_d - K_v \dot{e} - K_p e \right) + C(\theta, \dot{\theta}) \, \dot{\theta} + N(\theta, \dot{\theta})
\end{aligned}
$$

$C \dot{\theta}$ 和 $N$ 互相抵消，两边消去 $M(\theta)$（因为 $M(\theta)$ 正定可逆）：

$$
\ddot{\theta} = \ddot{\theta}_d - K_v \dot{e} - K_p e
$$

整理为**误差的线性微分方程**：

$$
\boxed{\ddot{e} + K_v \dot{e} + K_p e = 0} \tag{4.50}
$$

> 🎯 **最关键的洞察**：非线性动力学被**精确抵消**了！原来高度非线性的机械臂动力学，经过 Computed Torque 控制后，误差动力学变成了一个**线性二阶系统**。

### 4.2 状态空间形式

将二阶误差方程改写为一阶状态空间方程：

$$
\boxed{\frac{d}{dt} \begin{bmatrix} e \\ \dot{e} \end{bmatrix}
= \begin{bmatrix} 0 & I \\ -K_p & -K_v \end{bmatrix}
\begin{bmatrix} e \\ \dot{e} \end{bmatrix}}
$$

令 $A = \begin{bmatrix} 0 & I \\ -K_p & -K_v \end{bmatrix} \in \mathbb{R}^{2n \times 2n}$。

> 误差动力学的稳定性完全取决于矩阵 $A$ 的特征值——它们必须在左半平面（负实部）。

---

## 五、特征值配置（Eigenvalue Placement）

### 5.1 通过选增益来配置特征值

$A^T = \begin{bmatrix} 0 & -K_p^T \\ I & -K_v^T \end{bmatrix}$。由于 $|A| = |A^T|$，$A$ 和 $A^T$ 有相同的特征值。

计算 $A^T$ 的特征多项式：

$$
|\lambda I_{2n} - A^T| =
\begin{vmatrix}
\lambda I_n & K_p^T \\
-I_n & \lambda I_n + K_v^T
\end{vmatrix} = 0
$$

### 5.2 块矩阵行列式的化简

课件末页提示：对于分块方阵 $\begin{bmatrix} A & B \\ C & D \end{bmatrix}$，若 $C$ 和 $D$ **可交换**（$CD = DC$），则：

$$
\begin{vmatrix} A & B \\ C & D \end{vmatrix} = |AD - BC|
$$

此处 $C = -I_n$，$D = \lambda I_n + K_v^T$，显然 $(-I_n)(\lambda I_n + K_v^T) = (\lambda I_n + K_v^T)(-I_n)$，满足交换条件。

利用块行列式公式（$A = \lambda I_n$, $B = K_p^T$, $C = -I_n$, $D = \lambda I_n + K_v^T$）：

$$
\begin{aligned}
|\lambda I_{2n} - A^T|
&= \left| \lambda I_n (\lambda I_n + K_v^T) - K_p^T (-I_n) \right| \\
&= \left| \lambda^2 I_n + \lambda K_v^T + K_p^T \right| = 0
\end{aligned}
$$

### 5.3 对角线增益的情况

将 $K_p$ 和 $K_v$ 选为**对角正定矩阵**（最简单常见的选择）：

$$
K_p = \operatorname{diag}(K_{p11}, \dots, K_{pnn}), \quad
K_v = \operatorname{diag}(K_{v11}, \dots, K_{vnn})
$$

特征多项式简化为 $n$ 个独立二阶系统的乘积：

$$
\boxed{\prod_{i=1}^{n} \left( \lambda_i^2 + \lambda_i K_{vii} + K_{pii} \right) = 0}
$$

> 🎯 **这意味着**：选择对角增益时，$n$ 个关节的误差动力学**完全解耦**。每个关节 $i$ 的误差由独立的二阶微分方程 $\ddot{e}_i + K_{vii} \dot{e}_i + K_{pii} e_i = 0$ 描述。

### 5.4 如何选择增益

对于每个关节的误差方程 $\ddot{e}_i + K_{vii} \dot{e}_i + K_{pii} e_i = 0$：

- 自然频率：$\omega_{ni} = \sqrt{K_{pii}}$
- 阻尼比：$\zeta_i = \frac{K_{vii}}{2\sqrt{K_{pii}}}$

| 目标 | 选法 |
|------|------|
| 临界阻尼（无超调） | $K_{vii} = 2\sqrt{K_{pii}}$（$\zeta_i = 1$） |
| 更快的收敛 | 增大 $K_{pii}$（提高自然频率） |
| 更小的超调 | 增大 $K_{vii}$（增大阻尼） |

---

## 六、Proposition 4.8 的证明：指数收敛性

### 6.1 命题陈述

> **Proposition 4.8（p.192）**：若 $K_p, K_v \in \mathbb{R}^{n \times n}$ 是**正定对称**矩阵，则 Computed Torque 控制律保证跟踪误差**指数收敛**到零。

### 6.2 证明

设 $\lambda \in \mathbb{C}$ 为 $A$ 的特征值，对应特征向量 $v = (v_1, v_2) \in \mathbb{C}^{2n} \setminus \{0\}$：

$$
\lambda \begin{bmatrix} v_1 \\ v_2 \end{bmatrix}
= \begin{bmatrix} 0 & I \\ -K_p & -K_v \end{bmatrix}
\begin{bmatrix} v_1 \\ v_2 \end{bmatrix}
= \begin{bmatrix} v_2 \\ -K_p v_1 - K_v v_2 \end{bmatrix}
$$

**第一步**：证明 $\lambda = 0$ 不可能是特征值。
- 若 $\lambda = 0$，则 $v_2 = 0$ 且 $-K_p v_1 - 0 = 0$，由于 $K_p$ 正定 $\Rightarrow v_1 = 0 \Rightarrow v = 0$，矛盾。

**第二步**：证明 $v_1 \neq 0$ 且 $v_2 \neq 0$。
- 若 $v_1 = 0$，则 $\lambda \cdot 0 = v_2 \Rightarrow v_2 = 0 \Rightarrow v = 0$，矛盾。
- 若 $v_2 = 0$，则 $\lambda v_1 = 0 \Rightarrow \lambda = 0$（因为 $v_1 \neq 0$），与第一步矛盾。

**第三步**：不失一般性，令 $\|v_1\| = 1$（即 $v_1^* v_1 = 1$，$v_1^*$ 为共轭转置）。

$$
\begin{aligned}
\lambda^2 &= \lambda^2 v_1^* v_1 = v_1^* \lambda^2 v_1 = v_1^* \lambda v_2 \\
&= v_1^* (-K_p v_1 - K_v v_2) \\
&= -v_1^* K_p v_1 - \lambda v_1^* K_v v_1 \\
&= -\beta - \alpha \lambda
\end{aligned}
$$

其中：
- $\alpha = v_1^* K_v v_1 > 0$（因为 $K_v$ 正定）
- $\beta = v_1^* K_p v_1 > 0$（因为 $K_p$ 正定）

**第四步**：特征值满足二次方程：

$$
\boxed{\lambda^2 + \alpha \lambda + \beta = 0, \qquad \alpha > 0,\; \beta > 0}
$$

二次方程 $\lambda^2 + \alpha \lambda + \beta = 0$（系数全正）的根满足：

$$
\lambda = \frac{-\alpha \pm \sqrt{\alpha^2 - 4\beta}}{2}
$$

- 若 $\alpha^2 \geq 4\beta$：$\lambda$ 为负实数
- 若 $\alpha^2 < 4\beta$：$\lambda$ 为具有负实部 $-\alpha/2$ 的共轭复数

无论哪种情况，**所有特征值都有负实部**：$\operatorname{Re}(\lambda_i) < 0, \forall i$。

因此误差系统 $\frac{d}{dt}[e;\dot{e}] = A[e;\dot{e}]$ 是**指数稳定**的。

$\blacksquare$ **证毕（QED）**

---

## 核心公式速查表

| 概念 | 公式 | 编号 |
|------|------|------|
| Plant 模型 | $M\ddot{\theta} + C\dot{\theta} + N = \tau$ | (4.47) |
| 开环控制律 | $\tau = M(\theta_d)\ddot{\theta}_d + C(\theta_d, \dot{\theta}_d)\dot{\theta}_d + N(\theta_d, \dot{\theta}_d)$ | — |
| Computed Torque | $\tau = M(\ddot{\theta}_d - K_v \dot{e} - K_p e) + C\dot{\theta} + N$ | (4.49) |
| 前馈分量 | $\tau_{ff} = M\ddot{\theta}_d + C\dot{\theta} + N$ | — |
| 反馈分量 | $\tau_{fb} = M(-K_v \dot{e} - K_p e)$ | — |
| 误差动力学 | $\ddot{e} + K_v \dot{e} + K_p e = 0$ | (4.50) |
| 状态空间 | $\frac{d}{dt}[e;\dot{e}] = \begin{bmatrix} 0 & I \\ -K_p & -K_v \end{bmatrix} [e;\dot{e}]$ | — |
| 特征方程 | $\lambda^2 + \alpha \lambda + \beta = 0,\; \alpha, \beta > 0$ | — |

---

## 控制策略对比

| 特性 | 开环控制 | Computed Torque |
|------|----------|-----------------|
| 使用实际 $\theta$？ | ❌ 只用 $\theta_d$ | ✅ 用实际 $\theta, \dot{\theta}$ |
| 反馈修正 | 无 | PD 型反馈 |
| 误差动力学 | 无保证 | 指数收敛 |
| 鲁棒性 | 差 | 较好（但依赖精确模型） |
| 计算量 | 小 | 较大（需实时计算 $M, C, N$） |
| 适用场景 | 高精度系统、标定好的轨迹 | 一般轨迹跟踪 |

---

## 主要知识点总结

### 1. 仿真中的"双重身份"是理解控制的关键

同一个方程 $M\ddot{\theta} + C\dot{\theta} + N = \tau$ 可以表示 plant 或 controller，但物理含义完全不同。Plant 是"真实世界"（$\tau \mapsto \theta$），Controller 是"计算法则"（$\theta_d, \theta \mapsto \tau$）。

### 2. Computed Torque = 反馈线性化（Feedback Linearization）

- Controller 中的 $C\dot{\theta} + N$ 精确抵消了 plant 中的非线性项
- 剩下的 $M(\ddot{\theta}_d - K_v \dot{e} - K_p e)$ 将系统变成线性误差动力学
- 这是非线性控制中**反馈线性化**方法的经典实例

### 3. 误差动力学的三个层次

| 层次 | 形式 | 含义 |
|------|------|------|
| 原始动力学 | $M\ddot{\theta} + C\dot{\theta} + N = \tau$ | 非线性、耦合 |
| 误差动力学 | $\ddot{e} + K_v \dot{e} + K_p e = 0$ | 线性、解耦 |
| 特征值分析 | $\lambda^2 + \alpha \lambda + \beta = 0,\; \alpha,\beta > 0$ | 所有根在左半平面 |

### 4. 证明的技术要点

- 引入特征向量并令 $v_1$ 归一化（$\|v_1\| = 1$）
- 利用 $v_2 = \lambda v_1$ 替代 $v_2$，归结为 $\lambda$ 的二次方程
- $\alpha, \beta > 0$ 来自于 $K_v, K_p$ 的正定性
- 二次方程系数全正 $\Rightarrow$ 根有负实部（Routh-Hurwitz 判据的简化版）

### 5. 实际应用中的注意事项

- Computed Torque 要求**精确的动力学模型**（$M, C, N$ 都需要实时计算）
- 模型不精确时，误差方程中会有残留非线性项
- 实际系统中通常加入**积分项**（PID 型）来消除稳态误差
- 增益 $K_p, K_v$ 的选择需要在收敛速度与控制力矩之间权衡（过大增益会导致力矩饱和）
