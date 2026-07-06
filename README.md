# GTIIT 大四下 · 课程笔记与机器人学工具箱

> 广东以色列理工学院（GTIIT）大四下学期课程资料汇总，含 **机器人学 MATLAB 函数库**、**传感器课程笔记**，以及考试复习材料。
> 
> 💡 **阅读建议**：仓库中的 `.md` 文件（笔记、总结）在 [Obsidian](https://obsidian.md/) 中打开可获得最佳阅读体验——双向链接、公式渲染、大纲导航等开箱即用。直接克隆仓库后用 Obsidian 打开根目录即可。

---

## 📁 仓库结构

```
├── Nico_Robo_control/    ← 🔧 机器人学（核心，详见下文）
├── Sensor/               ← 📡 传感器课程（讲义 + 习题解答 + Jupyter 分析）
├── Coffee/               ← ☕ 咖啡机/磨豆机选购笔记
├── slprj/                ← 🔧 Simulink 项目缓存
└── 截图仓库/              ← 🖼️ 课程截图存档
```

---

## 🔧 Nico_Robo_control — 机器人控制工具箱与课程

这是本仓库的核心，基于 **MLS**（*A Mathematical Introduction to Robotic Manipulation*, Murray, Li & Sastry）教材的完整 MATLAB 机器人学工具链，涵盖从运动学到动力学、再到计算力矩控制的全部内容。

> ⚙️ **课程依赖**：本课程需要 **MATLAB + Simulink**（R2020a 及以上）。仓库中的代码（`+robo` 函数库、作业、仿真模型）覆盖了全部课程内容，可以跟随代码逐步学习。如有疑问欢迎联系：**dxiao9@jh.edu** 或 **微信: 13925852078**。

### 目录结构

```
Nico_Robo_control/
├── Codes/+robo/                         ← ⭐ MATLAB 机器人学函数库（32 个函数）
├── 课件/                                 ← 📖 课程讲义 PDF（15 份，覆盖全学期）
├── 总结/                                 ← 📝 每讲知识点总结（Markdown）
├── notes/                               ← ✍️ 手写/补充推导笔记 PDF
├── 考试_2/                              ← 📋 考试复习资料
│   ├── Codes/                           ←   作业代码（HW1–7）+ 过往试题
│   └── 二阶系统/                         ←   二阶系统 Simulink 控制仿真
├── exam_A_2025/                         ← 📄 2025 年 Exam A 真题及解答（7 份 PDF）
├── examB/                               ← 📄 Exam B 真题、解答及 MATLAB/Simulink 代码
├── Exam_A_2026/                         ← 📄 2026 年 Exam A
│   ├── *.xlsx                           ←   数据表格（q2adat, q2bdat 等）
│   ├── rounded_step_gen.m / .py         ←   圆角阶跃信号生成（MATLAB / Python）
│   ├── rounded_step_tesing.mlx / .ipynb / .py  ← 测试与仿真（MATLAB Live / Jupyter / Python）
│   └── rounded_step_tesing_sim.slx      ←   Simulink 模型
├── RA_Concept_Review_CN_EN.pdf          ← 📘 机器人学概念速查（中英双语）
├── MLS_sets_tabulated.pdf               ← 📋 关键结论公式速查表
└── Murray Li and Sastry Robotics.pdf    ← 📗 MLS 教材全文
```

### ⭐ `+robo` 函数库快速上手

`+robo` 是一个 MATLAB **package**。将 `Nico_Robo_control/Codes/` 添加到 MATLAB 路径后，通过 `import robo.*` 导入即可直接调用所有函数（无需 `robo.` 前缀）：

```matlab
addpath('Nico_Robo_control/Codes/');
import robo.*   % 导入包，之后可直接使用函数名调用

% 示例 1：构建旋转矩阵
R = rodrigues([0; 0; 1], pi/4);   % 绕 z 轴旋转 45°

% 示例 2：正运动学 (POE)
g = gtwist(xi1, theta1) * gtwist(xi2, theta2) * gst0;

% 示例 3：计算雅可比
[Js, Jb] = jacobian(xis, thetas, gst0);

% 示例 4：逆动力学
tau = inverseDynamics(thetadd_d, thetad, theta, xi, calMp, lM, beta);

% 示例 5：计算力矩控制 (CTC)
tau = computedTorque(theta_d, thetad_d, thetadd_d, theta, thetad, ...
                     xi, calMp, lM, beta);
```

### 函数一览（32 个）

| 类别 | 函数 | 功能 |
|------|------|------|
| **李代数** | `hatm`, `vee_so3`, `vee`, `wedge`, `twist`, `ad` | hat/vee 映射、反对称矩阵、李括号伴随 |
| **SO(3)** | `rodrigues`, `iRodrigues`, `Rx`, `Ry`, `Rz` | 旋转矩阵正/逆运算 |
| **SE(3)** | `gmat`, `gtwist`, `G2twist`, `twistExp`, `buildTwist`, `twistDecompose`, `adjoint`, `pitch` | 齐次变换、指数/对数映射、twist 拆组、伴随变换、节距 |
| **Wrench** | `coadjoint`, `jointTorque` | 力旋量伴随变换、力 → 关节力矩 |
| **雅可比** | `jacobian` | 空间/体雅可比矩阵 |
| **逆运动学** | `PK1`, `PK2`, `PK3` | Paden-Kahan 子问题 1/2/3 |
| **动力学** | `newtonEuler`, `inertiaTransform`, `gravityWrench`, `inertiaMatrix`, `inverseDynamics`, `forwardDynamics` | Newton-Euler、惯性变换、重力旋量、M/C/N 组装、正/逆动力学 |
| **控制** | `computedTorque` | 计算力矩控制器 (CTC) |

### 考试资料导航

| 目录 | 年份 | 内容 |
|------|------|------|
| `exam_A_2025/` | 2025 | Exam A 真题试卷 + 7 份解答 PDF（含 wrench、指数映射、逆运动学等题解） |
| `examB/` | — | Exam B 真题试卷 + 5 道大题解答（MLX/SLX/MATLAB）+ 标准答案 |
| `Exam_A_2026/` | 2026 | Exam A 数据与仿真代码（Python/MATLAB/Simulink 多版本）+ 阶跃信号生成与测试 |
| `考试_2/Codes/` | — | Homework 1–7 + Tutorial 作业 + 2025 Final A 真题 |

### 学习路线建议

1. **入门**：阅读 `课件/` 中的讲义 PDF，按时间顺序（March → April → May → June）
2. **动手**：配合 `总结/` 中的 Markdown 总结，在 MATLAB 中运行 `Codes/+robo/` 的函数
3. **深入**：查看 `notes/` 中的手写推导笔记，理解关键公式（Rodrigues、指数映射、动力学）
4. **速查**：打印 `MLS_sets_tabulated.pdf`（公式表）+ `RA_Concept_Review_CN_EN.pdf`（中英概念对照）备考
5. **实战**：运行 `考试_2/Codes/` 中的作业代码（HW1–7）
6. **冲刺**：做 `exam_A_2025/`、`examB/`、`Exam_A_2026/` 中的历年真题

### 依赖

- **MATLAB R2020a+**（需支持 package 文件夹机制，即以 `+` 前缀命名的文件夹）
- **Python 3.8+**（`Exam_A_2026/` 中的 `rounded_step_tesing.ipynb` 和 `.py` 脚本需要 `numpy`, `matplotlib`, `pandas`, `openpyxl`）
- Simulink（`考试_2/二阶系统/` 和 `Exam_A_2026/` 中的 Simulink 仿真需要）

### 约定

| 约定 | 说明 |
|------|------|
| 角度单位 | 全部使用**弧度**（rad） |
| Twist 顺序 | `ξ = [v₁, v₂, v₃, ω₁, ω₂, ω₃]ᵀ`（线速度在前） |
| Wrench 顺序 | `F = [f₁, f₂, f₃, τ₁, τ₂, τ₃]ᵀ`（力在前） |
| 旋转轴 | 输入前须归一化（`‖ω‖ = 1`） |
| 容差 | 大部分函数在 `1e-12` 量级判断退化情况 |

---

## 📡 Sensor — 传感器课程

JHU/GTIIT 传感器原理课程资料。⚠️ **注意**：课程 Project（`Sensor_prij/`）完成度一般，建议仅作补充参考，不要以此为主要学习依据。

| 目录 | 内容 |
|------|------|
| `Lecture/` | 讲义 PDF + 对应 Markdown 笔记总结（第 1–6 讲） |
| `Tutorial/` | 习题课解答（第 1–13 讲），含详细推导与最终汇编 |
| `Sensor_prij/` | 课程 Final Project |
| `Examples/` | 习题解答 PDF 汇编 |
| `code*.ipynb` | Jupyter Notebook：RC 滤波器分析（Bode 图、阶跃响应、抗混叠） |

---

## ☕ Coffee

个人咖啡设备选购笔记（磨豆机、咖啡机对比），供参考。

---

## 📜 License

MIT License — 详见 [LICENSE](LICENSE) 文件。

---

## 🙏 致谢

- **MLS 教材**：*A Mathematical Introduction to Robotic Manipulation* — Murray, Li & Sastry
- **GTIIT**：广东以色列理工学院机械工程系机器人学课程
- **特别鸣谢**：Last Semester 仍然在 106 认真学（摸）习（鱼）并且互相提供帮助的同学们 —— Qi Zhang、Bowen Cheng、Weijian Yin、Yufei Wang、Boyan Zhang、Zhenyuan Chen 🍻
- 所有讲义、作业与考试的著作权归课程教师所有；`+robo` 函数库为个人学习过程中的独立实现
