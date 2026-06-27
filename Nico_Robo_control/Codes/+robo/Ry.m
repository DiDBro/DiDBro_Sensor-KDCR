function R = Ry(theta)
% RY  绕 y 轴旋转 theta 弧度
%   R = Ry(theta)
%   R = [ c, 0,  s;
%         0, 1,  0;
%        -s, 0,  c]
    c = cos(theta);
    s = sin(theta);
    R = [ c,  0,  s;
          0,  1,  0;
         -s,  0,  c];
end
