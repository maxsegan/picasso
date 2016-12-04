function CreateBall(r,x0,y0,z0,theta)
    global ball_num
    global plot_mode
    N = 100;
    [x,y,z]=sphere(N); %%The resolution of sphere
    surf(r*x+x0,r*y+y0,r*z+z0);
    k = (r+0.4)/r;
    %X=k*r*x+x0;Y=k*r*y+y0;Z=k*r*z+z0;
    X=k*r*x+z0;Y=k*r*y+x0;Z=k*r*z+y0;
    hold on
    %shading interp
   
    %%%
    if plot_mode == 0 || plot_mode == 1
        kk = (-cos(theta)+1)/2;
        if ceil(kk*N)<N
        xxx = X(ceil(kk*N):N,:);
        yyy = Y(ceil(kk*N):N,:);
        zzz = Z(ceil(kk*N):N,:);
        mesh(yyy,zzz,xxx)
        hold on
        end
    end
    
    if plot_mode == 2
        kk = (-cos(theta)+1)/2;
        if ceil(kk*N)<N
        xxx = X(ceil(kk*N):N/2,:);
        yyy = Y(ceil(kk*N):N/2,:);
        zzz = Z(ceil(kk*N):N/2,:);
        mesh(yyy,zzz,xxx)
        hold on
        end
    end
    %hold on,mesh(X(1:ball_num+1,:),Y(1:ball_num+1,:),Z(1:ball_num+1,:)),colormap(hot)
    %hold on,mesh(X(1:ceil(kk*r),:),Y(1:ceil(kk*r),:),Z(1:ceil(kk*r),:)),colormap(hot) %%Control the mesh
end
