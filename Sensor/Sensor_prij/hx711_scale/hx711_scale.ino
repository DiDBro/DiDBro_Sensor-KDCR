/**
 * HX711 + CZL611N 电子秤 — Arduino 下位机程序
 * ============================================
 * 功能：
 *   1. 读取 HX711 24 位 ADC 原始数据
 *   2. 通过串口以 ≥10 Hz 频率发送数据（格式：一行一个数值）
 *   3. 支持简易校准（去皮 / 毛重读数发送，上位机完成拟合）
 *
 * 硬件连接 (以 Arduino Mega 为例)：
 *   HX711        Arduino
 *   ------       -------
 *   VCC   →      5V
 *   GND   →      GND
 *   DT    →      PIN_DOUT (默认 56, Mega)
 *   SCK   →      PIN_SCK  (默认 57, Mega)
 *
 *   Arduino Uno 用户请将 PIN_DOUT 改为 2, PIN_SCK 改为 3
 *
 * 串口设置：115200 baud（不低于 10 Hz 输出，每次 loop 约 20 ms）
 * 数据格式：每行一个整数（原始 ADC 读数），末尾换行
 */

// ======== 用户配置区 ========
// Arduino Mega 推荐引脚: 56 (DOUT), 57 (SCK)
// Arduino Uno 推荐引脚:  2  (DOUT), 3  (SCK)
const uint8_t PIN_DOUT = 56;
const uint8_t PIN_SCK  = 57;

// 串口波特率（建议 115200 或 9600）
const long   SERIAL_BAUD = 115200;

// 采样间隔（毫秒），20 ms → 50 Hz，满足 ≥10 Hz 要求
const uint8_t SAMPLE_INTERVAL_MS = 20;
// ============================

// 内部变量
long raw_value = 0;

void setup() {
  pinMode(PIN_SCK, OUTPUT);
  pinMode(PIN_DOUT, INPUT_PULLUP);  // Mega 内置上拉，确保 DOUT 初始为高

  // HX711 上电后需要一段稳定时间
  digitalWrite(PIN_SCK, LOW);
  delay(100);

  Serial.begin(SERIAL_BAUD);
  delay(50);

  // 冷启动后丢弃前几次不稳定读数
  for (int i = 0; i < 5; i++) {
    readHX711();
    delay(50);
  }
}

void loop() {
  static unsigned long lastSample = 0;
  unsigned long now = millis();

  if (now - lastSample >= SAMPLE_INTERVAL_MS) {
    lastSample = now;

    // 读取 HX711
    long reading = readHX711();

    if (reading != 0) {
      raw_value = reading;
      // 通过串口发送：一行一个整数
      Serial.println(raw_value);
    }
  }

  // 处理串口命令（可选扩展）
  if (Serial.available() > 0) {
    char cmd = Serial.read();
    // 预留：可添加 't' 去皮（tare）等命令
    // if (cmd == 't') { ... }
  }
}

/**
 * 读 HX711 24 位 ADC 值（补码格式 → long）
 *
 * 时序协议：
 *   1. 等待 DOUT 从高变低（表示数据就绪）
 *   2. 连续发送 24 个 SCK 脉冲，每个脉冲上升沿读取 1 bit
 *   3. 再发第 25 个 SCK 脉冲：决定增益/通道
 *      - 25 个脉冲 → 通道 A, 128 增益（常用）
 *      - 27 个脉冲 → 通道 A, 64 增益
 *      - 26 个脉冲 → 通道 B, 32 增益
 *
 * 返回：24 位有符号整数（范围 -8388608 ~ 8388607）
 */
long readHX711() {
  // 等待数据就绪（DOUT 拉低）
  uint8_t timeout = 0;
  while (digitalRead(PIN_DOUT)) {
    delayMicroseconds(1);
    timeout++;
    if (timeout > 100) {         // 超时约 100 µs
      return 0;                  // 返回 0 表示异常
    }
  }

  uint8_t data[3] = {0, 0, 0};

  // 读取 24 位数据（MSB first）
  for (uint8_t j = 0; j < 3; j++) {
    for (uint8_t i = 0; i < 8; i++) {
      digitalWrite(PIN_SCK, HIGH);
      delayMicroseconds(1);
      bitWrite(data[2 - j], 7 - i, digitalRead(PIN_DOUT));
      digitalWrite(PIN_SCK, LOW);
      delayMicroseconds(1);
    }
  }

  // 第 25 个脉冲：通道 A, 128 增益
  digitalWrite(PIN_SCK, HIGH);
  delayMicroseconds(1);
  digitalWrite(PIN_SCK, LOW);
  delayMicroseconds(1);

  // 合并为 24 位有符号数（补码扩展）
  long value = ((long) data[2] << 16) | ((long) data[1] << 8) | (long) data[0];
  if (value & 0x800000) {        // 最高位为符号位
    value |= ~0xFFFFFF;          // 符号扩展为 32 位
  }

  return value;
}
