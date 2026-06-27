function R = Rx(theta)
% RX  绕 x 轴旋转 theta 弧度
%   R = Rx(theta)
%   R = [1,  0,   0;
%        0,  c,  -s;
%        0,  s,   c]
    c = cos(theta);
    s = sin(theta);
    R = [1,  0,  0;
         0,  c, -s;
         0,  s,  c];
end
