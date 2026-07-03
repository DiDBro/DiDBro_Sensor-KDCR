function g = gmat(R, p)
% GMAT  构建 4x4 齐次变换矩阵
%   输入: R - 3x3 旋转矩阵, p - 3x1 平移向量
    g = [R, p; zeros(1,3), 1];
end
