function  Adjoint = Adgg(matrix)
import robo.*
if isa(matrix, 'sym')
    matrix = formula(matrix);
end
R = matrix(1:3,1:3);  %MATLAB 索引语法：矩阵(行范围, 列范围)
p = matrix(1:3,4);
Adjoint = [R, hatm(p)*R;   
    zeros(3,3),R];

end
