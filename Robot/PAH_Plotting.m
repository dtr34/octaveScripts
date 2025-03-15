%PAH inverse kinematics

L5 = 1
L6 = 1
gammaY = 0
Pz = linspace(2,3)

d1 = -L5 - L6*cos(gammaY) + Pz

figure;
plot(Pz, d1, 'b', 'LineWidth', 2);
xlabel('Pz');
ylabel('d1');
title('Plot of d1 vs Pz');
grid on;

L3=1;
gammaY = 0;
Px = linspace(0.75,1.25);
gammaZ = pi/4
L4=1

%changing the x coord and looking at theta3
theta3= acos((-L3 + L6*sin(gammaY)*sin(gammaZ)+Px)/L4)

figure;
plot(Px, theta3, 'b', 'LineWidth', 2);
xlabel('Px');
ylabel('theta3');
title('Plot of theta3 vs Px');
grid on;

%changing the x coord and looking at d2
gammaY = pi/3
Px = linspace(0,1)
Py = 1
d2 = L4*sqrt(1-((-L3+L6*sin(gammaY)*sin(gammaY)+Px)/L4).^2) + L6*sin(gammaY)*cos(gammaY)-Py

figure;
plot(Px, d2, 'b', 'LineWidth', 2);
xlabel('Px');
ylabel('d2');
title('Plot of d2 vs Px');
grid on;
