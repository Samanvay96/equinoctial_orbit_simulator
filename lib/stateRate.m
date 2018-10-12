function x_dot = stateRate(x)
% stateRate - Calculate A_x & B_x from given calculations 

% Load constants
global mu_earth
global mu_J2_r_sq

% Load up Equinoctinal Elements
p = x(1);
f = x(2);
g = x(3);
h = x(4);
k = x(5);
L = x(6);

% Calculate other necessary parameters
a_square = h^2 - k^2;
s_square = 1 + h^2 + k^2;
w = 1 + f*cos(L) + g*sin(L);
r = p/w;

% Initialise the A(x) matrix 
A_x      =  zeros(6,3);
a        =  sqrt(p/mu_earth);
A_x(1,2) =  a*(2*p/w);
A_x(2,1) =  a*sin(L);
A_x(2,2) =  a*(((w+1)*cos(L)+f)/w);
A_x(2,3) = -a*(g/w)*(h*sin(L) - k*cos(L));
A_x(3,1) = -a*cos(L);
A_x(3,2) =  a*(((w+1)*sin(L)+g)/w);
A_x(3,3) =  a*(f/w)*(h*sin(L) - k*cos(L));
A_x(4,3) =  a*(s_square*cos(L)/2*w);
A_x(5,3) =  a*(s_square*sin(L)/2*w);
A_x(6,3) =  a*(1/w)*(h*sin(L)-k*cos(L));

% Initialising B(x)
B_x    = zeros(6,1);
B_x(6) = sqrt(mu_earth*p)*(w/p)^2;

% Initialising J2 Perturbations
den        =   (1 + h^2 + k^2)^2;

delta_J2_r = -(3*mu_J2_r_sq/(2*r^4))*(1 - (12*(h*sin(L) - k*cos(L))^2)...
              /den);
          
delta_J2_t = -(12*mu_J2_r_sq/r^4)*(((h*sin(L)-k*cos(L)) * (h*cos(L)... 
              + k*sin(L)))/den);
         
delta_J2_n = -(6*mu_J2_r_sq/r^4)*(((1 - h^2 - k^2) * (h*sin(L) - ...
               k*cos(L)))/den);
           
           
% Defining deltax
delta_x    = [delta_J2_r; delta_J2_t; delta_J2_n];

x_dot      = A_x*delta_x + B_x;


end

