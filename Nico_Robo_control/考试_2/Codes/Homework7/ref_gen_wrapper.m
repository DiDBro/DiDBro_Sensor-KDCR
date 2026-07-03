function ref_vec = ref_gen_wrapper(t)
% REF_GEN_WRAPPER  Wrapper for Ref_Gen Interpreted MATLAB Function block
%   Returns a single 12×1 vector: [theta_d; thetad_d; thetadd_d]
%   which is then split by a Demux block into 3 signals of 4×1 each.
    [theta_d, thetad_d, thetadd_d] = ref_quintic_step(t);
    ref_vec = [theta_d; thetad_d; thetadd_d];
end
