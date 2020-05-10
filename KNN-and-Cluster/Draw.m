%% »­Í¼


clear all;
[p_num, p_txt] = xlsread ('Police_Man_without_nomeans_one_weak_3h_final_marked');
X(:,1) = p_num(:,2);
X(:,2) = p_num(:,5);
X(:,3) = p_num(:,10);
X(:,4) = p_num(:,11);

figure
F1 = plot3(X(idx==1,2), X(idx==1,3), X(idx==1,4), 'r*', ...
                  X(idx==2,2), X(idx==2,3), X(idx==2,4), 'bo', ...
                  X(idx==3,2), X(idx==3,3), X(idx==3,4), 'gs');
                  
set(gca, 'LineWidth',1);
grid on;
set(F1,  'MarkerSize',5,'LineWidth',2);
title 'Police Man';
xlabel 'Time'; 
ylabel 'Distance (m)'; 
zlabel 'Speed (m/s)';
% zlabel 'Acceleration (m/(s^2))';
datetick('x', 13);