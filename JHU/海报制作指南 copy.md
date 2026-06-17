# 海报制作完整指南（最终版）

> 尺寸：80cm × 180cm | 竖版 | 3列布局
> 最后更新：2026-06-11

---

## 第0步：开始前先修正 ⚠️

1. **导师姓名**：`[导师姓名]` → 真实姓名
2. **小球质量说明**：电磁力实验 M12=6.487g / M15=13.152g；自由振荡用另一颗球 6.38g
3. **Error band**：M12 和 M15 都是 ±28.9%（Parity Plot 已验证），不要写成旧值 ±17.5%
4. **删掉任何 Garmin Connect 引用**，替换为真实 References

---

## 📐 整体网格

```
┌──────────────────────────────────────────────────┐
│                    标题栏  ~18cm                   │
│    Nonlinear Modeling and Visual Feedback Control  │
│         of a 1D Magnetic Levitation System        │
│   Di Xiao | Supervisor | GTIIT | 2025–2026        │
├──────────────┬──────────────┬─────────────────────┤
│   第1列 24cm  │   第2列 24cm  │     第3列 24cm      │
│              │              │                     │
│ 1.1 Challenge│ 2.1 EM Model │ 3.1 Free Osc Exp   │
│ 1.2 Objective│ 2.2 2-Step   │ 3.2 Coulomb vs Visc│
│ 1.3 System   │ 2.3 Formulas │ 3.3 Six-Method     │
│    Arch      │ 2.4 Parity   │ 3.4 Parameters      │
│ 1.4 Hardware │              │ 3.5 Simulink Valid  │
│    Evolution │              │                     │
├──────────────┴──────────────┴─────────────────────┤
│              底部栏  ~12cm                         │
│   Key Achievements + Future Work + References      │
└──────────────────────────────────────────────────┘
剩余约20cm：页边距 + 栏间距
```

---

## 🔵 标题栏 (高约18cm，通栏)

**配色**：深海军蓝 (#1a3a5c) 底色，白色文字

```
Title（48-60pt，白色加粗）:
Nonlinear Modeling and Visual Feedback Control
of a 1D Magnetic Levitation System

Author（28-32pt，白色）:
Di Xiao | Supervisor: [导师姓名]
Guangdong Technion – Israel Institute of Technology (GTIIT)
Capstone Design / Final Year Project | 2025–2026
```

---

## 🔵 第1列 — Motivation, Architecture & Hardware

### 1.1 The Challenge（~15cm）

**标题**：`The Challenge`

```
Traditional precision control of magnetic levitation relies on
expensive sensors (laser displacement, force gauges). Using
low-cost industrial cameras introduces critical challenges:

• Frame-rate loss and processing latency (~13–27 ms actual vs.
  10 ms target at 100 Hz)
• Severe non-linearity in electromagnetic forces — no
  off-the-shelf formula exists
• Mechanical unpredictability: random multidirectional friction
  in conventional linkages makes 1D vertical motion unrepeatable
```
> 设计：左边加橙色/红色竖线边框，做"痛点"视觉

### 1.2 Our Objective（~12cm）

**标题**：`Our Objective`

```
1. Upgrade mechanical design for pure 1D motion — replace
   acrylic tube with precision glass rod through ball center
   hole. This revealed the true damping: Coulomb dry friction.

2. Eliminate camera frame-drop via Raspberry Pi parallel
   processing — software-triggered 100 Hz stable capture
   with millimeter-level ball centroid detection.

3. Develop accurate mathematical models of nonlinear
   electromagnetic and friction forces, laying the foundation
   for future closed-loop control.

4. Systematically identify system parameters (k, Ff, fn,
   damping mechanism) through cross-validated free-oscillation
   analysis of 30 datasets.
```

### 1.3 System Architecture（~18cm）

**标题**：`System Architecture`

**图**：nanobanana 生成的系统架构框图（提示词见附录 A）

**图下方参数表**（8-10pt）：
| Component | Specification |
|-----------|--------------|
| Camera | HIKROBOT MV-CS016-10GC, 1440×1080, software trigger |
| Processor | Raspberry Pi 4B |
| Electromagnet | 24V DC, R≈61Ω, L≈0.70H |
| Current Sensor | ADS1115 (16-bit) + INA240 (50 V/V), shunt 0.1Ω |
| PWM | Hardware PWM, 18 kHz, chip 0, ch 2 |
| M12 Ball* | 6.487 g, Ø12 mm |
| M15 Ball* | 13.152 g, Ø15 mm |

> \* EM force measurement. Free oscillation used a 6.38 g ball.

### 1.4 Hardware Evolution（~12cm）

**标题**：`Solving the Repeatability Problem`

**图**：两张装置照片并排
| 左 | 右 |
|----|----|
| 亚克力管装置 | 玻璃棒装置 |
| ❌ Acrylic Tube (Old) | ✅ Glass Rod (New) |

**文字**：
```
Acrylic Tube:                  Glass Rod:
• Too tight → random friction  • Through ball center hole
• Too loose → 3D oscillation    • Pure 1D motion guaranteed
• Unrepeatable experiments     • Repeatable, quantifiable friction
```

**高亮结论**：
> **Key insight**: Glass-rod upgrade revealed Coulomb dry friction as
> the dominant damping — previously masked by parasitic lateral motion.

### 1.5 Camera Timing Proof（~14cm）

**标题**：`Camera Timing: 100 Hz Stable Capture`

**图**：MATLAB `timing_proof.m` 生成的两子图
- 左：Raw vs PCHIP Resampled
- 右：Frame Jitter Distribution

**结论一行**：
```
625 frames, 6.2 s, mean dt = 10.00 ms, 0 drops, jitter = 1.23 ± 0.65 ms
```

---

## 🔵 第2列 — Electromagnetic Force Modeling

### 2.1 Physical Model（~10cm）

**标题**：`EM Force: Variable Separation Hypothesis`

**核心公式**（最大字号，高亮框）：
$$\boxed{\frac{F_{EM}}{M_b g} = f(V) \cdot f(z) = \left[ A\left(\frac{V}{V_{max}}\right)^2 + B\left(\frac{V}{V_{max}}\right) \right] \left(\frac{z}{D_b}\right)^C}$$

```
Experimental basis: 2 ball sizes (M12, M15) × 6 voltages (4–24V)
× 7 distances (2–20 mm) — 400+ force measurements with precision
force gauge.
```

### 2.2 Two-Step Dimensionless Fitting（~18cm）

**标题**：`Two-Step Fitting Method`

**图**：nanobanana 生成的两步法流程图（提示词见附录 B）

### 2.3 Final Empirical Formulas（~10cm）

**标题**：`Final Empirical Formulas`

**参数表**：
| Parameter | M12 (Ø12 mm) | M15 (Ø15 mm) |
|-----------|-------------|-------------|
| **A** | 1.8473 | 1.1290 |
| **B** | −0.0627 | −0.0405 |
| **C** | −3.1139 (Trimmed Mean) | −3.4115 (Trimmed Mean) |

**显式公式 M12**（高亮框）：
$$\boxed{\frac{F_{EM}}{M_b g} = \left[ 1.847 \left(\frac{V}{24}\right)^2 - 0.063 \left(\frac{V}{24}\right) \right] \left(\frac{z}{12}\right)^{-3.1139}}$$

### 2.4 Validation: Parity Plot（~14cm）

**标题**：`Validation: Parity Plot`

**图**：MATLAB `parity_plot.m` 跑出的图（分别出 M12 和 M15 各一张，或选一张）

**关键数据标注**：
```
±28.9% error band (2σ) — identical for M12 and M15
log₁₀(F_pred/F_meas): M12 mean=0.003, std=0.055
                       M15 mean=0.003, std=0.055
→ Identical residuals prove variable separation hypothesis is
  physically valid, not a statistical artifact.
```

---

## 🔵 第3列 — System Identification & Simulink Validation

### 3.1 Free Oscillation Experiment（~12cm）

**标题**：`Free Oscillation Analysis`

**图**：`May_18/fig_61_time_history.png`（全时间历程）

```
Setup: 5 heights (5,7,10,12,15 mm) × 6 trials = 30 datasets
100 Hz camera, glass rod guide, ball mass 6.38 g
24V hold (~0.8s) → power cut → free decay (~6s)
~5–15 oscillation cycles per trial
```

### 3.2 Damping Mechanism — Coulomb Discovery（~14cm）

**标题**：`Damping: Coulomb vs Viscous`

**图**：`fig_coulomb_vs_viscous.png`（MATLAB `coulomb_vs_viscous.m` 生成）

**对比表**：
| Model | Decay Law | R² |
|-------|-----------|-----|
| **Coulomb (Linear)** ★ | Aₙ = A₀ − n·ΔA | **0.996–0.999** |
| Viscous (Exponential) | Aₙ = A₀·e^(−nδ) | 0.75–0.95 |

**高亮结论框**（绿色）：
```
Coulomb dry friction dominates. Per-cycle amplitude decay is
constant (~0.85 mm/cycle), independent of amplitude — the
hallmark signature of dry friction.

Physical origin: dynamic side loads between through-hole and
glass rod. NOT gravity-driven (Mg = 62.6 mN ≫ Ff ≈ 2.2 mN).
```

### 3.3 Six-Method Cross-Validation（~14cm）

**标题**：`Method Cross-Validation`

**图**：`fig_six_method_overlay.png`（MATLAB `six_method_overlay.m` 生成）
红色虚线=实验，6条彩色细线=各方法拟合曲线

**方法对比表**：
| Method | Mean k (N/m) | CV |
|--------|-------------|-----|
| Envelope Fitting ★ | 10.79 | 3.53% |
| Log Decrement ★ | 10.80 | 3.54% |
| Zero-Crossing | 10.69 | 3.62% |
| Curve Fitting | 10.41 | 5.25% |
| FFT Half-Power BW | — | — |
| Coulomb Linear Fit ★ | — | — |

```
Four independent methods agree within 4% CV —
stiffness identification is unbiased and reliable.
```

### 3.4 Final Parameters（~10cm）

**标题**：`Identified System Parameters`

**核心参数表**（最大字号）：
| Parameter | Value | Confidence |
|-----------|-------|-----------|
| Spring stiffness **k** | **10.67 ± 0.38 N/m** | ⭐⭐⭐⭐⭐ |
| Equivalent friction **Ff** | **2.23 ± 0.20 mN** | ⭐⭐⭐⭐⭐ |
| Natural frequency **fn** | **6.52 ± 0.12 Hz** | ⭐⭐⭐⭐⭐ |
| Damping model | **Coulomb dry friction** | ⭐⭐⭐⭐⭐ |
| Per-cycle decay **ΔA** | **~0.85 mm/cycle** | ⭐⭐⭐⭐⭐ |

```
Note: measured k (10.67) is ~35% higher than nominal (7.9 N/m)
— consistent across all 30 trials (CV = 3.5%).
```

### 3.5 Simulink Validation: Mixed Friction（~14cm）

**标题**：`Simulink Validation: Mixed Friction Model`

**图**：两张 Simulink Scope 截图并排
| 左 | 右 |
|----|----|
| Simulink: **Viscous only** | Simulink: **Viscous + Coulomb** |
| Mẍ + cẋ + kx = 0 | Mẍ + cẋ + b·sgn(ẋ) + kx = 0 |

**高亮结论框**（绿色）：
```
Only the mixed friction model reproduces the constant
per-cycle amplitude decay observed in experiment —
confirming Coulomb + viscous damping coexist.

This reconciles the free-oscillation discovery (Column 3.2)
with the Simulink model used for EM force simulation (Column 2.5).
```

### 3.6 Open-Loop Validation: Simulink + Ramp Response（~18cm）

**标题**：`Open-Loop System Validation`

**上方**：Simulink 开环模型截图（你的截图，约 8cm 高）
> 包括：EM Force 公式块、运动方程、电压内环 PI、Scope 输出

**下方**：`fig_ramp_response.png`（MATLAB `ramp_response_plot.m` 生成，约 10cm 高）
> 双 Y 轴：位移（蓝） + 目标电压（红阶梯）
> 背景色带标注：RAMP (15→22.5V) / HOLD / FREE OSC

**解读文字**（12-14pt，两句即可）：
```
The ball tracks the voltage ramp in open-loop mode,
then enters free oscillation after power cut —
validating the full hardware + EM model integration.
```

---

## 🔵 收尾区：Where We Are → Future Work (约20cm，通栏)

### 左侧（~50%）：Current State — Foundation Laid

```
 ┌─────────────────────────────────────────────────┐
 │                                                 │
 │  ✅ 100 Hz stable visual feedback                │
 │  ✅ Repeatable 1D motion (glass rod)              │
 │  ✅ EM force formula (±28.9%)                     │
 │  ✅ System ID: k, Ff, fn, Coulomb + viscous       │
 │  ✅ Simulink model calibrated & validated          │
 │  ✅ Open-loop ramp control demonstrated            │
 │  ✅ PI voltage inner loop working                  │
 │  ✅ Position-control framework built (open_pos_DD) │
 │                                                 │
 │  ⬜ Position outer loop not yet closed            │
 │                                                 │
 └─────────────────────────────────────────────────┘
```

### 右侧（~50%）：Future Work — Close the Loop

```
                 EM Force Formula
                 (Feed-Forward)
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
   Target Force → PI Voltage → PWM → Electromagnet
                       │                  │
                       │    ┌─────────────┘
                       ▼    ▼
                  Ball Position ← Camera (100 Hz)
                       │
                       ▼
              Position Error → Outer PID → Target Force
                              ↑                    │
                              └────────────────────┘
                     Visual Feedback Closed Loop

Step 1: Implement position outer-loop PID
Step 2: Add EM force feed-forward (formula from Column 2)
Step 3: Real-time closed-loop visual feedback MagLev control
```

### References（最底部，8-10pt，灰色）

```
[1] HIKROBOT MVS SDK  [2] OpenCV  [3] MATLAB & Simulink
[4] Levenberg-Marquardt (lsqcurvefit)  [5] J. J. Craig, Introduction to Robotics
```

## 🖼️ 图源清单

### Column 1

| 图 | 来源 | 状态 |
|---|------|:--:|
| 系统架构框图 | nanobanana（提示词附录 A） | ⏳ |
| 实验装置照片 ×2（亚克力管 / 玻璃棒） | 自己拍 | ⏳ |
| 相机时序图（Raw vs PCHIP + Jitter） | MATLAB `timing_proof.m` → `fig_resample_jitter_matlab.png` | ✅ |

### Column 2

| 图 | 来源 | 状态 |
|---|------|:--:|
| 两步法流程图 | nanobanana（提示词附录 B） | ⏳ |
| Parity Plot M12 | MATLAB `parity_plot.m` | ✅ |
| Parity Plot M15 | MATLAB `parity_plot.m`（改参数重跑） | ✅ |

### Column 3

| 图 | 来源 | 状态 |
|---|------|:--:|
| Full Time Series | `May_18/fig_61_time_history.png` | ✅ |
| Coulomb vs Viscous | MATLAB `coulomb_vs_viscous.m` → `fig_coulomb_vs_viscous.png` | ✅ |
| Six-Method Overlay | MATLAB `six_method_overlay.m` → `fig_six_method_overlay.png` | ✅ |
| FFT Spectrum | `May_18/fig_44_fft_spectrum.png` | ✅ |
| Simulink Viscous Only | 你的截图 | ⏳ |
| Simulink Viscous + Coulomb | 你的截图 | ⏳ |
| Simulink Open-Loop Model | 你的截图 | ⏳ |
| Ramp Response | MATLAB `ramp_response_plot.m` → `fig_ramp_response.png` | ✅ |

---

## ⏱️ 操作顺序

```
第1步 (10min) ：找模板（PowerPoint/Canva），设 80×180cm，3列
第2步 (15min) ：把所有文字块粘贴进去（不排版）
第3步 (30min) ：nanobanana 出系统架构图 + 两步法流程图
第4步 (15min) ：拍实验装置照片
第5步 (10min) ：整理 Simulink 三张截图（混合摩擦×2 + 开环模型）
第6步 (5min)  ：MATLAB 跑 ramp_response_plot.m
第7步 (45min) ：逐列排版，调整字号/颜色/间距
第8步 (10min) ：最终检查（导师名、±28.9%、小球质量标注、References）
第9步 (5min)  ：导出 PDF，打印小样
```

---

## ⚠️ 最终检查清单

- [ ] 导师姓名已填入
- [ ] Error band 写的是 ±28.9%（不是 ±17.5%）
- [ ] 小球质量：EM 力 M12=6.487g/M15=13.152g；振荡=6.38g，已标注
- [ ] 所有 6 方法参数来自 batch_results.json（15mm trial1）
- [ ] Simulink 三张图：混合摩擦对比 + 开环模型截图
- [ ] Ramp Response 图已插入
- [ ] Coulomb 拼写正确（不是 Coloumb）
- [ ] 正文字号 ≥ 24pt，标题 ≥ 36pt，主标题 ≥ 48pt
- [ ] 收尾区"Current State → Future Work"逻辑通畅
- [ ] References 不包含 Garmin Connect
- [ ] 校徽 Logo 位置正确

---

## 附录 A：系统架构图 nanobanana 提示词

```
Clean technical block diagram of a 1D magnetic levitation visual feedback system. White background, navy blue rectangular boxes with white text labels, dark gray arrows connecting them.

Top row (left to right): "HIK Camera MV-CS016" → "Raspberry Pi + OpenCV" → "PI Voltage Controller"

Middle row: "Hardware PWM 18kHz" → "Electromagnet 24V"

Bottom: "Spring + Ball + Glass Rod (1D Motion)"

A feedback arrow from bottom loops back to camera labeled "Visual Position Feedback". A side arrow from electromagnet goes to "ADS1115 Current Sensor" then loops back to PI Controller labeled "Current Feedback (Inner Voltage Loop)".

Flat vector style, engineering diagram aesthetic, no gradients, no 3D, clean and simple. All text readable.
```

## 附录 B：两步法流程图 nanobanana 提示词

```
A clean academic flowchart of a two-step electromagnetic force fitting method. White background, navy headers.

TOP HALF labeled "Step 1: Strip Geometry → Extract f(V)":
- Box 1: "Robust linear fit per voltage: ln(F/Mg) = C·ln(z/D_b) + ln(K_v)"
- Box 2: "Trimmed Mean C: M12=-3.114, M15=-3.412"
- Box 3 (highlighted): "f(V)_measured = (F/Mg) / (z/D_b)^C_global  →  average per voltage"

Arrow pointing down.

BOTTOM HALF labeled "Step 2: Linearize → Fit A, B":
- Box 1: "Model: f(V) = A(V/V_max)² + B(V/V_max)"
- Box 2 (highlighted with star): "Linearization trick: let x=V/V_max, divide by x → f(V)/x = A·x + B  (a straight line!)"
- Box 3: "1st-order polynomial fit → A, B"

Bottom result bar (green): "F/Mg = [A(V/V_max)² + B(V/V_max)] · (z/D_b)^C"
Parameter table: M12: A=1.847, B=-0.063, C=-3.114 | M15: A=1.129, B=-0.041, C=-3.412
Validation: Parity Plot ±28.9%

Flat vector style, clean boxes, no 3D, no shadows.
```
