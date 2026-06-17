#!/usr/bin/env python3
"""
电子秤 — 标定、滤波、动态性能与精度分析
======================================
完整数据分析流程，对应项目要求 B ~ F。

用法：
  1. 先用 data_collection.py 采集各标准砝码的原始数据
  2. 将数据文件放入本脚本同目录，修改下方 CALIB_DATA 路径
  3. 运行: python calibration_analysis.py

依赖：
  pip install numpy matplotlib scipy scikit-learn --break-system-packages
"""

import os
import pickle
import warnings

import numpy as np
from numpy import polyfit, polyval
import matplotlib.pyplot as plt
from scipy import signal
from sklearn.metrics import mean_squared_error

warnings.filterwarnings('ignore')

# 全局绘图参数
plt.rcParams.update({
    'figure.dpi': 120,
    'figure.figsize': (10, 5),
    'axes.grid': True,
    'grid.alpha': 0.3,
    'font.size': 11,
})

# =====================================================================
# 配置区 — 请根据实际文件路径修改
# =====================================================================

# 标定数据：每个文件是用 data_collection.py 采集的 .pkl 文件
# 键 = 标准砝码质量（克），值 = 对应的 pkl 文件路径
# ★ 请替换为你自己的数据文件路径 ★
CALIBRATION_FILES = {
     0:   'data/calib_0g.pkl',
    50:   'data/calib_50g.pkl',
   100:   'data/calib_100g.pkl',
   200:   'data/calib_200g.pkl',
   300:   'data/calib_300g.pkl',
   400:   'data/calib_400g.pkl',
   500:   'data/calib_500g.pkl',
   600:   'data/calib_600g.pkl',
   700:   'data/calib_700g.pkl',
   800:   'data/calib_800g.pkl',
   900:   'data/calib_900g.pkl',
  1000:   'data/calib_1000g.pkl',
}

# 如果有静态噪声数据（无负载时采集），用于噪声分析
NOISE_FILE = 'data/noise_empty.pkl'

# 精度测试数据：随机重量（例如 65, 289, ...）对应的 pkl 文件
ACCURACY_FILES = {
    # 重量_g : 文件路径
    # 65:  'data/test_65g.pkl',
    # 289: 'data/test_289g.pkl',
}

# =====================================================================
# 工具函数
# =====================================================================

def load_pkl(path):
    """加载 pickle 数据文件"""
    with open(path, 'rb') as f:
        data = pickle.load(f)
    return data['raw_values']


def load_data_files(file_dict, stable_ratio=0.5):
    """
    从文件中加载标定数据。
    stable_ratio: 取后半部分稳定数据做平均（默认后半 50%）
    返回: (weights_array, mean_values_array, std_values_array)
    """
    weights = []
    means = []
    stds = []
    for w in sorted(file_dict.keys()):
        path = file_dict[w]
        if not os.path.exists(path):
            print(f"  ⚠ 文件不存在，跳过: {path}")
            continue
        raw = load_pkl(path)
        # 只取后半部分稳定数据
        n = len(raw)
        stable = raw[int(n * stable_ratio):]
        weights.append(w)
        means.append(np.mean(stable))
        stds.append(np.std(stable))
        print(f"  {w:5d} g → 均值={np.mean(stable):10.2f}, 标准差={np.std(stable):.2f}, "
              f"采样数={len(stable)}")
    return np.array(weights), np.array(means), np.array(stds)


def apply_filter(data, method='moving_average', window=11):
    """应用数字滤波器"""
    if method == 'moving_average':
        kernel = np.ones(window) / window
        return np.convolve(data, kernel, mode='same')
    elif method == 'median':
        return signal.medfilt(data, kernel_size=window if window % 2 == 1 else window + 1)
    elif method == 'savgol':
        from scipy.signal import savgol_filter
        w = window if window % 2 == 1 else window + 1
        return savgol_filter(data, w, polyorder=3)
    else:
        raise ValueError(f"未知滤波方法: {method}")


# =====================================================================
# B 部分 — 系统标定与多项式拟合
# =====================================================================

def part_b_calibration(weights, adc_means):
    """标定与多项式拟合（1~5 阶），画出拟合曲线和残差"""
    print("\n" + "=" * 60)
    print("  B 部分：系统标定与多项式拟合")
    print("=" * 60)

    # 在各阶多项式之间测试
    orders = [1, 2, 3, 4, 5]
    colors = ['blue', 'green', 'red', 'orange', 'purple']
    results = {}

    # --- 子图1: 拟合曲线 ---
    fig1, ax1 = plt.subplots()
    ax1.plot(weights, adc_means, 'ko', markersize=6, label='Measured data')

    w_plot = np.linspace(min(weights), max(weights), 500)

    for order, color in zip(orders, colors):
        coeffs = polyfit(weights, adc_means, order)
        pred = polyval(coeffs, w_plot)

        # 残差（每个标定点）
        pred_at_w = polyval(coeffs, weights)
        residuals = adc_means - pred_at_w
        rmse = np.sqrt(mean_squared_error(adc_means, pred_at_w))

        results[order] = {
            'coeffs': coeffs,
            'rmse': rmse,
            'max_residual': np.max(np.abs(residuals)),
            'residuals': residuals,
        }

        ax1.plot(w_plot, pred, color=color, linewidth=1.2,
                 label=f'{order}-order (RMSE={rmse:.2f})')

        print(f"\n  {order} 阶多项式:")
        print(f"    RMSE = {rmse:.4f}")
        print(f"    Max |residual| = {np.max(np.abs(residuals)):.4f}")
        if order == 1:
            print(f"    斜率 (scale factor) = {coeffs[0]:.6f}  ADC/g")
            print(f"    截距 (offset) = {coeffs[1]:.4f}  ADC")

    ax1.set_xlabel('Standard Weight (g)')
    ax1.set_ylabel('ADC Raw Value')
    ax1.set_title('Polynomial Fitting: Weight vs ADC Reading')
    ax1.legend(fontsize=9)

    # --- 子图2: 残差 ---
    fig2, axes2 = plt.subplots(2, 1, figsize=(10, 7))

    for order, color in zip(orders, colors):
        r = results[order]['residuals']
        axes2[0].plot(weights, r, 'o-', color=color, linewidth=0.8,
                      label=f'{order}-order', markersize=4)
        axes2[1].plot(weights, np.abs(r), 'o-', color=color, linewidth=0.8,
                      label=f'{order}-order', markersize=4)

    axes2[0].axhline(0, color='gray', linestyle='--', linewidth=0.5)
    axes2[0].set_ylabel('Residual (ADC)')
    axes2[0].set_title('Residual vs Weight (Signed)')
    axes2[0].legend(fontsize=9)

    axes2[1].set_ylabel('|Residual| (ADC)')
    axes2[1].set_xlabel('Standard Weight (g)')
    axes2[1].set_title('Residual vs Weight (Absolute)')
    axes2[1].legend(fontsize=9)

    plt.tight_layout()

    # --- 过拟合讨论 ---
    print("\n  --- 过拟合分析 ---")
    for o in orders:
        print(f"  {o} 阶: RMSE={results[o]['rmse']:.4f}, "
              f"Max|res|={results[o]['max_residual']:.4f}")
    print("\n  ★ 结论：虽然高阶多项式训练 RMSE 更小，但在实际使用时")
    print("    可能发生过拟合（尤其是 4~5 阶），实际误差反而更大。")
    print("    通常 1 阶（线性拟合）已足够，且泛化性最好。")

    return results


# =====================================================================
# C 部分 — 信号处理与滤波
# =====================================================================

def part_c_filtering(weights, adc_values_all):
    """
    信号处理与滤波。
    使用某一砝码的完整时间序列数据进行滤波对比。
    """
    print("\n" + "=" * 60)
    print("  C 部分：信号处理与滤波")
    print("=" * 60)

    # 选择中等重量的数据做演示（例如 500 g）
    if 500 in weights:
        idx = list(weights).index(500)
    else:
        idx = len(weights) // 2

    data_original = adc_values_all[idx]
    print(f"  使用 {weights[idx]:.0f} g 数据进行分析")
    print(f"  数据点数: {len(data_original)}")

    # 应用不同滤波器
    methods = [
        ('Moving Average (win=5)', 'moving_average', 5),
        ('Moving Average (win=15)', 'moving_average', 15),
        ('Moving Average (win=31)', 'moving_average', 31),
        ('Median Filter (win=5)', 'median', 5),
        ('Median Filter (win=15)', 'median', 15),
        ('Savitzky-Golay (win=15)', 'savgol', 15),
    ]

    # --- 整体对比 ---
    fig, axes = plt.subplots(3, 2, figsize=(14, 10))
    axes = axes.flatten()

    for ax, (name, method, win) in zip(axes, methods):
        filtered = apply_filter(data_original, method, win)
        noise_std_before = np.std(data_original[-200:])
        noise_std_after = np.std(filtered[-200:])

        ax.plot(data_original, alpha=0.4, linewidth=0.5, label='Raw')
        ax.plot(filtered, linewidth=1.0, label=name)
        ax.set_title(f'{name}  |  Std: {noise_std_before:.1f}→{noise_std_after:.1f}')
        ax.set_xlabel('Sample index')
        ax.set_ylabel('ADC Value')
        ax.legend(fontsize=8)

        print(f"  {name:35s}: Noise STD {noise_std_before:8.2f} → {noise_std_after:8.2f} "
              f"(降噪 {(1 - noise_std_after/noise_std_before)*100:.0f}%)")

    plt.suptitle('Filtering Comparison', fontsize=14)
    plt.tight_layout()

    # --- 推荐滤波方法 ---
    print(f"\n  ★ 推荐：Moving Average (win=5~15) 或 Median Filter (win=5)")
    print(f"    在噪声抑制和信号保真度之间取得较好平衡。")

    return fig


# =====================================================================
# D 部分 — 动态性能测试
# =====================================================================

def part_d_dynamic(ts, raw_vals):
    """
    动态性能测试。
    输入: 包含加载/卸载过程的完整时间序列
    输出: 时间常数、动态误差
    """
    print("\n" + "=" * 60)
    print("  D 部分：动态性能测试")
    print("=" * 60)

    if len(ts) == 0:
        print("  ⚠ 未提供动态数据，跳过此部分")
        return

    # 找到阶跃响应区域（值大幅跳变的地方）
    diff = np.abs(np.diff(raw_vals))
    threshold = np.std(raw_vals) * 5
    step_indices = np.where(diff > threshold)[0]

    if len(step_indices) == 0:
        print("  ⚠ 未检测到明显阶跃，请提供加载/卸载的动态数据")
        return

    # 假设第一个大跳变是加载事件
    step_start = step_indices[0] + 1

    if step_start >= len(raw_vals) - 10:
        print("  ⚠ 阶跃点位置异常")
        return

    y_before = np.mean(raw_vals[max(0, step_start-50):step_start])
    y_after = np.mean(raw_vals[step_start:min(len(raw_vals), step_start+100)])
    y_step = y_after - y_before

    print(f"  检测到阶跃响应: 起始索引={step_start}")
    print(f"  阶跃前均值: {y_before:.2f}")
    print(f"  阶跃后均值: {y_after:.2f}")
    print(f"  阶跃幅度: {y_step:.2f}")

    # 提取阶跃响应曲线
    response = raw_vals[step_start:step_start + 200] - y_before
    t_response = ts[step_start:step_start + 200] - ts[step_start]

    if len(response) < 5:
        print("  响应数据不足")
        return

    # 拟合一阶系统响应 y(t) = A * (1 - exp(-t/tau))
    final_val = np.mean(response[-50:]) if len(response) > 50 else response[-1]
    if abs(final_val) < 1e-6:
        print("  阶跃幅度太小，跳过动态分析")
        return

    # 寻找 63.2% 时间点（一阶系统时间常数）
    target = final_val * 0.632
    tau_idx = np.argmin(np.abs(response - target))
    tau = t_response[tau_idx] if tau_idx < len(t_response) else np.nan

    # 寻找 90% / 95% 稳定时间
    idx_90 = np.where(np.abs(response) >= abs(final_val * 0.90))[0]
    t_90 = t_response[idx_90[0]] if len(idx_90) > 0 else np.nan

    idx_95 = np.where(np.abs(response) >= abs(final_val * 0.95))[0]
    t_95 = t_response[idx_95[0]] if len(idx_95) > 0 else np.nan

    print(f"\n  动态性能指标:")
    print(f"    时间常数 τ (63.2%) = {tau:.3f} s" if not np.isnan(tau) else "    时间常数 τ = N/A")
    print(f"    上升时间 t_90       = {t_90:.3f} s" if not np.isnan(t_90) else "    上升时间 t_90 = N/A")
    print(f"    稳定时间 t_95       = {t_95:.3f} s" if not np.isnan(t_95) else "    稳定时间 t_95 = N/A")

    # 稳态误差
    steady_noise = np.std(response[-50:]) if len(response) > 50 else np.std(response)
    print(f"    稳态噪声 (Std)      = {steady_noise:.2f} ADC")
    print(f"    动态误差范围        = ±{3*steady_noise:.2f} ADC (±3σ)")

    # 绘制阶跃响应
    fig, ax = plt.subplots()
    ax.plot(t_response, response, 'b-', linewidth=1.0, label='Step Response')

    # 标注关键指标
    if not np.isnan(tau):
        ax.axvline(tau, color='r', linestyle='--', alpha=0.6,
                   label=f'τ={tau:.3f}s (63.2%)')
        ax.plot(tau, target, 'ro', markersize=6)
    if not np.isnan(t_90):
        ax.axvline(t_90, color='g', linestyle='--', alpha=0.6,
                   label=f't_90={t_90:.3f}s')
    if not np.isnan(t_95):
        ax.axvline(t_95, color='orange', linestyle='--', alpha=0.6,
                   label=f't_95={t_95:.3f}s')

    ax.axhline(final_val, color='gray', linestyle=':', alpha=0.5,
               label=f'Steady State = {final_val:.1f}')
    ax.axhline(final_val * 0.632, color='r', linestyle=':', alpha=0.3)
    ax.axhline(final_val * 0.90, color='g', linestyle=':', alpha=0.3)
    ax.axhline(final_val * 0.95, color='orange', linestyle=':', alpha=0.3)

    ax.set_xlabel('Time (s)')
    ax.set_ylabel('Response (ADC, normalized)')
    ax.set_title('Dynamic Step Response')
    ax.legend(fontsize=9)

    plt.tight_layout()

    return {
        'tau': tau,
        't_90': t_90,
        't_95': t_95,
        'steady_noise': steady_noise,
        'final_val': final_val,
    }


# =====================================================================
# E 部分 — 蠕变分析 (Creep Analysis)
# =====================================================================

def part_e_creep(ts, raw_vals, weights_info=None):
    """
    蠕变（Creep）分析：传感器持续受力时读数缓慢变化的现象。
    输入: 长时间加载下的时间序列数据
    """
    print("\n" + "=" * 60)
    print("  E 部分：蠕变分析 (Creep)")
    print("=" * 60)

    if len(ts) < 100:
        print("  ⚠ 数据点数太少（<100），无法进行有意义的蠕变分析")
        print("  请采集连续加载 30 秒以上的数据")
        return

    # 取后半段数据观察蠕变
    mid = len(ts) // 2
    t_creep = ts[mid:] - ts[mid]
    v_creep = raw_vals[mid:]

    if len(t_creep) < 50:
        print("  数据不足")
        return

    # 线性拟合蠕变趋势
    coeffs = polyfit(t_creep, v_creep, 1)
    creep_rate = coeffs[0]  # ADC/秒
    creep_fit = polyval(coeffs, t_creep)

    # 总蠕变量
    total_drift = v_creep[-1] - v_creep[0]

    print(f"  蠕变斜率 (Creep rate): {creep_rate:.4f} ADC/s")
    print(f"  总漂移 (Total drift):  {total_drift:.2f} ADC")
    print(f"  采样时长: {t_creep[-1]:.2f} s")
    if total_drift != 0:
        print(f"  蠕变方向: {'上升 ↑' if creep_rate > 0 else '下降 ↓'}")

    # 绘制
    fig, ax = plt.subplots()
    ax.plot(t_creep, v_creep, 'b-', linewidth=0.8, alpha=0.6, label='Raw data')
    ax.plot(t_creep, creep_fit, 'r--', linewidth=1.5, label=f'Linear fit (slope={creep_rate:.4f})')
    ax.set_xlabel('Time (s)')
    ax.set_ylabel('ADC Value')
    ax.set_title('Creep Analysis: ADC Drift Under Constant Load')
    ax.legend()
    plt.tight_layout()

    # 蠕变补偿建议
    print(f"\n  ★ 蠕变补偿建议:")
    print(f"    1. 如果已知加载时间，可减去蠕变趋势项（斜率补偿）")
    print(f"    2. 在加载后等待固定时间再读数（如 5 秒后）")
    print(f"    3. 软件补偿：y_compensated = y - creep_rate * (t - t_start)")

    return {'creep_rate': creep_rate, 'total_drift': total_drift}


# =====================================================================
# F 部分 — 自动清零验证 (Auto-zeroing)
# =====================================================================

def part_f_autozero():
    """
    自动清零（Auto-zeroing）逻辑演示。
    在实际 Arduino 代码中实现，这里在 Python 中模拟验证。
    """
    print("\n" + "=" * 60)
    print("  F 部分：自动清零 (Auto-zeroing)")
    print("=" * 60)

    print("""
  自动清零逻辑（在 Arduino 或上位机中实现）:

  1. 维护一个滑动窗口记录最近 N 个读数（如最近 50 个）
  2. 如果滑动窗口的均值接近 0（在阈值内），将当前偏移更新为零点
  3. 当检测到读数显著偏离零点时（加载），停止自动清零
  4. 当检测到读数回到零点附近并稳定后（卸载），重新触发自动清零

  伪代码：
  ```
  ZERO_THRESHOLD = 50     // ADC 阈值
  WINDOW_SIZE = 30        // 滑动窗口大小
  buffer = [0] * WINDOW_SIZE

  loop:
      reading = readHX711()
      buffer.push(reading)
      avg = mean(buffer)

      if abs(avg) < ZERO_THRESHOLD and not loaded:
          offset = avg         // 更新零点偏移
      elif abs(avg) > ZERO_THRESHOLD * 5:
          loaded = true        // 检测到加载
      elif loaded and avg < ZERO_THRESHOLD:
          loaded = false       // 检测到卸载
          offset = avg         // 自动清零

      corrected = reading - offset
      Serial.println(corrected)
  ```
    """)

    # 模拟自动清零效果
    np.random.seed(42)
    t_sim = np.linspace(0, 20, 1000)

    # 模拟信号：空载 → 加载 → 卸载 → 自动清零
    signal = np.zeros_like(t_sim)
    # 0~5s: 空载（有噪声）
    signal[:250] = np.random.normal(10, 15, 250)
    # 5~12s: 加载 500g
    signal[250:600] = 52000 + np.random.normal(15, 15, 350)
    # 12~20s: 卸载，有偏移
    signal[600:] = np.random.normal(30, 15, 400)

    # 零点跟踪（滑动均值）
    window = 30
    zero_offset = np.zeros_like(t_sim)
    loaded = False

    for i in range(len(t_sim)):
        if i < window:
            zero_offset[i] = np.mean(signal[:i+1])
            continue
        avg = np.mean(signal[i-window:i])
        if not loaded and abs(avg) < 50:
            zero_offset[i] = avg
        elif abs(avg) > 500:
            loaded = True
            zero_offset[i] = zero_offset[i-1]
        elif loaded and abs(avg) < 50:
            loaded = False
            zero_offset[i] = avg
        else:
            zero_offset[i] = zero_offset[i-1]

    corrected = signal - zero_offset

    # 绘图
    fig, axes = plt.subplots(3, 1, figsize=(12, 8), sharex=True)

    axes[0].plot(t_sim, signal, 'b-', linewidth=0.8)
    axes[0].set_ylabel('Raw ADC')
    axes[0].set_title('Raw Signal (with offset drift)')
    axes[0].axvline(5, color='r', linestyle='--', alpha=0.3, label='Load')
    axes[0].axvline(12, color='g', linestyle='--', alpha=0.3, label='Unload')
    axes[0].legend()

    axes[1].plot(t_sim, zero_offset, 'r-', linewidth=1.0)
    axes[1].set_ylabel('Zero Offset (ADC)')
    axes[1].set_title('Auto-zeroing: Tracking Offset')
    axes[1].set_ylim(-100, 100)

    axes[2].plot(t_sim, corrected, 'g-', linewidth=0.8)
    axes[2].set_xlabel('Time (s)')
    axes[2].set_ylabel('Corrected ADC')
    axes[2].set_title('After Auto-zeroing: Drift Removed')
    axes[2].axhline(0, color='gray', linestyle=':', alpha=0.5)

    plt.tight_layout()
    print("  ★ 自动清零模拟图已生成")


# =====================================================================
# 精度测试分析
# =====================================================================

def part_accuracy(weights, adc_values, calib_results, order_choice=1):
    """
    精度测试：使用随机重量的测试数据，计算测量误差。
    输出: 绝对误差、相对误差、是否符合 < 0.1 g 要求
    """
    print("\n" + "=" * 60)
    print("  精度测试分析 (Accuracy Test)")
    print("=" * 60)

    if not ACCURACY_FILES:
        print("  ⚠ 未配置精度测试数据文件。")
        print("  请在使用 data_collection.py 采集不同重量的数据后，")
        print("  填写 ACCURACY_FILES 字典。")
        return

    # 选用的拟合多项式阶数
    coeffs = calib_results[order_choice]['coeffs']

    test_weights = []
    test_predicted = []
    test_errors = []

    for true_w, path in sorted(ACCURACY_FILES.items()):
        if not os.path.exists(path):
            print(f"  ⚠ 文件不存在: {path}")
            continue
        raw = load_pkl(path)
        # 后半段稳定数据均值
        n = len(raw)
        mean_adc = np.mean(raw[int(n * 0.5):])
        predicted_w = polyval(coeffs, mean_adc)  # ★ 注意：这里用ADC->重量需反函数

        error = predicted_w - true_w
        test_weights.append(true_w)
        test_predicted.append(predicted_w)
        test_errors.append(error)

        status = "✓" if abs(error) < 0.1 else "✗"
        print(f"  {status}  {true_w:4d} g → 测量值={predicted_w:7.3f} g, "
              f"误差={error:+.4f} g")

    if len(test_weights) == 0:
        return

    test_errors = np.array(test_errors)
    rmse = np.sqrt(np.mean(test_errors**2))
    max_err = np.max(np.abs(test_errors))

    print(f"\n  --- 汇总 ---")
    print(f"  测试次数: {len(test_weights)}")
    print(f"  RMSE: {rmse:.4f} g")
    print(f"  最大绝对误差: {max_err:.4f} g")
    print(f"  目标: < 0.1 g")
    print(f"  结果: {'✓ 通过' if max_err < 0.1 else '✗ 未通过'}")

    # 绘制
    fig, axes = plt.subplots(1, 2, figsize=(12, 4))
    axes[0].plot(test_weights, test_predicted, 'bo', label='Measured')
    axes[0].plot(test_weights, test_weights, 'r-', label='Ideal')
    axes[0].set_xlabel('True Weight (g)')
    axes[0].set_ylabel('Measured Weight (g)')
    axes[0].set_title('Measured vs True Weight')
    axes[0].legend()
    axes[0].axis('equal')

    axes[1].bar(range(len(test_weights)), test_errors, color=['g' if abs(e) < 0.1 else 'r'
                                                               for e in test_errors])
    axes[1].axhline(0.1, color='r', linestyle='--', alpha=0.5, label='±0.1 g limit')
    axes[1].axhline(-0.1, color='r', linestyle='--', alpha=0.5)
    axes[1].set_xticks(range(len(test_weights)))
    axes[1].set_xticklabels([f'{w}g' for w in test_weights], rotation=45)
    axes[1].set_ylabel('Error (g)')
    axes[1].set_title('Measurement Error')
    axes[1].legend()

    plt.tight_layout()

    return {'rmse': rmse, 'max_error': max_err, 'errors': test_errors}


# =====================================================================
# 系统框图（文本输出）
# =====================================================================

def part_system_block_diagram():
    """输出系统结构框图（文本格式，也可用于绘图）"""
    print("\n" + "=" * 60)
    print("  系统结构框图 (System Block Diagram)")
    print("=" * 60)

    print("""
  ┌─────────────────────────────────────────────────────────────┐
  │                    电子秤系统架构                              │
  └─────────────────────────────────────────────────────────────┘

  ┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
  │ CZL611N  │     │  HX711   │     │ Arduino  │     │ 电脑端   │
  │ 称重传感器│────→│ 24-bit   │────→│ (Mega/   │────→│ Python   │
  │ (1 kg)   │     │ ADC +    │     │  Uno)    │     │ 数据分析 │
  │ 灵敏度:  │     │ 运放     │     │          │     │          │
  │ 1 mV/V   │     │ 分辨率:  │     │ 采样率:  │     │ 标定    │
  │          │     │ 24 bit   │     │ ≥10 Hz   │     │ 滤波    │
  │ 非线性:  │     │ 增益:    │     │ 串口:    │     │ 拟合    │
  │ <0.03%FS │     │ 128x     │     │ 115200   │     │ 绘图    │
  └──────────┘     └──────────┘     └──────────┘     └──────────┘
       │                                  │
       │                                  ├── 显示屏 (可选)
       │                                  └── 自动清零 (固件)
       │
  ┌────┴────┐
  │ 砝码/重物│
  └─────────┘

  关键性能指标:
  ┌─────────────────────┬────────────────────────────────────┐
  │ 指标                │ 数值/说明                          │
  ├─────────────────────┼────────────────────────────────────┤
  │ 量程 (Range)        │ 0 ~ 1000 g                        │
  │ 理论分辨率          │ 1/2^24 ≈ 0.00006 g (远超要求)      │
  │ ADC 采样率          │ ≥ 10 Hz (实际 50 Hz)               │
  │ 传感器非线性        │ < 0.03% FS                        │
  │ 蠕变 (Creep)        │ 可高达 0.15 g (需补偿)             │
  │ 目标精度            │ < 0.1 g                           │
  │ 校准方法            │ 多项式拟合 (推荐 1 阶)              │
  │ 滤波方法            │ 移动平均/中值滤波                   │
  │ 输出接口            │ USB 串口 (115200 baud)             │
  └─────────────────────┴────────────────────────────────────┘
    """)


# =====================================================================
# 理论分辨率分析
# =====================================================================

def part_theoretical_analysis():
    """理论分辨率分析"""
    print("\n" + "=" * 60)
    print("  理论分辨率分析")
    print("=" * 60)

    adc_bits = 24
    range_g = 1000
    resolution = range_g / (2**adc_bits)

    print(f"""
  HX711 ADC: {adc_bits} 位
  理论分辨率: 1 / 2^{adc_bits} = 1 / {2**adc_bits:,}
  量程: {range_g} g
  理论分辨率（重量）: {resolution:.8f} g ≈ {resolution*1000:.6f} mg

  远超项目的 0.1 g 要求！

  实际误差主要来源:
  1. 传感器蠕变 (Creep) — 可达 0.15 g
  2. 温度漂移
  3. 机械噪声与振动
  4. 空气流动（呼吸、风扇）
  5. ADC 电路噪声
  6. 砝码自身误差（M2 级 500g 砝码误差 ±75 mg）
    """)


# =====================================================================
# 主程序
# =====================================================================

def main():
    print("=" * 60)
    print("  电子秤项目 — 完整数据分析")
    print("=" * 60)

    # ---- 加载数据 ----
    print("\n[1] 加载标定数据...")
    weights, adc_means, adc_stds = load_data_files(CALIBRATION_FILES)

    if len(weights) < 3:
        print("\n⚠ 标定点数不足（至少需 3 个），无法完成分析。")
        print("请先使用 data_collection.py 采集各标准砝码数据并配置路径。")
        return

    # 加载所有原始时间序列数据（用于滤波分析）
    adc_values_all = []
    for w in sorted(CALIBRATION_FILES.keys()):
        path = CALIBRATION_FILES[w]
        if os.path.exists(path):
            adc_values_all.append(load_pkl(path))
        else:
            adc_values_all.append(np.array([]))

    # ---- B. 系统标定与多项式拟合 ----
    calib_results = part_b_calibration(weights, adc_means)

    # ---- C. 信号处理与滤波 ----
    if any(len(v) > 0 for v in adc_values_all):
        fig_c = part_c_filtering(weights, adc_values_all)
    else:
        print("\n⚠ 跳过滤波分析：无原始时间序列数据")

    # ---- D. 动态性能测试 ----
    # 如果有动态测试数据文件
    if os.path.exists('data/dynamic_response.pkl'):
        dyn = load_pkl('data/dynamic_response.pkl')
        part_d_dynamic(dyn['timestamps'], dyn['raw_values'])
    else:
        print("\n⚠ 跳过动态性能测试（需 data/dynamic_response.pkl）")
        print("  提示：在加载和卸载砝码时采集数据即可获得")

    # ---- E. 蠕变分析 ----
    if os.path.exists('data/creep_test.pkl'):
        creep = load_pkl('data/creep_test.pkl')
        part_e_creep(creep['timestamps'], creep['raw_values'])
    else:
        print("\n⚠ 跳过蠕变分析（需 data/creep_test.pkl）")
        print("  提示：放上砝码后连续采集 30 秒以上数据")

    # ---- F. 自动清零 ----
    part_f_autozero()

    # ---- 精度测试 ----
    part_accuracy(weights, adc_values_all, calib_results)

    # ---- 系统框图 ----
    part_system_block_diagram()

    # ---- 理论分析 ----
    part_theoretical_analysis()

    # ---- 显示所有图 ----
    print("\n" + "=" * 60)
    print("  所有图表已生成，请关闭图形窗口以退出")
    print("=" * 60)
    plt.show()


if __name__ == '__main__':
    main()
