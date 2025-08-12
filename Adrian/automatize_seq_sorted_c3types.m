% Octave script to process new .mat files (Seq_Subsampled2000HPC_Clus1-3_Long&Short_Seq_...) and save a CSV with header

% Get list of rat folders (assumed to be named as integers)
rat_dirs = dir();
rat_dirs = rat_dirs([rat_dirs.isdir]);
rat_dirs = rat_dirs(~ismember({rat_dirs.name}, {'.', '..'}));

all_data = {}; % to accumulate results
seen_keys = {};
condition_order = {'SWR_Del', 'Del_SWR', 'SWR_Del_CS', 'Del_SWR_CS'};

for r = 1:length(rat_dirs)
    rat_folder = rat_dirs(r).name;
    rat_id = str2double(rat_folder);
    if isnan(rat_id)
        continue;
    end

    cd(rat_folder);

    files = dir('Seq_Subsampled2000HPC_Clus1-3_Long&Short_Seq_*.mat');
    if isempty(files)
        warning('No files found in folder %s', rat_folder);
        cd('..');
        continue;
    end

    for k = 1:length(files)
        fname = files(k).name;
        data = load(fname);

        % Identify variable fields
        var_names = fieldnames(data);
        c1_vars = var_names(endsWith(var_names, 'count_c1'));
        c2_vars = var_names(endsWith(var_names, 'count_c2'));
        c3_short_vars = var_names(endsWith(var_names, 'count_c3_short'));
        c3_long_vars  = var_names(endsWith(var_names, 'count_c3_long'));

        if isempty(c1_vars) || isempty(c2_vars)
            warning([fname ' missing c1 or c2. Skipping.']);
            continue;
        end

        spindle_c1 = data.(c1_vars{1})(:);
        spindle_c2 = data.(c2_vars{1})(:);
        spindle_c3_short = [];
        spindle_c3_long  = [];

        if ~isempty(c3_short_vars)
            spindle_c3_short = data.(c3_short_vars{1})(:);
        else
            spindle_c3_short = zeros(size(spindle_c1));
        end

        if ~isempty(c3_long_vars)
            spindle_c3_long = data.(c3_long_vars{1})(:);
        else
            spindle_c3_long = zeros(size(spindle_c1));
        end

        if iscell(spindle_c1), spindle_c1 = cell2mat(spindle_c1); end
        if iscell(spindle_c2), spindle_c2 = cell2mat(spindle_c2); end
        if iscell(spindle_c3_short), spindle_c3_short = cell2mat(spindle_c3_short); end
        if iscell(spindle_c3_long),  spindle_c3_long  = cell2mat(spindle_c3_long); end

        condition = 'unknown';
        for ci = 1:length(condition_order)
            pattern1 = ['Seq_Subsampled2000HPC_Clus1-3_Long&Short_Seq_' condition_order{ci} '_Rat'];
            pattern2 = ['Seq_Subsampled2000HPC_Clus1-3_Long&Short_Seq_' condition_order{ci} '_OS'];
            if ~isempty(strfind(fname, pattern1)) || ~isempty(strfind(fname, pattern2))
                condition = condition_order{ci};
                break;
            end
        end

        sd_match = regexp(fname, 'SD(\d+)', 'tokens');
        study_day = -1;
        if ~isempty(sd_match)
            study_day = str2double(sd_match{1}{1});
        end

        key = sprintf('%d_%d_%s', rat_id, study_day, condition);
        if ismember(key, seen_keys)
            continue;
        end
        seen_keys{end+1} = key;

        % Assemble data block
        rat_col  = repmat(rat_id, length(spindle_c1), 1);
        sd_col   = repmat(study_day, length(spindle_c1), 1);
        cond_col = repmat({condition}, length(spindle_c1), 1);
        block    = [num2cell(rat_col), num2cell(sd_col), cond_col, ...
                    num2cell(spindle_c1), num2cell(spindle_c2), ...
                    num2cell(spindle_c3_short), num2cell(spindle_c3_long)];
        all_data = [all_data; block];
    end

    cd('..');
end

% Sort results
sorted_data = {};
for c = 1:length(condition_order)
    cond = condition_order{c};
    matches = strcmp(all_data(:,3), cond);
    rows = all_data(matches, :);
    if ~isempty(rows)
        rows = sortrows(rows, [1 2]); % sort by rat, study day
        sorted_data = [sorted_data; rows];
    end
end

% Save to CSV
outfile = 'seq_summary.csv';
fid = fopen(outfile, 'w');
if fid == -1, error('Cannot open %s for writing.', outfile); end

fprintf(fid, 'RatID,StudyDay,Condition,Count_C1,Count_C2,Count_C3_SHORT,Count_C3_LONG\n');
fclose(fid);

fid = fopen(outfile, 'a');
if fid == -1, error('Cannot open %s for appending.', outfile); end

for i = 1:size(sorted_data, 1)
    try
        fprintf(fid, '%d,%d,%s,%f,%f,%f,%f\n', sorted_data{i,1}, sorted_data{i,2}, ...
            sorted_data{i,3}, sorted_data{i,4}, sorted_data{i,5}, ...
            sorted_data{i,6}, sorted_data{i,7});
    catch err
        fprintf('Error writing row %d\n', i);
        disp(sorted_data(i,:));
        rethrow(err);
    end
end

fclose(fid);
printf('✅ Saved sequence summary with extended columns to %s\n', outfile);

