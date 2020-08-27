clc
clear
close all

% Simulate the autopilot %
options = odeset('RelTol',1e-4,'AbsTol',[1e-5 1e-5 1e-5 1e-5]);
tspan = linspace(0,20,500);

n = 4; % number of mobile robots

a = randi([-20,20],[n,2]);
xx = zeros(500,4,n,2);
target = zeros(4,2,2);
target(:,:,1) = [0,10;
            0,0;
            5,0;
            -5,0];
target(:,:,2) = [0,10;
            0,-10;
            5,0;
            -5,0];

for shape = 1:2
    for k = 1:n
        % Calling sequence: ode45(System function, time length, ICs, options)
        if shape == 1
            [T,x] = ode45(@(t,x) MobileRobot(t,x,target,k,shape),tspan,[a(k,1), 0, a(k,2), 0]',options);
            % [T,x] = ode45(@MobileRobot,tspan,[0, 0, 0, 0]',options);
            xx(:,:,k,shape) = x;
        else
            [T,x] = ode45(@(t,x) MobileRobot(t,x,target,k,shape),tspan,[target(k,1,1), 0, target(k,2,1), 0]',options);
            xx(:,:,k,shape) = x;
        end
    end
end

figure
% plot(target(1),target(2),'r*')
% hold on
grid on
% plot(x1,x2,'r*')
axis([-20 20 -20 20])
hold on
% color_array = ['ro', 'ko', 'bo', 'go'];

for i = 1:length(T)
    for l = 1:n
        h(l) = plot(xx(i,1,l,1),xx(i,3,l,1),'ro');
        hold on
    end
    drawnow
%     F1(i) = getframe(gcf);
    for ll = 1:n
        delete(h(ll))
    end
end

for i2 = 1:length(T)
    for l = 1:n
        h(l) = plot(xx(i2,1,l,2),xx(i2,3,l,2),'ro');
        hold on
    end
    drawnow
%     F2(i2) = getframe(gcf);
    for ll = 1:n
        delete(h(ll))
    end
end

% 
% video = VideoWriter('Vid','MPEG-4');
% video.FrameRate = 90;
% open(video)
% writeVideo(video,F1);
% writeVideo(video,F2);
% close(video)

