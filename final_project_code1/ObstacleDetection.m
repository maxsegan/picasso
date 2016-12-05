function is_collide = ObstacleDetection(ox,oy,oz,r,link_x1,link_y1,link_z1,link_x2,link_y2,link_z2,N)
    is_collide = 0
    Pos(1,:)=linspace(link_x1,link_x2,N);
    Pos(2,:)=linspace(link_y1,link_y2,N);
    Pos(3,:)=linspace(link_z1,link_z2,N);
    for i = 1:N
        if ((Pos(1,i)-ox)^2+(Pos(2,i)-oy)^2+(Pos(3,i)-oz)^2)<r^2 
           is_collide = 1
        end
    end
end