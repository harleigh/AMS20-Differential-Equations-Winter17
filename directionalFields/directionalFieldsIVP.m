%{
    Title: directionalFieldsIVP

    Purpose: learn how to plot directional fields for first order ODEs (ordinary
             differential equations)  y' = f(t,y) over the rectangular domain
                    R = { (t,f) : tMin<=t<=tMax and fMin<=f<=fMax }
             Also, graph a specific IVP, solved with ODE45

             To do this we introduce the matlab functions
                *meshgrid: creates points on our rectangular domain R of
                           uniform length
                *quiver: plots (cute) little vectors at each point of a
                         rectangular domain whose directions are determined
                         by our function f(t,y)
                *ode45: integrates an equation dy/dt = f(t,y) so we get y(t)
    Notes:
        * When drawing directional fields, your first order ODE must be in
          'normal form' which is the form y' = f(t,y)  (notice that there is
          nothing in front of y', i.e.: everything has been moved into the
          function f)
        * Using quiver, we usually have to rescale the little vectors to make
          them more pretty
%}

%we always want a clear and close all at the top of our matlab (script) files
clear all;
close all;

%Here we define the boundary for our directional field, as well as the fineness;
%t is the horizontal axis and f is our vertical axis
tMin = -3; tMax =6;
fMin = -5; fMax = 5;
gridStepSize = 0.2;

%{
 Here we define (as an 'anonomous function') the function we wish to see as a
 directional field, as well as to numerically integrate.  Note the dot-operator
 notation to handle componentwise operations of vectors as well as matrices.
%}
f = @(t,y) 1 - 0.5*t.*y;



%{
    Here we create our rectangular uniform grid R.  At each value of f we have
    the entire time domain from tMin to tMax.  Imagine R visually as a screen
    (like on a door) where the intersections occur at (t_i,f_i)
%}
tAxis = tMin:gridStepSize:tMax; %here we give the range for time
fAxis = fMin:gridStepSize:fMax; %here we give the range for fValues

%Now we tell matlab to create a rectanglular grid of uniform points (t,f)
[ tDom, fDom ] = meshgrid( tAxis, fAxis);


%{
  A small example on how to integrate a first order ODE.  Note that we can not
  start the ode solver at t==0, as the differential equation y'=cos(2*t)-y./t is
  not defined at t=0, hence we solve for y over the time domain 0.1 to tMax.  Added to
  this, since I want to  run the solition as an animation, I force a very small time step
  into ode45; by doing so, the animation is slowed down.
%}
y0=-3;   %Initial vaue to the differential equation y'=cos(2*t)-y./t
t0 = 0;
[t,y]=ode45(f, [t0 tMax], y0);

%{
    Next we build the data to display the arrows in the directional field
    Here we calucate the horizontal and vertical components of the vectors at
    each point (t,y).  As we want all of the vectors to be the same length, we
    normalize the vectors (The L).  We want the vectors the same length because
    making pretty directional fiends can be a reall pain sometimes.  For
    example, set L to 1 (which removes normalization) and see the sad
    'directional' field (more like a bunch of dots :P)
%}
dF = f(tDom, fDom);       %vertical component of vector at point (1,\dot y)
dT = ones(size(dF));      %horizontal component of vector at point (1,\dot y)
L = sqrt(dT.^2 + dF.^2);  %here we normalize the vector <u,v> where u==dT v==dF
scaleFactor = 0.6;        %for scaling the lengths of the vectors (to prettify)

%Here we plot the directional field as well as the 
%At the points specified by tDom and fDom we draw the vector with components dT
%and dF.  We normalized the lengths of the vectors all the vectors, and added a
%scale factor of 0.5 to make the plot pretty; I had to try a few scalar values
%to get the pretty-ness I desired :).  Note in the graph, all vectors <dT,dF>
%are of the same length; that's the normalization process :)
%{
  Also, we get silly with automating the title of the plot.  It's just there to showcase
  some of the interesting features of Matlab and of programing in general.  That is, it's
  just for fun, as because this file is so small, and that there won't be too many
  candidate functions, there really is no need to automate the generation of the title to
  this plot.   Also also, I wrote this section in comment-block format since by doing so,
  you are able to collapse (fold) this comment block.
%}
hold on;
    quiver(tDom, fDom, dT./L, dF./L, scaleFactor);  %Plots the vector field
    plot(t, y);
    functionName = func2str(f);
    functionName = functionName(7:end);%find out what I do by debugging :)
    functionName = regexprep(functionName,'[.]','');%find out what I do by debugging :)
    title(strcat('Directional Field for f(t,y)=', functionName), 'FontSize', 16);
    xlabel('t', 'FontSize', 16);
    ylabel('f',  'FontSize', 16, 'Rotation',0);
    legend( strcat('y(t=', num2str(t0),')=', num2str(y(1))), 'Location', 'best' );
    axis tight; %cuts out all of the white space around our dir field
    grid on;
    %Note that comet is really finicky when plotting; comet must be the last thing you
    %draw to your figure i.e.: you must put the title and everything before comet.
    %comet(t, y); %Plots the solution to the IVP found with ode45 as an animation
hold off;



%
% end directionalFieldsIVP.m
%
