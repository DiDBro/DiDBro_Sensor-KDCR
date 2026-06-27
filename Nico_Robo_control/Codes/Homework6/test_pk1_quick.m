addpath('..'); import robo.*;

omega = [0;0;1]; r_axis = [2;0;0]; v_tw = -cross(omega,r_axis); xi = [v_tw; omega];
theta_true = pi/3;

fprintf('Rotation axis: line through r=[2;0;0] parallel to z-axis\n');
fprintf('  axis equation: x=2, y=0, z=anything\n\n');

p_list = {[3;1;2], [2;0;100], [2.0001;0;100]};
labels  = {'off axis (normal case)', 'ON the axis! (degenerate)', 'slightly off axis'};

for i=1:length(p_list)
    p = p_list{i};
    g = gtwist(xi, theta_true);
    q = g*[p;1]; q=q(1:3);
    theta_pk1 = PK1(xi,p,q);

    % distance from p to axis
    dist2axis = norm( (p - r_axis) - omega*(omega'*(p - r_axis)) );

    fprintf('%s\n', labels{i});
    fprintf('  p=[%g;%g;%g]  dist2axis=%.4f\n', p, dist2axis);
    fprintf('  theta_true=%.4f  PK1=%.4f  |q-p|=%.4f\n', theta_true, theta_pk1, norm(q-p));
    if dist2axis < 1e-10
        fprintf('  -> q = p (point on axis does not move). Angle is undefined!\n');
    end
    fprintf('\n');
end

fprintf('Conclusion:\n');
fprintf('  p can be ANYWHERE in 3D space (any omega''p, any position)\n');
fprintf('  EXCEPT: p must NOT be exactly on the rotation axis.\n');
fprintf('  On the axis: rotation does not move p, angle is undefined.\n');
exit;
