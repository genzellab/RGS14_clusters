% MATLAB (R2016b+) script to process new .mat files:
%   Seq_Subsampled2000HPC_Clus1-3_Long&Short_Seq_... .mat
% Scans rat folders named as integers and writes seq_summary.csv

% ----------------------------
% Config
% ----------------------------
condition_order = {'SWR_Del','Del_SWR','SWR_Del_CS','Del_SWR_CS'};

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
% Collect rows
% ----------------------------
all_rows = {};   % cell array rows: {RatID, StudyDay, Condition, C1, C2, C3S, C3L}
seen_keys = {};  % dedupe "rat_studyday_condition"

for r = 1:numel(rat_folders)
    rat_folder = rat_folders{r};
    rat_id = str2double(rat_folder);

    files = dir(fullfile(rat_folder, 'Seq_Subsampled2000HPC_Clus1-3_Long&Short_Seq_*.mat'));
    if isempty(files)
        warning('No files found in folder %s', rat_folder);
        continue;
    end

    for k = 1:numel(files)
        fname = files(k).name;
        fpath = fullfile(files(k).folder, fname);

        % Load once
        S = load(fpath);

        % Identify variable fields by suffix
        var_names = fieldnames(S);
        c1_vars       = var_names(endsWith(var_names, 'count_c1'));
        c2_vars       = var_names(endsWith(var_names, 'count_c2'));
        c3_short_vars = var_names(endsWith(var_names, 'count_c3_short'));
        c3_long_vars  = var_names(endsWith(var_names, 'count_c3_long'));

        if isempty(c1_vars) || isempty(c2_vars)
            warning('%s missing c1 or c2. Skipping.', fname);
            continue;
        end

        % Extract columns
        c1 = S.(c1_vars{1})(:);
        c2 = S.(c2_vars{1})(:);
        c3s = []; c3l = [];

        if ~isempty(c3_short_vars), c3s = S.(c3_short_vars{1})(:); else, c3s = zeros(size(c1)); end
        if ~isempty(c3_long_vars),  c3l = S.(c3_long_vars{1})(:);  else, c3l = zeros(size(c1)); end

        if iscell(c1),  c1  = cell2mat(c1); end
        if iscell(c2),  c2  = cell2mat(c2); end
        if iscell(c3s), c3s = cell2mat(c3s); end
        if iscell(c3l), c3l = cell2mat(c3l); end

        % Ensure equal length (truncate to min if mismatched)
        n = min([numel(c1), numel(c2), numel(c3s), numel(c3l)]);
        c1 = c1(1:n); c2 = c2(1:n); c3s = c3s(1:n); c3l = c3l(1:n);

        % Determine condition from filename
        condition = 'unknown';
        for ci = 1:numel(condition_order)
            pat1 = ['Seq_Subsampled2000HPC_Clus1-3_Long&Short_Seq_' condition_order{ci} '_Rat'];
            pat2 = ['Seq_Subsampled2000HPC_Clus1-3_Long&Short_Seq_' condition_order{ci} '_OS'];
            if contains(fname, pat1) || contains(fname, pat2)
                condition = condition_order{ci};
                break;
            end
        end

        % Extract Study Day (SD# if present; else -1)
        sd_num = -1;
        tok = regexp(fname, 'SD(\d+)', 'tokens', 'once');
        if ~isempty(tok)
            sd_num = str2double(tok{1});
        end

        % Dedupe per rat-day-condition
        key = sprintf('%d_%d_%s', rat_id, sd_num, condition);
        if ismember(key, seen_keys)
            continue;
        end
        seen_keys{end+1} = key; %#ok<AGROW>

        % Assemble rows
        all_rows = [all_rows; ...
            num2cell(repmat(rat_id, n, 1)), ...
            num2cell(repmat(sd_num, n, 1)), ...
            repmat({condition}, n, 1), ...
            num2cell(c1), num2cell(c2), num2cell(c3s), num2cell(c3l)]; %#ok<AGROW>
    end
end

% ----------------------------
% Build table and sort
% ----------------------------
if isempty(all_rows)
    warning('No data collected. Nothing to write.');
else
    T = cell2table(all_rows, 'VariableNames', ...
        {'RatID','StudyDay','Condition','Count_C1','Count_C2','Count_C3_SHORT','Count_C3_LONG'});

    % Enforce condition ordering (unknown goes last if present)
    present = intersect(condition_order, unique(T.Condition, 'stable'), 'stable');
    other   = setdiff(unique(T.Condition, 'stable'), present, 'stable');
    T.Condition = categorical(T.Condition, [present, other], 'Ordinal', true);

    % Sort by Condition (in desired order), then RatID, then StudyDay
    T = sortrows(T, {'Condition','RatID','StudyDay'});

    % ----------------------------
    % Write CSV
    % ----------------------------
    outfile = 'seq_summary.csv';
    writetable(T, outfile);
    fprintf('✅ Saved sequence summary with extended columns to %s\n', outfile);
end
