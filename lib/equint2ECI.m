function ECIPos = equint2ECI(x_array)
% equint2ECI -  Convert satellite coordinates from Equinoctical coordinates
% to ECI coordinates
% Author: Samanvay Karambhe 2016
% Question: 2 

% % Load up Equinoctinal Elements
% p = x(1);
% f = x(2);
% g = x(3);
% h = x(4);
% k = x(5);
% L = x(6);
% 
% % Calculate other necessary parameters
% a_square = h^2 - k^2;
% s_square = 1 + h^2 + k^2;
% w = 1 + f*cos(L) + g*sin(L);
% r = p/w;
% 
% % Obtain ECI Coordinates
% ECIPos(1,count) = (r/s_square)*(cos(L) + a_square*cos(L) + 2*h*k*sin(L));
% ECIPos(2,count) = (r/s_square)*(sin(L) - a_square*sin(L) + 2*h*k*sin(L));
% ECIPos(3,count) = (2*r/s_square)*(h*sin(L) - k*cos(L));

% Load up Equinoctinal Elements
p = x_array(1,:);
f = x_array(2,:);
g = x_array(3,:);
h = x_array(4,:);
k = x_array(5,:);
L = x_array(6,:);

% Calculate other necessary parameters
a_square = h.^2 - k.^2;
s_square = 1 + h.^2 + k.^2;
w = 1 + f.*cos(L) + g.*sin(L);
r = p./w;

% Obtain ECI Coordinates
ECIPos(1,:) = (r./s_square).*(cos(L) + a_square.*cos(L) + 2.*h.*k.*sin(L));
ECIPos(2,:) = (r./s_square).*(sin(L) - a_square.*sin(L) + 2.*h.*k.*sin(L));
ECIPos(3,:) = (2.*r./s_square).*(h.*sin(L) - k.*cos(L));


end

