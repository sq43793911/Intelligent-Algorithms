%% 距离计算

clc;
clear;

%% P_info = xlsread('20180416_Police_GPS_HIS');

x1 = 117.434395;
y1 = 31.84739028;

x2 = 117.4755455;
y2 = 31.86744815;

% 把地球看作球体
R=6371004;

D = ( R * acos( sind(y1) * sind(y2)  + cosd(y1) * cosd(y2) * cosd(x1-x2) ) );

% 把地球看作椭球
a = 6378160;
f = 1/278.256;
F = (y1 + y2)/2;
G = (y1 - y2)/2;
ramda = (x1 - x2)/2;

S = sind(G)^2 * cosd(ramda)^2 + cosd(F)^2 * sind(ramda)^2 ;
C = cosd(G)^2 * cosd(ramda)^2 + sind(F)^2 * sind(ramda)^2 ;

omega = atan (sqrt(S/C));
R = sqrt(S*C)/omega;
E = 2*omega*a;

H1 = (3*R-1)/(2*C);
H2 = (3*R+1)/(2*S);

result = E * (1 + f*H1*( sind(F)^2)*(cosd(G)^2) - f*H2* (cosd(F)^2)*(sind(G)^2)) ;
