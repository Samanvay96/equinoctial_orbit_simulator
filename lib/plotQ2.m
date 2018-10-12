function plotQ2(LEOSat,ECIPos,classicParameters,simTime)
% plotQ2 - Ths function is used plot all the necessary classic orbital
% parameters 

% Load necessary data
load trueAnomaly_LEO

%% Classical Parameters Plot
% Initialise time array 
timeArray = 1:simTime;

% Initialise unperturbed Classic Parameters from Question 1
a_Array_unperturbed      =  LEOSat.a.*ones(1,simTime);
e_Array_unperturbed      =  LEOSat.e.*ones(1,simTime);
i_Array_unperturbed      =  LEOSat.i.*ones(1,simTime);
AoP_Array_unperturbed    =  LEOSat.AoP.*ones(1,simTime)-360;
OMEGA_Array_unperturbed  =  LEOSat.rascension.*ones(1,simTime);
disp(size(trueAnomaly_LEO))
theta_Array_unperturbed  =  rad2deg(trueAnomaly_LEO(1:simTime));

% Initialise classic parameters from Question 2
a_Array     = classicParameters(1,:); 
e_Array     = classicParameters(2,:);
i_Array     = rad2deg(classicParameters(3,:));
AoP_Array   = rad2deg(classicParameters(4,:));
OMEGA_Array = rad2deg(classicParameters(5,:));
theta_Array = mod(rad2deg(classicParameters(6,:)),360)-180;

% Plot semi-major axis
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,3,1)
plot(timeArray,a_Array)
hold on
plot(timeArray,a_Array_unperturbed)
xlabel('Time (s)', 'FontSize', 18);
ylabel('Semi-Major Axis (m)', 'FontSize', 18)
h = legend('Modified Equinoctial Mode','Classic Mode','Location','Best');
set(h,'FontSize',14);
title('Semi-Major Axis (a)','FontSize', 14)

% Plot ecentricity
subplot(2,3,2)
plot(timeArray,e_Array)
hold on
plot(timeArray,e_Array_unperturbed)
xlabel('Time (s)','FontSize', 18);
ylabel('Ecentricity','FontSize', 18)
h1 = legend('Modified Equinoctial Model','Classic Model','Location','Best');
set(h1,'FontSize',14);
title('Ecentricity (e)','FontSize', 15)

% Plot inclination
subplot(2,3,3)
plot(timeArray,i_Array)
hold on
plot(timeArray,i_Array_unperturbed)
xlabel('Time (s)','FontSize', 18);
ylabel('Inclination (deg)','FontSize', 18)
h2 = legend('Modified Equinoctial Model','Classic Model','Location','Best');
set(h2,'FontSize',14);
title('Orbit Inclination (i)','FontSize', 15)

% Plot argument of perigee
subplot(2,3,4)
plot(timeArray,AoP_Array)
hold on
plot(timeArray,AoP_Array_unperturbed)
xlabel('Time (s)','FontSize', 18);
ylabel('Argument of Perigee (deg)','FontSize', 18)
h3 = legend('Modified Equinoctial Model','Classic Model','Location','Best');
set(h3,'FontSize',14);
title('Argument of Perigee (omega)','FontSize', 15)

% Plot Right Ascension
subplot(2,3,5)
plot(timeArray,OMEGA_Array)
hold on
plot(timeArray,OMEGA_Array_unperturbed)
xlabel('Time (s)','FontSize', 18);
ylabel('Right Ascension of the Ascending Node (deg)','FontSize', 18)
h4 = legend('Modified Equinoctial Model','Classic Model','Location','Best');
set(h4,'FontSize',14);
title('Right Ascension of the Ascending Node (Omega)','FontSize', 13)

% Plot True Anomaly 
subplot(2,3,6)
plot(timeArray,theta_Array)
hold on
plot(timeArray,theta_Array_unperturbed)
xlabel('Time (s)','FontSize', 18);
ylabel('True Anomaly (deg)','FontSize', 18)
h5 = legend('Modified Equinoctial Model','Classic Model','Location','Best');
set(h5,'FontSize',14);
title('True Anomaly (nu)','FontSize', 15)

%% 3D plot of the orbits 

% figure()
% PlotEarthSphere
% hold on 
% plot3(ECIPos(1,:),ECIPos(2,:),ECIPos(3,:),'r')
% xlabel('x-axis');
% ylabel('y-axis');
% zlabel('z-axis');

%% 3D Plot Set-up 
screen2 = [0.5 0.5 0.5 0.5];
% Create a sphere, make it earth sized (in meters)
fig.globe = figure(2);
set(fig.globe, 'Units', 'normalized', 'Position', screen2);

% Create figure and load topographical Earth map
load('topo.mat','topo');

% Create a sphere, make it earth sized (in meters)
[x,y,z] = sphere(50);
x = -x.*6378000;
y = -y.*6378000;
z = z.*6378000;

props.FaceColor= 'texture';
props.EdgeColor = 'none';
props.FaceLighting = 'phong';
props.Cdata = topo;

% Plot Earth
axes('dataaspectratio',[1 1 1],'visible','on')
hold on
globe = surface(x,y,z,props);
hold on

% Plot the 3D orbit lines
plt.orbits_LEO = plot3(ECIPos(1,:),ECIPos(2,:),ECIPos(3,:));
hold on

% Save LEO points for the 3D plots
plt.sats_LEO = scatter3(NaN, NaN, NaN,'r', 'filled', ...
                    'XDataSource', 'ECIPos(1,i)', ...
                    'YDataSource', 'ECIPos(2,i)', ...
                    'ZDataSource', 'ECIPos(3,i)');

% Initialise the angular rate of earth
omega_earth = 7.2921159e-5;
                
timeStep = 75;
rotate_angle = rad2deg(omega_earth*timeStep);

% Run a loop to animate the 3D plots and ground trace 
for i = 1:simTime
   
    if mod(i,timeStep) ==0
        refreshdata(plt.sats_LEO, 'caller');
        rotate(globe,[0 0 1],rotate_angle);
        drawnow();
    end
end
                
                
end