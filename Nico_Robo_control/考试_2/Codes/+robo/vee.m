
function xi = vee(xi_wedge)
% VEE  vee 算子 (se3): 4x4 矩阵 -> 6x1 向量 [v; omega]
%   支持数值矩阵和符号矩阵
    if isa(xi_wedge, 'sym')
        xi_wedge = formula(xi_wedge);
    end
    v  = xi_wedge(1:3,4);
    w1 = xi_wedge(3,2);
    w2 = xi_wedge(1,3);
    w3 = xi_wedge(2,1);
    xi = [v; w1; w2; w3];
end
