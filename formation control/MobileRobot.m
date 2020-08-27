function [dx] = MobileRobot(t,x,target,k,shape)

kp = 1; % Proportional control gain %

r = [target(k,1,shape), target(k,2,shape)]; % Desired target location %

% Enter system dynamics here %
% with no control input
dx = zeros(4,1);
dx(1) = x(2);
dx(2) = -kp.*(x(1) + x(2)) + r(1);
dx(3) = x(4);
dx(4) = -kp.*(x(3) + x(4)) + r(2);
end
 
 