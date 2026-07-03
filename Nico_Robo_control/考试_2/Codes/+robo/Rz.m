function R = Rz(theta)
% RZ  绕 z 轴旋转 theta 弧度
%   R = Rz(theta)
%   R = [c, -s,  0;
%        s,  c,  0;
%        0,  0,  1]
    c = cos(theta);
    s = sin(theta);
    R = [c, -s,  0;
         s,  c,  0;
         0,  0,  1];
end
