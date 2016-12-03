function R = RotationMatrix(theta,phi,r,Ox,Oy,Oz)

%Generate all solutions
%Iterate through them for each pair of links. We know that links are
%straight lines in our robot so we can use
%https://www.mathworks.com/matlabcentral/fileexchange/24484-geom3d/content/geom3d/geom3d/intersectLineSphere.m
%on all of link pairs (origin0, origin1), (origin1, origin2) to check for
%intersection
%From valid solutions, pick one with smallest delta from current state

%compute R_0_6
    Px = Ox + r*sin(theta)*cos(phi);
    Pz = Oz + r*sin(theta)*sin(phi);
    Py = Oy - r*cos(theta);
    dPx = -r*sin(theta)*sin(phi);
    dPz = r*sin(theta)*cos(phi);
    
    z = [Ox-Px, Oy-Py, Oz-Pz];
    %z = -z;
    x = [dPx, 0, dPz];
    %normalize
    z_square = sqrt(z(1)^2+z(2)^2+z(3)^2);
    z_norm = [z(1)/z_square, z(2)/z_square, z(3)/z_square];
    x_square = sqrt(x(1)^2+x(2)^2+x(3)^2);
    x_norm = [x(1)/x_square, x(2)/x_square, x(3)/x_square];
    y = cross(z_norm, x_norm);
    %R = [x_norm; y; z_norm];
    R = [x_norm', y', z_norm'];
end