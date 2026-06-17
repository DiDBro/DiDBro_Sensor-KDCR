# April_27_inv_kinNT.pdf — 逆运动学总结

## 文档概述
该 PDF 是机器人学中关于 **逆运动学** 的讲义，重点介绍 Paden-Kahan 子问题方法，共 9 页。对应 MLS 教材 §3.2–§3.3 内容。

---

## 1. 逆运动学问题（Inverse Kinematics）

给定末端执行器的目标位姿 $g_d \in SE(3)$，求解满足下式的关节变量 $\theta \in Q$：

$$
g_{st}(\theta) = g_d
$$

**解的可能性**：
- 多解（Multiple solutions）
- 唯一解（Unique solution）
- 无解（No solution）

逆运动学通常比正运动学更难求解。

---

## 2. Paden-Kahan 子问题方法

### 2.1 基本思路

- 基于指数积公式（POE）
- 建立常见子问题的解库
- 将完整逆运动学问题**分解**为已知子问题的组合
- MLS §3.2 给出 3 个子问题，足以求解大量机械臂的逆运动学

### 2.2 三个子问题概览

| 子问题 | 描述 | 已知 | 求解 |
|--------|------|------|------|
| Subproblem 1 | 绕单轴旋转 | $\xi, p, q \in \mathbb{R}^3$ | $\theta$ 使 $e^{\hat{\xi}\theta}p = q$ |
| Subproblem 2 | 绕两相继轴旋转 | $\xi_1, \xi_2$（轴相交）, $p, q \in \mathbb{R}^3$ | $\theta_1, \theta_2$ 使 $e^{\hat{\xi}_1\theta_1}e^{\hat{\xi}_2\theta_2}p = q$ |
| Subproblem 3 | 旋转至给定距离 | $\xi, p, q \in \mathbb{R}^3, \delta > 0$ | $\theta$ 使 $\|q - e^{\hat{\xi}\theta}p\| = \delta$ |

---

## 3. 子问题 1：绕单轴旋转

**问题**：设 $\xi$ 为零螺距、单位幅值的旋量，$p, q \in \mathbb{R}^3$ 为两点，求 $\theta$ 使 $e^{\hat{\xi}\theta}p = q$。

### 3.1 几何分解

令 $r$ 为轴上一点，$u = p - r$，$v = q - r$。由于 $e^{\hat{\xi}\theta}r = r$：

$$
e^{\hat{\omega}\theta}u = v \tag{3.18}
$$

### 3.2 向量分解

将 $u, v$ 分解为平行于 $\omega$ 和垂直于 $\omega$ 的分量：

$$
\begin{aligned}
u' &= u - \omega\omega^T u \quad (\text{垂直分量}) \\
v' &= v - \omega\omega^T v \quad (\text{分量})
\end{aligned}
$$

### 3.3 可解条件

解存在的充要条件：

$$
\omega^T u = \omega^T v \quad \text{且} \quad \|u'\| = \|v'\|
$$

（即两向量在旋转轴上的投影相等，且垂直分量的长度相等。）

### 3.4 解的表达式

$$
\begin{aligned}
\tan\theta &= \frac{\omega^T \widehat{u'v'}}{\;(u')^T v'} \\[8pt]
\theta &= \operatorname{atan2}\!\left( \omega^T \widehat{u'v'},\; (u')^T v' \right)
\end{aligned}
$$

其中 $\widehat{u'v'} = u' \times v'$ 为叉积，$\operatorname{atan2}$ 返回 $(-\pi, \pi]$ 范围内的角度。

---

## 4. 子问题 2：绕两相继轴旋转

**问题**：设 $\xi_1, \xi_2$ 为两个零螺距、单位幅值且**轴线相交**的旋量，$p, q \in \mathbb{R}^3$ 为两点，求 $\theta_1, \theta_2$ 使：

$$
e^{\hat{\xi}_1\theta_1} e^{\hat{\xi}_2\theta_2} p = q
$$

### 关键结果（MLS 式 3.25, p.102）

向量和 $\alpha \vec{\omega}_1 + \beta \vec{\omega}_2$ 的长度 $l$ 由余弦定理给出（$\|\omega_1\| = \|\omega_2\| = 1$）：

$$
l^2 = \alpha^2 + \beta^2 - 2\alpha\beta\cos\theta
= \alpha^2 + \beta^2 + 2\alpha\beta\cos\eta
$$

由于 $\cos\eta = \omega_1^T \omega_2$，因此：

$$
l^2 = \alpha^2 + \beta^2 + 2\alpha\beta\,\omega_1^T \omega_2
$$

课堂详细推导参考教材。

---

## 5. 子问题 3：旋转至给定距离

**问题**：设 $\xi$ 为零螺距、单位幅值旋量，$p, q \in \mathbb{R}^3$，$\delta > 0$，求 $\theta$ 使：

$$
\|q - e^{\hat{\xi}\theta}p\| = \delta
$$

### 几何简化

定义 $\delta'$ 为去除轴向分量后的有效距离：

$$
\delta'^2 + \|\omega^T(p - q)\|^2 = \delta^2 \quad\Rightarrow\quad \delta'^2 = \delta^2 - \|\omega^T(p - q)\|^2
$$

则问题转化为子问题 1 的形式：

$$
\|v' - e^{\hat{\omega}\theta}u'\|^2 = \delta'^2
$$

其中 $u', v'$ 分别为 $p, q$ 垂直于旋转轴 $\omega$ 的分量。

---

## 6. §3.3 用子问题求解逆运动学

### 示例：三关节旋量结构

对于 $\delta := \|g p - q\|$，利用旋转运动保持距离的性质（等距变换），可将复合旋量逐步化简：

$$
\begin{aligned}
\delta &= \|e^{\hat{\xi}_1\theta_1} e^{\hat{\xi}_2\theta_2} e^{\hat{\xi}_3\theta_3} p - q\| \\[4pt]
&= \|e^{\hat{\xi}_1\theta_1} e^{\hat{\xi}_2\theta_2} \left( e^{\hat{\xi}_3\theta_3} p - q \right)\| \\[4pt]
&= \|e^{\hat{\xi}_3\theta_3} p - q\|
\end{aligned}
$$

关键技巧：由于 $e^{\hat{\xi}\theta}$ 是刚体变换（保距），可以将旋量从范数内移出，最终将复杂问题**降维**为已知子问题。

---

## 7. 核心结论

1. Paden-Kahan 子问题将逆运动学分解为**几何上可解的原子问题**
2. 三个子问题覆盖了旋转型关节的最常见模式
3. 求解策略：通过刚体变换的保距性质，将复合旋量逐步化简为子问题
4. 更多子问题见教材习题，可处理更复杂的机械臂构型
