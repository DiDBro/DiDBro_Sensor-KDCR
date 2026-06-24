function K = hatm(omega)
% HATM  帽子算子: 3x1 向量 -> 3x3 反对称矩阵 (支持符号变量)
    omega = omega(:);
    w1 = omega(1); 
    w2 = omega(2); 
    w3 = omega(3);
    K = [  0, -w3,  w2;
          w3,   0, -w1;
         -w2,  w1,   0];
end
