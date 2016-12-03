function theta = ik_elbow_robot(tr, R, a, d)
% IK_ELBOW_ROBOT: this function computes the inverse kinematics for the
% elbow robot using equations 4.4.26-4.4.31.
% Inputs:
%   tr - 3x1 vector specifying the desired end-effector position
%   R - 3x3 matrix specifying the desired orientation of the end-effector
%   a - 6x1 vector, column for a from DH table
%   d - 6x1 vector, column for d from DH table
% Output:
%   theta - 6x1 vector, column for theta from DH table
px = tr(1) - d(6)*R(1,3);
py = tr(2) - d(6)*R(2,3);
pz = tr(3) - d(6)*R(3,3);

x1 = px;
y1 = py;
theta(1,:) = atan2(y1,x1);  %theta 1
D = (px^2+py^2+(pz-d(1))^2-a(2)^2-d(4)^2) / (2*a(2)*d(4));
x3 = D;
y3 = -sqrt(1-D^2);
theta(3,:) = atan2(y3,x3);  %theta 3
x2 = sqrt(px^2+py^2);
y2 = pz - d(1);
x22 = a(2)+d(4)*cos(theta(3));
y22 = d(4)*sin(theta(3));
theta(2,:) = atan2(y2,x2) - atan2(y22,x22);  %theta 2
theta(3,:) = theta(3,:) + pi/2;

u13 = R(1,3)*(cos(theta(1))*cos(theta(2))*cos(theta(3)) - cos(theta(1))*sin(theta(2))*sin(theta(3))) + R(2,3)*(cos(theta(2))*cos(theta(3))*sin(theta(1)) - sin(theta(1))*sin(theta(2))*sin(theta(3))) + R(3,3)*(cos(theta(2))*sin(theta(3)) + cos(theta(3))*sin(theta(2)));
u23 = R(1,3)*sin(theta(1)) - R(2,3)*cos(theta(1));
u31 = R(1,1)*(cos(theta(1))*cos(theta(2))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2))) + R(2,1)*(cos(theta(2))*sin(theta(1))*sin(theta(3)) + cos(theta(3))*sin(theta(1))*sin(theta(2))) - R(3,1)*(cos(theta(2))*cos(theta(3)) - sin(theta(2))*sin(theta(3)));
u32 = R(1,2)*(cos(theta(1))*cos(theta(2))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2))) + R(2,2)*(cos(theta(2))*sin(theta(1))*sin(theta(3)) + cos(theta(3))*sin(theta(1))*sin(theta(2))) - R(3,2)*(cos(theta(2))*cos(theta(3)) - sin(theta(2))*sin(theta(3)));
u33 = R(1,3)*(cos(theta(1))*cos(theta(2))*sin(theta(3)) + cos(theta(1))*cos(theta(3))*sin(theta(2))) + R(2,3)*(cos(theta(2))*sin(theta(1))*sin(theta(3)) + cos(theta(3))*sin(theta(1))*sin(theta(2))) - R(3,3)*(cos(theta(2))*cos(theta(3)) - sin(theta(2))*sin(theta(3)));
x4 = u13;
y4 = u23;
theta(4,:) = atan2(y4,x4);
x5 = u33;
y5 = sqrt(1-u33^2);
theta(5,:) = atan2(y5,x5);
x6 = -u31;
y6 = u32;
theta(6,:) = atan2(y6,x6);
end

