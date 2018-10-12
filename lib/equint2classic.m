function classic = equint2classic(x_array)
% equint2classic - The aim of this function is to convert orbital
% parameters from equintnoctial to classic
% Author: Samanvay Karambhe 2016
% Question: 2

% Load up Equinoctinal Elements
p = x_array(1,:);
f = x_array(2,:);
g = x_array(3,:);
h = x_array(4,:);
k = x_array(5,:);
L = x_array(6,:);

% Use the equinoctial to classical orbital parameters
a     = (p./(1-f.^2-g.^2));
e     = sqrt(f.^2 + g.^2);
i     = atan2(2.*sqrt(h.^2+k.^2),(1-h.^2-k.^2));
AoP   = atan2(g.*h-f.*k,f.*h+g.*k);
OMEGA = atan2(k,h);
theta = L - atan2(g,f);

% Return the classical orbital parameters into an array
classic(1,:) = a;
classic(2,:) = e;
classic(3,:) = i;
classic(4,:) = AoP;
classic(5,:) = OMEGA;
classic(6,:) = theta;

end

