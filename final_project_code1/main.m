clear
clc

global ball_num     %Count the number of trajectory points
global plot_mode    %Plot mode: 
                      %0-plot whole sphere; 
                      %1-plot front-hemisphere;  
                      %2-plot back-hemisphere;
global end_effector %Change the length of end-effector
                      %0-short end-effector & big sphere (Without obstacle)
                      %1-long end-effector & small sphere (With obstacle)[Solution 1]
                      %2-long end-effector & small sphere (With obstacle)[Solution 2]
plot_mode = 0;
ball_num = 0;
end_effector = 1;

if end_effector==0
DH = [  0,   pi/2,  0.5;...
        1.8,      0,    0;...
        0,   pi/2,    0;
        0,  -pi/2,    1.8;
        0,   pi/2,    0;
        0,      0,    0.4];
end

if end_effector==1 || end_effector==2
DH = [  0,   pi/2,  0.5;...
        1.8,      0,    0;...
        0,   pi/2,    0;
        0,  -pi/2,    1.8;
        0,   pi/2,    0;
        0,      0,    0.8];
end

a = DH(:,1);
alpha = DH(:,2);
d = DH(:,3);

%Parameters of sphere
r = 0.5;
Ox = 0;
Oy = 1.5;
Oz = 1.5;
if end_effector == 1
view(90,0);
end
%%%Plot Whole Sphere
if plot_mode == 0
    for theta = pi/2:pi/7:pi
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