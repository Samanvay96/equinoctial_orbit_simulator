function x_new = rungeKutta(x_old)
% rungeKutta - The goal of this function is to perform runge kutta
% integration to obtain the position of the satellite
% Author: Samanvay Karambhe 2016 
% Question: 2

% Define delta_t 
delta_t = 1;
 
% Find X_dot
xdot = stateRate(x_old);

% Find k1 
k1     = delta_t*xdot;

% Find 2nd x array
x2    = x_old + 0.5*k1;

% Find 2nd xdot
xdot2 = stateRate(x2);

% Find k2
k2     = delta_t*xdot2;

% Find 3rd x array
x3    = x_old + 0.5*k2;

% Find 3rd xdot 
xdot3 = stateRate(x3);

% Find k3
k3     = delta_t*xdot3;

% Find 4th x array
x4    = x_old + k3;

% Find 4th xdot
xdot4 = stateRate(x4);

% Find k4
k4     = delta_t*xdot4;

% Calculate new x array 
x_new  = x_old + (1/6)*(k1 + 2*k2 + 2*k3 + k4);

end

