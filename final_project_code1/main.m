clear
clc

global ball_num  %Count the number of trajectory points
global plot_mode %Plot mode: 
                    %0-plot whole sphere; 
                    %1-plot front-hemisphere;  
                    %2-plot back-hemisphere;
plot_mode = 2;
ball_num = 0;
DH = [  0,   pi/2,  0.5;...
        1.8,      0,    0;...
        0,   pi/2,    0;
        0,  -pi/2,    1.8;
        0,   pi/2,    0;
        0,      0,    0.4];

a = DH(:,1);
alpha = DH(:,2);
d = DH(:,3);

%Parameters of sphere
r = 0.5;
Ox = 0;
Oy = 1.5;
Oz = 1.5;
%view(42,12);
%%%Plot Whole Sphere
if plot_mode == 0
    for theta = 0.1:0.2:pi
        for phi = 0.1:0.5:2*pi
            Px = Ox + r*sin(theta)*cos(phi);
            Pz = Oz + r*sin(theta)*sin(phi);
            Py = Oy - r*cos(theta);
            tr = [Px;Py;Pz];
            testMain(a,alpha,d,tr,theta,phi,r,Ox,Oy,Oz);
        end
    end
end
%%%Plot Front-Hemisphere
if plot_mode == 1 || plot_mode == 2
    for theta = 0.1:0.2:pi/2
        for phi = 0.1:0.5:2*pi
            Px = Ox + r*sin(theta)*cos(phi);
            Pz = Oz + r*sin(theta)*sin(phi);
            Py = Oy - r*cos(theta);
            tr = [Px;Py;Pz];
            testMain(a,alpha,d,tr,theta,phi,r,Ox,Oy,Oz);
        end
    end
end