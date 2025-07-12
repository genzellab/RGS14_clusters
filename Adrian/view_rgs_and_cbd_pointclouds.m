%% Load RGS data
cd '/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/wetransfer_pelin-folder-from-malaga-second-attempt_2025-04-09_0406/Pelin'
load('clusters_corrected_struct.mat')
rgs_data = clusters.data;
cluster_data_corrected = clusters.labels;
centroids = clusters.centroids;

%% Load CBD data
cd /home/adrian/Documents/GitHub/RGS14_clusters/Adrian
load coeff.mat
cd /home/adrian/Downloads
load updated_pca_features_cbd.mat

%% Prepare PCA-projected data
veh_X = zscore(PCA_features_veh_m22);
cbd_X = zscore(PCA_features_cbd_m22);

Z_veh = veh_X * coeff;
Z_cbd = cbd_X * coeff;

cbd_Zveh = Z_veh(:, 1:3);
cbd_Zcbd = Z_cbd(:, 1:3);

%% Define specified colors for RGS clusters
colors = [
    209/255, 233/255, 196/255;  % cluster 1: light green
     44/255, 210/255, 245/255;  % cluster 2: light blue
     10/255,  75/255, 141/255;  % cluster 3: dark blue
      0,      120/255,   0      % cluster 4: dark green
];

%% Compute combined axis limits across all datasets
all_data = [rgs_data; cbd_Zveh; cbd_Zcbd];
xmin = min(all_data(:,1)); xmax = max(all_data(:,1));
ymin = min(all_data(:,2)); ymax = max(all_data(:,2));
zmin = min(all_data(:,3)); zmax = max(all_data(:,3));

%% Assign clusters to CBD Z_veh
cbd_Zveh_labels = zeros(size(cbd_Zveh,1),1);
for i = 1:size(cbd_Zveh,1)
    dists = vecnorm(centroids - cbd_Zveh(i,:), 2, 2);
    [~, cbd_Zveh_labels(i)] = min(dists);
end

%% Assign clusters to CBD Z_cbd
cbd_Zcbd_labels = zeros(size(cbd_Zcbd,1),1);
for i = 1:size(cbd_Zcbd,1)
    dists = vecnorm(centroids - cbd_Zcbd(i,:), 2, 2);
    [~, cbd_Zcbd_labels(i)] = min(dists);
end

%% Create figure
figure()

%% Left subplot: RGS VEH clusters
ax1 = subplot(1,3,1);
hold on
for k = 1:4
    idx = cluster_data_corrected == k;
    scatter3(rgs_data(idx,1), rgs_data(idx,2), rgs_data(idx,3), 10, ...
        'filled', ...
        'MarkerFaceColor', colors(k,:), ...
        'MarkerEdgeColor', colors(k,:));
end
scatter3(centroids(:,1), centroids(:,2), centroids(:,3), 100, 'kx', 'LineWidth', 2);
title('RGS14 VEH: Corrected Clusters + Centroids')
xlabel('PCA1')
ylabel('PCA2')
zlabel('PCA3')
grid on
axis equal
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
view(3)
hold off

%% Middle subplot: CBD Z_veh with assigned clusters
ax2 = subplot(1,3,2);
hold on
for k = 1:4
    idx = cbd_Zveh_labels == k;
    scatter3(cbd_Zveh(idx,1), cbd_Zveh(idx,2), cbd_Zveh(idx,3), 10, ...
        'filled', ...
        'MarkerFaceColor', colors(k,:), ...
        'MarkerEdgeColor', colors(k,:));
end
title('CBD: Z\_veh (assigned clusters)')
xlabel('PCA1')
ylabel('PCA2')
zlabel('PCA3')
grid on
axis equal
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
view(3)
hold off

%% Right subplot: CBD Z_cbd with assigned clusters
ax3 = subplot(1,3,3);
hold on
for k = 1:4
    idx = cbd_Zcbd_labels == k;
    scatter3(cbd_Zcbd(idx,1), cbd_Zcbd(idx,2), cbd_Zcbd(idx,3), 10, ...
        'filled', ...
        'MarkerFaceColor', colors(k,:), ...
        'MarkerEdgeColor', colors(k,:));
end
title('CBD: Z\_cbd (assigned clusters)')
xlabel('PCA1')
ylabel('PCA2')
zlabel('PCA3')
grid on
axis equal
xlim([xmin xmax])
ylim([ymin ymax])
zlim([zmin zmax])
view(3)
hold off

%% Put legend below RGS
legend(ax1, {'Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Centroids'}, ...
    'Position',[0.4,0.05,0.3,0.05], 'Orientation','horizontal')

%% Link camera properties
linkprop([ax1, ax2, ax3], {'CameraPosition','CameraUpVector','CameraTarget','CameraViewAngle'});
%%
%% Compute counts & percentages for RGS
fprintf('\nRGS14 VEH:\n')
total_rgs = numel(cluster_data_corrected);
for k = 1:4
    count = sum(cluster_data_corrected == k);
    pct = 100 * count / total_rgs;
    fprintf('Cluster %d: %d (%.2f%%)\n', k, count, pct);
end

%% Compute counts & percentages for CBD Z_veh
fprintf('\nCBD Z_veh:\n')
total_veh = numel(cbd_Zveh_labels);
for k = 1:4
    count = sum(cbd_Zveh_labels == k);
    pct = 100 * count / total_veh;
    fprintf('Cluster %d: %d (%.2f%%)\n', k, count, pct);
end

%% Compute counts & percentages for CBD Z_cbd
fprintf('\nCBD Z_cbd:\n')
total_cbd = numel(cbd_Zcbd_labels);
for k = 1:4
    count = sum(cbd_Zcbd_labels == k);
    pct = 100 * count / total_cbd;
    fprintf('Cluster %d: %d (%.2f%%)\n', k, count, pct);
end
