# 第四章：开链机械臂中重力的处理 — 课件总结

> 课件：June_1_gravitational_forcesNT.pdf（7 页）
> 对应教材：MLS Chapter 4, §4 — Example 4.4 & 重力项 $N(\theta, \dot{\theta})$

---

## 一、运动方程中 $N(\theta, \dot{\theta})$ 的构成回顾

### 1.1 回顾标准动力学方程

上一讲我们推导了开链机械臂的标准动力学方程（教材 p.171）：

$$
M(\theta) \, \ddot{\theta} + C(\theta, \dot{\theta}) \, \dot{\theta} + N(\theta, \dot{\theta}) = \tau \tag{4.24}
$$

其中 $N(\theta, \dot{\theta}) \in \mathbb{R}^n$ 是一个**列向量**，其第 $i$ 个分量定义为（教材 p.170）：

$$
-N_i(\theta, \dot{\theta}) = -\frac{\partial V}{\partial \theta_i} - \beta_i \dot{\theta}_i
$$

移项后：

$$
\boxed{N_i(\theta, \dot{\theta}) = \frac{\partial V}{\partial \theta_i} + \beta_i \dot{\theta}_i}
$$

| 符号 | 含义 | 说明 |
|------|------|------|
| $\frac{\partial V}{\partial \theta_i}$ | 重力（保守力）对关节 $i$ 的贡献 | $V(\theta) = \sum_{i=1}^n m_i g \, h_i(\theta)$ |
| $\beta_i \dot{\theta}_i$ | 粘性阻尼力矩 | 关节轴承摩擦的简化模型 |

> ⚠️ **关键提醒**：$N_i$ 一般来说依赖于**所有 $n$ 个关节角**和**角速度**，而不仅仅是第 $i$ 个。这是因为势能 $V(\theta)$ 中的 $h_i(\theta)$ —— 第 $i$ 连杆质心的高度 —— 是**所有 $n$ 个关节角的函数**（教材 p.169 明确指出这一点）。

---

## 二、教材 Example 4.4 的不足

课件明确指出：**MLS 教材的 Example 4.4（p.177）并不是一个好的例子**。

> 📖 原因：该例题没有充分展示 $h_i(\theta)$ 依赖于所有 $n$ 个关节角这一事实。学生容易误以为第 $i$ 根连杆的重力只依赖于 $\theta_1, \dots, \theta_i$，而实际上它也依赖于下游关节。

课件建议使用**更好的例子**来理解重力项——通过虚功原理直接计算每个连杆重力对每个关节力矩的贡献。

---

## 三、利用虚功原理计算重力贡献

### 3.1 基本思路

重力是有势力（conservative force），其产生的广义力为 $-\frac{\partial V}{\partial \theta}$。但我们可以**不直接对势能求偏导**，而是通过 **Jacobian 转置**将重力 wrench 映射到关节力矩。这建立了动力学与之前 §4.2（力-力矩关系）的桥梁。

### 3.2 虚功分析

考虑第 $i$ 根连杆所受的**重力**。在空间坐标系中，重力是一个纯力（不产生力矩）：

$$
F_{wi}^s = \begin{bmatrix} 0 \\ 0 \\ -m_i g \\ 0 \\ 0 \\ 0 \end{bmatrix} \in \mathbb{R}^6
$$

> 前三个分量是力（沿 $-z$ 方向的重力，大小 $m_i g$），后三个分量为零（重力通过质心，不产生绕质心的力矩）。

重力所做的**虚功**（virtual work）等于广义力乘以虚位移：

$$
\delta W_c = -\delta \theta^T \frac{\partial V}{\partial \theta}
$$

另一方面，对第 $i$ 根连杆单独来看，重力做的虚功又等于：

$$
\delta W_{ci} = V_i^{bT} F_{wi}^b \, \delta t = (J_i(\theta) \dot{\theta})^T F_{wi}^b \, \delta t = \dot{\theta}^T J_i^T(\theta) F_{wi}^b \, \delta t
$$

用虚位移 $\delta \theta = \dot{\theta} \delta t$ 表达：

$$
\boxed{\delta W_{ci} = \delta \theta^T J_i^T(\theta) \, F_{wi}^b}
$$

> 关键：这里使用的是**体坐标系中的重力 wrench** $F_{wi}^b$，而不是空间坐标系中的 $F_{wi}^s$。两者通过伴随映射的转置关联。

### 3.3 重力对势能的贡献

由于虚功的两种计算方式应该等价（保守力做的虚功等于势能减少的负值）：

$$
\delta W_{ci} = -\delta \theta^T \frac{\partial V_i}{\partial \theta}
$$

与 $\delta W_{ci} = \delta \theta^T J_i^T(\theta) F_{wi}^b$ 对比，立即得到：

$$
\boxed{\frac{\partial V_i}{\partial \theta} = -J_i^T(\theta) \, F_{wi}^b}
$$

对所有连杆求和，得到**总重力的广义力**：

$$
\boxed{\frac{\partial V}{\partial \theta} = \sum_{i=1}^{n} \frac{\partial V_i}{\partial \theta}
= -\sum_{i=1}^{n} J_i^T(\theta) \, F_{wi}^b}
$$

> ✅ **核心洞察**：重力产生的广义力 = 各连杆 Jacobian 的转置 × 该连杆上的重力 wrench（在体坐标系中表示）的**负求和**。这与 §4.2 的 $\tau = J^T F$ 形式完全一致！

---

## 四、$F_{wi}^b$ 的显式计算

### 4.1 Jacobian $J_i(\theta)$ 的列结构（回顾）

$$
J_i(\theta) = \begin{bmatrix} \xi_1^{\dagger} & \cdots & \xi_i^{\dagger} & 0 & \cdots & 0 \end{bmatrix}
$$

其中（使用课件修正后的版本，与教材 p.168 & p.176 兼容）：

$$
\xi_j^{\dagger} =
\begin{cases}
\operatorname{Ad}^{-1}_{\left(e^{\hat{\xi}_{j+1} \theta_{j+1}} \cdots e^{\hat{\xi}_i \theta_i} g_{sl_i}(0)\right)} \, \xi_j, & j < i \\[8pt]
\operatorname{Ad}^{-1}_{g_{sl_i}(0)} \, \xi_j, & j = i
\end{cases}
$$

### 4.2 将空间重力力螺旋变换到体坐标系

已知空间坐标中的重力 wrench：

$$
F_{wi}^s = \begin{bmatrix} 0 \\ 0 \\ -m_i g \\ 0 \\ 0 \\ 0 \end{bmatrix}
$$

利用伴随映射的转置进行变换（教材 eq. (2.67), p.63）：

$$
\boxed{F_{wi}^b = \operatorname{Ad}_{g_{sl_i}}^T \, F_{wi}^s}
$$

> **实际计算方法**：$g_{sl_i}$ 是 $4 \times 4$ 的齐次变换矩阵。其第 3 行（对应 $-z$ 方向的平动）的前 3 个元素乘以 $-m_i g$，构成 $F_{wi}^b$ 的前 3 个分量（力分量），其余为 0。

| 步骤 | 操作 |
|------|------|
| 1 | 计算 $g_{sl_i}(\theta) = e^{\hat{\xi}_1 \theta_1} \cdots e^{\hat{\xi}_i \theta_i} g_{sl_i}(0)$ |
| 2 | 取 $\operatorname{Ad}_{g_{sl_i}}^T$（$6 \times 6$ 矩阵） |
| 3 | 乘上 $F_{wi}^s = [0, 0, -m_i g, 0, 0, 0]^T$ |
| 4 | 得到 $F_{wi}^b$（体坐标系中的重力 wrench） |

> **技巧**：实际上不需要构造完整的 $\operatorname{Ad}^T$ 矩阵。只需将 $g_{sl_i}$ 的旋转部分（$R_i$）的**第 3 列**（重力在空间坐标系中是 $-z$ 方向，旋转后变成 $-R_i^T \mathbf{e}_z$）乘以 $-m_i g$，作为 $F_{wi}^b$ 的力分量；力矩分量为零（重力作用于质心）。

---

## 五、虚位移计算的形式检验

### 5.1 体速度与虚功的关系

连杆 $i$ 的体速度由 Jacobian 给出：

$$
V_i^b = J_i(\theta) \, \dot{\theta}
$$

根据教材 p.61，wrench 在体速度上做的**机械功率**（mechanical power）为：

$$
\Delta W = V_{ab}^{bT} \, F^b
$$

应用到第 $i$ 连杆上的重力：

$$
\Delta W_i = V_i^{bT} \, F_{wi}^b = \dot{\theta}^T J_i^T(\theta) \, F_{wi}^b
$$

用虚位移替代（$\delta \theta = \dot{\theta} \delta t$，$\delta W = \Delta W \cdot \delta t$）：

$$
\boxed{\delta W_i = \delta \theta^T J_i^T(\theta) \, F_{wi}^b}
$$

这与之前的结论完全一致，验证了推导的正确性。

---

## 核心公式速查表

| 概念 | 公式 | 来源 |
|------|------|------|
| $N$ 的定义 | $N_i = \frac{\partial V}{\partial \theta_i} + \beta_i \dot{\theta}_i$ | p.170 |
| 总势能 | $V(\theta) = \sum_{i=1}^{n} m_i g \, h_i(\theta)$ | p.169 |
| 虚功（总） | $\delta W_c = -\delta \theta^T \frac{\partial V}{\partial \theta}$ | — |
| 虚功（单连杆） | $\delta W_{ci} = \delta \theta^T J_i^T(\theta) F_{wi}^b$ | — |
| 重力广义力（单连杆） | $\frac{\partial V_i}{\partial \theta} = -J_i^T(\theta) F_{wi}^b$ | — |
| 重力广义力（全部） | $\frac{\partial V}{\partial \theta} = -\sum_{i=1}^{n} J_i^T(\theta) F_{wi}^b$ | — |
| 空间重力 wrench | $F_{wi}^s = [0, 0, -m_i g, 0, 0, 0]^T$ | — |
| 体坐标重力 wrench | $F_{wi}^b = \operatorname{Ad}_{g_{sl_i}}^T F_{wi}^s$ | (2.67) |
| 体速度-虚功关系 | $\delta W_i = \delta \theta^T J_i^T(\theta) F_{wi}^b$ | p.61 |

---

## 主要知识点总结

### 1. $N(\theta, \dot{\theta})$ 不是什么简单的东西

- $N_i$ 依赖于**全部**关节角和角速度（不仅第 $i$ 个），因为每个连杆的高度 $h_i(\theta)$ 是所有关节的函数
- 教材 Example 4.4 容易误导学生

### 2. 重力项 = Jacobian 转置 × 重力 wrench

- 这与 §4.2 的 $\tau = J^T F$ 完全一致
- Jacobian 建立的是"关节速度 → 末端速度"的映射
- 其转置建立的是"外部 wrench → 关节力矩"的映射
- 重力 wrench 作用于**每个连杆的质心**，通过各连杆自己的 $J_i(\theta)$ 转化为关节力矩贡献

### 3. 体坐标系 vs 空间坐标系中的重力

- 空间坐标系中重力始终是沿 $-z$ 方向的纯力：$F_{wi}^s = [0, 0, -m_i g, 0, 0, 0]^T$
- 但在体坐标系中，$F_{wi}^b$ 的方向随连杆姿态变化：$F_{wi}^b = \operatorname{Ad}_{g_{sl_i}}^T F_{wi}^s$
- 这个变换体现了连杆旋转后，重力在连杆体坐标系中"看起来"的方向

### 4. 内容串联

本讲将三部分知识串联起来：

1. **Lagrangian 动力学**（§4.4）：$M\ddot{\theta} + C\dot{\theta} + N = \tau$ 中 $N$ 的由来
2. **Jacobian 与力**（§4.2）：$\tau = J^T F$ 的重力版本
3. **刚体动力学**（§2.4）：wrench 在不同坐标系间的变换 $\operatorname{Ad}^T$
