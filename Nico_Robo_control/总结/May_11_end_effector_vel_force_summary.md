# 第四章：末端执行器速度与力 — 课件总结

> 课件：May_11_end_effector_vel_forcNT.pdf（14页）
> 对应教材：MLS Chapter 4.1–4.2

---

## §4.1 末端执行器速度（End-effector Velocity）

### 4.1.1 速度的基本表达

设机械臂关节空间路径为 $\theta(t) \in \mathcal{Q}$，末端执行器的**完整位姿路径**为 $g_{st}(\theta(t)) \in SE(3)$。

末端执行器的**瞬时空间速度**可表示为 **twist（旋量）** 形式：

$$
\widehat{V}_{st}^s = \dot{g}_{st}(\theta) \, g_{st}^{-1}(\theta)
$$

> 该定义来自教材公式 (2.53)，其中 $\widehat{V}_{st}^s \in se(3)$ 是空间速度的 Lie 代数形式。

### 4.1.2 链式法则展开

对 $g_{st}(\theta(t))$ 求时间导数，应用链式法则：

$$
\dot{g}_{st}(\theta) = \sum_{i=1}^{n} \frac{\partial g_{st}(\theta)}{\partial \theta_i} \frac{d\theta_i}{dt} = \sum_{i=1}^{n} \frac{\partial g_{st}(\theta)}{\partial \theta_i} \dot{\theta}_i
$$

将其代入速度表达式：

$$
\widehat{V}_{st}^s = \left( \sum_{i=1}^{n} \frac{\partial g_{st}(\theta)}{\partial \theta_i} \dot{\theta}_i \right) g_{st}^{-1}(\theta)
= \sum_{i=1}^{n} \left[ \frac{\partial g_{st}(\theta)}{\partial \theta_i} g_{st}^{-1}(\theta) \right] \dot{\theta}_i \tag{3.51}
$$

### 4.1.3 空间 Jacobian 矩阵的引出

可以证明，每一项 $\frac{\partial g_{st}(\theta)}{\partial \theta_i} g_{st}^{-1}(\theta)$ 也是一个 twist（属于 $se(3)$）。因此可以将其"展开（$\vee$）"为 6 维向量，得到：

$$
V_{st}^s = J_{st}^s(\theta) \, \dot{\theta}
$$

其中**空间机械臂 Jacobian**（Spatial Manipulator Jacobian）定义为：

$$
J_{st}^s(\theta) = 
\begin{bmatrix}
\left(\frac{\partial g_{st}}{\partial \theta_1} g_{st}^{-1}\right)^{\vee} & 
\cdots & 
\left(\frac{\partial g_{st}}{\partial \theta_n} g_{st}^{-1}\right)^{\vee}
\end{bmatrix} \in \mathbb{R}^{6 \times n} \tag{3.52}
$$

各符号含义：

| 符号 | 含义 | 维度 |
|------|------|------|
| $V_{st}^s$ | 末端执行器的空间速度（向量形式） | $\mathbb{R}^6$ |
| $\dot{\theta}$ | 关节速度向量 | $\mathbb{R}^n$ |
| $J_{st}^s(\theta)$ | 空间机械臂 Jacobian | $\mathbb{R}^{6 \times n}$ |

在每一构型 $\theta$ 处，$J_{st}^s(\theta)$ 将关节速度**线性映射**为末端执行器速度。

### 4.1.4 空间 Jacobian 的列结构

空间 Jacobian 的第 $i$ 列具有明确的几何含义：

$$
J_{st}^s(\theta) = 
\begin{bmatrix}
\xi_1 & \xi_2' & \cdots & \xi_n'
\end{bmatrix}
$$

其中：

$$
\xi_i' = \operatorname{Ad}_{g_{s,i-1}} \, \xi_i
$$

$$
g_{s,i-1} = e^{\hat{\xi}_1 \theta_1} \, e^{\hat{\xi}_2 \theta_2} \, \cdots \, e^{\hat{\xi}_{i-1} \theta_{i-1}} \tag{3.54}
$$

> **几何解释**：空间 Jacobian 的第 $i$ 列，是第 $i$ 个关节的 twist $\xi_i$ 经过**前 $i-1$ 个关节的刚体运动变换**（通过伴随映射 $\operatorname{Ad}$）后，在当前机械臂构型下的表示。

**注意第一列特殊**：$g_{s,0}=I$（单位变换），所以第一列 $\xi_1' = \xi_1$，即第 1 关节的 twist 不需要变换。

### 4.1.5 物体 Jacobian（Body Manipulator Jacobian）

类似地，可以定义**物体 Jacobian** $J_{st}^b(\theta)$，满足：

$$
V_{st}^b = J_{st}^b(\theta) \, \dot{\theta}
$$

其列结构为：

$$
J_{st}^b(\theta) = 
\begin{bmatrix}
\xi_1^{\dagger} & \xi_2^{\dagger} & \cdots & \xi_n^{\dagger}
\end{bmatrix}
$$

其中：

$$
\xi_i^{\dagger} = \operatorname{Ad}_{g_{i,t}}^{-1} \, \xi_i
$$

$$
g_{i,t} = e^{\hat{\xi}_i \theta_i} \, \cdots \, e^{\hat{\xi}_n \theta_n} \, g_{st}(0) \tag{3.55}
$$

> **几何解释**：物体 Jacobian 的第 $i$ 列，是第 $i$ 个关节的 twist $\xi_i$ **在工具坐标系（tool frame）中**当前构型下的表示。这里的 $g_{i,t}$ 是从第 $i$ 个关节坐标系到工具坐标系的变换。

**空间 vs 物体 Jacobian 的区别**：
- 空间 Jacobian：每个关节 twist 从空间坐标系"看"是什么样
- 物体 Jacobian：每个关节 twist 从工具坐标系"看"是什么样

### 4.1.6 空间 Jacobian 与物体 Jacobian 的关系

两者通过末端执行器当前位置的伴随映射相互转换：

$$
J_{st}^s(\theta) = \operatorname{Ad}_{g_{st}(\theta)} \, J_{st}^b(\theta) \tag{3.56}
$$

> 这是一个非常重要的关系——已知一个 Jacobian，可以通过伴随映射直接得到另一个，无需重新逐列计算。

### 4.1.7 末端执行器上点的速度

- 若 $q_b$ 是末端执行器上某点在**工具坐标系**中的坐标，则该点的线速度为：

  $$
  v_{q}^b = \widehat{V}_{st}^b \, q_b = \left( J_{st}^b(\theta) \, \dot{\theta} \right)^{\wedge} \, q_b
  $$

- 若 $q_s$ 是该点在**空间坐标系**中的坐标，则该点的线速度为：

  $$
  v_{q}^s = \widehat{V}_{st}^s \, q_s = \left( J_{st}^s(\theta) \, \dot{\theta} \right)^{\wedge} \, q_s
  $$

> 这里 $(\cdot)^{\wedge}$ 将 6 维向量还原为 $4 \times 4$ 的 twist 矩阵，再作用在点的齐次坐标上。

---

## §4.2 末端执行器力（End-effector Forces）

### 4.2.1 力与关节力矩的关系：推导

**核心问题**：施加在末端执行器上的 **wrench（力螺旋）** $F$ 与**关节力矩** $\tau$ 之间是什么关系？

推导基于**虚功原理**（Principle of Virtual Work）：关节力矩做的功 = 末端执行器 wrench 做的功。

关节一侧的功率是 $\dot{\theta}^T \tau$，末端一侧是 $V_{st}^{b\,T} F_t$。在任意时间段 $[t_1,t_2]$ 内，功的相等意味着功率的相等：

$$
\int_{t_1}^{t_2} \dot{\theta}^T \tau \, dt = W = \int_{t_1}^{t_2} V_{st}^{b\,T} F_t \, dt
$$

将 §4.1 中的速度关系 $V_{st}^b = J_{st}^b(\theta) \dot{\theta}$ 代入：

$$
\int_{t_1}^{t_2} \dot{\theta}^T \tau \, dt = \int_{t_1}^{t_2} \dot{\theta}^T J_{st}^{b\,T} F_t \, dt
$$

由于这对任意关节速度 $\dot{\theta}$ 都成立，被积函数本身相等：

$$
\dot{\theta}^T \tau = \dot{\theta}^T J_{st}^{b\,T} F_t
$$

**最终得到两个等价的力-力矩关系：**

$$
\boxed{\tau = J_{st}^{b\,T}(\theta) \, F_t} \tag{3.59}
$$

$$
\boxed{\tau = J_{st}^{s\,T}(\theta) \, F_s} \tag{3.60}
$$

> $F_t$ 是在工具坐标系中表示的 wrench，$F_s$ 是在空间坐标系中表示的 wrench。两者的关系为 $F_s = \operatorname{Ad}_{g_{st}}^{-T} F_t$。

### 4.2.2 物理含义与重要注意事项

公式 $\tau = J^{b\,T} F_t$ 和 $\tau = J^{s\,T} F_s$ 回答的问题是：

> ✅ **"为抵抗（resist）施加在末端执行器上的 wrench，需要多大的关节力矩 $\tau$？"**

但**一般不能**回答：

> ❌ **"要使得末端执行器对外施加某个指定的 wrench，需要多大的关节力矩？"**

**为什么两者不等价？** 因为末端执行器对外施加力时，除了克服外力，还可能需要克服机械臂自身的惯性力、科氏力、重力等。只有在**静力平衡**（static equilibrium）条件下，两者才等价。

> ⚠️ 请仔细研读教材 MLS p.122 的相关讨论。

### 4.2.3 例题 3.10（教材 p.122）：Jacobian 转置的零空间

**问题背景**：教材图 3.15（p.118）中的三连杆机械臂（例题 3.8），分析哪些施加在末端执行器上的 wrench 不会产生关节力矩。

**已知数据**（来自例题 3.8 p.118，末端为 prismatic 关节）：

空间 Jacobian 为：

$$
J_{st}^s = \begin{bmatrix}
0 & l_1 \cos\theta_1 & l_1 \cos\theta_1 + l_2 \cos(\theta_1+\theta_2) & 0 \\
0 & l_1 \sin\theta_1 & l_1 \sin\theta_1 + l_2 \sin(\theta_1+\theta_2) & 0 \\
0 & 0 & 0 & 1 \\
0 & 0 & 0 & 0 \\
0 & 0 & 0 & 0 \\
1 & 1 & 1 & 0
\end{bmatrix}
$$

> 前三行为线速度分量，后三行为角速度分量。第 4 列为 prismatic 关节，因此其 twist 在前三行只有第 3 行为 1（沿某方向平动），角速度部分全为 0。

转置后：

$$
(J_{st}^s)^T = \begin{bmatrix}
0 & 0 & 0 & 0 & 0 & 1 \\
l_1 c_1 & l_1 s_1 & 0 & 0 & 0 & 1 \\
l_1 c_1 + l_2 c_{12} & l_1 s_1 + l_2 s_{12} & 0 & 0 & 0 & 1 \\
0 & 0 & 1 & 0 & 0 & 0
\end{bmatrix}
$$

> 简写：$c_1 = \cos\theta_1$, $s_1 = \sin\theta_1$, $c_{12} = \cos(\theta_1+\theta_2)$, $s_{12} = \sin(\theta_1+\theta_2)$。

**分析零空间：**

考虑两个特殊方向上的工具 wrench：

$$
F_{N1} = \begin{bmatrix} 0 \\ 0 \\ 0 \\ 1 \\ 0 \\ 0 \end{bmatrix}, \quad
F_{N2} = \begin{bmatrix} 0 \\ 0 \\ 0 \\ 0 \\ 1 \\ 0 \end{bmatrix}
$$

> wrench 的前三个分量为力（force），后三个分量为力矩（moment）。$F_{N1}$ 是纯绕 $x$ 轴的力矩，$F_{N2}$ 是纯绕 $y$ 轴的力矩。

容易验证：$(J_{st}^s)^T F_{N1} = 0$ 且 $(J_{st}^s)^T F_{N2} = 0$，即：

$$
F_{N1}, F_{N2} \in \operatorname{null}\big((J_{st}^s)^T\big)
$$

这意味着由 $\tau = (J_{st}^s)^T F_s$ 可知，这些 wrench **产生的关节力矩为零**。

同时还可以证明：

- $F_{N1}, F_{N2} \in \operatorname{null}\big((J_{st}^b)^T\big)$，即它们在物体 Jacobian 转置的零空间中

**物理含义**：
- 零空间中的 wrench 是机械臂在**当前构型下无力可施**的方向——即使末端执行器在这些方向上受力/受力矩，关节也不会感受到
- 这一结论在空间坐标系和物体坐标系中**同时成立**——物理现象与坐标系的选取无关
- 零空间的维度 = $6 - \text{rank}(J^T)$，代表末端执行器"失去控制"的自由度数量

---

## 📝 补充笔记：MLS p.168 与 p.176 勘误 — 连杆体 Jacobian 的正确计算

> **Source**: `notes/on_MLS_Chapter_4_section_3_1_and_3_3.pdf` (N.J. Theron, May 2026)
> **对应教材**: MLS Chapter 4, §3.1 (p.168) 和 §3.3 (p.176)
> **问题**: 课本在计算第 $i$ 个连杆的**体 Jacobian** $J_{sl_i}^b$ 的列时，公式有误。

---

### A. 问题的提出

在 p.168，MLS 声称 $J_{sl_i}^b$ 的第 $j$ 列 $(j \leq i)$ 由下式计算：

$$\xi_{y_j} = \text{Ad}^{-1}_{\left(e^{\hat{\xi}_j\theta_j}\cdots e^{\hat{\xi}_i\theta_i} g_{sl_i}(0)\right)} \;\xi_j \qquad j \leq i \tag{a}$$

**Theron 指出这是错误的**。正确的公式应为：

$$\boxed{\xi_{y_j} = \begin{cases}
\text{Ad}^{-1}_{\left(e^{\hat{\xi}_{j+1}\theta_{j+1}}\cdots e^{\hat{\xi}_i\theta_i}\; g_{sl_i}(0)\right)} \;\xi_j, & j < i \\[12pt]
\text{Ad}^{-1}_{g_{sl_i}(0)} \;\xi_j, & j = i
\end{cases}} \tag{b}$$

| 谁 | $j < i$ 时包含的变换 | 差异 |
|----|----------------------|------|
| MLS (a) ❌ | $e^{\hat{\xi}_j\theta_j}\,e^{\hat{\xi}_{j+1}\theta_{j+1}}\cdots e^{\hat{\xi}_i\theta_i}$ | **多了** $e^{\hat{\xi}_j\theta_j}$ |
| Theron (b) ✅ | $e^{\hat{\xi}_{j+1}\theta_{j+1}}\cdots e^{\hat{\xi}_i\theta_i}$ | 从关节 $j+1$ 开始 |

---

### B. 为什么 MLS 的公式是错的？

考虑链中的三个连杆坐标系 $L_j, L_{j+1}, \ldots, L_i$（$j < i$）：

$$
\begin{aligned}
g_{sl_j}(\theta) &= e^{\hat{\xi}_1\theta_1} \cdots e^{\hat{\xi}_j\theta_j}\,g_{sl_j}(0) \\
g_{sl_{j+1}}(\theta) &= e^{\hat{\xi}_1\theta_1} \cdots e^{\hat{\xi}_j\theta_j}\,e^{\hat{\xi}_{j+1}\theta_{j+1}}\,g_{sl_{j+1}}(0) \\
g_{sl_i}(\theta) &= e^{\hat{\xi}_1\theta_1} \cdots e^{\hat{\xi}_j\theta_j}\,e^{\hat{\xi}_{j+1}\theta_{j+1}}\cdots e^{\hat{\xi}_i\theta_i}\,g_{sl_i}(0) \\
&= e^{\hat{\xi}_1\theta_1} \cdots e^{\hat{\xi}_j\theta_j}\; g_{ji}\; g_{sl_i}(0)
\end{aligned}
$$

其中：

$$\boxed{g_{ji} = e^{\hat{\xi}_{j+1}\theta_{j+1}} \cdots e^{\hat{\xi}_i\theta_i}}$$

$g_{ji}$ 可理解为**从 $L_j$ 生成 $L_i$ 的齐次变换**，在 $L_j$ 系中表达。其逆：

$$\boxed{g_{ij} = e^{-\hat{\xi}_i\theta_i} \cdots e^{-\hat{\xi}_{j+1}\theta_{j+1}}} \quad (i > j)$$

当 $i = j$ 时，$g_{ii} = I$。

> 🔑 **关键洞察**：$\xi_j$ 是关节 $j$ 的 twist，定义在**空间系 S** 中。要计算连杆 $i$ 的物体 Jacobian 第 $j$ 列，需要把 $\xi_j$ 从 S 系"拉回"到 $L_i$ 系。拉回的过程只经过**关节 $j$ 之后的变换**（即 $j+1, \ldots, i$），因为 $\xi_j$ 在 $L_j$ 系中表达时，不需要经过关节 $j$ 自身的运动 $e^{\hat{\xi}_j\theta_j}$。

利用伴随变换的复合性质（`Composition of Adjoint Transformations.pdf`）：

$$\text{Ad}_{g_{sc}} = \text{Ad}_{g_{sb}}\,\text{Ad}_{g_{bc}}$$

对于 $j < i$ 的情况，(b) 的第一行可写为：

$$\begin{aligned}
\xi_{y_j}
&= \text{Ad}^{-1}_{g_{sl_i}(0)}\,\text{Ad}^{-1}_{\left(e^{\hat{\xi}_{j+1}\theta_{j+1}}\cdots e^{\hat{\xi}_i\theta_i}\right)}\;\xi_j \\
&= \text{Ad}^{-1}_{g_{sl_i}(0)}\,\text{Ad}^{-1}_{g_{ji}}\;\xi_j \\
&= \text{Ad}^{-1}_{g_{sl_i}(0)}\,\text{Ad}_{g_{ij}}\;\xi_j \\
&= \text{Ad}^{-1}_{g_{sl_i}(0)}\,A_{ij}\;\xi_j
\end{aligned}$$

其中 $A_{ij} = \text{Ad}_{g_{ij}}$ 正是 MLS 在 p.176 定义式 (4.27) 中的矩阵。

---

### C. MLS p.176 的第二处错误

p.176 紧随式 (4.27) 后，MLS 写道：

$$\text{Ad}^{-1}_{g_{sl_i}}\,A_{ij}\,\xi_j \qquad ❌$$

应改为：

$$\boxed{\text{Ad}^{-1}_{g_{sl_i}(0)}\,A_{ij}\,\xi_j \qquad ✅}$$

即 $g_{sl_i}$ 应替换为 $g_{sl_i}(0)$（参考构型，$\theta = 0$ 时的位姿），因为 $A_{ij}$ 已经封装了关节 $j+1$ 到 $i$ 的当前构型信息。

> 📖 **MLS p.177 顶部** 也印证了这一点：$\text{Ad}_{g_{ij}} = A_{ij}$。

---

### D. 直观总结

| 列 $j$ 与连杆 $i$ 的关系 | $j < i$ | $j = i$ |
|:--|:--|:--|
| 关节 $j$ 在 $i$ 之前 | ✅ 需要拉过 $j+1,\ldots,i$ | — |
| 关节 $j$ 就是关节 $i$ | — | 只需拉过参考构型 |
| 穿过哪些变换 | $e^{\hat{\xi}_{j+1}\theta_{j+1}}\cdots e^{\hat{\xi}_i\theta_i}$ **（不含 $e^{\hat{\xi}_j\theta_j}$）** | 无 |
| 最终公式 | $\text{Ad}^{-1}_{g_{sl_i}(0)}\,A_{ij}\,\xi_j$ | $\text{Ad}^{-1}_{g_{sl_i}(0)}\,\xi_j$ |

> ✅ **一句话记忆**：$J_{sl_i}^b$ 的第 $j$ 列 = $\text{Ad}^{-1}_{g_{sl_i}(0)}$ 把关节 twist $\xi_j$ 从 $L_j$ 系拉到 $L_i$ 系，中间只穿过 $j+1$ 到 $i$ 的变换——关节 $j$ 自己的运动 $e^{\hat{\xi}_j\theta_j}$ 不参与此变换。

---

## 核心公式速查表

| 概念 | 公式 | 编号 |
|------|------|------|
| 空间速度 twist | $\widehat{V}_{st}^s = \dot{g}_{st} g_{st}^{-1}$ | (2.53) |
| 速度-关节速度关系 | $V_{st}^s = J_{st}^s(\theta) \dot{\theta}$ | (3.52) |
| 空间 Jacobian 列 | $\xi_i' = \operatorname{Ad}_{g_{s,i-1}} \xi_i$ | (3.54) |
| 物体 Jacobian 列 | $\xi_i^{\dagger} = \operatorname{Ad}_{g_{i,t}}^{-1} \xi_i$ | (3.55) |
| 两 Jacobian 关系 | $J_{st}^s = \operatorname{Ad}_{g_{st}} J_{st}^b$ | (3.56) |
| 力-力矩（物体坐标系） | $\tau = J_{st}^{b\,T} F_t$ | (3.59) |
| 力-力矩（空间坐标系） | $\tau = J_{st}^{s\,T} F_s$ | (3.60) |
| 连杆 $i$ 体 Jacobian 第 $j$ 列 ($j<i$) | $\text{Ad}^{-1}_{g_{sl_i}(0)} A_{ij}\,\xi_j$ | — |
| $A_{ij}$ 定义 | $A_{ij} = \text{Ad}_{(e^{-\hat{\xi}_i\theta_i}\cdots e^{-\hat{\xi}_{j+1}\theta_{j+1}})}$ | (4.27) |

---

## 主要知识点总结

### 1. Jacobian 的本质
Jacobian 将**关节空间的速度 $\dot{\theta} \in \mathbb{R}^n$** 映射到**任务空间的速度 $V \in \mathbb{R}^6$**。它是构型 $\theta$ 的函数——不同构型下，同样的关节速度产生不同的末端速度。

### 2. 空间 vs 物体 Jacobian：观察视角的区别
- **空间 Jacobian $J_{st}^s$**：从固定的空间坐标系"看"各关节对末端速度的贡献，第 $i$ 列需要将 $\xi_i$ 通过前 $i-1$ 个关节的正向运动学"传递"到当前构型
- **物体 Jacobian $J_{st}^b$**：从随动的工具坐标系"看"各关节对末端速度的贡献，第 $i$ 列需要将 $\xi_i$ 通过后 $n-i$ 个关节的逆向运动学"回拉"到当前构型
- 两者通过伴随映射 $\operatorname{Ad}_{g_{st}}$ 相互转换

### 3. 速度映射与力映射的对偶性
- 速度映射：$V = J \dot{\theta}$（Jacobian 本身）
- 力映射：$\tau = J^T F$（Jacobian 的转置）
- 这是虚功原理的直接结果：**功率在坐标系变换下不变**

### 4. 连杆体 Jacobian 的注意事项（MLS p.168 勘误）
- MLS p.168 公式中 $\xi_{y_j}$ 多包含了 $e^{\hat{\xi}_j\theta_j}$——关节 $j$ 自身的运动**不参与**将 $\xi_j$ 拉到 $L_i$ 系的伴随变换
- 正确公式：$\xi_{y_j} = \text{Ad}^{-1}_{g_{sl_i}(0)} A_{ij} \xi_j$（$j < i$），仅穿过关节 $j+1$ 到 $i$
- p.176 也应将 $\text{Ad}^{-1}_{g_{sl_i}}$ 改为 $\text{Ad}^{-1}_{g_{sl_i}(0)}$

### 5. 零空间的物理意义
- $J$ 的零空间：$\dot{\theta}$ 使得末端速度为零 → 内部运动，末端不动
- $J^T$ 的零空间：$F$ 使得关节力矩为零 → 末端受力，关节无感
- 零空间维度越大，说明当前构型下机械臂的"能力"越受限

### 6. 静力平衡 vs 动力学
- $\tau = J^T F$ 给出的是**抵抗外力**所需的静力平衡力矩
- 要让末端**主动施加**某个力，还需考虑动力学效应（惯性、科氏力、重力等）
- 在准静态（quasi-static）假设下，两者等价
