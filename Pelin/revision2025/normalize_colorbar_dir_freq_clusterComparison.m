%% find min and max colorbar values for each direction and each freq range across clusters
% !! ONLY stats_contrast plots

direction = 'pfc2hpc';       % 'hpc2pfc' or 'pfc2hpc'
freq_range = '0-20';         % '0-20', '20-100', '100-300'
base_dir = '/Users/pelinozsezer/Desktop/Others/granger_cluster_veh-rgs';
clusters = {'c1', 'c2', 'c3'};

global_min = inf;
global_max = -inf;

for ci = 1:length(clusters)
    folder_path = fullfile(base_dir, clusters{ci}, direction, freq_range);
    fig_files = dir(fullfile(folder_path, '*stats_contrast*.fig'));
    
    for fig_idx = 1:length(fig_files)
        fig_path = fullfile(folder_path, fig_files(fig_idx).name);
        fig_handle = openfig(fig_path, 'invisible');

        cb = findall(fig_handle, 'Type', 'Colorbar');
        if ~isempty(cb)
            cmin = cb.Limits(1);
            cmax = cb.Limits(2);

            global_min = min(global_min, cmin);
            global_max = max(global_max, cmax);
        else
            fprintf('no colorbar in: %s\n', fig_path);
        end
        
        close(fig_handle);
    end
end

fprintf('\nGLOBAL COLORBAR LIMITS for %s / %s\n', direction, freq_range);
fprintf('Minimum: %.4f\n', global_min);
fprintf('Maximum: %.4f\n', global_max);



%% adjust colorbar in the actual plots now and also save as PDF 

for ci = 1:length(clusters)
    folder_path = fullfile(base_dir, clusters{ci}, direction, freq_range);
    
    fig_files = dir(fullfile(folder_path, '*stats_contrast*.fig'));
    
    for fig_idx = 1:length(fig_files)
        fig_path = fullfile(folder_path, fig_files(fig_idx).name);
        fig_handle = openfig(fig_path, 'invisible');

        cb = findall(fig_handle, 'Type', 'Colorbar');
        if ~isempty(cb)
            cb.Limits = [global_min, global_max];
        else
            fprintf('No colorbar in %s\n', fig_path);
            close(fig_handle);
            continue;
        end

        % updated .fig (overwrite)
        savefig(fig_handle, fig_path);
        
        % PDF with the same name
        [~, base_name, ~] = fileparts(fig_path);
        pdf_path = fullfile(folder_path, [base_name, '.pdf']);
        set(fig_handle, 'PaperPositionMode', 'auto');
        print(fig_handle, '-dpdf', '-bestfit', pdf_path);
        
        fprintf('Updated and exported: %s\n', pdf_path);
        close(fig_handle);
    end
end

