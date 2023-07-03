function [combinedCellArray]=combine_cells(delta_hpc,N)

    combinedCellArray = cell(1, 3);
    for i = 1:N
        for j = 1:3
            if isempty(combinedCellArray{1, j})
                combinedCellArray{1, j} = delta_hpc{i, j};
            else
                combinedCellArray{1, j} = [combinedCellArray{1, j}, delta_hpc{i, j}];
            end
        end
    end

end