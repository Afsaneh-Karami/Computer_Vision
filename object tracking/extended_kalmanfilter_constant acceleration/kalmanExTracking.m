function [px, py] = kalmanExTracking(z,valgate)
% Track a target with a extended Kalman filter
% z: observation vector
% Return the estimated state position coordinates (px,py)
dt = 0.2; % time interval
N = length(z); % number of samples
F =  [1 dt 0 0 0 0;0 1 0 0 0 0;0 0 0 0 0 0;0 0 0 1 dt dt^2/2;0 0 0 0 1 dt;0 0 0 0 0 1]; % Jacobian of motion model
Q = [0.16 0 0 0 0 0; 0 0.36 0 0 0 0; 0 0 0 0 0 0; 0 0 0 0.16 0 0 ; 0 0 0 0 0.36 0 ;0 0 0 0 0 0]; % motion noise
H = [1 0 0 0 0 0; 0 0 0 1 0 0]; % Cartesian observation model
R = [0.25 0; 0 0.25]; % observation noise
x = [0 0 0 6 6.9 -4]'; % initial state
P = Q; % initial state covariance
s = zeros(6,N);
for i = 1 : N
 [xp, Pp] = kalmanExPredict(x, P, F, Q);
 h=[xp(1);xp(4)];
 [x, P] = kalmanExUpdate(xp, Pp, H, R, z(:,i),h,valgate);
 s(:,i) = x; % save current state
end
px = s(1,:); % NOTE: s(2, :) and s(4, :), not considered here,
py = s(4,:); % contain the velocities on x and y respectively
end