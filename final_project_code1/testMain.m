function testMain(a,alpha,d,tr,theta_ball,phi,r,Ox,Oy,Oz)
% TESTMAIN: this function plots the robot using the inverse kinematic and
% compares the true location
% Inputs:
%   a - 6x1 vector, column for a from DH table
%   alpha - 6x1 vector, column for alpha from DH table
%   d - 6x1 vector, column for d from DH table
%   eulerAngles - 3x1 vector with angles for rotation using euler
%   convention
%   tr - 3x1 vector specifying the desired end-effector position
% Output:
%   


% Calculate R
R = RotationMatrix(theta_ball,phi,r,Ox,Oy,Oz);
theta = ik_elbow_robot(tr, R, a, d);
%Combine columns into table
DH = [a, alpha, d, theta];

%plot the robot
drawRobot(DH,theta_ball,Ox,Oy,Oz,r)