% Octave script to process .mat files and save a CSV with header, iterating over rat folders and allowing user to select cluster

% Ask user for cluster
cluster = input('Enter cluster to process (e.g., C1, C2, C3_SHORT, C3_LONG): ', 's');
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

    cd(rat_folder);

    % Use wildcard to match all cluster types and filter manually
    files = dir('Subsampled2000HPC_Cluster_*_CO_*.mat');

    % Filter only those matching the full cluster name
    matching_files = {};
    for i = 1:length(files)
        if ~isempty(strfind(files(i).name, ['Cluster_' cluster '_CO_']))
            matching_files{end+1} = files(i).name;
        end
    end

    if isempty(matching_files)
        warning('No files found for cluster %s in folder %s', cluster, rat_folder);
        cd('..');
        continue;
    end

    for k = 1:length(matching_files)
        fname = matching_files{k};

        % Extract study day number from filename
        tokens = regexp(fname, 'SD(\d+)', 'tokens');
        if isempty(tokens)
            warning([fname ' does not contain SD number. Skipping.']);
            continue;
        end
        sd_num = str2double(tokens{1}{1});

        % Load the .mat file
        data = load(fname);

        % Build variable names based on cluster
        spindle_var = sprintf('CO_count_spindle_%s', cluster_lower);
        ripple_var  = sprintf('CO_count_ripple_%s', cluster_lower);

        if ~isfield(data, spindle_var) || ~isfield(data, ripple_var)
            warning([fname ' does not contain required variables. Skipping.']);
            continue;
        end

        spindle = data.(spindle_var)(:); % make it column vector
        ripple  = data.(ripple_var)(:);  % make it column vector

        % Create columns
        rat_col = repmat(rat_id, size(spindle));
        sd_col  = repmat(sd_num, size(spindle));

        % Combine into one matrix
        combined = [rat_col sd_col spindle ripple];

        % Append
        all_data = [all_data; combined];
    end

    cd('..');
end

% Sort rows by RatID then StudyDay
all_data = sortrows(all_data, [1 2]);  % First by rat, then study day

% Save as CSV with header
outfile = sprintf('spindle_ripple_summary_%s.csv', cluster);
fid = fopen(outfile, 'w');
fprintf(fid, 'RatID,StudyDay,Spindle,Ripple\n');
fclose(fid);
dlmwrite(outfile, all_data, '-append');

printf('✅ Saved combined data with header to %s\n', outfile);

