function Ad_g = adjmg(g)
% ADJMG 计算齐次变换矩阵的伴随矩阵（Adjoint Transformation）
%   Ad_g = ADJMG(g) 计算齐次变换矩阵g的6x6伴随矩阵
%
%   输入：
%       g - 4x4齐次变换矩阵 [R, p; 0 0 0, 1]
%           R: 3x3旋转矩阵，p: 3x1平移向量
%   输出：
%       Ad_g - 6x6伴随矩阵，形式为 [R, hat(p)*R; 0, R]
%               对应旋量顺序 ξ = [v; ω]（线速度在前）
%
%   此实现对应公式：
%       Ad_g = [ R,  hat(p)*R ]
%              [ 0,       R   ]
%
%   注意：此形式与常见形式 [R, 0; hat(p)R, R] 不同，
%         区别在于旋量表示顺序（v在前 vs ω在前）
%
%   使用示例：
%       g = [eye(3), [0.1; 0.2; 0.3]; [0 0 0], 1];
%       Ad = adjmg(g);
%
%   另见： HATM_NUM
    % 
    % % 输入验证
    % if nargin ~= 1
    %     error('ADJMG: 需要且仅需要一个输入参数');
    % end
    % 
    % if ~isequal(size(g), [4, 4])
    %     error('ADJMG: 输入必须是4x4齐次变换矩阵');
    % end
    % 
    % % 检查齐次变换矩阵的最后一行是否为 [0, 0, 0, 1]
    % if ~isequal(g(4, :), [0, 0, 0, 1])
    %     warning('ADJMG: 输入矩阵最后一行不是 [0, 0, 0, 1]，可能不是有效的齐次变换矩阵');
    % end
    
    % 提取旋转和平移部分
    R = g(1:3, 1:3);
    p = g(1:3, 4);
    
    % 计算平移向量的反对称矩阵（使用自定义函数）
    p_hat = hatm_num(p);
    
    % 按照图片中的公式组装伴随矩阵
    % 形式： [R, p_hat*R; 0, R]
    Ad_g = [R,         p_hat * R;
            zeros(3),  R];
end