% MATLAB (R2016b+) script to extract del_spinwrip counts for clusters
% C1, C2, C3_SHORT, C3_LONG and save a CSV summary.
% Assumes the working directory contains rat folders named as integers.

% ----------------------------
% Setup
% ----------------------------
all_data_map = containers.Map();  % key: "ratID_studyDay" -> struct with fields per cluster
detected_clusters = {};           % clusters encountered while scanning
desired_cluster_order = {'C1','C2','C3_SHORT','C3_LONG'};

% ----------------------------
% Find rat folders (numeric)
% ----------------------------
d = dir();
isDir = [d.isdir];
names = {d(isDir).name};
names = names(~ismember(names, {'.','..'}));

rat_folders = {};
for i = 1:numel(names)
    if ~isnan(str2double(names{i}))
        rat_folders{end+1} = names{i}; %#ok<AGROW>
    end
end

% ----------------------------
% Scan each rat folder
% ----------------------------
for r = 1:numel(rat_folders)
    rat_folder = rat_folders{r};
    rat_id = str2double(rat_folder);

    % Match files like: Subsampled2000HPC_Cluster_*_del_spinwrip_*.mat
    files = dir(fullfile(rat_folder, 'Subsampled2000HPC_Cluster_*_del_spinwrip_*.mat'));
    if isempty(files)
        continue;
    end

    for k = 1:numel(files)
        fname = files(k).name;
        fpath = fullfile(files(k).folder, fname);

        % Extract Study Day (SD#)
        tokSD = regexp(fname, 'SD(\d+)', 'tokens', 'once');
        if isempty(tokSD)
            fprintf('⚠️ No SD found in: %s\n', fname);
            continue;
        end
        sd_num = str2double(tokSD{1});

        % Extract raw cluster from filename
        tokCl = regexp(fname, 'Cluster_([A-Z0-9_]+)_del', 'tokens', 'once');
        if isempty(tokCl)
            fprintf('⚠️ No cluster found in: %s\n', fname);
            continue;
        end
        cluster_raw = tokCl{1};

        % Normalize cluster (group any C1_* under C1, any C2_* under C2)
        if strcmp(cluster_raw,'C1') || strncmp(cluster_raw,'C1_',3)
            cluster = 'C1';
        elseif strcmp(cluster_raw,'C2') || strncmp(cluster_raw,'C2_',3)
            cluster = 'C2';
        elseif strcmp(cluster_raw,'C3_SHORT')
            cluster = 'C3_SHORT';
        elseif strcmp(cluster_raw,'C3_LONG')
            cluster = 'C3_LONG';
        else
            cluster = cluster_raw; % fallback (will still be handled)
        end

        % Track seen clusters
        if ~ismember(cluster, detected_clusters)
            detected_clusters{end+1} = cluster; %#ok<AGROW>
        end

        fprintf('📄 File: %s\n   ↳ Cluster: %s, SD: %d\n', fname, cluster, sd_num);

        % Load variables
        S = load(fpath);

        % Variable naming rule:
        %   C1, C2 -> 'subsampled_del_spinwrip_count_hpc'
        %   C3_SHORT, C3_LONG -> 'subsampled_del_spinwrip_count_hpc_c3_short/long'
        if strcmp(cluster,'C1') || strcmp(cluster,'C2')
            varname = 'subsampled_del_spinwrip_count_hpc';
        else
            varname = ['subsampled_del_spinwrip_count_hpc_' lower(cluster)];
        end

        if ~isfield(S, varname)
            fprintf('❌ Missing variable: %s in %s\n', varname, fname);
            disp('🧾 Variables in file:');
            disp(fieldnames(S));
            continue;
        end

        spinwrip = S.(varname)(:);
        if iscell(spinwrip)
            spinwrip = cell2mat(spinwrip);
        end

        % Map key per rat & day
        key = sprintf('%d_%d', rat_id, sd_num);

        % Initialize entry if new
        if ~isKey(all_data_map, key)
            entry = struct('rat_id', rat_id, 'study_day', sd_num);
            % Precreate fields for clusters seen so far (others handled later)
            for c = 1:numel(detected_clusters)
                entry.(detected_clusters{c}) = NaN(9,1);
            end
            all_data_map(key) = entry;
        end

        % Ensure this entry has a field for this (possibly newly seen) cluster
        entry = all_data_map(key);
        if ~isfield(entry, cluster)
            entry.(cluster) = NaN(9,1);
        end

        % Update with values
        entry.(cluster) = spinwrip(:);
        all_data_map(key) = entry;
    end
end

% ----------------------------
% Build output cluster order
% ----------------------------
cluster_order = {};
for i = 1:numel(desired_cluster_order)
    if ismember(desired_cluster_order{i}, detected_clusters)
        cluster_order{end+1} = desired_cluster_order{i}; %#ok<AGROW>
    end
end

fprintf('✅ Clusters in output (ordered):\n');
disp(cluster_order);

keysMap = all_data_map.keys;
if isempty(keysMap)
    warning('⚠️ No data entries were collected. Check input files and variables.');
end

% ----------------------------
% Convert map to rows (9 rows per rat/day)
% ----------------------------
rows = [];
for i = 1:numel(keysMap)
    entry = all_data_map(keysMap{i});
    for j = 1:9
        row = [entry.rat_id, entry.study_day];
        for c = 1:numel(cluster_order)
            val = NaN;
            if isfield(entry, cluster_order{c})
                vec = entry.(cluster_order{c});
                if numel(vec) >= j
                    val = vec(j);
                end
            end
            row(end+1) = val; %#ok<AGROW>
        end
        rows(end+1, :) = row; %#ok<AGROW>
    end
end

% Sort by RatID then StudyDay
if ~isempty(rows) && size(rows,2) >= 2
    rows = sortrows(rows, [1 2]);
else
    warning('⚠️ No valid rows to sort or fewer than 2 columns.');
end

% ----------------------------
% Write CSV with header
% ----------------------------
outfile = 'del_spinwrip_summary.csv';

if ~isempty(rows)
    varNames = [{'RatID','StudyDay'}, strcat('Spinwrip_', cluster_order)];
    T = array2table(rows, 'VariableNames', varNames);
    writetable(T, outfile);
    fprintf('✅ Saved del_spinwrip data with ordered cluster columns to %s\n', outfile);
else
    warning('⚠️ No data to write to file.');
end
