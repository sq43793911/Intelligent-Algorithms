%% 距离和速度分析

clc;
clear;

% [p_num, p_txt] = xlsread ('Police_GPS_HIS');
% 
% p_id_set = ('002230', '2017-06-13');
% p_id = strcmp(, p_txt);
% [p_id_row, p_id_col] = find(p_id == 1);

[p_num, p_txt] = xlsread ('Police_one_2230_0613');

[a, b] = size(p_num);
[c, d] = size(p_txt);

p_time = zeros(c-1, 1);

parfor e = 1: a 
    p_time(e,1) = datenum(p_txt(e+1,4));
end

figure(1)

subplot(2,2,1);
plot(p_time,p_num(:,4));
ylabel('速度');
datetick('x', 13);
grid on;
set(gca,'Fontsize',14);

subplot(2,2,2);
plot(p_time,p_num(:,2));
ylabel('移动距离');
datetick('x', 13);
grid on;
set(gca,'Fontsize',14);

subplot(2,2,3);
plot(p_time,p_num(:,5));
ylabel('走停率');
datetick('x', 13);
grid on;
set(gca,'Fontsize',14);

% axis([mdain(p_info(1,:)) max(p_info(1,:)) min(p_info(2,:)) max(p_info(2,:))]);

