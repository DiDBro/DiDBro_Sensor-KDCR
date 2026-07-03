function [u,du,ddu] = rounded_step_gen(tt,stepp)
    %{
    Three input parameters are passed to this function in the
    list stepp, namely st0, t1 and t3, in this sequence.
    
    Function to generate a rounded unit step function of time, tt.
    If st0 is zero, the step is generated as starting with zero
    slope at time 0 and increasing with a parabolic curve until t1.
    Then it changes to increasing linearly with the same slope as
    that of the parabola at t1, until t2 (which is calculated by
    the function), after which it increases with negative second
    derivative, with the same parabolic shape, until it reaches the
    unit step function value at t3, with zero slope.  The slope of
    the curve is the same just before and just after t2.

    The whole rounded step can be delayed by st0.    
    %}
    st0 = stepp(1);t1 = stepp(2);t3 = stepp(3);
    alpha = 1/(t3 - t1)/t1/2;
    beta  = -alpha*t1*t1;
    t2    = t3 - t1;

    A = [t2, 1;t3, 1];
    b = [alpha*(t2*t2 + 2*t1*t2 - t1*t1);1 + alpha*t3*t3];

    x = A\b;
    gamma = x(1);
    eta   = x(2);

    st1 = st0 + t1;
    st2 = st0 + t2;
    st3 = st0 + t3;
    ta  = tt - st0;
    if tt <= st0
        u   = 0;
        du  = 0;
        ddu = 0;
    elseif tt <= st1
        u   = alpha*ta*ta;
        ddu = 2*alpha;
        du  = ddu*ta;
    elseif tt <= st2
        u   = 2*alpha*t1*ta + beta;
        du  = 2*alpha*t1;
        ddu = 0;
    elseif tt <= st3
        u   = -alpha*ta*ta + gamma*ta + eta;
        ddu = -2*alpha;
        du  = ddu*ta + gamma;
    else
        u  = 1;
        du  = 0;
        ddu = 0;
    end
end