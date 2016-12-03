function Oi = calcOi(DH_table,i)
% CALCOI(DH_table,i) Given a DH table and index i, compute the position of
% origin of the ith frame
% Inputs:
%     DH_table: nX4 matrix with the parameters of each link as following:
%     [a , alpha , d , theta] 
%     i: link index
% Outputs:
%     Oi: 3x1 position vector of the origin of the ith frame
% HINT: Use the functions you created in part 1.

    T = calcT0n(DH_table(1:i,:));
    Oi = T*[0,0,0,1]';
    Oi = Oi(1:3);
end