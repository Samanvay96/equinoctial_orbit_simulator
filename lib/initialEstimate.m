function x_initial = initialEstimate(Satdata)

% initialEstimate - Make an initial estimate of Equinoctial Model
% Author : Samanvay Karambhe 2016

% Initial estimate for true anomaly
% Calculate M (Radians)
M  = deg2rad(Satdata.meanAnomaly);

% Find E
E  = findE(M,Satdata.e);

% Find true anomaly 
A     = sqrt((1+Satdata.e)./(1- Satdata.e)).*tan(E./2);
theta = 2*atan2(A,1); 

% Defining variables that are to be used
AoP   = deg2rad(Satdata.AoP);
OMEGA = deg2rad(Satdata.rascension);
i     = deg2rad(Satdata.i);
e     = Satdata.e;
a     = Satdata.a;

% Calculate Equinoctial Parameters 
p = a*(1-e^2);
f = e*cos(AoP + OMEGA);
g = e*sin(AoP + OMEGA);
h = tan(i/2)*cos(OMEGA);
k = tan(i/2)*sin(OMEGA);
L = OMEGA + AoP + theta;

% Save parameters
x_initial = [p,f,g,h,k,L]';

end

