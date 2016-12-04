function [theta1,theta2,theta3,theta4,theta5,theta6] = PumaIK(Px,Py,Pz, theta,phi1,r,Ox,Oy,Oz)
    theta4 = 0;
    theta5 = 0;
    theta6 = 0;
    sign1 = 1;
    sign3 = 1;
    nogo = 0;
    noplot = 0;
    % Because the sqrt term in theta1 & theta3 can be + or - we run through
    % all possible combinations (i = 4) and take the first combination that
    % satisfies the joint angle constraints.
    while nogo == 0;
        for i = 1:1:4
            if i == 1
                sign1 = 1;
                sign3 = 1;
            elseif i == 2
                sign1 = 1;
                sign3 = -1;
            elseif i == 3
                sign1 = -1;
                sign3 = 1;
            else
                sign1 = -1;
                sign3 = -1;
            end
            a2 = 650;
            a3 = 0;
            d3 = 190;
            d4 = 600;
            rho = sqrt(Px^2+Py^2);
            phi = atan2(Py,Px);
            K = (Px^2+Py^2+Pz^2-a2^2-a3^2-d3^2-d4^2)/(2*a2);
            c4 = cos(theta4);
            s4 = sin(theta4);
            c5 = cos(theta5);
            s5 = sin(theta5);
            c6 = cos(theta6);
            s6 = sin(theta6);
            theta1 = (atan2(Py,Px)-atan2(d3,sign1*sqrt(Px^2+Py^2-d3^2)));

            c1 = cos(theta1);
            s1 = sin(theta1);
            theta3 = (atan2(a3,d4)-atan2(K,sign3*sqrt(a3^2+d4^2-K^2)));

            c3 = cos(theta3);
            s3 = sin(theta3);
            t23 = atan2((-a3-a2*c3)*Pz-(c1*Px+s1*Py)*(d4-a2*s3),(a2*s3-d4)*Pz+(a3+a2*c3)*(c1*Px+s1*Py));
            theta2 = (t23 - theta3);

            %%%%%%%%%%%%%%%%%%%%%% compute R_3_6 %%%%%%%%%%%%%%%%%%%%%%%%
                R_0_6 = RotationMatrix(theta,phi1,r,Ox,Oy,Oz);
                %R_0_3
                t1 = theta1/pi*180;
                t2 = theta2/pi*180;
                t3 = theta3/pi*180;
                T_01 = tmat(0, 0, 0, t1);
                T_12 = tmat(-90, 0, 0, t2);
                T_23 = tmat(0, a2, d3, t3);
                T_02 = T_01*T_12;
                T_03 = T_02*T_23;                
                R_0_3 = T_03(1:3,1:3);
                %R_3_6
                R_3_6 = (R_0_3)'*R_0_6;
                r11 = R_3_6(1,1);r12 = R_3_6(1,2);r13 = R_3_6(1,3);
                r21 = R_3_6(2,1);r22 = R_3_6(2,2);r23 = R_3_6(2,3);
                r31 = R_3_6(3,1);r32 = R_3_6(3,2);r33 = R_3_6(3,3);
            %%%%%%%%%%  method from document
                theta5 = -atan2(-sqrt(r21^2+r22^2), r23);
                theta4 = atan2(r33/sin(theta5),-r13/sin(theta5));
                theta6 = atan2(-r22/sin(theta5),r21/sin(theta5));
                
            theta1 = theta1*180/pi;
            theta2 = theta2*180/pi;
            theta3 = theta3*180/pi;
            theta4 = theta4*180/pi;
            theta5 = theta5*180/pi;
            theta6 = theta6*180/pi;
            if theta2>=160 && theta2<=180
                theta2 = -theta2;
            end

            %if theta1<=160 && theta1>=-160 && (theta2<=20 && theta2>=-200) && theta3<=45 && theta3>=-225 && theta4<=266 && theta4>=-266 && theta5<=100 && theta5>=-100 && theta6<=266 && theta6>=-266
            if theta1<=160 && theta1>=-160 && (theta2<=20 && theta2>=-200) && theta3<=45 && theta3>=-225 
                nogo = 1;
                theta3 = theta3+180;
                break
            end
            if i == 4 && nogo == 0
                h = errordlg('Point unreachable due to joint angle constraints.','JOINT ERROR');
                waitfor(h);
                nogo = 1;
                noplot = 1;
                break
            end
        end
    end
end
%