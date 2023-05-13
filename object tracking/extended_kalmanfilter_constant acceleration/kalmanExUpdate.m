function [xe, Pe] = kalmanUpdate(x, P, H, R, z,h,valgate)
% Update step of extended Kalman filter.
% x: state vector
% P: covariance matrix of x
% H: Jacobian matrix of observation model
% R: matrix of observation noise
% z: observation vector
% Return estimated state vector xe and covariance Pe
y = z - h;
S = H * P * H' + R;
K = P * H' * inv(S);

zp = [x(1);x(4)]; % predicted observation

%%%%%%%%% UNCOMMENT FOR VALIDATION GATING %%%%%%%%%%
gate = (z - zp)' * inv(S) * (z - zp);
if gate > valgate
warning('Observation outside validation gate');
xe = x;
Pe = P;
return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xe = x + K * y; % estimated state
Pe = (eye(6) - K * H) * P; % estimated covariance
end