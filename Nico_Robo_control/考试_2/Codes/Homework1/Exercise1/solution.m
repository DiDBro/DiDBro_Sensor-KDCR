% 完整代码：读取CSV矩阵并判断是否为SO(3)旋转矩阵
clear; clc;

%% 1. 读取CSV文件，修改这里为你的csv文件名
filename = 'R3_matrix.csv';
R = readmatrix(filename);

%% 2. 检查尺寸必须是3×3
[m, n] = size(R);
fprintf('读取矩阵尺寸：%d × %d\n', m, n);
if m ~= 3 || n ~= 3
    disp('错误：矩阵不是3×3，不可能是旋转矩阵');
    return;
end

%% 3. 判断正交性：R'*R 应近似单位阵I
I3 = eye(3);
ortho_err = norm(R' * R - I3);
fprintf('正交误差 ||R^T R - I|| = %.2e\n', ortho_err);

%% 4. 判断行列式det(R)≈1
det_R = det(R);
fprintf('矩阵行列式 det(R) = %.6f\n', det_R);

%% 5. 设定浮点误差阈值（机器精度允许微小偏差）
tol = 1e-8;
is_orthogonal = (ortho_err < tol);
det_ok = (abs(det_R - 1) < tol);

%% 6. 输出结果
if is_orthogonal && det_ok
    disp('✅ 该矩阵是有效的SO(3)旋转矩阵');
elseif is_orthogonal && abs(det_R + 1) < tol
    disp('⚠️ 正交但行列式=-1，是反射矩阵，不是纯旋转');
else
    disp('❌ 不是旋转矩阵');
end

%% 可选：打印R^T*R直观查看
disp('R^T * R = ');
disp(R'*R);