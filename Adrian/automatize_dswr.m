% Octave script to extract del_spinwrip counts for C1 and C2 side by side

all_data_map = containers.Map(); % key: "ratID_studyDay", value: struct with fields C1, C2

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

    files = dir('Subsampled2000HPC_Cluster_C*_del_spinwrip_*.mat');

    for k = 1:length(files)
        fname = files(k).name;

        % Extract study day
        tokens = regexp(fname, 'SD(\d+)', 'tokens');
        if isempty(tokens), continue; end
        sd_num = str2double(tokens{1}{1});

        % Extract cluster
        clust_match = regexp(fname, 'Cluster_(C[12])', 'tokens');
        if isempty(clust_match), continue; end
        cluster = clust_match{1}{1}; % 'C1' or 'C2'

        % Load variable
        data = load(fname);
        if ~isfield(data, 'subsampled_del_spinwrip_count_hpc'), continue; end
        spinwrip = data.subsampled_del_spinwrip_count_hpc(:); % column
        if iscell(spinwrip)
           spinwrip = cell2mat(spinwrip);
        end

        key = sprintf('%d_%d', rat_id, sd_num);
        if ~isKey(all_data_map, key)
            all_data_map(key) = struct('rat_id', rat_id, 'study_day', sd_num, 'C1', NaN(9,1), 'C2', NaN(9,1));
        end

        entry = all_data_map(key);
        entry.(cluster) = spinwrip;
        all_data_map(key) = entry;
    end

    cd('..');
end

% Convert map to sorted numeric matrix
keys = all_data_map.keys;
rows = zeros(0, 4);  % Initialize as numeric matrix: [RatID, StudyDay, Spinwrip_C1, Spinwrip_C2]

for i = 1:length(keys)
    entry = all_data_map(keys{i});
    for j = 1:9
        rows(end+1, :) = [entry.rat_id, entry.study_day, entry.C1(j), entry.C2(j)];
    end
end

% Sort by RatID and StudyDay
rows = sortrows(rows, [1 2]);

% Save to CSV
outfile = 'del_spinwrip_summary.csv';
fid = fopen(outfile, 'w');
fprintf(fid, 'RatID,StudyDay,Spinwrip_C1,Spinwrip_C2\n');
fclose(fid);

dlmwrite(outfile, rows, '-append');

printf('✅ Saved del_spinwrip data with C1 and C2 columns to %s\n', outfile);

