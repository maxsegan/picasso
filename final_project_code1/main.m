clear
clc

global ball_num %Count the number of trajectory points
ball_num = 0;
DH = [  0,   pi/2,  0.5;...
        2,      0,    0;...
        0,   pi/2,    0;
        0,  -pi/2,    2;
        0,   pi/2,    0;
        0,      0,    0.4];

a = DH(:,1);
alpha = DH(:,2);
d = DH(:,3);

%Parameters of sphere
% r = 0.6;
% Ox = 1.5;
% Oy = 1.5;
% Oz = 1.5;
r = 0.5;
Ox = 0;
Oy = 1.5;
Oz = 1.5;
%view(42,12);
for theta = 0.1:0.2:pi
    for phi = 0.1:0.5:2*pi
        Px = Ox + r*sin(theta)*cos(phi);
        Pz = Oz + r*sin(theta)*sin(phi);
        Py = Oy - r*cos(theta);
        tr = [Px;Py;Pz];
        testMain(a,alpha,d,tr,theta,phi,r,Ox,Oy,Oz);
    end
end