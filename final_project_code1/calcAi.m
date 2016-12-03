function Ai = calcAi(DH_table,i)
% CALCAI(DH_table,i) Given a DH table and index i, create matrix Ai
% Inputs:
%     DH_table: nX4 matrix with the parameters of each link as following:
%     [a , alpha , d , theta]
%     i: link index
% Outputs:
%     Ai: 4x4 transformation matrix (as explained in class)

    a_i = DH_table(i,1);
    alpha_i = DH_table(i,2);
    d_i = DH_table(i,3);
    theta_i = DH_table(i,4);
    Ai = [cos(theta_i)  -sin(theta_i)*cos(alpha_i)     sin(theta_i)*sin(alpha_i)    a_i*cos(theta_i);
        sin(theta_i)    cos(theta_i)*cos(alpha_i)     -cos(theta_i)*sin(alpha_i)    a_i*sin(theta_i);
        0               sin(alpha_i)                   cos(alpha_i)                 d_i                 ;
        0               0                              0                            1                   ];
end


