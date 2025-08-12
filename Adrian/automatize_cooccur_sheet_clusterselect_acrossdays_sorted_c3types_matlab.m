% MATLAB (R2016b+) script to process .mat files across rat folders and save a CSV
% Expects the working directory to contain rat folders named as integers.

% Ask user for cluster
cluster = input('Enter cluster to process (e.g., C1, C2, C3_SHORT, C3_LONG): ', 's');
cluster_lower = lower(cluster);

% Get list of rat folders (directories named as integers)
d = dir();
isDir = [d.isdir];
names = {d(isDir).name};
names = names(~ismember(names, {'.','..'}));

% Keep only folders whose names are numeric (rats)
rat_folders = {};
for i = 1:numel(names)
    if ~isnan(str2double(names{i}))
        rat_folders{end+1} = names{i}; %#ok<AGROW>
    end
end

all_data = []; % [RatID, StudyDay, Spindle, Ripple]

for r = 1:numel(rat_folders)
    rat_folder = rat_folders{r};
    rat_id = str2double(rat_folder);

    % Find candidate files inside this rat folder
    files = dir(fullfile(rat_folder, 'Subsampled2000HPC_Cluster_*_CO_*.mat'));
    if isempty(files)
        warning('No .mat files found in folder %s', rat_folder);
        continue;
    end

    % Filter only those matching the full cluster name
    matching = {};
    for i = 1:numel(files)
        fname = files(i).name;
        if contains(fname, ['Cluster_' cluster '_CO_'])
            matching{end+1} = fname; %#ok<AGROW>
        end
    end

    if isempty(matching)
        warning('No files found for cluster %s in folder %s', cluster, rat_folder);
        continue;
    end

    for k = 1:numel(matching)
        fname = matching{k};

        % Extract study day number from filename (SD#)
        tok = regexp(fname, 'SD(\d+)', 'tokens', 'once');
        if isempty(tok)
            warning('%s does not contain SD number. Skipping.', fname);
            continue;
        end
        sd_num = str2double(tok{1});

        % Load file
        S = load(fullfile(rat_folder, fname));

        % Variable names based on cluster (lowercase suffix)
        spindle_var = sprintf('CO_count_spindle_%s', cluster_lower);
        ripple_var  = sprintf('CO_count_ripple_%s',  cluster_lower);

        if ~isfield(S, spindle_var) || ~isfield(S, ripple_var)
            warning('%s missing %s and/or %s. Skipping.', fname, spindle_var, ripple_var);
            continue;
        end

        spindle = S.(spindle_var)(:); % column vector
        ripple  = S.(ripple_var)(:);  % column vector

        n = max(numel(spindle), numel(ripple));
        if numel(spindle) ~= numel(ripple)
            warning('%s: spindle/ripple lengths differ; truncating to min length.', fname);
            n = min(numel(spindle), numel(ripple));
            spindle = spindle(1:n);
            ripple  = ripple(1:n);
        end

        rat_col = repmat(rat_id, n, 1);
        sd_col  = repmat(sd_num, n, 1);

        all_data = [all_data; [rat_col, sd_col, spindle, ripple]]; %#ok<AGROW>
    end
end

if isempty(all_data)
    warning('No data aggregated. Nothing to write.');
else
    % Sort by RatID then StudyDay
    all_data = sortrows(all_data, [1 2]);

    % Write CSV with header
    outfile = sprintf('spindle_ripple_summary_%s.csv', cluster);
    T = array2table(all_data, 'VariableNames', {'RatID','StudyDay','Spindle','Ripple'});
    writetable(T, outfile);

    fprintf('✅ Saved combined data with header to %s\n', outfile);
end
