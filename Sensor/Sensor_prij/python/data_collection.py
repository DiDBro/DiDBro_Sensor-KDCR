#!/usr/bin/env python3
"""
电子秤数据采集上位机 — 实时接收 + 绘图 + 保存
============================================
功能：
  1. 自动检测 Arduino 串口
  2. 实时接收 HX711 原始读数（≥10 Hz）
  3. 动态绘图显示实时数据流
  4. 按 Ctrl+C 停止后自动保存为 pickle 文件

用法：
  python data_collection.py

依赖：
  pip install pyserial numpy matplotlib --break-system-packages
"""

import time
import pickle
import sys
from copy import copy

import numpy as np
import serial
import serial.tools.list_ports
from matplotlib import pyplot as plt


# ======== 配置 ========
SERIAL_BAUD = 115200        # 必须与 Arduino 代码一致
SERIAL_TIMEOUT = 1          # 串口读取超时（秒）
PLOT_WINDOW_SEC = 10        # 实时绘图显示最近多少秒的数据
# ======================


def find_serial_port():
    """自动查找 Arduino 串口"""
    ports = serial.tools.list_ports.comports()
    if not ports:
        raise RuntimeError("未检测到串口设备！\n"
                           "请检查：\n"
                           "  1. Arduino 已通过 USB 连接\n"
                           "  2. 已安装 CH340/CP210x 驱动（如需要）")

    # 优先选择常见的 Arduino 串口描述
    for p in ports:
        desc = p.description.lower()
        if any(kw in desc for kw in ['arduino', 'ch340', 'cp210', 'ftdi', 'usb']):
            print(f"  自动选择: {p.device} ({p.description})")
            return p.device

    # 回退到第一个串口
    print(f"  未识别到 Arduino 特征，使用第一个串口: {ports[0].device}")
    return ports[0].device


def receive_line(ser, timeout=2):
    """从串口读取一行数据（兼容各种结束符）"""
    buf = bytearray()
    start = time.time()
    while time.time() - start < timeout:
        if ser.in_waiting > 0:
            b = ser.read(1)
            if b == b'\n' or b == b'\r':
                if len(buf) > 0:
                    break
            else:
                buf.extend(b)
        else:
            time.sleep(0.001)
    return buf.decode('utf-8').strip()


def main():
    print("=" * 50)
    print("  电子秤 — 数据采集上位机")
    print("=" * 50)

    # --- 查找串口 ---
    print("\n[1/4] 查找 Arduino 串口...")
    port = find_serial_port()

    # --- 连接串口 ---
    print(f"\n[2/4] 连接 {port} (波特率 {SERIAL_BAUD})...")
    ser = serial.Serial(port, SERIAL_BAUD, timeout=SERIAL_TIMEOUT)
    ser.reset_input_buffer()
    ser.reset_output_buffer()
    print("  连接成功！")

    # --- 准备绘图 ---
    print("\n[3/4] 初始化实时绘图...")
    plt.ion()  # 交互模式
    fig, ax = plt.subplots(figsize=(12, 5))
    ax.set_xlabel("Time (s)")
    ax.set_ylabel("Raw ADC Value")
    ax.set_title("Real-time HX711 Data")
    ax.grid(True, alpha=0.3)

    line, = ax.plot([], [], 'b-', linewidth=0.8, label='Raw')
    ax.legend()

    print("\n" + "=" * 50)
    print("  开始采集数据...")
    print("  按 Ctrl+C 停止采集并保存数据")
    print("=" * 50 + "\n")

    # --- 数据缓冲区 ---
    ts = []          # 时间戳（秒，相对起始）
    raw_values = []  # 原始 ADC 读数
    t0 = time.time() * 1000  # 起始毫秒时间戳

    try:
        while True:
            data_str = receive_line(ser, timeout=1)
            if data_str:
                try:
                    value = int(data_str)
                except ValueError:
                    continue  # 忽略非数字行

                # 相对时间（秒）
                t = (time.time() * 1000 - t0) / 1000.0
                ts.append(t)
                raw_values.append(value)

                # 更新绘图
                if len(ts) > 1:
                    # 只显示最近 PLOT_WINDOW_SEC 秒
                    if ts[-1] - ts[0] > PLOT_WINDOW_SEC:
                        # 找到窗口起点
                        window_start = ts[-1] - PLOT_WINDOW_SEC
                        idx = next(i for i, v in enumerate(ts) if v >= window_start)
                        plot_t = ts[idx:]
                        plot_v = raw_values[idx:]
                    else:
                        plot_t = ts
                        plot_v = raw_values

                    line.set_xdata(plot_t)
                    line.set_ydata(plot_v)
                    ax.relim()
                    ax.autoscale_view()
                    fig.canvas.draw()
                    fig.canvas.flush_events()

                # 状态提示（每分钟一次）
                if len(ts) % 3000 == 0:
                    print(f"  已采集 {len(ts):5d} 个数据点, "
                          f"当前读数: {raw_values[-1]:8d}, "
                          f"耗时: {ts[-1]:.1f} s")

    except KeyboardInterrupt:
        print("\n\n  用户中断采集")
    finally:
        # --- 关闭串口 ---
        ser.close()
        print("  串口已关闭")

    # --- 保存数据 ---
    print(f"\n[4/4] 保存数据 ({len(ts)} 个数据点)...")

    data_pkg = {
        'timestamps': np.array(ts),
        'raw_values': np.array(raw_values),
        't0_ms': t0,
        'baud': SERIAL_BAUD,
    }

    filename = f'scale_data_{time.strftime("%Y%m%d_%H%M%S")}.pkl'
    with open(filename, 'wb') as f:
        pickle.dump(data_pkg, f)
    print(f"  数据已保存至: {filename}")

    # 同时另存为 CSV（方便查看）
    csv_name = filename.replace('.pkl', '.csv')
    with open(csv_name, 'w') as f:
        f.write("time_s,raw_adc\n")
        for t, v in zip(ts, raw_values):
            f.write(f"{t:.4f},{v}\n")
    print(f"  CSV 备份: {csv_name}")

    # 保持绘图窗口打开
    plt.ioff()
    plt.show(block=True)

    print("\n  采集结束。")
    # 提示后续步骤
    print("\n" + "-" * 50)
    print("  下一步:")
    print("  运行 calibration_analysis.py 进行标定和滤波分析")
    print("-" * 50)


if __name__ == '__main__':
    main()
