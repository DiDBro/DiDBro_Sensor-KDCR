function [omega, v, theta] = twistDecompose(varargin)
% TWISTDECOMPOSE  从 twist 或 SE(3) 矩阵中分离出 omega, v, theta
%   用法 1: [omega, v, theta] = twistDecompose(xi, theta)
%           输入 xi = [v; omega] (6×1), theta (标量)
%           返回 omega (3×1), v (3×1), theta (标量)
%
%   用法 2: [omega, v, theta] = twistDecompose(G)
%           输入 G = 4×4 SE(3) 矩阵 [R, p; 0 0 0 1]
%           先调用 G2twist 提取 xi 和 theta，再分解
%           返回 omega (3×1), v (3×1), theta (标量)
%
%   典型用途: 在推导或手算时快速查看 twist 的各组成部分，
%            无需手动写 xi(1:3) / xi(4:6) 索引。

    import robo.*

    if nargin == 1
        % 用法 2: 从 SE(3) 矩阵分解
        G = varargin{1};
        [xi, theta] = G2twist(G);
        v     = xi(1:3);
        omega = xi(4:6);

    elseif nargin == 2
        % 用法 1: 从 twist 坐标 + theta 分解
        xi    = varargin{1};
        theta = varargin{2};
        v     = xi(1:3);
        omega = xi(4:6);

    else
        error('用法: [omega,v,theta]=twistDecompose(xi,theta) 或 [omega,v,theta]=twistDecompose(G)');
    end

    % 确保列向量
    omega = omega(:);
    v     = v(:);
end
