function [xe, Pe] = kalmanExUpdate(x, P, H, R, z,h,valgate)
% Update step of Kalman filter.
% x: state vector
% P: covariance matrix of x
% H: matrix of observation model
% R: matrix of observation noise
% z: observation vector
% Return estimated state vector xe and covariance Pe
y = z - h;
S = H * P * H' + R; % innovation covariance
K = P * H' * inv(S); % Kalman gain

zp = H * x; % predicted observation
%%%%%%%%% UNCOMMENT FOR VALIDATION GATING %%%%%%%%%%
gate = (z - zp)' * inv(S) * (z - zp);
if gate > valgate
warning('Observation outside validation gate');
xe = x;
Pe = P;
return
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xe = x + K * (z - zp); % estimated state
% Pe = P - K * S * K'; % estimated covariance
xe = x + K * y;
Pe = (eye(4) - K * H) * P;
end