clc
clear
close all

% Simulate the autopilot %
options = odeset('RelTol',1e-4,'AbsTol',[1e-5 1e-5 1e-5 1e-5]);
tspan = linspace(0,20,1000);
rng(1)
n = 10; % number of mobile robots

a1 = randi([-20,20],[n,2]);
% b = randi(20,[1,n]);
xx = zeros(1000,4,n);

for gg = 1:3
    b = zeros(n,2);
    counter = 0;
    if gg == 1
        a = a1;
    else
        targ = a;
    end
    for in = 1:n
        temp_targ = a(in,:);
        for kk = 1:n
            if kk ~= in
                if norm(a(kk,:) - a(in,:)) <= 15
                    temp_targ = temp_targ + a(kk,:);
                    counter = counter + 1;
                end
            end
        end
        b(in,:) = temp_targ./(counter+1);
        counter = 0;
    end
    a = b;
    
    for k = 1:n
        % Calling sequence: ode45(System function, time length, ICs, options)
        if gg == 1
            [T,x] = ode45(@(t,x) MobileRobot(t,x,k,a),tspan,[a1(k,1), 0, a1(k,2), 0]',options);
            xx(:,:,k,gg) = x;
        else 
            [T,x] = ode45(@(t,x) MobileRobot(t,x,k,a),tspan,[targ(k,1), 0, targ(k,2), 0]',options);
            xx(:,:,k,gg) = x;
        end
    end
end

figure
grid on
axis([-20 20 -20 20])
hold on

for gh = 1:gg
    for i = 1:length(T)
        for l = 1:n
            h(l) = plot(xx(i,1,l,gh),xx(i,3,l,gh),'ro');
            hold on
        end
        drawnow
        if gh == 1
            F1(i) = getframe(gcf);
        elseif gh == 2
            F2(i) = getframe(gcf);
        elseif gh == 3
            F3(i) = getframe(gcf);
        end
        for ll = 1:n
            delete(h(ll))
        end
    end
end

video = VideoWriter('Vid','MPEG-4');
video.FrameRate = 90;
open(video)
writeVideo(video,F1);
writeVideo(video,F2);
writeVideo(video,F3);
close(video)

