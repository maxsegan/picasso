function [theta1,theta2,theta3,theta4,theta5,theta6] = PumaIK(Px,Py,Pz)
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

            c2 = cos(theta2);
            s2 = sin(theta2);
            s23 = ((-a3-a2*c3)*Pz+(c1*Px+s1*Py)*(a2*s3-d4))/(Pz^2+(c1*Px+s1*Py)^2);
            c23 = ((a2*s3-d4)*Pz+(a3+a2*c3)*(c1*Px+s1*Py))/(Pz^2+(c1*Px+s1*Py)^2);
            r13 = -c1*(c23*c4*s5+s23*c5)-s1*s4*s5;
            r23 = -s1*(c23*c4*s5+s23*c5)+c1*s4*s5;
            r33 = s23*c4*s5 - c23*c5;
            theta4 = atan2(-r13*s1+r23*c1,-r13*c1*c23-r23*s1*c23+r33*s23);

            r11 = c1*(c23*(c4*c5*c6-s4*s6)-s23*s5*c6)+s1*(s4*c5*c6+c4*s6);
            r21 = s1*(c23*(c4*c5*c6-s4*s6)-s23*s5*c6)-c1*(s4*c5*c6+c4*s6);
            r31 = -s23*(c4*c5*c6-s4*s6)-c23*s5*c6;
            s5 = -(r13*(c1*c23*c4+s1*s4)+r23*(s1*c23*c4-c1*s4)-r33*(s23*c4));
            c5 = r13*(-c1*s23)+r23*(-s1*s23)+r33*(-c23);
            theta5 = atan2(s5,c5);

            s6 = -r11*(c1*c23*s4-s1*c4)-r21*(s1*c23*s4+c1*c4)+r31*(s23*s4);
            c6 = r11*((c1*c23*c4+s1*s4)*c5-c1*s23*s5)+r21*((s1*c23*c4-c1*s4)*c5-s1*s23*s5)-r31*(s23*c4*c5+c23*s5);
            theta6 = atan2(s6,c6);

            theta1 = theta1*180/pi;
            theta2 = theta2*180/pi;
            theta3 = theta3*180/pi;
            theta4 = theta4*180/pi;
            theta5 = theta5*180/pi;
            theta6 = theta6*180/pi;
            if theta2>=160 && theta2<=180
                theta2 = -theta2;
            end

            if theta1<=160 && theta1>=-160 && (theta2<=20 && theta2>=-200) && theta3<=45 && theta3>=-225 && theta4<=266 && theta4>=-266 && theta5<=100 && theta5>=-100 && theta6<=266 && theta6>=-266
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