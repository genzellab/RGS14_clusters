%% Pelin Özsezer - 30 March 2026

%% Normalize colorbars across conditions and cluster diffs
% BUT keep directions separate
% ONLY stats_contrast plots

clc
clear

base_dir = '';   % parent folder containing Veh and RGS
conditions = {'Veh', 'RGS'};
clusters = {'c1-2', 'c1-3', 'c2-3'};
directions = {'HPC2PFC', 'PFC2HPC'};
freq_ranges = {'0-20', '100-300'};

for di = 1:length(directions)
    direction = directions{di};
    
    for fi = 1:length(freq_ranges)
        freq_range = freq_ranges{fi};
        
        global_min = inf;
        global_max = -inf;
        
        fprintf('\n====================================================\n');
        fprintf('Processing direction: %s | freq range: %s\n', direction, freq_range);
        fprintf('Normalizing across Veh + RGS and all cluster diffs\n');
        fprintf('====================================================\n');
        
        %% STEP 1: Find global min/max across conditions and cluster diffs
        for cond_i = 1:length(conditions)
            condition = conditions{cond_i};
            
            for ci = 1:length(clusters)
                cluster = clusters{ci};
                folder_path = fullfile(base_dir, condition, cluster, direction, freq_range);
                
                if ~exist(folder_path, 'dir')
                    fprintf('Folder not found: %s\n', folder_path);
                    continue;
                end
                
                fig_files = dir(fullfile(folder_path, '*stats_contrast*.fig'));
                
                if isempty(fig_files)
                    fprintf('No stats_contrast fig files in: %s\n', folder_path);
                    continue;
                end
                
                for fig_idx = 1:length(fig_files)
                    fig_path = fullfile(folder_path, fig_files(fig_idx).name);
                    
                    try
                        fig_handle = openfig(fig_path, 'invisible');
                        
                        cb = findall(fig_handle, 'Type', 'Colorbar');
                        if ~isempty(cb)
                            cmin = cb(1).Limits(1);
                            cmax = cb(1).Limits(2);
                            
                            global_min = min(global_min, cmin);
                            global_max = max(global_max, cmax);
                        else
                            fprintf('No colorbar in: %s\n', fig_path);
                        end
                        
                        close(fig_handle);
                        
                    catch ME
                        fprintf('Error reading file: %s\n', fig_path);
                        fprintf('Reason: %s\n', ME.message);
                    end
                end
            end
        end
        
        %% Report global limits
        if isinf(global_min) || isinf(global_max)
            fprintf('No valid colorbar limits found for %s / %s\n', direction, freq_range);
            continue;
        end
        
        fprintf('\nGLOBAL COLORBAR LIMITS for %s / %s\n', direction, freq_range);
        fprintf('Minimum: %.4f\n', global_min);
        fprintf('Maximum: %.4f\n', global_max);
        
        %% STEP 2: Apply same limits to all matching figures and export PDF
        for cond_i = 1:length(conditions)
            condition = conditions{cond_i};
            
            for ci = 1:length(clusters)
                cluster = clusters{ci};
                folder_path = fullfile(base_dir, condition, cluster, direction, freq_range);
                
                if ~exist(folder_path, 'dir')
                    continue;
                end
                
                fig_files = dir(fullfile(folder_path, '*stats_contrast*.fig'));
                
                for fig_idx = 1:length(fig_files)
                    fig_path = fullfile(folder_path, fig_files(fig_idx).name);
                    
                    try
                        fig_handle = openfig(fig_path, 'invisible');
                        
                        % Set colorbar limits
                        cb = findall(fig_handle, 'Type', 'Colorbar');
                        if ~isempty(cb)
                            cb(1).Limits = [global_min, global_max];
                        else
                            fprintf('No colorbar in: %s\n', fig_path);
                            close(fig_handle);
                            continue;
                        end
                        
                        % Set axes CLim too
                        ax = findall(fig_handle, 'Type', 'Axes');
                        for ai = 1:length(ax)
                            try
                                ax(ai).CLim = [global_min, global_max];
                            catch
                                % skip axes that do not support CLim
                            end
                        end
                        
                        % Overwrite .fig
                        savefig(fig_handle, fig_path);
                        
                        % Export PDF
                        [~, base_name, ~] = fileparts(fig_path);
                        pdf_path = fullfile(folder_path, [base_name, '.pdf']);
                        set(fig_handle, 'PaperPositionMode', 'auto');
                        print(fig_handle, '-dpdf', '-bestfit', pdf_path);
                        
                        fprintf('Updated and exported: %s\n', pdf_path);
                        close(fig_handle);
                        
                    catch ME
                        fprintf('Error updating file: %s\n', fig_path);
                        fprintf('Reason: %s\n', ME.message);
                    end
                end
            end
        end
    end
end

fprintf('\nAll done.\n');