function R = rotation(Euler)
% ROTATION: this function computes a rotation matrix based on Euler angle
% inputs, which specifically represented in z-y-z body sequence.
% Input: 
%   Euler - 3x1 vector with three angles in z-y-z body sequence.
% Output:
%   R - rotation matrix
R(1,1) = cos(Euler(1))*cos(Euler(2))*cos(Euler(3)) - sin(Euler(1))*sin(Euler(3));
R(1,2) = -cos(Euler(1))*cos(Euler(2))*sin(Euler(3)) - sin(Euler(1))*cos(Euler(3));
R(1,3) = cos(Euler(1))*sin(Euler(2));
R(2,1) = sin(Euler(1))*cos(Euler(2))*cos(Euler(3)) + cos(Euler(1))*sin(Euler(3));
R(2,2) = -sin(Euler(2))*cos(Euler(2))*sin(Euler(3)) + cos(Euler(1))*cos(Euler(3));
R(2,3) = sin(Euler(1))*sin(Euler(2));
R(3,1) = -sin(Euler(2))*cos(Euler(3));
R(3,2) = sin(Euler(2))*sin(Euler(3));
R(3,3) = cos(Euler(2));
end

