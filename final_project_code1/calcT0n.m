function T = calcT0n(DH_table)
% CALCT0N(DH_table) Given a DH table, compute transformation from EE to
% base
% Inputs:
%     DH_table: nX4 matrix with the parameters of each link as following:
%     [a , alpha , d , theta]
% Outputs:
%     T: 4x4 transformation matrix from End Effector to base frame
% HINT: Use the function calcAi you created in part 1a
    T = eye(4);  % initialize a homogeneous transformation
    for j = 1:size(DH_table,1)
        Aj = calcAi(DH_table,j);
        T = T*Aj;
    end
end