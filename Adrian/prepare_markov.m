addingpath()
clear variables 
fn=1000; % Sampling rate
cd('/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/RGSfiles_ForAdrian/RGS_event_timestamps/1/Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018')
load('2018-07-26_11-58-33_Post-Trial2-states.mat')
cd ..

% load('ripple_timestamps_Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018.mat')
load('Cluster_ripple_timestamps_Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018.mat');


j=3; % Post trial index

ripple_c1=ripple_timestamps_c1{j};
ripple_c2=ripple_timestamps_c2{j};
ripple_c3=ripple_timestamps_c3{j};

% ripple=ripple_timestamps{j};


load('spindles_timestamps_Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018.mat')
spindles=spindles_bout_specific_timestamps{j};
spindles_hpc=spindles_bout_specific_timestamps_hpc{j};

load('delta_timestamps_Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018.mat')
delta=delta_bst_total_data{j};

load('delta_hpc_timestamps_Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018.mat')
delta_hpc=delta_bst_total_data_hpc{j};



% load('delta_timestamps_Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018.mat')
% delta=delta_timestamps_SD{3};
% delta=delta(:,1:4);

%Find start and end of NREM bouts
nrem=ConsecutiveOnes(states==3);
nrem_start=find(nrem);
nrem_end=nrem_start+(nrem(nrem~=0))-1;

for i=1:length(nrem_end) %Iterate nrem bouts
%Start-End bouts    
bout_time=nrem_start(i):1/fn:nrem_end(i);
bout_ripple_c1{i}=zeros(size(bout_time));
bout_ripple_c2{i}=zeros(size(bout_time));
bout_ripple_c3{i}=zeros(size(bout_time));
bout_spindle{i}=zeros(size(bout_time));
bout_delta{i}=zeros(size(bout_time));
bout_spindles_hpc{i}=zeros(size(bout_time));
bout_delta_hpc{i}=zeros(size(bout_time));
%Peak bouts
pbout_time=nrem_start(i):1/fn:nrem_end(i);
pbout_ripple_c1{i}=zeros(size(bout_time));
pbout_ripple_c2{i}=zeros(size(bout_time));
pbout_ripple_c3{i}=zeros(size(bout_time));
pbout_spindle{i}=zeros(size(bout_time));
pbout_delta{i}=zeros(size(bout_time));
pbout_spindles_hpc{i}=zeros(size(bout_time));
pbout_delta_hpc{i}=zeros(size(bout_time));


% 
% ripple_start=ripple{i,1};
% ripple_end=ripple{i,2};

ripple_c1_start=ripple_c1{i,1};
ripple_c1_end=ripple_c1{i,3};
ripple_c2_start=ripple_c2{i,1};
ripple_c2_end=ripple_c2{i,3};
ripple_c3_start=ripple_c3{i,1};
ripple_c3_end=ripple_c3{i,3};
spindles_start=spindles{i,1};
spindles_end=spindles{i,2};
spindles_hpc_start=spindles_hpc{i,1};
spindles_hpc_end=spindles_hpc{i,2};
delta_start=delta{i,1};
delta_end=delta{i,2};
delta_hpc_start=delta_hpc{i,1};
delta_hpc_end=delta_hpc{i,2};



[bout_ripple_c1]=get_ticks(bout_time,bout_ripple_c1,ripple_c1_start, ripple_c1_end,i,fn);
[bout_ripple_c2]=get_ticks(bout_time,bout_ripple_c2,ripple_c2_start, ripple_c2_end,i,fn);
[bout_ripple_c3]=get_ticks(bout_time,bout_ripple_c3,ripple_c3_start, ripple_c3_end,i,fn);
[bout_spindle]=get_ticks(bout_time,bout_spindle,spindles_start, spindles_end,i,fn);
[bout_spindles_hpc]=get_ticks(bout_time,bout_spindles_hpc,spindles_hpc_start, spindles_hpc_end,i,fn);
[bout_delta]=get_ticks(bout_time,bout_delta,delta_start, delta_end,i,fn);
[bout_delta_hpc]=get_ticks(bout_time,bout_delta_hpc,delta_hpc_start, delta_hpc_end,i,fn);

%Get peak
ripple_c1_peak=ripple_c1{i,2};
ripple_c2_peak=ripple_c2{i,2};
ripple_c3_peak=ripple_c3{i,2};
spindles_peak=spindles{i,3};
spindles_hpc_peak=spindles_hpc{i,3};
delta_peak=delta{i,3};
delta_hpc_peak=delta_hpc{i,3};

[pbout_ripple_c1]=get_ticks_peak(bout_time,pbout_ripple_c1,ripple_c1_peak,i,fn);
[pbout_ripple_c2]=get_ticks_peak(bout_time,pbout_ripple_c2,ripple_c2_peak,i,fn);
[pbout_ripple_c3]=get_ticks_peak(bout_time,pbout_ripple_c3,ripple_c3_peak,i,fn);
[pbout_spindle]=get_ticks_peak(bout_time,pbout_spindle,spindles_peak,i,fn);
[pbout_spindles_hpc]=get_ticks_peak(bout_time,pbout_spindles_hpc,spindles_hpc_peak,i,fn);
[pbout_delta]=get_ticks_peak(bout_time,pbout_delta,delta_peak,i,fn);
[pbout_delta_hpc]=get_ticks_peak(bout_time,pbout_delta_hpc,delta_hpc_peak,i,fn);

end
xo

%Outputs:
% bout_ripple_c1
% bout_ripple_c2
% bout_ripple_c3
% bout_spindle
% bout_spindles_hpc
% bout_delta
% bout_delta_hpc
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
bout_ind=1;

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
bout_ind=3;
figure()
stem(bout_delta{bout_ind},bout_delta{bout_ind}*0+7)
hold on
stem(bout_delta_hpc{bout_ind},bout_delta_hpc{bout_ind}*0+6)
stem(bout_spindle{bout_ind},bout_spindle{bout_ind}*0+5)
stem(bout_spindles_hpc{bout_ind},bout_spindles_hpc{bout_ind}*0+4)
stem(bout_ripple_c3{bout_ind},bout_ripple_c3{bout_ind}*0+3)
stem(bout_ripple_c2{bout_ind},bout_ripple_c2{bout_ind}*0+2)
stem(bout_ripple_c1{bout_ind},bout_ripple_c1{bout_ind}*0+1)
xlabel('Time (sec)')
title('Example NonREM bout with 7 events')
legend('Dc','Dh','Sc','Sh', 'R C3','R C2','R C1')
%% peaks only
figure()
stem(pbout_delta{bout_ind},pbout_delta{bout_ind}*0+7)
hold on
stem(pbout_delta_hpc{bout_ind},pbout_delta_hpc{bout_ind}*0+6)
stem(pbout_spindle{bout_ind},pbout_spindle{bout_ind}*0+5)
stem(pbout_spindles_hpc{bout_ind},pbout_spindles_hpc{bout_ind}*0+4)
stem(pbout_ripple_c3{bout_ind},pbout_ripple_c3{bout_ind}*0+3)
stem(pbout_ripple_c2{bout_ind},pbout_ripple_c2{bout_ind}*0+2)
stem(pbout_ripple_c1{bout_ind},pbout_ripple_c1{bout_ind}*0+1)
xlabel('Time (sec)')
title('Example NonREM bout with 7 events')
legend('Dc','Dh','Sc','Sh', 'R C3','R C2','R C1')

%% Convert to spikes
% spikes is a struct array with dimension [ntrials,nunits] and field .spk containing spike times
% we will change it to [nbouts, nevents] = [nbouts, 5]
% in this example [4,5]


N = length(nrem_end); % Number of rows
M = 7; % Number of columns
clear spikes spikes_peak
spikes = struct('spk', cell(N, M));
spikes_peak=struct('spk', cell(N, M));

for i = 1:N % bouts
%    for j = 1:M % events
        spikes(i, 1).spk = bout_ripple_c1{i}; 
        spikes(i, 2).spk = bout_ripple_c2{i}; 
        spikes(i, 3).spk = bout_ripple_c3{i}; 
        spikes(i, 4).spk = bout_spindles_hpc{i};
        spikes(i, 5).spk = bout_spindle{i}; 
        spikes(i, 6).spk = bout_delta_hpc{i};
        spikes(i, 7).spk = bout_delta{i}; 

        spikes_peak(i, 1).spk = pbout_ripple_c1{i}; 
        spikes_peak(i, 2).spk = pbout_ripple_c2{i}; 
        spikes_peak(i, 3).spk = pbout_ripple_c3{i}; 
        spikes_peak(i, 4).spk = pbout_spindles_hpc{i};
        spikes_peak(i, 5).spk = pbout_spindle{i}; 
        spikes_peak(i, 6).spk = pbout_delta_hpc{i};
        spikes_peak(i, 7).spk = pbout_delta{i}; 

%    end
end



% 3) create your own 'win_train' array with dimensions [ntrials, 2], where each row is the [start, end] times for each trial (spike times in 'spikes' must be consistently aligned with 'win_train')
%[4,2]

win_train=[zeros(N,1) (nrem_end-nrem_start)'];

cd('/home/adrian/Documents/GitHub/RGS14_clusters/Adrian/mazzucato_scripts')
