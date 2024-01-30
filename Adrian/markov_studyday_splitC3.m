%% Load previously computed data
clear variables
addpath(genpath('/home/adrian/Documents/GitHub/RGS14_clusters/Adrian'))
% cd('/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/RGSfiles_ForAdrian')
cd('/home/adrian/Documents/GitHub/RGS14_clusters/Adrian')
load('veh_data_hmm_c3split.mat')
%% Select condition(s) and rat(s).
ConditionField=[ {'OD' }]; %Object space Conditions.
%     {'CON'}
%     {'HC' } 
%     {'OR' }];
%ConditionField=[ {'OD' } ];
% RatField=[ {'Rat1' } ];
        RatField=    [ {'Rat1' } %Only Vehicle rats from RGS14 dataset.
            {'Rat2' }
            {'Rat6'}
            {'Rat9' }];
bout_ripple_c1=extractSpecificData(Day_Bout_ripple_c1,ConditionField,RatField ,fn);
bout_ripple_c2=extractSpecificData(Day_Bout_ripple_c2,ConditionField,RatField,fn);
bout_ripple_c3Short=extractSpecificData(Day_Bout_ripple_c3Short,ConditionField,RatField,fn);
bout_ripple_c3Long=extractSpecificData(Day_Bout_ripple_c3Long,ConditionField,RatField,fn);

bout_spindle=extractSpecificData(Day_Bout_spindle,ConditionField,RatField,fn);
bout_spindles_hpc=extractSpecificData(Day_Bout_spindles_hpc,ConditionField,RatField,fn);
bout_delta=extractSpecificData(Day_Bout_delta,ConditionField,RatField,fn);
[bout_delta_hpc,length_concatenatedData]=extractSpecificData(Day_Bout_delta_hpc,ConditionField,RatField,fn);

pbout_ripple_c1=extractSpecificData(Day_Pbout_ripple_c1,ConditionField,RatField,fn);
pbout_ripple_c2=extractSpecificData(Day_Pbout_ripple_c2,ConditionField,RatField,fn);
pbout_ripple_c3Short=extractSpecificData(Day_Pbout_ripple_c3Short,ConditionField,RatField,fn);
pbout_ripple_c3Long=extractSpecificData(Day_Pbout_ripple_c3Long,ConditionField,RatField,fn);

pbout_spindle=extractSpecificData(Day_Pbout_spindle,ConditionField,RatField,fn);
pbout_spindles_hpc=extractSpecificData(Day_Pbout_spindles_hpc,ConditionField,RatField,fn);
pbout_delta=extractSpecificData(Day_Pbout_delta,ConditionField,RatField,fn);
pbout_delta_hpc=extractSpecificData(Day_Pbout_delta_hpc,ConditionField,RatField,fn);


win_train=[zeros(1,1) length_concatenatedData]/fn; %Should be in seconds
[num2str(length_concatenatedData/fn/60/60) ' hours'] 

%%

% bout_ind=3;
% 
% T=[bout_ripple{bout_ind}
% bout_spindle{bout_ind}
% bout_spindles_hpc{bout_ind}
% bout_delta{bout_ind}
% bout_delta_hpc{bout_ind}];

%%
%xo

% stem([0:length(bout_delta{bout_ind})-1]/fn,bout_delta{bout_ind}*5)
% hold on
% stem([0:length(bout_delta_hpc{bout_ind})-1]/fn,bout_delta_hpc{bout_ind}*4)
% stem([0:length(bout_spindle{bout_ind})-1]/fn,bout_spindle{bout_ind}*3)
% 
% stem([0:length(bout_spindles_hpc{bout_ind})-1]/fn,bout_spindles_hpc{bout_ind}*2)
% stem([0:length(bout_ripple{bout_ind})-1]/fn,bout_ripple{bout_ind})
% 
% xlabel('Time (sec)')
% title('Example NonREM bout with 5 events')
%%

%% Convert to spikes
% spikes is a struct array with dimension [ntrials,nunits] and field .spk containing spike times
% we will change it to [nbouts, nevents] = [nbouts, 5]
% in this example [4,5]


% N = length(nrem_end); % Number of rows
N=1;
M = 8; % Number of columns
clear spikes spikes_peak
spikes = struct('spk', cell(N, M));
spikes_peak=struct('spk', cell(N, M));

for i = 1:N % bouts
%    for j = 1:M % events
        spikes(i, 1).spk = bout_ripple_c1.'; 
        spikes(i, 2).spk = bout_ripple_c2.'; 
        spikes(i, 3).spk = bout_ripple_c3Short.';
        spikes(i, 4).spk = bout_ripple_c3Long.';
        spikes(i, 5).spk = bout_spindles_hpc.';
        spikes(i, 6).spk = bout_spindle.'; 
        spikes(i, 7).spk = bout_delta_hpc.';
        spikes(i, 8).spk = bout_delta.'; 

        spikes_peak(i, 1).spk = pbout_ripple_c1.'; 
        spikes_peak(i, 2).spk = pbout_ripple_c2.'; 
        spikes_peak(i, 3).spk = pbout_ripple_c3Short.'; 
        spikes_peak(i, 4).spk = pbout_ripple_c3Long.';
        spikes_peak(i, 5).spk = pbout_spindles_hpc.';
        spikes_peak(i, 6).spk = pbout_spindle.'; 
        spikes_peak(i, 7).spk = pbout_delta_hpc.';
        spikes_peak(i, 8).spk = pbout_delta.'; 

%    end
end

cd(    '/home/adrian/Documents/GitHub/RGS14_clusters/Adrian/mazzucato_scripts')
% Now run demo2_HMM_Simple.m