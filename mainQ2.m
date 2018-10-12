% Main File for Question 2
% Author: Samanvay Karambhe 2016

%% Clear 
clear 
close all
clc;
tic
%% Initialisation 

% Add other useful folders onto the path
addpath('./lib', './config', './lib/conversions');

% Load constants
constants();    

% Initialise simulation time
simTime = 86400;

% Deconstruting TLE Data
LEOSat = deconstruct_TLE('OrbocommTLE.txt');

% Call function for initial estimate of Equinoctical Elements
x      = initialEstimate(LEOSat);

% Initialise old x array 
x_old  = x;

% Establish count variable
count   = 1; 

x_array = ones(size(x,1), simTime);

%% Perturbation Calculations 
for timestep = 1:simTime

% Run Runge Kutta Integration methods
x_new  = rungeKutta(x_old);

% Update x array 
x_old  = x_new;

% Store x array
x_array(:,count) = x_new;

% Update count value 
count = count + 1;

end

% Convert satellite coordinates from Equinoctial to ECI
ECIPos = equint2ECI(x_array);

% Call function to obtain classical orbital parameters
classicParameters = equint2classic(x_array);

%% Calculate the orbital Period 
ECEFPos_LEO = eci2ecef(ECIPos, 1:simTime);
timeArray   = 1:simTime;

% Find the orbital period work
orbitPeriodArray = findPeriod(ECEFPos_LEO, timeArray);


%% Plot includes all animations, just RUN
plotQ2(LEOSat, ECIPos, classicParameters, simTime);


%% Keep it commented, if need to see period graph comment out plotQ2 before 
% running this line
% Plot Period graph
% figure()
% plot(orbitPeriodArray);
% xlabel('Orbit Number','FontSize',15);
% ylabel('Orbital Period (s)','FontSize',15);
% title('Simulation/Calculated Orbital Period','FontSize',15);

toc


