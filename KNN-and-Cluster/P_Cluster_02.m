%% Partition Data into Three Clusters
%%
% Randomly generate the sample data.

% Copyright 2015 The MathWorks, Inc.

% rng default; % For reproducibility
% X = [randn(100,2)*0.75+ones(100,2);
%     randn(100,2)*0.5-ones(100,2)];

clear all;
[p_num, p_txt] = xlsread ('Police_Man_without_nomeans_one_weak_3h_all');
X(:,1) = p_num(:,2);
X(:,2) = p_num(:,5);
X(:,3) = p_num(:,10);
X(:,4) = p_num(:,11);


figure;
plot3(X(:,2),X(:,3),X(:,4),'k*','MarkerSize',3);
title 'Police Man';
xlabel 'Time'; 
ylabel 'Distance (m)'; 
zlabel 'Speed (m/s)';
% zlabel 'Acceleration (m/(s^2))';
datetick('x', 13);
%%
% There appears to be two clusters in the data.
%%
% Partition the data into two clusters, and choose the best arrangement out of
% five initializations. Display the final output.
% delete(gcp('nocreate'));
% pool = parpool;                      % Invokes workers
stream = RandStream('mlfg6331_64');  % Random number stream
options = statset('UseParallel',1,'UseSubstreams',1,...
    'Streams',stream);


% tic; % Start stopwatch timer
[idx,C,sumd,D] = kmeans(X(:,2:4),3,'Options',options,'MaxIter',10000,...
    'Display','final','Replicates',10);
% toc % Terminate stopwatch timer
%%
% By default, the software initializes the replicates separately using
% _k_-means++.
%%
% Plot the clusters and the cluster centroids.
% figure;
% plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12)
% hold on
% plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12)
% plot(C(:,1),C(:,2),'kx',...
%      'MarkerSize',15,'LineWidth',3) 
% legend('Cluster 1','Cluster 2','Centroids',...
%        'Location','NW')
% title 'Cluster Assignments and Centroids'
% hold off
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

%  X(idx==3,2), X(idx==3,3), X(idx==3,4), 'kd'

%%
% You can determine how well separated the clusters are by passing |idx| to
% <docid:stats_ug.f3984482>.