function S = hatm_num(v)
% HATM_NUM 计算三维向量的反对称矩阵（叉乘矩阵）
%   S = HATM_NUM(v) 输入一个3维向量v，返回其对应的3x3反对称矩阵S
%   使得对于任意向量w，有 S*w = cross(v, w)
%
%   输入：
%       v - 3元素向量，可以是行向量或列向量，支持数值和符号输入
%   输出：
%       S - 3x3反对称矩阵 [0, -v3, v2; v3, 0, -v1; -v2, v1, 0]
%
%   示例：
%       S = hatm_num([1, 2, 3])      % 数值输入
%       syms a b c; S = hatm_num([a; b; c])  % 符号输入
%
%   另见： CROSS, SKEW

    % % 输入验证
    % if nargin ~= 1
    %     error('HATM_NUM: 需要且仅需要一个输入参数');
    % end
    % 
    % % 确保v是向量
    % if ~isvector(v)
    %     error('HATM_NUM: 输入必须是一个向量');
    % end
    % 
    % % 确保是3维向量
    % v = v(:);  % 转换为列向量
    % if length(v) ~= 3
    %     error('HATM_NUM: 输入必须是3维向量 [v1; v2; v3] 或 [v1, v2, v3]');
    % end
    
    % 提取分量
    v1 = v(1);
    v2 = v(2);
    v3 = v(3);
    
    % 构造反对称矩阵
    S = [0,   -v3,   v2;
         v3,   0,   -v1;
        -v2,   v1,   0];
end