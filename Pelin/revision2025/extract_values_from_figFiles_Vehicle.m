%%% === EXTRACT GRANGER VALUES FROM .FIG FILES AND CONVERT TO .XLSX FILES === %%%

% written by Pelin Özsezer
clc
clear all
close all
format compact
path = '/Users/pelinozsezer/Desktop/GenzelLab/copy_of_paper'; % your main path
cd(path);
rootDir = pwd;

main_folder = '/Users/pelinozsezer/Desktop/GenzelLab/copy_of_paper/Vehicle'; % select the folder you want to process
cd(main_folder);
fprintf('current path is %s\n', main_folder);

% Folder Structure:
%
% Vehicle/                             % Treatment: 'Vehicle'
% ├── clusterX-Y/                      % Cluster comparison (e.g., 'cluster1-2')
% │   ├── HPC2PFC/                     % Directionality: HPC → PFC
% │   │   ├── 0-20/                    % Frequency range
% │   │   │   ├── *.fig                % .fig files live here
% │   │   ├── 20-100/
% │   │   └── 100-300/
% │   ├── PFC2HPC/                     % Directionality: PFC → HPC
% │   │   ├── 0-20/
% │   │   ├── 20-100/
% │   │   └── 100-300/


clustersDiff = {'cluster1-2', 'cluster1-3', 'cluster2-3'};
directions = {'HPC2PFC', 'PFC2HPC'};
freqRanges = {'0-20', '20-100', '100-300'};

for i = 1:length(clustersDiff)
    fprintf('%s\n',clustersDiff{i});

    for j = 1:length(directions)
        fprintf('%s - direction: %s\n', clustersDiff{i}, directions{j});

        for k = 1:length(freqRanges)
            fprintf('%s - direction: %s - freq range: %s\n', clustersDiff{i}, directions{j}, freqRanges{k} );
            currentFolder = fullfile(main_folder, clustersDiff{i}, directions{j}, freqRanges{k});
            cd(currentFolder);

            %% PROCESS
            allFigs = dir(fullfile(currentFolder, '*.fig')); % Get all .fig files, exclude with 'contrast'
            validFigs = allFigs(~contains({allFigs.name}, 'contrast', 'IgnoreCase', true));

            for m = 1:length(validFigs)
                figFile = validFigs(m);
                figPath = fullfile(currentFolder, figFile.name);
                %
                fig = openfig(figPath, 'invisible');
                img = findobj(fig, 'Type', 'image');

                if ~isempty(img)
                    CData = get(img, 'CData');

                    % create XLSX file name from .fig file name
                    baseName = erase(figFile.name, '.fig');
                    sanitizedName = matlab.lang.makeValidName(baseName);
                    xlsxName = fullfile(currentFolder, strcat(baseName, '.xlsx'));

                    % write CData to XLSX
                    writematrix(CData, xlsxName);
                    fprintf('Saved %s to %s\n', baseName, xlsxName);
                end
                close(fig);

            end


        end
    end
end

cd(path);