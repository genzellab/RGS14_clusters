%% Pelin Özsezer
% Extracts ripples from waveforms; 
% Generates the data of features; 
% Normalizes and computes PCA; 
% Generates density maps; Thresholds; 
% Fits GMM model; Finds clusters per treatment; 
% Creates new files per cluster and per treatment.


clc
clear
format compact
format longG
load('GC_waveforms_treatmentwise.mat'); % load data

GC_raw_veh = GC_broadband_veh; % Copy the value to the new variable
clear GC_broadband_veh; % Optional: Remove the old variable from the workspace

GC_raw_rgs = GC_broadband_rgs; % Copy the value to the new variable
clear GC_broadband_rgs; % Optional: Remove the old variable from the workspace

%%
%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EXTRACT WAVEFORMS %%%
%%%%%%%%%%%%%%%%%%%%%%%%%

%% Vehicle


data=[];
for i=1:length(GC_raw_veh(:,1))
    duration_start = 3001-(GC_raw_veh{i,3}-GC_raw_veh{i,2})*1000;
    duration_end   = 3001+(GC_raw_veh{i,4}-GC_raw_veh{i,3})*1000;
    data{i}=(GC_raw_veh{i}(2,floor(duration_start):round(duration_end)));
end
waveforms_veh=data';

%% RGS


data=[];
for i=1:length(GC_raw_rgs(:,1))
    duration_start = 3001-(GC_raw_rgs{i,3}-GC_raw_rgs{i,2})*1000;
    duration_end   = 3001+(GC_raw_rgs{i,4}-GC_raw_rgs{i,3})*1000;
    data{i}=(GC_raw_rgs{i}(2,floor(duration_start):round(duration_end)));
end
waveforms_rgs=data';

%%
%%%%%%%%%%%%%%%%
%%% FEATURES %%%
%%%%%%%%%%%%%%%%
fs=1000;

data=waveforms_veh;
si=data;
data2=waveforms_rgs;
si2=data2;

timeasleep=0;
print_hist=1;

[x,y,z,w,h,q,l,p,si_mixed,th,PCA_features]=delta_specs(si,timeasleep,print_hist,fs); % Vehicle
[x2,y2,z2,w2,h2,q2,l2,p2,si_mixed2,th2,PCA_features2]=delta_specs(si2,timeasleep,print_hist,fs); % RGS

PCA_features_veh_m22=PCA_features(:,2:end);  
PCA_features_rgs_m22=PCA_features2(:,2:end); 


%%
%%%%%%%%%%%%%%%%%%%%%
%%% COMPUTING PCA %%%
%%%%%%%%%%%%%%%%%%%%%

X=zscore(PCA_features_veh_m22);
Y=zscore(PCA_features_rgs_m22);

[coeff,score,latent,~,explained] = pca(X); 
[coeff2,score2,latent2,~,explained2] = pca(Y); 

Z_veh=X*coeff;
Z_rgs=Y*coeff;
%Z_rgs=Y*coeff2;


%%
        
        % Veh
        X=Z_veh(:,1); % Change the value according to which PCA/s you want to analyze!
        Y=Z_veh(:,2); % e.g.; 1 corresponds to PCA1, etc.  
        Z=Z_veh(:,3);
        % RGS
%         X=Z_rgs(:,1);
%         Y=Z_rgs(:,2);
%         Z=Z_rgs(:,3);
 
%%
%%%%%%%%%%%%%%%
%%% FIT GMM %%%
%%%%%%%%%%%%%%%

data = [X,Y,Z];

%% fit the model
rng(1);
k =4; % change the number of components/clusters here!
options = statset('MaxIter',1000);
gmm_data = fitgmdist(data,k,'CovarianceType','diagonal','SharedCovariance',false,'Options',options);
cluster_data=cluster(gmm_data,data);

%% cluster1
idx_c1 = cluster_data==1; % CHANGE NUMBER ACCORDINGLY!
actual = data(idx_c1,:);

x_axis1 =actual(:,1);
y_axis1 =actual(:,2);
z_axis1 =actual(:,3);

    rect_x_points1=[mean(x_axis1)-2*std(x_axis1) mean(x_axis1)+2*std(x_axis1)];
    rect_y_points1=[mean(y_axis1)-2*std(y_axis1) mean(y_axis1)+2*std(y_axis1)];
    rect_z_points1=[mean(z_axis1)-2*std(z_axis1) mean(z_axis1)+2*std(z_axis1)];

    width1     = rect_x_points1(2)-rect_x_points1(1);
    height1    = rect_y_points1(2)-rect_y_points1(1);
    depth1     = rect_z_points1(2)-rect_z_points1(1);

%% cluster 2
idx_c2 = cluster_data==2; % CHANGE NUMBER ACCORDINGLY!
actual = data(idx_c2,:);

x_axis2 =actual(:,1);
y_axis2 =actual(:,2);
z_axis2 =actual(:,3);

    rect_x_points2=[mean(x_axis2)-2*std(x_axis2) mean(x_axis2)+2*std(x_axis2)];
    rect_y_points2=[mean(y_axis2)-2*std(y_axis2) mean(y_axis2)+2*std(y_axis2)];
    rect_z_points2=[mean(z_axis2)-2*std(z_axis2) mean(z_axis2)+2*std(z_axis2)];

    width2     = rect_x_points2(2)-rect_x_points2(1);
    height2    = rect_y_points2(2)-rect_y_points2(1);
    depth2     = rect_z_points2(2)-rect_z_points2(1);

%% cluster 3
idx_c3 = cluster_data==3; % CHANGE NUMBER ACCORDINGLY!
actual = data(idx_c3,:);

x_axis3 =actual(:,1);
y_axis3 =actual(:,2);
z_axis3 =actual(:,3);

    rect_x_points3=[mean(x_axis3)-2*std(x_axis3) mean(x_axis3)+2*std(x_axis3)];
    rect_y_points3=[mean(y_axis3)-2*std(y_axis3) mean(y_axis3)+2*std(y_axis3)];
    rect_z_points3=[mean(z_axis3)-2*std(z_axis3) mean(z_axis3)+2*std(z_axis3)];

    width3     = rect_x_points3(2)-rect_x_points3(1);
    height3    = rect_y_points3(2)-rect_y_points3(1);
    depth3     = rect_z_points3(2)-rect_z_points3(1);

%% cluster 4
idx_c4 = cluster_data==4; % CHANGE NUMBER ACCORDINGLY!
actual = data(idx_c4,:);

x_axis4 =actual(:,1);
y_axis4 =actual(:,2);
z_axis4 =actual(:,3);

    rect_x_points4=[mean(x_axis4)-2*std(x_axis4) mean(x_axis4)+2*std(x_axis4)];
    rect_y_points4=[mean(y_axis4)-2*std(y_axis4) mean(y_axis4)+2*std(y_axis4)];
    rect_z_points4=[mean(z_axis4)-2*std(z_axis4) mean(z_axis4)+2*std(z_axis4)];

    width4     = rect_x_points4(2)-rect_x_points4(1);
    height4    = rect_y_points4(2)-rect_y_points4(1);
    depth4     = rect_z_points4(2)-rect_z_points4(1);
%% Correcting cluster ID assignment
% Store cluster 1 temporarily
temp_x1 = x_axis1;
temp_y1 = y_axis1;
temp_z1 = z_axis1;
temp_idx_c1 = idx_c1;


% Store cluster 2 temporarily
temp_x2 = x_axis2;
temp_y2 = y_axis2;
temp_z2 = z_axis2;
temp_idx_c2 = idx_c2;

% Store cluster 4 temporarily
temp_x4 = x_axis4;
temp_y4 = y_axis4;
temp_z4 = z_axis4;
temp_idx_c4 = idx_c4;

%%
% % Switch cluster 1 with cluster 2
% x_axis1 = temp_x2;
% y_axis1 = temp_y2;
% z_axis1 = temp_z2;
% 
% % Switch cluster 4 with cluster 1 (which now holds cluster 2's values)
% x_axis4 = temp_x1;
% y_axis4 = temp_y1;
% z_axis4 = temp_z1;

% Switch cluster 2 with cluster 4 (which now holds cluster 1's original values)
x_axis4 = temp_x2;
y_axis4= temp_y2;
z_axis4 = temp_z2;
idx_c4=temp_idx_c2;

x_axis1 = temp_x4;
y_axis1= temp_y4;
z_axis1 = temp_z4;
idx_c1=temp_idx_c4;

x_axis2 = temp_x1;
y_axis2= temp_y1;
z_axis2 = temp_z1;
idx_c2=temp_idx_c1;


%% Plot
figure()
scatter3(x_axis1,y_axis1,z_axis1,'filled','MarkerFaceColor',[209/255 233/255 196/255],'MarkerEdgeColor',[209/255 233/255 196/255])
hold on
scatter3(x_axis2,y_axis2,z_axis2,'filled','MarkerFaceColor',[44/255 210/255 245/255],'MarkerEdgeColor',[44/255 210/255 245/255])
hold on
scatter3(x_axis3,y_axis3,z_axis3,'filled','MarkerFaceColor',[10/255 75/255 141/255],'MarkerEdgeColor',[10/255 75/255 141/255])
hold on
scatter3(x_axis4,y_axis4,z_axis4,'filled','MarkerFaceColor',[0 120/255 0],'MarkerEdgeColor',[0 120/255 0])
hold on
title('4 clusters');
xlabel('PCA1')
ylabel('PCA2')
zlabel('PCA3')
legend('cluster 1','cluster 2','cluster 3','cluster 4');
xlim([-10 60])
ylim([-30 20])
zlim([-10 40])

% saveas(gcf,'4clusters.jpg')
% saveas(gcf,'4clusters.pdf')
% saveas(gcf,'4clusters.fig')

%% OPTIONAL: PLOT
%%
% --- Plot clusters with transparency ---
scatter3(x_axis1, y_axis1, z_axis1, 36, 'filled', ...
    'MarkerFaceColor', [209/255 233/255 196/255], ...
    'MarkerEdgeColor', [209/255 233/255 196/255], ...
    'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3);
hold on
scatter3(x_axis2, y_axis2, z_axis2, 36, 'filled', ...
    'MarkerFaceColor', [44/255 210/255 245/255], ...
    'MarkerEdgeColor', [44/255 210/255 245/255], ...
    'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3);
scatter3(x_axis3, y_axis3, z_axis3, 36, 'filled', ...
    'MarkerFaceColor', [10/255 75/255 141/255], ...
    'MarkerEdgeColor', [10/255 75/255 141/255], ...
    'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3);
scatter3(x_axis4, y_axis4, z_axis4, 36, 'filled', ...
    'MarkerFaceColor', [0 120/255 0], ...
    'MarkerEdgeColor', [0 120/255 0], ...
    'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3);

coord=load('/home/adrian/Documents/GitHub/RGS14_clusters/Adrian/cluster_peak_coords.mat')
% --- Plot centroids at actual positions ---
scatter3(coord.peak1(1), coord.peak1(2), coord.peak1(3), 200, '^', ...
    'MarkerFaceColor', [1 0 0], 'MarkerEdgeColor', [1 0 0], 'LineWidth', 2);
scatter3(coord.peak2(1), coord.peak2(2), coord.peak2(3), 200, 's', ...
    'MarkerFaceColor', [1 0 1], 'MarkerEdgeColor', [1 0 1], 'LineWidth', 2);
scatter3(coord.peak3(1), coord.peak3(2), coord.peak3(3), 200, 'd', ...
    'MarkerFaceColor', [1 0.5 0], 'MarkerEdgeColor', [1 0.5 0], 'LineWidth', 2);

% --- Set axis limits ---
xlim([-10 60]);
ylim([-30 20]);
zlim([-10 40]);
% Get axis limits
x_limits = xlim;
y_limits = ylim;
z_limits = zlim;

% --- Add axis-aligned dashed lines for each centroid ---

% Peak1 (red)
line([x_limits(1), x_limits(2)], [coord.peak1(2), coord.peak1(2)], [coord.peak1(3), coord.peak1(3)], ...
    'Color', [1 0 0], 'LineStyle', '--', 'LineWidth', 1.2);
line([coord.peak1(1), coord.peak1(1)], [y_limits(1), y_limits(2)], [coord.peak1(3), coord.peak1(3)], ...
    'Color', [1 0 0], 'LineStyle', '--', 'LineWidth', 1.2);
line([coord.peak1(1), coord.peak1(1)], [coord.peak1(2), coord.peak1(2)], [z_limits(1), z_limits(2)], ...
    'Color', [1 0 0], 'LineStyle', '--', 'LineWidth', 1.2);

% Peak2 (magenta)
line([x_limits(1), x_limits(2)], [coord.peak2(2), coord.peak2(2)], [coord.peak2(3), coord.peak2(3)], ...
    'Color', [1 0 1], 'LineStyle', '--', 'LineWidth', 1.2);
line([coord.peak2(1), coord.peak2(1)], [y_limits(1), y_limits(2)], [coord.peak2(3), coord.peak2(3)], ...
    'Color', [1 0 1], 'LineStyle', '--', 'LineWidth', 1.2);
line([coord.peak2(1), coord.peak2(1)], [coord.peak2(2), coord.peak2(2)], [z_limits(1), z_limits(2)], ...
    'Color', [1 0 1], 'LineStyle', '--', 'LineWidth', 1.2);

% Peak3 (orange)
line([x_limits(1), x_limits(2)], [coord.peak3(2), coord.peak3(2)], [coord.peak3(3), coord.peak3(3)], ...
    'Color', [1 0.5 0], 'LineStyle', '--', 'LineWidth', 1.2);
line([coord.peak3(1), coord.peak3(1)], [y_limits(1), y_limits(2)], [coord.peak3(3), coord.peak3(3)], ...
    'Color', [1 0.5 0], 'LineStyle', '--', 'LineWidth', 1.2);
line([coord.peak3(1), coord.peak3(1)], [coord.peak3(2), coord.peak3(2)], [z_limits(1), z_limits(2)], ...
    'Color', [1 0.5 0], 'LineStyle', '--', 'LineWidth', 1.2);

%%
% Number of closest points to find
num_points = 1500;
% num_points = 5000;

% Compute distances for Cluster 1
distances1 = sqrt((x_axis1 - coord.peak1(1)).^2 + (y_axis1 - coord.peak1(2)).^2 + (z_axis1 - coord.peak1(3)).^2);
[~, idx1] = mink(distances1, num_points); % Get indices of closest points

% Compute distances for Cluster 2
distances2 = sqrt((x_axis2 - coord.peak2(1)).^2 + (y_axis2 - coord.peak2(2)).^2 + (z_axis2 - coord.peak2(3)).^2);
[~, idx2] = mink(distances2, num_points);

% Compute distances for Cluster 3
distances3 = sqrt((x_axis3 - coord.peak3(1)).^2 + (y_axis3 - coord.peak3(2)).^2 + (z_axis3 - coord.peak3(3)).^2);
[~, idx3] = mink(distances3, num_points);

% Extract the closest points while preserving index
x_axis1_closest = x_axis1(idx1);
y_axis1_closest = y_axis1(idx1);
z_axis1_closest = z_axis1(idx1);

x_axis2_closest = x_axis2(idx2);
y_axis2_closest = y_axis2(idx2);
z_axis2_closest = z_axis2(idx2);

x_axis3_closest = x_axis3(idx3);
y_axis3_closest = y_axis3(idx3);
z_axis3_closest = z_axis3(idx3);
%%
% --- Define cluster colors ---
colors = { [209/255 233/255 196/255], ...  % Light pastel green (Cluster 1)
           [44/255 210/255 245/255], ...   % Vibrant cyan/aqua (Cluster 2)
           [10/255 75/255 141/255] };      % Deep blue (Cluster 3)

% --- Plot closest clusters with transparency ---
scatter3(x_axis1_closest, y_axis1_closest, z_axis1_closest, 36, 'filled', ...
    'MarkerFaceColor', colors{1}, 'MarkerEdgeColor', colors{1}, ...
    'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3);
hold on

scatter3(x_axis2_closest, y_axis2_closest, z_axis2_closest, 36, 'filled', ...
    'MarkerFaceColor', colors{2}, 'MarkerEdgeColor', colors{2}, ...
    'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3);
hold on

scatter3(x_axis3_closest, y_axis3_closest, z_axis3_closest, 36, 'filled', ...
    'MarkerFaceColor', colors{3}, 'MarkerEdgeColor', colors{3}, ...
    'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3);

scatter3(x_axis4, y_axis4, z_axis4, 36, 'filled', ...
    'MarkerFaceColor', [0 120/255 0], 'MarkerEdgeColor', [0 120/255 0], ...
    'MarkerFaceAlpha', 0.3, 'MarkerEdgeAlpha', 0.3);

% --- Plot centroids using cluster colors ---
for i = 1:3
    scatter3(coord.(['peak' num2str(i)])(1), coord.(['peak' num2str(i)])(2), coord.(['peak' num2str(i)])(3), 200, 'o', ...
        'MarkerFaceColor', colors{i}, 'MarkerEdgeColor', colors{i}, 'LineWidth', 2);
end

% --- Set axis limits ---
xlim([-10 60]);
ylim([-30 20]);
zlim([-10 40]);

% Get axis limits
x_limits = xlim;
y_limits = ylim;
z_limits = zlim;

% --- Add axis-aligned dashed lines for each centroid using matching colors ---
for i = 1:3
    line([x_limits(1), x_limits(2)], [coord.(['peak' num2str(i)])(2), coord.(['peak' num2str(i)])(2)], ...
        [coord.(['peak' num2str(i)])(3), coord.(['peak' num2str(i)])(3)], 'Color', colors{i}, 'LineStyle', '--', 'LineWidth', 1.2);
    line([coord.(['peak' num2str(i)])(1), coord.(['peak' num2str(i)])(1)], [y_limits(1), y_limits(2)], ...
        [coord.(['peak' num2str(i)])(3), coord.(['peak' num2str(i)])(3)], 'Color', colors{i}, 'LineStyle', '--', 'LineWidth', 1.2);
    line([coord.(['peak' num2str(i)])(1), coord.(['peak' num2str(i)])(1)], [coord.(['peak' num2str(i)])(2), coord.(['peak' num2str(i)])(2)], ...
        [z_limits(1), z_limits(2)], 'Color', colors{i}, 'LineStyle', '--', 'LineWidth', 1.2);
end

xlabel('PCA 1')
ylabel('PCA 2')
zlabel('PCA 3')
%%
% Absolute indices in full data
cluster1_indices = find(idx_c1);  % these are the indices of cluster 1 in the original dataset
cluster2_indices = find(idx_c2);  % these are the indices of cluster 1 in the original dataset
cluster3_indices = find(idx_c3);  % these are the indices of cluster 1 in the original dataset

% Now map idx1 (local) to global
absolute_idx1 = cluster1_indices(idx1);  % absolute indices of the closest points in data
absolute_idx2 = cluster2_indices(idx2);  % absolute indices of the closest points in data
absolute_idx3 = cluster3_indices(idx3);  % absolute indices of the closest points in data

absolute_idx1=sort(absolute_idx1);
absolute_idx2=sort(absolute_idx2);
absolute_idx3=sort(absolute_idx3);

veamos1=GC_raw_veh(absolute_idx1,6:end);
veamos2=GC_raw_veh(absolute_idx2,6:end);
veamos3=GC_raw_veh(absolute_idx3,6:end);

% Extract the subset of GC_raw_veh based on absolute_idx1
GC_raw_veh_subsampled1 = GC_raw_veh(absolute_idx1, :);
GC_raw_veh_subsampled2 = GC_raw_veh(absolute_idx2, :);
GC_raw_veh_subsampled3 = GC_raw_veh(absolute_idx3, :);
GC_raw_veh_subsampled= [GC_raw_veh_subsampled1; GC_raw_veh_subsampled2; GC_raw_veh_subsampled3];
%save('GC_raw_veh_subsampled.mat', 'GC_raw_veh_subsampled');
GC_bandpassed_veh_subsampled1 = GC_bandpassed_veh(absolute_idx1, :);
GC_bandpassed_veh_subsampled2 = GC_bandpassed_veh(absolute_idx2, :);
GC_bandpassed_veh_subsampled3 = GC_bandpassed_veh(absolute_idx3, :);
GC_bandpassed_veh_subsampled= [GC_bandpassed_veh_subsampled1; GC_bandpassed_veh_subsampled2; GC_bandpassed_veh_subsampled3];
%save('GC_bandpassed_veh_subsampled.mat', 'GC_bandpassed_veh_subsampled');


% veamos1_traces=GC_raw_veh(absolute_idx1,1);
% veamos2_traces=GC_raw_veh(absolute_idx2,1);
% veamos3_traces=GC_raw_veh(absolute_idx3,1);
% 
% % Initialize output matrix
% final_matrix = zeros(num_points, 6001); % Preallocate for efficiency
% 
% % Loop through each cell and extract the first row
% for i = 1:num_points
%     final_matrix(i, :) = veamos1_traces{i}(2, :); % Extract first row (1x6001)
% end


veamos1_total=GC_raw_veh(cluster1_indices,6:end);
veamos2_total=GC_raw_veh(cluster2_indices,6:end);
veamos3_total=GC_raw_veh(cluster3_indices,6:end);

% %%
% % Extract first column
% first_column = cell2mat(veamos1(:,1)); % Convert to numeric array if needed
% 
% % Find unique values and their counts
% [unique_values, ~, idx] = unique(first_column);
% counts = accumarray(idx, 1); % Count occurrences of each unique value
% 
% % Compute percentages
% total_elements = numel(first_column);
% percentages = (counts / total_elements) * 100;
% 
% % Display results
% fprintf('Rat | Percentage\n');
% fprintf('--------------------------\n');
% for i = 1:length(unique_values)
%     fprintf('%d           | %.2f%%\n', unique_values(i), percentages(i));
% end
%%
% Extract first column
first_column = cell2mat(veamos3_total(:,1)); % Convert to numeric array if needed

% Find unique values and their counts
[unique_values, ~, idx] = unique(first_column);
counts = accumarray(idx, 1); % Count occurrences of each unique value

% Compute percentages
total_elements = numel(first_column);
percentages = (counts / total_elements) * 100;

% Display results
fprintf('Rat | Count | Percentage\n');
fprintf('-----------------------------------\n');
for i = 1:length(unique_values)
    fprintf('%d            | %d    | %.2f%%\n', unique_values(i), counts(i), percentages(i));
end

%% pLOTTING EVENTS
% Initialize output matrix
final_matrix1 = zeros(num_points, 6001); % Preallocate for efficiency
final_matrix2 = zeros(num_points, 6001); % Preallocate for efficiency
final_matrix3 = zeros(num_points, 6001); % Preallocate for efficiency

% Loop through each cell and extract the first row
for i = 1:num_points
    final_matrix1(i, :) = GC_bandpassed_veh_subsampled{i}(2, :); % Extract first row (1x6001)
end
% Loop through each cell and extract the first row
% Extract rows for final_matrix2
for i = num_points+1:2*num_points
    final_matrix2(i - num_points, :) = GC_bandpassed_veh_subsampled{i}(2, :);
end

% Extract rows for final_matrix3
for i = 2*num_points+1:3*num_points
    final_matrix3(i - 2*num_points, :) = GC_bandpassed_veh_subsampled{i}(2, :);
end


%% Aligned

% Initialize matrices for aligned traces
aligned_matrix1 = zeros(num_points, 6001);
aligned_matrix2 = zeros(num_points, 6001);
aligned_matrix3 = zeros(num_points, 6001);

% Loop through each event and align based on nearest trough
for i = 1:num_points
    trace = final_matrix1(i, :); % Get the trace
    [~, trough_idx] = min(trace(2900:3100)); % Find local trough around 3001
    trough_idx = trough_idx + 2899; % Adjust index relative to full signal
    
    shift_amount = 3001 - trough_idx; % Compute shift required
    aligned_matrix1(i, :) = circshift(trace, shift_amount, 2); % Align trace
end

for i = 1:num_points
    trace = final_matrix2(i, :);
    [~, trough_idx] = min(trace(2900:3100));
    trough_idx = trough_idx + 2899;
    
    shift_amount = 3001 - trough_idx;
    aligned_matrix2(i, :) = circshift(trace, shift_amount, 2);
end

for i = 1:num_points
    trace = final_matrix3(i, :);
    [~, trough_idx] = min(trace(2900:3100));
    trough_idx = trough_idx + 2899;
    
    shift_amount = 3001 - trough_idx;
    aligned_matrix3(i, :) = circshift(trace, shift_amount, 2);
end

% Compute the mean after alignment
mean_trace1 = mean(aligned_matrix1, 1);
mean_trace2 = mean(aligned_matrix2, 1);
mean_trace3 = mean(aligned_matrix3, 1);

% % Plot the averaged aligned traces
% figure;
% plot(mean_trace1, 'Color', [209/255 233/255 196/255], 'LineWidth', 2); hold on;
% plot(mean_trace2, 'Color', [44/255 210/255 245/255], 'LineWidth', 2);
% plot(mean_trace3, 'Color', [10/255 75/255 141/255], 'LineWidth', 2);
% xlabel('Samples');
% ylabel('Amplitude');
% title('Aligned and Averaged Event Traces');
% legend('Cluster 1', 'Cluster 2', 'Cluster 3');
% grid on;

%%
figure;

% Create a tiled layout for linked subplots
tiledlayout(3, 1); % Three rows, one column

% Define colors for each cluster
colors = {[209/255 233/255 196/255], ...  % Light pastel green (Cluster 1)
          [44/255 210/255 245/255], ...   % Vibrant cyan/aqua (Cluster 2)
          [10/255 75/255 141/255]};       % Deep blue (Cluster 3)

% Plot Cluster 1
ax1 = nexttile;
plot(mean_trace1, 'Color', colors{1}, 'LineWidth', 2);
ylabel('Amplitude');
title('Cluster 1');
grid on;

% Plot Cluster 2
ax2 = nexttile;
plot(mean_trace2, 'Color', colors{2}, 'LineWidth', 2);
ylabel('Amplitude');
title('Cluster 2');
grid on;

% Plot Cluster 3
ax3 = nexttile;
plot(mean_trace3, 'Color', colors{3}, 'LineWidth', 2);
xlabel('Samples');
ylabel('Amplitude');
title('Cluster 3');
grid on;

% Link axes for consistent scaling
linkaxes([ax1, ax2, ax3], 'xy'); % Link both x and y axes
xlim([2800 3200])
%% Examples

figure;

% Create a tiled layout for linked subplots
tiledlayout(3, 1); % Three rows, one column

% Define colors for each cluster
colors = {[209/255 233/255 196/255], ...  % Light pastel green (Cluster 1)
          [44/255 210/255 245/255], ...   % Vibrant cyan/aqua (Cluster 2)
          [10/255 75/255 141/255]};       % Deep blue (Cluster 3)

% Plot Cluster 1
ax1 = nexttile;
plot(aligned_matrix1(752,:), 'Color', colors{1}, 'LineWidth', 2);
ylabel('Amplitude');
title('Cluster 1');
grid on;

% Plot Cluster 2
ax2 = nexttile;
plot(aligned_matrix2(760,:), 'Color', colors{2}, 'LineWidth', 2);
ylabel('Amplitude');
title('Cluster 2');
grid on;

% Plot Cluster 3
ax3 = nexttile;
plot(aligned_matrix3(755,:), 'Color', colors{3}, 'LineWidth', 2);
xlabel('Samples');
ylabel('Amplitude');
title('Cluster 3');
grid on;

% Link axes for consistent scaling
linkaxes([ax1, ax2, ax3], 'xy'); % Link both x and y axes
xlim([2800 3200])