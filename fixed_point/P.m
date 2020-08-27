clc
clear
close all

% Simulate the autopilot %
options = odeset('RelTol',1e-4,'AbsTol',[1e-5 1e-5 1e-5 1e-5]);
tspan = linspace(0,20,5000);

n = 10; % number of mobile robots

a = randi([-20,20],[n,2]);
xx = zeros(5000,4,n);
target = [5,5];

for k = 1:n
    % Calling sequence: ode45(System function, time length, ICs, options)
    [T,x] = ode45(@(t,x) MobileRobot(t,x),tspan,[a(k,1), 0, a(k,2), 0]',options);
    xx(:,:,k) = x;
end

figure
plot(target(1),target(2),'r*')
hold on
grid on
axis([-20 20 -20 20])
hold on

for i = 1:length(T)
    for l = 1:n
        h(l) = plot(xx(i,1,l),xx(i,3,l),'ro');
        hold on
    end
    drawnow
    F(i) = getframe(gcf);
    for ll = 1:n
        delete(h(ll))
    end
end

for lll = 1:n
    plot(xx(i,1,lll),xx(i,3,lll),'ro');
    hold on
end

video = VideoWriter('Vid','MPEG-4');
video.FrameRate = 15;
open(video)
writeVideo(video,F);
close(video)

