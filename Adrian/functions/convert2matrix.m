function [array_10]=convert2matrix(st_duration)

    data_cell=cellfun(@transpose,st_duration,'UniformOutput',false);

    % Find the maximum length of data
%     max_length = max(cellfun(@numel, data_cell));
    max_length=80000;
    % Pad each data cell with NaNs to make them the same length
    padded_data = cellfun(@(x) [x; nan(max_length - numel(x), 1)], data_cell, 'UniformOutput', false);

    % Convert the padded cell array into a numeric array for boxplot
    numeric_data = cell2mat(padded_data');

    array_10 = reshape(numeric_data, length(numeric_data)/10, 10);



end