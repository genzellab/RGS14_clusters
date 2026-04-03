%% Pelin Özsezer - 30 March 2026

%% Extract contrast stats values from each figure for normalization and save into same .fig file

% Current folder logic:
% base_dir / condition / cluster / direction / freq_range / *stats_contrast*.fig

clc
clear

base_dir = '';   % parent containing Veh and RGS
conditions = {'Veh', 'RGS'};
clusters = {'c1-2', 'c1-3', 'c2-3'};
directions = {'HPC2PFC', 'PFC2HPC'};
freq_ranges = {'0-20', '100-300'};

for cond_i = 1:length(conditions)
    condition = conditions{cond_i};
    
    for ci = 1:length(clusters)
        cluster = clusters{ci};
        
        for di = 1:length(directions)
            direction = directions{di};
            
            for fi = 1:length(freq_ranges)
                freq_range = freq_ranges{fi};
                
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
                    fprintf('\nProcessing: %s\n', fig_path);
                    
                    try
                        fig_handle = openfig(fig_path, 'invisible');
                        
                        % Find all axes except colorbars/legends
                        ax_all = findall(fig_handle, 'Type', 'Axes');
                        valid_axes = [];
                        
                        for ai = 1:length(ax_all)
                            tag_here = '';
                            try
                                tag_here = ax_all(ai).Tag;
                            catch
                            end
                            
                            if ~strcmpi(tag_here, 'Colorbar') && ~strcmpi(tag_here, 'legend')
                                valid_axes(end+1) = ax_all(ai); %#ok<SAGROW>
                            end
                        end
                        
                        extracted = struct();
                        extracted.file_name = fig_files(fig_idx).name;
                        extracted.full_path = fig_path;
                        extracted.condition = condition;
                        extracted.cluster = cluster;
                        extracted.direction = direction;
                        extracted.freq_range = freq_range;
                        extracted.extraction_time = datestr(now);
                        extracted.contrast_stats = [];
                        extracted.source_object_type = '';
                        extracted.source_axis_index = [];
                        extracted.xdata = [];
                        extracted.ydata = [];
                        extracted.note = '';
                        
                        found_data = false;
                        
                        % Search each axis for plottable objects carrying CData
                        for ai = 1:length(valid_axes)
                            ax = valid_axes(ai);
                            children = allchild(ax);
                            
                            best_obj = [];
                            best_numel = 0;
                            best_cdata = [];
                            best_xdata = [];
                            best_ydata = [];
                            best_type = '';
                            
                            for ch = 1:length(children)
                                obj = children(ch);
                                
                                if isprop(obj, 'CData')
                                    try
                                        cdata = get(obj, 'CData');
                                        
                                        if isnumeric(cdata) && ~isempty(cdata) && numel(cdata) > best_numel
                                            best_obj = obj;
                                            best_numel = numel(cdata);
                                            best_cdata = cdata;
                                            best_type = class(obj);
                                            
                                            if isprop(obj, 'XData')
                                                try
                                                    best_xdata = get(obj, 'XData');
                                                catch
                                                    best_xdata = [];
                                                end
                                            end
                                            
                                            if isprop(obj, 'YData')
                                                try
                                                    best_ydata = get(obj, 'YData');
                                                catch
                                                    best_ydata = [];
                                                end
                                            end
                                        end
                                    catch
                                    end
                                end
                            end
                            
                            if ~isempty(best_obj)
                                extracted.contrast_stats = best_cdata;
                                extracted.source_object_type = best_type;
                                extracted.source_axis_index = ai;
                                extracted.xdata = best_xdata;
                                extracted.ydata = best_ydata;
                                extracted.note = 'Largest numeric CData object extracted from figure axes.';
                                found_data = true;
                                break;
                            end
                        end
                        
                        if found_data
                            % Save inside same FIG file
                            setappdata(fig_handle, 'extracted_contrast_stats', extracted);
                            
                            % Also store in UserData for easier manual inspection
                            current_ud = get(fig_handle, 'UserData');
                            if isempty(current_ud) || ~isstruct(current_ud)
                                current_ud = struct();
                            end
                            current_ud.extracted_contrast_stats = extracted;
                            set(fig_handle, 'UserData', current_ud);
                            
                            savefig(fig_handle, fig_path);
                            fprintf('Extracted stats saved into FIG: %s\n', fig_path);
                            
                            % Optional: also save a .mat next to it for easy loading
                            [~, base_name, ~] = fileparts(fig_path);
                            mat_path = fullfile(folder_path, [base_name, '_extractedContrastStats.mat']);
                            contrast_stats = extracted;
                            save(mat_path, 'contrast_stats');
                            fprintf('Also saved MAT: %s\n', mat_path);
                            
                        else
                            fprintf('No numeric CData found in: %s\n', fig_path);
                        end
                        
                        close(fig_handle);
                        
                    catch ME
                        fprintf('Error processing %s\n', fig_path);
                        fprintf('Reason: %s\n', ME.message);
                    end
                end
            end
        end
    end
end

fprintf('\nDone.\n');