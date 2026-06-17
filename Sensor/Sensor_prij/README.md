# 电子秤项目 — 基于 HX711 + CZL611N 的高精度电子秤

## 项目结构

```
Sensor/
├── README.md                      # 本文件
├── 工作流.md                      # 项目开发工作流说明
├── final project.pdf              # 项目任务书（含评分标准）
├── Sensors Project Instruction.pdf
├── hx711_scale/
│   └── hx711_scale.ino           # Arduino 下位机程序
└── python/
    ├── data_collection.py         # 数据采集上位机（实时接收 + 绘图 + 保存）
    └── calibration_analysis.py    # 标定/滤波/动态分析/精度测试
```

---

## 硬件连接

### 所需元件
| 元件 | 型号/规格 |
|------|-----------|
| 称重传感器 | CZL611N (量程 1 kg) |
| ADC 模块 | HX711 (24-bit, 128x 增益) |
| 开发板 | Arduino Mega 2560 (推荐) 或 Arduino Uno |
| 标准砝码 | M2 级，0~1000 g 套装 |
| 可选：显示屏、防风罩等 | — |

### 接线图

```
CZL611N (Load Cell)     HX711 模块            Arduino
──────────────────      ──────────            ───────
红 (E+)      ─────────→ E+
黑 (E-)      ─────────→ E-
绿 (A+)      ─────────→ A+
白 (A-)      ─────────→ A-

                        VCC      ─────────→ 5V
                        GND      ─────────→ GND
                        DT       ─────────→ D56 (Mega) / D2 (Uno)
                        SCK      ─────────→ D57 (Mega) / D3 (Uno)
```

> **注意**：不同型号的 CZL611N 传感器线色可能不同，请以实物标注为准。

---

## 软件使用步骤

### 1. Arduino 下位机程序

1. 打开 `hx711_scale/hx711_scale.ino`
2. 根据你的 Arduino 型号修改引脚配置：
   - **Arduino Mega**：默认 `PIN_DOUT=56, PIN_SCK=57`（不用改）
   - **Arduino Uno**：改为 `PIN_DOUT=2, PIN_SCK=3`
3. 上传到 Arduino 开发板
4. 打开串口监视器确认有数据输出（每秒约 50 行整数）

### 2. Python 环境准备

```bash
# 安装依赖
pip install pyserial numpy matplotlib scipy scikit-learn --break-system-packages
```

### 3. 数据采集

```bash
cd python/
python data_collection.py
```

- 程序会自动检测 Arduino 串口并开始接收数据
- 实时绘图显示数据流
- **按 Ctrl+C 停止采集**，数据自动保存为 `.pkl` 和 `.csv` 文件

#### 采集计划

| 数据用途 | 采集方法 | 保存命名建议 |
|---------|----------|-------------|
| **标定数据** | 分别放上每个标准砝码，稳定后采集 10 秒 | `calib_XXg.pkl` |
| **空载噪声** | 不放任何东西，采集 10 秒 | `noise_empty.pkl` |
| **动态响应** | 快速放上砝码，记录完整响应过程 | `dynamic_response.pkl` |
| **蠕变测试** | 放上 500 g 砝码，连续采集 30 秒以上 | `creep_test.pkl` |
| **精度测试** | 随机重量，每次稳定后采集 | `test_XXg.pkl` |

建议在 `python/` 下创建 `data/` 目录存放所有数据文件：
```bash
mkdir python/data
```

### 4. 数据分析

1. 在 `calibration_analysis.py` 中修改 `CALIBRATION_FILES` 字典，将路径指向你采集的数据文件
2. 同样配置 `ACCURACY_FILES`（精度测试）
3. 运行：

```bash
cd python/
python calibration_analysis.py
```

程序会自动生成：
- 各阶多项式拟合曲线对比图
- 残差分析图
- 滤波前后对比图
- 动态阶跃响应图
- 蠕变分析图
- 自动清零模拟图
- 精度测试误差图
- 系统框图（文本）
- 理论分辨率分析

---

## 标定流程

1. **准备环境**：安静、无风、平稳的桌面，建议加装防风罩
2. **佩戴手套**：绝对不要徒手接触标准砝码
3. **预热**：系统上电后等待 2 分钟稳定
4. **空载归零**：不放砝码，记录空载 ADC 读数
5. **逐次加载**：按 0 → 50 → 100 → 200 → ... → 1000 g 依次放置砝码
6. **每次采集**：稳定后采集至少 5 秒数据（建议 10 秒）
7. **记录数据**：用 `data_collection.py` 保存每个砝码的数据

---

## 项目要求对应表

| 项目要求 | 对应文件 | 说明 |
|---------|---------|------|
| A. 硬件搭建 | `hx711_scale.ino` | 硬件接线 + Arduino 程序 |
| B. 系统标定 | `calibration_analysis.py` 中 `part_b_calibration()` | 1~5 阶多项式拟合 |
| C. 信号滤波 | `calibration_analysis.py` 中 `part_c_filtering()` | 均值/中值/S-G 滤波对比 |
| D. 动态性能 | `calibration_analysis.py` 中 `part_d_dynamic()` | 时间常数、动态误差 |
| E. 系统框图 | `calibration_analysis.py` 中 `part_system_block_diagram()` | 结构框图 + 性能指标 |
| F. 自动清零 | `calibration_analysis.py` 中 `part_f_autozero()` | 自动清零逻辑 |
| 附加：蠕变分析 | `calibration_analysis.py` 中 `part_e_creep()` | 蠕变检测与补偿 |
| 附加：精度测试 | `calibration_analysis.py` 中 `part_accuracy()` | 10 次以上随机重量测试 |

---

## 常见问题

### Q: Arduino 没有数据输出？
- 检查串口波特率是否匹配（Arduino 和 Python 都设为 115200）
- 检查 HX711 接线是否正确
- 尝试 reset Arduino 开发板

### Q: Python 找不到串口？
- Mac: `ls /dev/tty.*` 查看可用串口
- Linux: `ls /dev/ttyUSB*` 或 `ls /dev/ttyACM*`
- Windows: 在设备管理器中查看 COM 端口
- 可能需要安装 CH340/CP210x 驱动

### Q: 读数跳动很大？
- 检查连接线是否牢固
- 远离 EMI 源（电机、电源适配器）
- 增加滤波窗口大小
- 检查是否在防风环境下

### Q: 如何提高精度到 < 0.1 g？
1. 做好防风（加玻璃罩）
2. 严格佩戴手套操作砝码
3. 使用适当的滤波（推荐 Moving Average, win=5~15）
4. 蠕变补偿
5. 自动清零处理
6. 多次测量取平均
