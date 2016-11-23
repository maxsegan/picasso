%%*******************UNIVERSIDAD POLITÉCNICA SALESIANA*******************%
%Asignatura:    Electiva I
%Autor:         John Gilces
%Docente:       Byron Lima
%Tema:          Trayectorias
%Mención:       SISTEMAS INDUSTRIALES
%%***********************************************************************%

%EJERCICIO 26

%% Inicialización
clc
clear all
close all
%% Definir Parametros del circulo
radius=0.125;
n=25;
%Ubicacion del circulo
INI = transl(-0.25, 0.25, -0.25); 
%% Generar la trayectoria del circulo
for i=1:n
 T1(:,:,i)= INI*trotz(-pi/2)*troty(2*pi*i/n)*transl(0, 0, radius);
end
%% Inicializar el robot Puma560
mdl_puma560;
%% Computation of the joint angles along the trajectory using the inverse kinematics
Q1= p560.ikine6s(T1, 'run');
%% Representar posicion inicial del robot
p560.plot(Q1(1,:));
%% Puntos de referencia para el diseño
%Esto dibuja las lineas
path = [-0.25 0.25 -0.125; -0.25 0.1589 -0.3356; -0.25 0.3595 -0.1898;
       -0.25 0.1405 -0.1898; -0.25 0.3411 -0.3356; -0.25 0.25 -0.125];
%% Generación de la trayectoria en multisegmentos (mjtraj)
Dt = 0.2;
Qdmax = [0.5 0.5 0.3];
Tacc = 0.2;
p0xyz = [-0.25 0.25 -0.125];
p1 = mstraj(path, Qdmax, [], p0xyz, Dt, Tacc);
Tp1 = transl(p1);
%% Cálculo de cinemática inversa la trayectoria generada
a1 = p560.ikine6s(Tp1);
%% Graficacion
hold on;
circle1 = circle([0.25 -0.25 -0.25], radius)
plot3(circle1(3,:),circle1(1,:), circle1(2,:),'b', 'LineWidth',2);
plot3(path(:,1), path(:,2), path(:,3), 'color', 'r', 'LineWidth', 1)
p560.plot(Q1);
p560.plot(a1);