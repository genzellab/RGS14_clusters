% Octave script to extract del_spinwrip counts for clusters C1, C2, C3_SHORT, C3_LONG

all_data_map = containers.Map();  % key: "ratID_studyDay", value: struct with fields per cluster
detected_clusters = {};  % Clusters found in the actual data

% Desired cluster order
desired_cluster_order = {'C1', 'C2', 'C3_SHORT', 'C3_LONG'};

% Get list of rat folders
rat_dirs = dir();
rat_dirs = rat_dirs([rat_dirs.isdir]);
rat_dirs = rat_dirs(~ismember({rat_dirs.name}, {'.', '..'}));

for r = 1:length(rat_dirs)
    rat_folder = rat_dirs(r).name;
    rat_id = str2double(rat_folder);
    if isnan(rat_id)
        continue;
    end

    cd(rat_folder);
    files = dir('Subsampled2000HPC_Cluster_*_del_spinwrip_*.mat');

    for k = 1:length(files)
        fname = files(k).name;

        % Extract study day
        tokens = regexp(fname, 'SD(\d+)', 'tokens');
        if isempty(tokens)
            disp(['⚠️ No SD found in: ' fname]);
            continue;
        end
        sd_num = str2double(tokens{1}{1});

        % Extract full cluster from filename
        clust_match = regexp(fname, 'Cluster_([A-Z0-9_]+)_del', 'tokens');
        if isempty(clust_match)
            disp(['⚠️ No cluster found in: ' fname]);
            continue;
        end
        cluster_raw = clust_match{1}{1};

        % 🔄 Normalize cluster name BEFORE variable name logic
        if strcmp(cluster_raw, 'C1') || startsWith(cluster_raw, 'C1_')
            cluster = 'C1';
        elseif strcmp(cluster_raw, 'C2') || startsWith(cluster_raw, 'C2_')
            cluster = 'C2';
        elseif strcmp(cluster_raw, 'C3_SHORT')
            cluster = 'C3_SHORT';
        elseif strcmp(cluster_raw, 'C3_LONG')
            cluster = 'C3_LONG';
        else
            cluster = cluster_raw;
        end

        % Track seen clusters
        if ~ismember(cluster, detected_clusters)
            detected_clusters{end+1} = cluster;
        end

        disp(['📄 File: ' fname]);
        disp(['   ↳ Cluster: ' cluster ', SD: ' num2str(sd_num)]);

        % Load .mat file
        data = load(fname);

        % ✅ Now build the correct variable name
        cluster_lower = lower(cluster);
        if strcmp(cluster, 'C1') || strcmp(cluster, 'C2')
            varname = 'subsampled_del_spinwrip_count_hpc';
        else
            varname = ['subsampled_del_spinwrip_count_hpc_' cluster_lower];
        end

        if ~isfield(data, varname)
            disp(['❌ Missing variable: ' varname]);
            disp('🧾 Variables in file:');
            disp(fieldnames(data));
            continue;
        end

        spinwrip = data.(varname)(:);
        if iscell(spinwrip)
            spinwrip = cell2mat(spinwrip);
        end

        key = sprintf('%d_%d', rat_id, sd_num);
        if ~isKey(all_data_map, key)
            temp = struct('rat_id', rat_id, 'study_day', sd_num);
            for c = 1:length(detected_clusters)
                temp.(detected_clusters{c}) = NaN(9,1);
            end
            all_data_map(key) = temp;
        end

        % Update entry
        entry = all_data_map(key);
        entry.(cluster) = spinwrip;
        all_data_map(key) = entry;
    end

    cd('..');
end

% Filter desired cluster order by what's actually present
cluster_order = {};
for i = 1:length(desired_cluster_order)
    if ismember(desired_cluster_order{i}, detected_clusters)
        cluster_order{end+1} = desired_cluster_order{i};
    end
end

disp('✅ Clusters in output (ordered):');
disp(cluster_order);

keys = all_data_map.keys;
if isempty(keys)
    warning('⚠️ No data entries were collected. Check if .mat files exist and have expected variables.');
end

% Convert map to matrix
rows = [];
for i = 1:length(keys)
    entry = all_data_map(keys{i});
    for j = 1:9
        row = [entry.rat_id, entry.study_day];
        for c = 1:length(cluster_order)
            val = NaN;
            if isfield(entry, cluster_order{c})
                vec = entry.(cluster_order{c});
                if length(vec) >= j
                    val = vec(j);
                end
            end
            row(end+1) = val;
        end
        rows(end+1, :) = row;
    end
end

% Sort by RatID and StudyDay
if ~isempty(rows) && size(rows, 2) >= 2
    rows = sortrows(rows, [1 2]);
else
    warning('⚠️ No valid rows to sort or fewer than 2 columns.');
end

% Save to CSV
outfile = 'del_spinwrip_summary.csv';
fid = fopen(outfile, 'w');

% Write header
fprintf(fid, 'RatID,StudyDay');
for c = 1:length(cluster_order)
    fprintf(fid, ',Spinwrip_%s', cluster_order{c});
end
fprintf(fid, '\n');
fclose(fid);

% Append data
if ~isempty(rows)
    dlmwrite(outfile, rows, '-append');
    printf('✅ Saved del_spinwrip data with ordered cluster columns to %s\n', outfile);
else
    warning('⚠️ No data to write to file.');
end

