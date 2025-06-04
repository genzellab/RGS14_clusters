clear variables
clc
close all
% addpath(genpath('F:\OSF\CorticoHippocampal-master\CorticoHippocampal-master'))
%addpath('/Volumes/Samsung_T5/Milan_DA/OS_ephys_da/ADRITOOLS')
% addpath('F:\OSF\chronic')
cd('/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/Trialwise-Cluster data RGS14 Kopal') % Animal folders
rat_folder  =getfolder;
for k = 1:length(rat_folder) % Iterates across animals
cd(rat_folder{k}) 
dinfo = dir;
dinfo = {dinfo.name};
idx = find(cellfun(@(x)contains(x,'trialwise'),dinfo));
trialwise = dinfo(idx);
% trialwise = trialwise(~cellfun(@(x)contains(x,'Cluster3_'),trialwise));
cluster3 = trialwise(cellfun(@(x)contains(x,'_c2'),trialwise));
timestamps = [];
for j = 1:length(cluster3) % Iterates across SDs
timestamps = struct2cell(load(cluster3{j})); % 1*9 cell array of timestamps table
timestamps = timestamps{2};
count_short_ripple = [];
count_long_ripple = []; 
ripple_timestamps_short = [];
ripple_timestamps_long = [];  
    for i  = 1:length(timestamps) % Iterates across trials
        t = timestamps{i};
        if ~isempty(t)
%             if ~isnan(t{1})
            duration = [t{:,4}]-[t{:,2}]; % duration per event in seconds; 2500 is the sampling rate
            duration = duration*1000; % Conversion into miliseconds
            short_ripple = find(duration<=70); %70ms is the threshold
            long_ripple = find(duration>70);
            count_short_ripple{i} = size(short_ripple,2); % counts per trial
            count_long_ripple{i} = size(long_ripple,2);
            ripple_timestamps_short{i} = t(short_ripple,:); % timestamps per trial 
            ripple_timestamps_long{i} = t(long_ripple,:);  
            clear duration
%             else
%             count_short_ripple{i} = 0;
%             count_long_ripple{i} = 0; 
%             ripple_timestamps_short{i} = NaN;
%             ripple_timestamps_long{i} = NaN;       
%             end
        else
        count_short_ripple{i} = 0;
        count_long_ripple{i} = 0; 
        ripple_timestamps_short{i} = [];
        ripple_timestamps_long{i} = [];    
        end
    end
    % Saving the counts and the timestamps
       save(strcat('Cluster2_Long_Short_Ripple_',cluster3{j},'.mat'),'count_short_ripple','count_long_ripple','ripple_timestamps_short','ripple_timestamps_long')
end
cd .. 
end