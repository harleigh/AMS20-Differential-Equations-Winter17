%{

    Graph a directional field for a one dimensional ODE of the form 
    dy/dt = f(t,y)

    Here we use meshgrid to select a grid of points (t,y) in the t-y plane (t is
    horizontal axis, y is vertical axis), and then use quiver to plot the slopes
    of the following:  d/dt(t,y)= (1, dy/dt)  at each of the (t,y) points
        e.g., at the point (t,y), draw an arrow of (1,dy/dt) where dy/dt is the
        slope of the tangent line at the point (t,y)

    Matlab functions used:
        meshgrid
        quiver

    What makes this one basic?
        *Only plots a directional field; does not graph any IVPs ontop of the
         directional field.

%}
clear all;
close all;


tMin = 0;
tStep=0.2;
tMax= 4;

yMin = -4;
yStep = tStep;
yMax = 4;


%{
    Here we make points (T,Y) where T ranges from tMin to tMax in increments of
    tStep, and similarly for Y (Y ranges from yMin to yMax in increments of
    yStep)
%}
[T, Y] = meshgrid( tMin:tStep:tMax, ...
                   yMin:yStep:yMax);


%here we take the time derivative (d/dt) to each point (T,Y)
dY = cos(2*T)-Y./T;
dT = ones(size(dY));


%Now, at each point (T,Y), we plot
L=sqrt(dT.^2 + dY.^2);  %get the length (two norm) of the vector [dT dY]
quiver(T, Y, dT./L, dY./L, 0.5);
axis tight;
grid on;
xlabel('t (time)');
ylabel('y (range)');

%
% end directionalFieldsBasic.m
%