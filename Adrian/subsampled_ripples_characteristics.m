cd(    '/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/wetransfer_pelin-folder-from-malaga-second-attempt_2025-04-09_0406/Pelin')
load('GC_raw_veh_subsampled.mat')
%%
% Initialize cell arrays
C1_events = cell(1500, 1);
C2_events = cell(1500, 1);
C3_events = cell(1500, 1);

% Sampling parameters
Fs = 1000;         % Hz
peak_sample = 3001;

% Loop over all 4500 events
for i = 1:4500
    % Extract signal trace
    trace = GC_bandpassed_veh_subsampled{i, 1}(2, :);
    
    % Get timestamps (in seconds)
    t_start = GC_bandpassed_veh_subsampled{i, 2};
    t_peak  = GC_bandpassed_veh_subsampled{i, 3};
    t_end   = GC_bandpassed_veh_subsampled{i, 4};
    
    % Convert timestamps to sample offsets relative to peak
    start_offset = round((t_start - t_peak) * Fs);
    end_offset   = round((t_end - t_peak) * Fs);
    
    % Convert to absolute sample indices
    start_idx = peak_sample + start_offset;
    end_idx   = peak_sample + end_offset;
    
    % Ensure indices are within bounds
    start_idx = max(1, start_idx);
    end_idx   = min(6001, end_idx);
    
    % Extract the event trace
    event_trace = trace(start_idx:end_idx);
    
    % Save in appropriate group
    if i <= 1500
        C1_events{i} = event_trace;
    elseif i <= 3000
        C2_events{i - 1500} = event_trace;
    else
        C3_events{i - 3000} = event_trace;
    end
end
%%
cd('/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/wetransfer_pelin-folder-from-malaga-second-attempt_2025-04-09_0406/Pelin/functions/')
timeasleep=0;
print_hist=1;
fs=1000;

[x,y,z,w,h,q,l,p,si_mixed,th,PCA_features_C1]=delta_specs(C1_events,timeasleep,print_hist,fs); % Vehicle
[x,y,z,w,h,q,l,p,si_mixed,th,PCA_features_C2]=delta_specs(C2_events,timeasleep,print_hist,fs); % Vehicle
[x,y,z,w,h,q,l,p,si_mixed,th,PCA_features_C3]=delta_specs(C3_events,timeasleep,print_hist,fs); % Vehicle

PCA_features_C1=PCA_features_C1(:,2:end);
PCA_features_C2=PCA_features_C2(:,2:end);
PCA_features_C3=PCA_features_C3(:,2:end);
%% Convert duration to ms
PCA_features_C1(:,4)=PCA_features_C1(:,4)*1000;
PCA_features_C2(:,4)=PCA_features_C2(:,4)*1000;
PCA_features_C3(:,4)=PCA_features_C3(:,4)*1000;
%%
% Define feature names
feature_names = { ...
    'Average_Frequency', 'Amplitude', 'Area_Under_Curve', ...
    'Duration', 'Peak_to_Peak_Distance', 'Power', 'Entropy', 'Number_of_Peaks'};

% Convert each matrix to a table and add a group label
T_C1 = array2table(PCA_features_C1, 'VariableNames', feature_names);
T_C1.Group = repmat("C1", height(T_C1), 1);

T_C2 = array2table(PCA_features_C2, 'VariableNames', feature_names);
T_C2.Group = repmat("C2", height(T_C2), 1);

T_C3 = array2table(PCA_features_C3, 'VariableNames', feature_names);
T_C3.Group = repmat("C3", height(T_C3), 1);

% Combine all tables
T_all = [T_C1; T_C2; T_C3];

% Move 'Group' to the first column
T_all = movevars(T_all, 'Group', 'Before', 1);

% Write to Excel
writetable(T_all, 'PCA_features_export.xlsx');
%%
% Combine data
all_data = [PCA_features_C1(:, 1); PCA_features_C2(:, 1); PCA_features_C3(:, 1)];
group = [repmat({'C1'}, 1500, 1); repmat({'C2'}, 1500, 1); repmat({'C3'}, 1500, 1)];

% Boxplot
figure;
boxplot(all_data, group);
xlabel('Group');
ylabel('Average Frequency');
title('Average Frequency Comparison (Boxplot)');
%%
addpath('/home/adrian/Downloads/violin')
figure;
violin2(all_data, group);
xlabel('Group');
ylabel('Average Frequency');
title('Average Frequency Comparison (Violin Plot)');
%%
% Combine the first column (Average Frequency) from all 3 groups
all_data = [PCA_features_C1(:, 1); PCA_features_C2(:, 1); PCA_features_C3(:, 1)];

% Create a grouping variable (must be categorical or string array)
group = [repmat("C1", 1500, 1); repmat("C2", 1500, 1); repmat("C3", 1500, 1)];

% Plot using violinplot (make sure you have this function installed)
figure;
violin2(all_data, group);

xlabel('Group');
ylabel('Average Frequency');
title('Average Frequency Comparison (Violin Plot)');
%%
% Combine data from all 3 groups
all_data = [PCA_features_C1(:,1); PCA_features_C2(:,1); PCA_features_C3(:,1)];

% Numeric group IDs: 1 for C1, 2 for C2, 3 for C3
group_ids = [ones(1500,1); 2*ones(1500,1); 3*ones(1500,1)];

% Plot violin plot using numeric groups
figure;
violin2(all_data, group_ids);

xticklabels({'C1', 'C2', 'C3'});
xlabel('Group');
ylabel('Average Frequency');
title('Average Frequency Comparison (Violin Plot)');
%%
% Extract data from each group (1st column = Average Frequency)
C1 = PCA_features_C1(:,1);
C2 = PCA_features_C2(:,1);
C3 = PCA_features_C3(:,1);

% Format as a 1x3 cell array (as expected by this violin function)
Y = {C1, C2, C3};

% Plot violin
figure;
violin2(Y, 'xlabel', {'C1', 'C2', 'C3'}, ...
           'facecolor', [0.8 0.3 0.3; 0.3 0.8 0.3; 0.3 0.3 0.8], ...
           'edgecolor', 'k', ...
           'mc', 'k', ...
           'medc', 'r');

ylabel('Average Frequency (Hz)');
title('Violin Plot of Average Frequency (C1, C2, C3)');

%%
%%
% Extract data from each group (1st column = Average Frequency)
C1 = PCA_features_C1(:,2);
C2 = PCA_features_C2(:,2);
C3 = PCA_features_C3(:,2);

% Format as a 1x3 cell array (as expected by this violin function)
Y = {C1, C2, C3};

% Plot violin
figure;
violin2(Y, 'xlabel', {'C1', 'C2', 'C3'}, ...
           'facecolor', [0.8 0.3 0.3; 0.3 0.8 0.3; 0.3 0.3 0.8], ...
           'edgecolor', 'k', ...
           'mc', 'k', ...
           'medc', 'r');

ylabel('Amplitude (uV)');
title('Violin Plot of Amplitude (C1, C2, C3)');
%%
% Extract data from each group (1st column = Average Frequency)
C1 = PCA_features_C1(:,4);
C2 = PCA_features_C2(:,4);
C3 = PCA_features_C3(:,4);

% Format as a 1x3 cell array (as expected by this violin function)
Y = {C1, C2, C3};

% Plot violin
figure;
violin2(Y, 'xlabel', {'C1', 'C2', 'C3'}, ...
           'facecolor', [0.8 0.3 0.3; 0.3 0.8 0.3; 0.3 0.3 0.8], ...
           'edgecolor', 'k', ...
           'mc', 'k', ...
           'medc', 'r');

ylabel('Duration (ms)');
title('Violin Plot of Duration (C1, C2, C3)');

