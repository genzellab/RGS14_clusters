% MATLAB script to process .mat files and save a CSV with header, iterating over rat folders and allowing user to select cluster

% Ask user for cluster
cluster = input('Enter cluster to process (e.g., C1, C2): ', 's');
cluster_lower = lower(cluster);

% Get list of rat folders (assumed to be named as integers)
rat_dirs = dir();
rat_dirs = rat_dirs([rat_dirs.isdir]);
rat_dirs = rat_dirs(~ismember({rat_dirs.name}, {'.', '..'}));

all_data = []; % to accumulate results

for r = 1:length(rat_dirs)
    rat_folder = rat_dirs(r).name;
    rat_id = str2double(rat_folder);
    if isnan(rat_id)
        continue; % skip non-numeric folders
    end

    rat_path = fullfile(pwd, rat_folder);
    files = dir(fullfile(rat_path, sprintf('Subsampled2000HPC_Cluster_%s_CO_*.mat', cluster)));

    if isempty(files)
        warning('No files found for cluster %s in folder %s', cluster, rat_folder);
        continue;
    end

    for k = 1:length(files)
        fname = files(k).name;
        full_path = fullfile(rat_path, fname);

        % Extract study day number from filename
        tokens = regexp(fname, 'SD(\d+)', 'tokens');
        if isempty(tokens)
            warning('%s does not contain SD number. Skipping.', fname);
            continue;
        end
        sd_num = str2double(tokens{1}{1});

        % Load the .mat file
        data = load(full_path);

        % Build variable names based on cluster
        spindle_var = sprintf('CO_count_spindle_%s', cluster_lower);
        ripple_var  = sprintf('CO_count_ripple_%s', cluster_lower);

        if ~isfield(data, spindle_var) || ~isfield(data, ripple_var)
            warning('%s does not contain required variables. Skipping.', fname);
            continue;
        end

        spindle = data.(spindle_var)(:); % make it column vector
        ripple  = data.(ripple_var)(:);  % make it column vector

        % Create columns
        rat_col = repmat(rat_id, size(spindle));
        sd_col  = repmat(sd_num, size(spindle));

        % Combine into one matrix
        combined = [rat_col, sd_col, spindle, ripple];

        % Append
        all_data = [all_data; combined];
    end
end

% Sort rows by RatID then StudyDay
all_data = sortrows(all_data, [1 2]);  % First by rat, then study day

% Save as CSV with header
outfile = sprintf('spindle_ripple_summary_%s.csv', cluster);
fid = fopen(outfile, 'w');
if fid == -1
    error('Could not open file %s for writing.', outfile);
end
fprintf(fid, 'RatID,StudyDay,Spindle,Ripple\n');
fclose(fid);

% Append data
dlmwrite(outfile, all_data, '-append');

fprintf('✅ Saved combined data with header to %s\n', outfile);

