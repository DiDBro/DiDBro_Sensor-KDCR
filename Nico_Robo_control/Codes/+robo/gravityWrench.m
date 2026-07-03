function G = gravityWrench(g_dir, g_mag)
% GRAVITYWRENCH  构造空间坐标系中的重力旋量 (wrench)
%    G = gravityWrench()           默认 [0;0;-9.81; 0;0;0]
%    G = gravityWrench(g_dir)      指定方向, 大小默认 9.81
%    G = gravityWrench(g_dir, g_mag) 指定方向和大小
%
%    输出: G (6×1) = [f; τ] = [g_accel; 0;0;0]
%    重力是纯力, 无力矩分量 (力作用线通过质心)
%
%    用法: 乘以质量得到连杆重力旋量
%        G_l = m_l * gravityWrench();
%        G_l_body = coadjoint(g_0l)' * G_l;  % 变换到连杆坐标系
    if nargin < 2, g_mag = 9.81; end
    if nargin < 1, g_dir = [0; 0; -1]; end
    g_dir = g_dir(:);
    G = [g_dir * g_mag; zeros(3,1)];
end
