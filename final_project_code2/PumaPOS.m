%%
% Use forward kinematics to place the robot in a specified configuration.
%
function PumaPOS(theta1,theta2,theta3,theta4,theta5,theta6)

    s1 = getappdata(0,'Link1_data');
    s2 = getappdata(0,'Link2_data');
    s3 = getappdata(0,'Link3_data');
    s4 = getappdata(0,'Link4_data');
    s5 = getappdata(0,'Link5_data');
    s6 = getappdata(0,'Link6_data');
    s7 = getappdata(0,'Link7_data');
    A1 = getappdata(0,'Area_data');
    %
    a2 = 650;
    a3 = 0;
    d3 = 190;
    d4 = 600;
    Px = 5000;
    Py = 5000;
    Pz = 5000;

    t1 = theta1; 
    t2 = theta2; 
    t3 = theta3 %-180;  
    t4 = theta4; 
    t5 = theta5; 
    t6 = theta6; 
    %
    % Forward Kinematics
    T_01 = tmat(0, 0, 0, t1);
    T_12 = tmat(-90, 0, 0, t2);
    T_23 = tmat(0, a2, d3, t3);
    T_34 = tmat(-90, a3, d4, t4);
    T_45 = tmat(90, 0, 0, t5);
    T_56 = tmat(-90, 0, 0, t6);

    %T_01 = T_01;
    T_02 = T_01*T_12;
    T_03 = T_02*T_23;
    T_04 = T_03*T_34;
    T_05 = T_04*T_45;
    T_06 = T_05*T_56;
    %
    Link1 = s1.V1;
    Link2 = (T_01*s2.V2')';
    Link3 = (T_02*s3.V3')';
    Link4 = (T_03*s4.V4')';
    Link5 = (T_04*s5.V5')';
    Link6 = (T_05*s6.V6')';
    Link7 = (T_06*s7.V7')';

    handles = getappdata(0,'patch_h');           %
    L1 = handles(1);
    L2 = handles(2);
    L3 = handles(3);
    L4 = handles(4);
    L5 = handles(5);
    L6 = handles(6);
    L7 = handles(7);
    %
    set(L1,'vertices',Link1(:,1:3),'facec', [0.717,0.116,0.123]);
    set(L1, 'EdgeColor','none');
    set(L2,'vertices',Link2(:,1:3),'facec', [0.216,1,.583]);
    set(L2, 'EdgeColor','none');
    set(L3,'vertices',Link3(:,1:3),'facec', [0.306,0.733,1]);
    set(L3, 'EdgeColor','none');
    set(L4,'vertices',Link4(:,1:3),'facec', [1,0.542,0.493]);
    set(L4, 'EdgeColor','none');
    set(L5,'vertices',Link5(:,1:3),'facec', [0.216,1,.583]);
    set(L5, 'EdgeColor','none');
    set(L6,'vertices',Link6(:,1:3),'facec', [1,1,0.255]);
    set(L6, 'EdgeColor','none');
    set(L7,'vertices',Link7(:,1:3),'facec', [0.306,0.733,1]);
    set(L7, 'EdgeColor','none');
end