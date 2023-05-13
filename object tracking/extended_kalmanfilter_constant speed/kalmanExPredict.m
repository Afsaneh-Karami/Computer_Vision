function [xp, Pp] = kalmanExPredict(x, P, F, Q)
% Prediction step of Kalman filter.
% x: state vector
% P: covariance matrix of x
% F: jacobian
% Q: matrix of motion noise
% Return predicted state vector xp and covariance Pp
xp = F * x; % predict state
Pp = F * P * F' + Q; % predict state covariance
end