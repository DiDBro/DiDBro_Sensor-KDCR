function G = gravityWrench(g, g_dir, g_mag)
% GRAVITYWRENCH  构造重力在空间坐标系中的力旋量 (wrench)
%    G = gravityWrench(g)
%    G = gravityWrench(g, g_dir)
%    G = gravityWrench(g, g_dir, g_mag)
%
%    输入:
%        g     - 4×4 齐次变换矩阵, 工具坐标系的当前位姿
%                 或标量 n (仅用于构造基座系重力旋量, n 为关节数)
%        g_dir - (可选) 重力在空间坐标系中的方向向量, 默认 [0; 0; -1]
%        g_mag - (可选) 重力加速度大小, 默认 9.81 m/s²
%
%    输出:
%        G     - 6×1 力旋量, 默认顺序 [f; τ] (力; 力矩)
%
%    公式:
%        空间坐标系中的重力旋量 (恒定向下的纯力):
%            G_0 = [m * g_dir * g_mag;  0; 0; 0]
%
%        变换到工具坐标系 (体坐标系):
%            G_body = Ad_g^T · G_0      (coadjoint)
%
%    用法:
%        % 构造基座系中的重力旋量 (连杆 l, 质量 m_l)
%        G_0 = m_l * gravityWrench(eye(4));   % G_0 = [0; 0; -9.81*m; 0; 0; 0]
%
%        % 变换到连杆当前坐标系
%        G_l = coadjoint(g_0l)' * G_0;        % 等价于 Ad_g^{-T} · G_0
%
%    参见: coadjoint, newtonEuler

    if nargin < 3
        g_mag = 9.81;
    end
    if nargin < 2
        g_dir = [0; 0; -1];   % 默认重力沿 -z 方向
    end

    g_dir = g_dir(:);
    g_accel = g_dir * g_mag;   % 重力加速度向量

    % 力旋量: 重力只有线力分量, 无力矩
    % (力作用在质心, 在质心处不产生力矩)
    % 注意: 对于空间旋量表示 [v; ω], wrench 为 [f; τ]
    G = [g_accel;    % f = 重力 (在空间坐标系中)
         zeros(3,1)]; % τ = 0 (纯力无矩)
end
