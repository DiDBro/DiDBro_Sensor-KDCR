# April_20_manip_kinemNT.pdf — 机械臂运动学总结

## 文档概述
该 PDF 是机器人学中关于 **开链机械臂运动学** 的讲义，涵盖关节机构分类、正运动学以及指数积公式（Product of Exponentials, POE），共 15 页。对应 MLS 教材第 3–4 章内容。

---

## 1. 关节机构分类（Joint Mechanisms）

机器人关节属于 **低副（lower pairs）**，共 6 种基本类型，每种对应 $SE(3)$ 的一个子群：

| 关节类型 | 自由度 | 说明 |
|---------|--------|------|
| 旋转关节（Revolute） | 1 | 绕固定轴旋转，$\theta_i \in S^1$ |
| 移动关节（Prismatic） | 1 | 沿固定轴平移，$\theta_i \in \mathbb{R}$ |
| 螺旋关节（Helical） | 1 | 旋转的同时沿轴平移 |
| 圆柱关节（Cylindrical） | 2 | 独立旋转和平移 |
| 球关节（Spherical） | 3 | 三个方向的旋转 |
| 平面关节（Planar） | 3 | 平面内的运动 |

---

## 2. 正运动学（Forward Kinematics）

### 2.1 基本概念

正运动学：**给定关节变量 $\theta$，确定末端执行器（工具）相对于基座标系的位姿**。

**符号约定**：
- 关节编号 $1$ 到 $n$，连杆编号 $0$ 到 $n$（$0$ 为基座）
- 关节 $i$ 连接连杆 $i-1$ 与连杆 $i$
- 关节空间 $Q$：所有关节变量的笛卡尔积
  - 例：$\theta = (\theta_1, \theta_2, \theta_3, \theta_4) \in S^1 \times S^1 \times \mathbb{R} \times S^1 = Q$
- 基座标系 $S$，工具坐标系 $T$

### 2.2 链式法则

相邻连杆间的变换 $g_{l_{i-1}l_i}(\theta_i)$ 连乘得到整体正运动学：

$$
g_{st}(\theta) = g_{sl_1}(\theta_1) \, g_{l_1l_2}(\theta_2) \, \cdots \, g_{l_{n-1}l_n}(\theta_n) \, g_{l_n t} \tag{3.1}
$$

其中 $g_{l_{i-1}l_i}$ 的坐标/位移分量必须在连杆 $i-1$ 坐标系中表达。

---

## 3. 指数积公式（Product of Exponentials, POE）

### 3.1 核心思想

绕螺旋轴 $\xi$ 旋转/平移的刚体运动可表示为：

$$
g_{ab}(\theta) = e^{\hat{\xi}\theta} g_{ab}(0) \tag{2.37}
$$

POE 公式将开链机构的运动学表示为各关节旋量（twist）的指数积：

$$
g_{st}(\theta) = e^{\hat{\xi}_1\theta_1} e^{\hat{\xi}_2\theta_2} \cdots e^{\hat{\xi}_n\theta_n} g_{st}(0) \tag{3.3}
$$

### 3.2 构造步骤

1. **定义参考构型**：$\theta = 0$ 时的位姿 $g_{st}(0)$
2. **构造旋量 $\xi_i$**：在参考构型下，固定其他关节，确定关节 $i$ 的旋量运动
3. **旋量形式**：
   - 旋转关节：
     $$
     \xi_i = \begin{bmatrix} -\omega_i \times q_i \\ \omega_i \end{bmatrix}
     $$
   - 移动关节：
     $$
     \xi_i = \begin{bmatrix} v_i \\ 0 \end{bmatrix}
     $$
   其中 $\omega_i, q_i, v_i \in \mathbb{R}^3$，均相对于基座标系 $S$ 定义

### 3.3 关键推导——关节顺序互换性

若先移动关节 $1$ 再移动关节 $2$：

$$
g_{st}(\theta_1, \theta_2) = e^{\hat{\xi}_1\theta_1} e^{\hat{\xi}_2\theta_2} g_{st}(0)
$$

若先移动关节 $2$ 再移动关节 $1$，关节 $2$ 的旋量轴会被关节 $1$ 的运动改变：

$$
\xi'_2 = \text{Ad}_{g} \xi_2, \quad g = e^{\hat{\xi}_1\theta_1}
$$

根据 **引理 2.13**，$\text{Ad}_g \xi_2$ 对应的李代数形式为 $g \hat{\xi}_2 g^{-1}$。利用式 (2.35)：

$$
e^{\hat{\xi}'_2 \theta_2} = e^{g \hat{\xi}_2 g^{-1} \theta_2} = g e^{\hat{\xi}_2 \theta_2} g^{-1} = e^{\hat{\xi}_1\theta_1} e^{\hat{\xi}_2\theta_2} e^{-\hat{\xi}_1\theta_1}
$$

代入后两种顺序的结果**完全相同**，证明了 POE 公式的正确性。

---

## 4. POE 的参数化优势

### 4.1 参考构型的选择

若基座标系 $S$ 与工具坐标系 $T$ 在初始构型下对齐，则 $g_{st}(0) = I$，POE 简化为：

$$
g_{st}(\theta) = e^{\hat{\xi}_1\theta_1} e^{\hat{\xi}_2\theta_2} \cdots e^{\hat{\xi}_n\theta_n}
$$

### 4.2 与 D-H 参数法对比

| 特性 | POE | D-H 参数 |
|------|-----|----------|
| 坐标系数量 | 仅 $S$ 和 $T$ 两个 | 每个连杆一个坐标系 |
| 几何意义 | 旋量 $\xi_i$ 有明确物理含义 | 四个参数较抽象 |
| 奇异性处理 | 自然，无 $90^\circ$ 限制 | 平行关节需特殊处理 |
| 计算效率 | 依赖矩阵指数 | 链式齐次变换 |

**结论**：POE 的正交化优势和对旋量的几何解释使其成为 D-H 方法的优秀替代方案。

---

## 5. 数值实验建议

讲义建议使用以下工具对 **例 3.1、3.2、3.3** 进行符号计算验证：
- MATLAB Symbolic Toolbox
- Python SymPy 模块

通过符号计算可以更直观理解 POE 公式的构造和验证过程。
