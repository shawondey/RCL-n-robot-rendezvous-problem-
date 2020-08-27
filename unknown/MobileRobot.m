function [dx] = MobileRobot(t,x,k,a)

kp = 1; % Proportional control gain %

r = a(k,:); % Desired target location %

dx = zeros(4,1);
dx(1) = x(2);
dx(2) = -kp.*(x(1) + x(2)) + r(1);
dx(3) = x(4);
dx(4) = -kp.*(x(3) + x(4)) + r(2);

if nargout>1
    aa = a;
    
end
 
 