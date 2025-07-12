%% Data already loaded in your workspace:
% rgs_data: your RGS points
% cluster_data_corrected: corrected cluster IDs (matches your colors)
% centroids: cluster centroids
% gmm_data: GMM trained on rgs_data
% cbd_Zveh: CBD Z_veh projected points
% cbd_Zcbd: CBD Z_cbd projected points

%% Define cluster colors (corrected order)
colors = [
    209/255, 233/255, 196/255;  % cluster 1: light green
     44/255, 210/255, 245/255;  % cluster 2: light blue
     10/255,  75/255, 141/255;  % cluster 3: dark blue
      0,      120/255,   0      % cluster 4: dark green
];

%% Compute axis limits
all_data = [rgs_data; cbd_Zveh; cbd_Zcbd];
xmin = min(all_data(:,1)); xmax = max(all_data(:,1));
ymin = min(all_data(:,2)); ymax = max(all_data(:,2));
zmin = min(all_data(:,3)); zmax = max(all_data(:,3));

%% STEP 1: Map GMM components to corrected cluster IDs
[P_rgs, ~] = posterior(gmm_data, rgs_data);
[~, gmm_components_rgs] = max(P_rgs, [], 2);

% Determine mapping: GMM component → corrected cluster ID
gmm_to_corrected = zeros(1,4);
for k = 1:4
    idx = gmm_components_rgs == k;
    gmm_to_corrected(k) = mode(cluster_data_corrected(idx));
end

disp('✅ GMM components mapped to corrected cluster IDs:')
disp(gmm_to_corrected)

%% STEP 2: Assign clusters to CBD points using GMM + corrected mapping
[P_veh, ~] = posterior(gmm_data, cbd_Zveh);
[~, cbd_Zveh_gmm_components] = max(P_veh, [], 2);
cbd_Zveh_labels_gmm = gmm_to_corrected(cbd_Zveh_gmm_components);

[P_cbd, ~] = posterior(gmm_data, cbd_Zcbd);
[~, cbd_Zcbd_gmm_components] = max(P_cbd, [], 2);
cbd_Zcbd_labels_gmm = gmm_to_corrected(cbd_Zcbd_gmm_components);

%% STEP 3: Plot RGS + CBD (GMM-labeled) side by side
figure()

% RGS plot
ax1 = subplot(1,3,1);
hold on
for k = 1:4
    idx = cluster_data_corrected == k;
    scatter3(rgs_data(idx,1), rgs_data(idx,2), rgs_data(idx,3), 10, ...
        'filled', 'MarkerFaceColor', colors(k,:), 'MarkerEdgeColor', colors(k,:));
end
scatter3(centroids(:,1), centroids(:,2), centroids(:,3), 100, 'kx', 'LineWidth', 2);
title('RGS14 VEH')
xlabel('PCA1'); ylabel('PCA2'); zlabel('PCA3')
grid on; axis equal
xlim([xmin xmax]); ylim([ymin ymax]); zlim([zmin zmax])
view(3)
hold off

% CBD Z_veh plot
ax2 = subplot(1,3,2);
hold on
for k = 1:4
    idx = cbd_Zveh_labels_gmm == k;
    scatter3(cbd_Zveh(idx,1), cbd_Zveh(idx,2), cbd_Zveh(idx,3), 10, ...
        'filled', 'MarkerFaceColor', colors(k,:), 'MarkerEdgeColor', colors(k,:));
end
title('CBD\_veh (GMM-assigned clusters)')
xlabel('PCA1'); ylabel('PCA2'); zlabel('PCA3')
grid on; axis equal
xlim([xmin xmax]); ylim([ymin ymax]); zlim([zmin zmax])
view(3)
hold off

% CBD Z_cbd plot
ax3 = subplot(1,3,3);
hold on
for k = 1:4
    idx = cbd_Zcbd_labels_gmm == k;
    scatter3(cbd_Zcbd(idx,1), cbd_Zcbd(idx,2), cbd_Zcbd(idx,3), 10, ...
        'filled', 'MarkerFaceColor', colors(k,:), 'MarkerEdgeColor', colors(k,:));
end
title('CBD\_cbd (GMM-assigned clusters)')
xlabel('PCA1'); ylabel('PCA2'); zlabel('PCA3')
grid on; axis equal
xlim([xmin xmax]); ylim([ymin ymax]); zlim([zmin zmax])
view(3)
hold off

% Legend
legend(ax1, {'Cluster 1','Cluster 2','Cluster 3','Cluster 4'}, ...
    'Position',[0.4,0.05,0.3,0.05], 'Orientation','horizontal');

% Link cameras
linkprop([ax1, ax2, ax3], {'CameraPosition','CameraUpVector','CameraTarget','CameraViewAngle'});
%% video rotattion
%% STEP 5: Create rotating video
video_filename = 'cluster_rotation.mp4';
v = VideoWriter('cluster_rotation.avi', 'Motion JPEG AVI');

v.FrameRate = 20; % frames per second
open(v);

% Define the rotation angles (0 to 360 degrees)
angles = linspace(0, 360, 180); % 180 frames for smooth rotation



fig = gcf;
set(fig, 'Units', 'normalized', 'OuterPosition', [0 0 1 1]);
drawnow;

% Set figure handle
fig = gcf;

% Rotate and capture frames
for angle = angles
    % Set same view for all linked axes
    view(ax1, [angle, 30]); % azimuth=angle, elevation=30
    drawnow;
    frame = getframe(fig);
    writeVideo(v, frame);
end

close(v);

fprintf('🎬 Video saved as: %s\n', video_filename);


%% STEP 4: Print ripple counts and percentages
fprintf('\n================ Ripple counts & percentages =================\n')

fprintf('\n📊 RGS14 VEH (corrected labels):\n')
total_rgs = numel(cluster_data_corrected);
for k = 1:4
    count = sum(cluster_data_corrected == k);
    pct = 100 * count / total_rgs;
    fprintf('Cluster %d: %d (%.2f%%)\n', k, count, pct);
end

fprintf('\n📊 CBD Z_veh (GMM-assigned):\n')
total_veh = numel(cbd_Zveh_labels_gmm);
for k = 1:4
    count = sum(cbd_Zveh_labels_gmm == k);
    pct = 100 * count / total_veh;
    fprintf('Cluster %d: %d (%.2f%%)\n', k, count, pct);
end

fprintf('\n📊 CBD Z_cbd (GMM-assigned):\n')
total_cbd = numel(cbd_Zcbd_labels_gmm);
for k = 1:4
    count = sum(cbd_Zcbd_labels_gmm == k);
    pct = 100 * count / total_cbd;
    fprintf('Cluster %d: %d (%.2f%%)\n', k, count, pct);
end

fprintf('\n===============================================================\n')
