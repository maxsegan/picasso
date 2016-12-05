function drawRobot(DH_table,theta,Ox,Oy,Oz,r)
% DRAWROBOT(DH_table) Given a DH table plot the robot at the describe
% configuration
% Inputs:
%     DH_table: nX4 matrix with the parameters of each link as following:
%     [a , alpha , d , theta] 
    global ball_num
    global end_effector
    %close all
    %figure
    hold off
    %view([1,1,1]);
    if end_effector == 1
        view(90,0);
    end
    %Plot a big ball
    CreateBall(r,Ox,Oy,Oz,theta)
    
    %axis equal
    numOfJoints = size(DH_table,1);
    O = zeros(3,numOfJoints+1);
    is_collide = 0;
    for i = 1:numOfJoints;
        O(:,i+1) = calcOi(DH_table,i);
        %Obstacle Detection
        if i == 4
            o1 = O(:,i);
            o2 = O(:,i+1);
            is_collide = ObstacleDetection(Ox,Oy,Oz,r,o1(1),o1(2),o1(3),o2(1),o2(2),o2(3),10);
        end
        plotLink(O(:,i),O(:,i+1),is_collide);
        hold on
    end
    ball_num = ball_num + 1;
    ball_pos = O(:,end);
    load mydata ball
    ball(1,ball_num) = ball_pos(1,1);
    ball(2,ball_num) = ball_pos(2,1);
    ball(3,ball_num) = ball_pos(3,1);
    save mydata ball
    for i = 1:ball_num
        plotBall(ball(:,i),1,'red')
    end

    hold on
    grid on
%     grid off
%     axis off
    %view(42,12);
    view(80,6);
%     if end_effector == 1 || end_effector == 2 
%         view(90,0);
%     end
    
%     if end_effector ~= 0
%         if end_effector==1
%             end_effector=2;
%         else 
%             end_effector=1;
%         end
%     end
    
    %axis([-0.2 1 -0.2 1 0 1]);
    %axis([-2 2 -1 3 0 4]);
    axis([-2.5 2.5 -1 3.5 -2 3]);
    %axis equal
    drawnow
end

function plotLink(o1,o2,is_collide)
    % this function links two points with a line.
    global end_effector
    %
    oo(:,1)=linspace(o1(1),o2(1),10);
    oo(:,2)=linspace(o1(2),o2(2),10);
    oo(:,3)=linspace(o1(3),o2(3),10);
    for i = 1:9
        plot3(oo(i,1),oo(i,2),oo(i,3),'ko',...
        'markersize',6,'markerfacecolor','k')
    end
    %
    
    plot3(o1(1),o1(2),o1(3),'ko',...
        'markersize',10,'markerfacecolor','k')
    plot3(o2(1),o2(2),o2(3),'ko',...
        'markersize',10,'markerfacecolor','k')
    link = [o1 o2].';
    line(link(:,1),link(:,2),link(:,3),'linewidth',3)
    if is_collide == 1
        line(link(:,1),link(:,2),link(:,3),'color','r','linewidth',6)
    end

    if is_collide == 1 && end_effector == 1
        end_effector = 2;
    elseif is_collide == 1 && end_effector == 2
        end_effector = 1;
    end
end

function plotBall(p, d, color)
    % this function plots a ball cetered at point p, with diameter d. The
    % color of the ball is defind by color input (string type).
    plot3(p(1),p(2),p(3),'o',...
        'markersize',d*3,'markerfacecolor',color)
end