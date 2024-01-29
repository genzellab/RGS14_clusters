%% Load previously computed data
clear variables
addpath(genpath('/home/adrian/Documents/GitHub/RGS14_clusters/Adrian'))
% cd('/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/RGSfiles_ForAdrian')
cd('/home/adrian/Documents/GitHub/RGS14_clusters/Adrian')
load('veh_data_hmm_c3split_with_trials.mat')
%% Select condition(s) and rat(s).
ConditionField=[ {'OD' } %Object space Conditions.
     {'CON'}
     {'HC' } 
     {'OR' }];
RatField=    [ {'Rat1' } %Only Vehicle rats from RGS14 dataset.
    {'Rat2' }
    {'Rat6'}
    {'Rat9' }];
        
Trialname=[{'PS'};{'PT1'};{'PT2'};{'PT3'};{'PT4'};{'PT5_1'};{'PT5_2'};{'PT5_3'};{'PT5_4'}];

for j=1:numel(ConditionField)
    for k=1:numel(RatField)
        for l=1:numel(Trialname)
            
bout_ripple_c1=extractSpecificData_with_trials(Day_Bout_ripple_c1,ConditionField(j),RatField(k) ,Trialname(l),fn);
bout_ripple_c2=extractSpecificData_with_trials(Day_Bout_ripple_c2,ConditionField(j),RatField(k),Trialname(l),fn);
bout_ripple_c3Short=extractSpecificData_with_trials(Day_Bout_ripple_c3Short,ConditionField(j),RatField(k),Trialname(l),fn);
bout_ripple_c3Long=extractSpecificData_with_trials(Day_Bout_ripple_c3Long,ConditionField(j),RatField(k),Trialname(l),fn);
bout_spindle=extractSpecificData_with_trials(Day_Bout_spindle,ConditionField(j),RatField(k),Trialname(l),fn);
bout_spindles_hpc=extractSpecificData_with_trials(Day_Bout_spindles_hpc,ConditionField(j),RatField(k),Trialname(l),fn);
bout_delta=extractSpecificData_with_trials(Day_Bout_delta,ConditionField(j),RatField(k),Trialname(l),fn);
[bout_delta_hpc,length_concatenatedData]=extractSpecificData_with_trials(Day_Bout_delta_hpc,ConditionField(j),RatField(k),Trialname(l),fn);

pbout_ripple_c1=extractSpecificData_with_trials(Day_Pbout_ripple_c1,ConditionField(j),RatField(k),Trialname(l),fn);
pbout_ripple_c2=extractSpecificData_with_trials(Day_Pbout_ripple_c2,ConditionField(j),RatField(k),Trialname(l),fn);
pbout_ripple_c3Short=extractSpecificData_with_trials(Day_Pbout_ripple_c3Short,ConditionField(j),RatField(k),Trialname(l),fn);
pbout_ripple_c3Long=extractSpecificData_with_trials(Day_Pbout_ripple_c3Long,ConditionField(j),RatField(k),Trialname(l),fn);
pbout_spindle=extractSpecificData_with_trials(Day_Pbout_spindle,ConditionField(j),RatField(k),Trialname(l),fn);
pbout_spindles_hpc=extractSpecificData_with_trials(Day_Pbout_spindles_hpc,ConditionField(j),RatField(k),Trialname(l),fn);
pbout_delta=extractSpecificData_with_trials(Day_Pbout_delta,ConditionField(j),RatField(k),Trialname(l),fn);
pbout_delta_hpc=extractSpecificData_with_trials(Day_Pbout_delta_hpc,ConditionField(j),RatField(k),Trialname(l),fn);


win_train=[zeros(1,1) length_concatenatedData]/fn; %Should be in seconds
[num2str(length_concatenatedData/fn/60/60) ' hours'] 

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
xo
        end
    end
end

%cd(    '/home/adrian/Documents/GitHub/RGS14_clusters/Adrian/mazzucato_scripts')
