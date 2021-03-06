function [coeffs,output_var,u]=uncondauxvec_coeffs(R,B,steer)
% AUXVEC_COEFFS_UNCOND
% Returns filter coefficients for auxiliary vector method (unconditionally
% optimized) as well as the variance at the output of the filter

orthotol=1e-3; % Tolerance on matrix inner product to be considered effectively zero
unittol=1e-3; % Tolerance for matrix to be considered unitary

% --------- Error checking ----------
% Todo: check matrices are correct dimensions

% Verify that steering vec and blocking matrix are orthogonal
if ~all(abs(B'*steer) < orthotol)
   warning('CDMA:check','Blocking matrix and steering vector are not orthogonal to within %e',orthotol)
end

% Verify that blocking matrix is unitary
if ~all(abs( B'*B - eye(size(B,2)) )< unittol) 
   warning('CDMA:check','Blocking matrix is not unitary to within %e',unittol)
end  
% -----------------------------------


u = inv(B'*R*B) * B' * R * steer;

coeffs = steer - B*u;


if nargout>1
    output_var = steer'*R*steer - steer'*R*B*inv(B'*R*B)*B'*R*steer;
end