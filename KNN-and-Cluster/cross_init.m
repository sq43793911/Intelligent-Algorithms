function cross_gps= cross_init(R_info)

%% ·�����ݷ�����ȷ��·��GPS����

% r_gps_x = unique(R_info(: , 11), 'stable');
% r_gps_y = unique(R_info(: , 12), 'stable');

[cross_gps, ~, ~] = unique(R_info( : , 11:12) ,'rows', 'stable');