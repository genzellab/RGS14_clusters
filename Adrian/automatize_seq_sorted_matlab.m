% MATLAB-compatible script to process .mat files and save a CSV with header

rat_dirs = dir();
rat_dirs = rat_dirs([rat_dirs.isdir]);
rat_dirs = rat_dirs(~ismember({rat_dirs.name}, {'.', '..'}));

all_data = {};
seen_keys = {};
condition_order = {'SWR_Del', 'Del_SWR', 'SWR_Del_CS', 'Del_SWR_CS'};

for r = 1:length(rat_dirs)
    rat_folder = rat_dirs(r).name;
    rat_id = str2double(rat_folder);
    if isnan(rat_id)
        continue;
    end

    cd(rat_folder);

    files = dir('Seq_Subsampled2000HPCClus1-3_HPC_Seq_*.mat');
    if isempty(files)
        warning('No files found in folder %s', rat_folder);
        cd('..');
        continue;
    end

    for k = 1:length(files)
        fname = files(k).name;
        data = load(fname);

        var_names = fieldnames(data);
        c1_vars = var_names(~cellfun('isempty', regexp(var_names, 'count_c1$')));
        c2_vars = var_names(~cellfun('isempty', regexp(var_names, 'count_c2$')));

        if isempty(c1_vars) || isempty(c2_vars)
            warning([fname ' missing required variables. Skipping.']);
            continue;
        end

        spindle_c1 = data.(c1_vars{1})(:);
        spindle_c2 = data.(c2_vars{1})(:);
        if iscell(spindle_c1), spindle_c1 = cell2mat(spindle_c1); end
        if iscell(spindle_c2), spindle_c2 = cell2mat(spindle_c2); end

        % Match condition using _Rat or _OS
        condition = 'unknown';
        for ci = 1:length(condition_order)
            pattern1 = ['Seq_Subsampled2000HPCClus1-3_HPC_Seq_' condition_order{ci} '_Rat'];
            pattern2 = ['Seq_Subsampled2000HPCClus1-3_HPC_Seq_' condition_order{ci} '_OS'];
            if ~isempty(strfind(fname, pattern1)) || ~isempty(strfind(fname, pattern2))
                condition = condition_order{ci};
                break;
            end
        end

        % Extract study day
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

        rat_col = repmat(rat_id, length(spindle_c1), 1);
        sd_col = repmat(study_day, length(spindle_c1), 1);
        cond_col = repmat({condition}, length(spindle_c1), 1);
        block = [num2cell(rat_col), num2cell(sd_col), cond_col, num2cell(spindle_c1), num2cell(spindle_c2)];
        all_data = [all_data; block];
    end

    cd('..');
end

% Reorder and save
sorted_data = {};
for c = 1:length(condition_order)
    cond = condition_order{c};
    matches = strcmp(all_data(:,3), cond);
    rows = all_data(matches, :);
    if ~isempty(rows)
        rows = sortrows(rows, [1 2]);
        sorted_data = [sorted_data; rows];
    end
end

outfile = 'seq_summary.csv';
fid = fopen(outfile, 'w');
if fid == -1
    error('Cannot open %s for writing.', outfile);
end
fprintf(fid, 'RatID,StudyDay,Condition,Count_C1,Count_C2\n');
fclose(fid);

fid = fopen(outfile, 'a');
if fid == -1
    error('Cannot open %s for appending.', outfile);
end

for i = 1:size(sorted_data, 1)
    try
        fprintf(fid, '%d,%d,%s,%f,%f\n', sorted_data{i,1}, sorted_data{i,2}, sorted_data{i,3}, sorted_data{i,4}, sorted_data{i,5});
    catch err
        fprintf('Error writing row %d\n', i);
        disp(sorted_data(i,:));
        rethrow(err);
    end
end
fclose(fid);

fprintf('✅ Saved sequence summary with header to %s\n', outfile);

