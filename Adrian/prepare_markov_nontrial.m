addingpath()
clear variables 
fn=1000; % Sampling rate
main_path='/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/RGSfiles_ForAdrian/RGS_event_timestamps/';
veh_rats=[1 2 6 9];

for l =1:length(veh_rats) %Iterate across rats

rat_folder=[main_path num2str(veh_rats(l))];
% rat_folder='/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/RGSfiles_ForAdrian/RGS_event_timestamps/1';
cd(rat_folder)
%xo

g=getfolder;

if length(g)~=4 %Should only be 4 study days (CON, OD, OR, HC).
    error('Extra folders found')
end


for k=1:4 %Iterate across Study days. 
cd([rat_folder '/' g{k}])    


%Find condition name
pattern = 'SD\d+_(\w+)';
match = regexp(g{k}, pattern, 'tokens');
% Check if a match is found and extract the string
if ~isempty(match)
    extractedString = match{1}{1};
%     disp(['Extracted String: ', extractedString]);
else
    disp('No match found.');
end
splitString = split(extractedString, '_');
ConditionString = splitString{1};




for j=1:9 % Post trial index

cd([rat_folder '/' g{k}])    

%cd('/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/RGSfiles_ForAdrian/RGS_event_timestamps/1/Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018')
clear states
files = dir;
files={files.name};
files=files(cellfun(@(x) contains(x,'states') & ~contains(x,'..'),files)); 

switch j
    case 1
    files=files(cellfun(@(x) contains(x,'Pre') ,files));   
        if length(files)>1
            xo
        end
    load(files{1})
    if length(states)>45*60
        states=states(1:45*60); %Take only 45 min.
    end        
    
    case 2
    files=files(cellfun(@(x) contains(x,'Trial1') ,files)); 
        if length(files)>1
            xo
        end
    load(files{1})
    if length(states)>45*60
        states=states(1:45*60); %Take only 45 min.
    end        
    
    case 3
    files=files(cellfun(@(x) contains(x,'Trial2') ,files)); 
        if length(files)>1
            xo
        end
    load(files{1})
    if length(states)>45*60
        states=states(1:45*60); %Take only 45 min.
    end        

    case 4
    files=files(cellfun(@(x) contains(x,'Trial3') ,files)); 
        if length(files)>1
            xo
        end
    load(files{1})
    if length(states)>45*60
        states=states(1:45*60); %Take only 45 min.
    end        

    case 5
    files=files(cellfun(@(x) contains(x,'Trial4') ,files)); 
        if length(files)>1
            xo
        end
    load(files{1})
    if length(states)>45*60
        states=states(1:45*60); %Take only 45 min.
    end        

    otherwise
    files=files(cellfun(@(x) contains(x,'Trial5') ,files)); 
        if length(files)>1
            xo
        end
    load(files{1})
      
      if j==6
      states=states(1:2700);
      end
      
      if j==7
      states=states(2700+1:2700*2);
      end
      if j==8
      states=states(1+2700*2:2700*3);
      end
      
      if j==9
      %states=states(1+2700*3:2700*4);
      states=states(1+2700*3:end);
        if length(states)>45*60
            states=states(1:45*60); %Take only 45 min.
        end        
      
      end
        %xo
end
%xo
% load('2018-07-26_11-58-33_Post-Trial2-states.mat')
cd ..


files = dir;
files={files.name};
files=files(cellfun(@(x) contains(x,'Cluster_ripple') & ~contains(x,'..') &contains(x,g{k}),files)); 
if isempty(files) | length(files)>2
    error('filename issue')
end

%load('Cluster_ripple_timestamps_Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018.mat');
load(files{1})   
    
    
ripple_c1=ripple_timestamps_c1{j};
ripple_c2=ripple_timestamps_c2{j};
ripple_c3=ripple_timestamps_c3{j};

% ripple=ripple_timestamps{j};

%xo
files = dir;
files={files.name};
files=files(cellfun(@(x) contains(x,'spindles_timestamps') & ~contains(x,'..') &contains(x,g{k}),files)); 
if isempty(files) | length(files)>2
    error('filename issue')
end
load(files{1})   

%load('spindles_timestamps_Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018.mat')
spindles=spindles_bout_specific_timestamps{j};
spindles_hpc=spindles_bout_specific_timestamps_hpc{j};

if isempty(spindles)
    if  ~isempty(ripple_c1)
        spindles=cell(size(ripple_c1,1),3);
    else
        error('ripple_c1 was not a good choice to find out the number of nrem bouts')
    end
end
if isempty(spindles_hpc)
    if  ~isempty(ripple_c1)
        spindles_hpc=cell(size(ripple_c1,1),3);
    else
        error('ripple_c1 was not a good choice to find out the number of nrem bouts')
    end
end

if ~iscell(ripple_c3)
if isnan(ripple_c3)
    if  ~isempty(ripple_c1)
        ripple_c3=cell(size(ripple_c1,1),3);
    else
        error('ripple_c1 was not a good choice to find out the number of nrem bouts')
    end
end
end



%load('delta_timestamps_Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018.mat')
files = dir;
files={files.name};
files=files(cellfun(@(x) contains(x,'delta_timestamps') & ~contains(x,'..') &contains(x,g{k}),files)); 
if isempty(files) | length(files)>2
    error('filename issue')
end
load(files{1})   

delta=delta_bst_total_data{j};

%load('delta_hpc_timestamps_Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018.mat')
files = dir;
files={files.name};
files=files(cellfun(@(x) contains(x,'delta_hpc_timestamps') & ~contains(x,'..') &contains(x,g{k}),files)); 
if isempty(files) | length(files)>2
    error('filename issue')
end
load(files{1})   

delta_hpc=delta_bst_total_data_hpc{j};

% N=size(delta_hpc,1); % Number of NREM bouts
% [cripple_c1]=combine_cells(ripple_c1,N);
% [cripple_c2]=combine_cells(ripple_c2,N);
% [cripple_c3]=combine_cells(ripple_c3,N);
% [cspindles]=combine_cells(spindles,N);
% [cspindles_hpc]=combine_cells(spindles_hpc,N);
% [cdelta]=combine_cells(delta,N);
% [cdelta_hpc]=combine_cells(delta_hpc,N);

% load('delta_timestamps_Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018.mat')
% delta=delta_timestamps_SD{3};
% delta=delta(:,1:4);

%Find start and end of NREM bouts
nrem=ConsecutiveOnes(states==3);
nrem_start=find(nrem);
nrem_end=nrem_start+(nrem(nrem~=0))-1;

%NO NREM sleep
if isempty(nrem_start)
    continue
end

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


clear ripple_c1_peak ripple_c2_peak ripple_c3_peak spindles_peak spindles_hpc_peak delta_peak delta_hpc_peak
clear ripple_c1_start ripple_c1_end ripple_c2_start ripple_c2_end ripple_c3_start ripple_c3_end spindles_start spindles_end spindles_hpc_start spindles_hpc_end delta_start delta_end delta_hpc_start delta_hpc_end
end

bout_ripple_c1={horzcat(bout_ripple_c1{:});};
bout_ripple_c2={horzcat(bout_ripple_c2{:});};
bout_ripple_c3={horzcat(bout_ripple_c3{:});};
bout_spindle={horzcat(bout_spindle{:});};
bout_spindles_hpc={horzcat(bout_spindles_hpc{:});};
bout_delta={horzcat(bout_delta{:});};
bout_delta_hpc={horzcat(bout_delta_hpc{:});};

pbout_ripple_c1={horzcat(pbout_ripple_c1{:});};
pbout_ripple_c2={horzcat(pbout_ripple_c2{:});};
pbout_ripple_c3={horzcat(pbout_ripple_c3{:});};
pbout_spindle={horzcat(pbout_spindle{:});};
pbout_spindles_hpc={horzcat(pbout_spindles_hpc{:});};
pbout_delta={horzcat(pbout_delta{:});};
pbout_delta_hpc={horzcat(pbout_delta_hpc{:});};



Bout_ripple_c1{j}=bout_ripple_c1{1};
Bout_ripple_c2{j}=bout_ripple_c2{1};
Bout_ripple_c3{j}=bout_ripple_c3{1};
Bout_spindle{j}=bout_spindle{1};
Bout_spindles_hpc{j}=bout_spindles_hpc{1};
Bout_delta{j}=bout_delta{1};
Bout_delta_hpc{j}=bout_delta_hpc{1};

Pbout_ripple_c1{j}=pbout_ripple_c1{1};
Pbout_ripple_c2{j}=pbout_ripple_c2{1};
Pbout_ripple_c3{j}=pbout_ripple_c3{1};
Pbout_spindle{j}=pbout_spindle{1};
Pbout_spindles_hpc{j}=pbout_spindles_hpc{1};
Pbout_delta{j}=pbout_delta{1};
Pbout_delta_hpc{j}=pbout_delta_hpc{1};

clear bout_ripple_c1 bout_ripple_c2 bout_ripple_c3 bout_spindle bout_spindles_hpc bout_delta bout_delta_hpc 
clear pbout_ripple_c1 pbout_ripple_c2 pbout_ripple_c3 pbout_spindle pbout_spindles_hpc pbout_delta pbout_delta_hpc 
clear states
clear ripple_c1 ripple_c2 ripple_c3 spindles spindles_hpc delta delta_hpc
clear ripple_timestamps_c1 ripple_timestamps_c2 ripple_timestamps_c3 ripple_timestamps_c4
clear spindles_bout_specific_timestamps spindles_bout_specific_timestamps_hpc
clear delta_bst_total_data delta_bst_total_data_hpc
clear delta_timestamps_SD delta_timestamps_SD_hpc
clear pbout_time bout_time transitions pattern
clear nrem nrem_end nrem_start
end

 
%xo 
%trial_durations(k,:)=[cellfun('length',Bout_delta) sum(cellfun('length',Bout_delta))];
%trial_durations.(['Rat' num2str(veh_rats(l))]).(ConditionString)=[cellfun('length',Bout_delta) sum(cellfun('length',Bout_delta))];
trial_durations.(ConditionString).(['Rat' num2str(veh_rats(l))])=[cellfun('length',Bout_delta) sum(cellfun('length',Bout_delta))];


% Store data per day
% Day_Bout_ripple_c1{k}=horzcat(Bout_ripple_c1{:});
% Day_Bout_ripple_c2{k}=horzcat(Bout_ripple_c2{:});
% Day_Bout_ripple_c3{k}=horzcat(Bout_ripple_c3{:});
% Day_Bout_spindle{k}=horzcat(Bout_spindle{:});
% Day_Bout_spindles_hpc{k}=horzcat(Bout_spindles_hpc{:});
% Day_Bout_delta{k}=horzcat(Bout_delta{:});
% Day_Bout_delta_hpc{k}=horzcat(Bout_delta_hpc{:});

% Day_Bout_ripple_c1.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Bout_ripple_c1{:});
% Day_Bout_ripple_c2.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Bout_ripple_c2{:});
% Day_Bout_ripple_c3.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Bout_ripple_c3{:});
% Day_Bout_spindle.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Bout_spindle{:});
% Day_Bout_spindles_hpc.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Bout_spindles_hpc{:});
% Day_Bout_delta.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Bout_delta{:});
% Day_Bout_delta_hpc.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Bout_delta_hpc{:});

Day_Bout_ripple_c1.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_ripple_c1{:});
Day_Bout_ripple_c2.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_ripple_c2{:});
Day_Bout_ripple_c3.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_ripple_c3{:});
Day_Bout_spindle.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_spindle{:});
Day_Bout_spindles_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_spindles_hpc{:});
Day_Bout_delta.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_delta{:});
Day_Bout_delta_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_delta_hpc{:});

Day_Pbout_ripple_c1.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_ripple_c1{:});
Day_Pbout_ripple_c2.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_ripple_c2{:});
Day_Pbout_ripple_c3.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_ripple_c3{:});
Day_Pbout_spindle.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_spindle{:});
Day_Pbout_spindles_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_spindles_hpc{:});
Day_Pbout_delta.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_delta{:});
Day_Pbout_delta_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_delta_hpc{:});

% Day_Pbout_ripple_c1.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_ripple_c1{:});
% Day_Pbout_ripple_c2.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_ripple_c2{:});
% Day_Pbout_ripple_c3.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_ripple_c3{:});
% Day_Pbout_spindle.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_spindle{:});
% Day_Pbout_spindles_hpc.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_spindles_hpc{:});
% Day_Pbout_delta.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_delta{:});
% Day_Pbout_delta_hpc.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_delta_hpc{:});

%xo
clear ConditionString
clear Bout_ripple_c1 Bout_ripple_c2 Bout_ripple_c3 Bout_spindle Bout_spindles_hpc Bout_delta Bout_delta_hpc 
clear Pbout_ripple_c1 Pbout_ripple_c2 Pbout_ripple_c3 Pbout_spindle Pbout_spindles_hpc Pbout_delta Pbout_delta_hpc 

end
%xo
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
%% Load previously computed data
% cd('/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/RGSfiles_ForAdrian')
cd('/home/adrian/Documents/GitHub/RGS14_clusters/Adrian')
load('veh_rgs_data_for_hmm.mat')
%% OD , HC, CON, OR

bout_ripple_c1=extractAndConcatenateData(Day_Bout_ripple_c1,fn);
bout_ripple_c2=extractAndConcatenateData(Day_Bout_ripple_c2,fn);
bout_ripple_c3=extractAndConcatenateData(Day_Bout_ripple_c3,fn);
bout_spindle=extractAndConcatenateData(Day_Bout_spindle,fn);
bout_spindles_hpc=extractAndConcatenateData(Day_Bout_spindles_hpc,fn);
bout_delta=extractAndConcatenateData(Day_Bout_delta,fn);
[bout_delta_hpc,length_concatenatedData]=extractAndConcatenateData(Day_Bout_delta_hpc,fn);

pbout_ripple_c1=extractAndConcatenateData(Day_Pbout_ripple_c1,fn);
pbout_ripple_c2=extractAndConcatenateData(Day_Pbout_ripple_c2,fn);
pbout_ripple_c3=extractAndConcatenateData(Day_Pbout_ripple_c3,fn);
pbout_spindle=extractAndConcatenateData(Day_Pbout_spindle,fn);
pbout_spindles_hpc=extractAndConcatenateData(Day_Pbout_spindles_hpc,fn);
pbout_delta=extractAndConcatenateData(Day_Pbout_delta,fn);
pbout_delta_hpc=extractAndConcatenateData(Day_Pbout_delta_hpc,fn);


win_train=[zeros(1,1) length_concatenatedData];
 

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
M = 7; % Number of columns
clear spikes spikes_peak
spikes = struct('spk', cell(N, M));
spikes_peak=struct('spk', cell(N, M));

for i = 1:N % bouts
%    for j = 1:M % events
        spikes(i, 1).spk = bout_ripple_c1.'; 
        spikes(i, 2).spk = bout_ripple_c2.'; 
        spikes(i, 3).spk = bout_ripple_c3.'; 
        spikes(i, 4).spk = bout_spindles_hpc.';
        spikes(i, 5).spk = bout_spindle.'; 
        spikes(i, 6).spk = bout_delta_hpc.';
        spikes(i, 7).spk = bout_delta.'; 

        spikes_peak(i, 1).spk = pbout_ripple_c1.'; 
        spikes_peak(i, 2).spk = pbout_ripple_c2.'; 
        spikes_peak(i, 3).spk = pbout_ripple_c3.'; 
        spikes_peak(i, 4).spk = pbout_spindles_hpc.';
        spikes_peak(i, 5).spk = pbout_spindle.'; 
        spikes_peak(i, 6).spk = pbout_delta_hpc.';
        spikes_peak(i, 7).spk = pbout_delta.'; 

%    end
end



% 3) create your own 'win_train' array with dimensions [ntrials, 2], where each row is the [start, end] times for each trial (spike times in 'spikes' must be consistently aligned with 'win_train')
%[4,2]

% win_train=[zeros(N,1) (nrem_end-nrem_start)'];