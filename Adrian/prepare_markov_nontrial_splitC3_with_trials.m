addingpath()
clear variables 
fn=1000; % Sampling rate
addpath('/home/adrian/Documents/GitHub/RGS14_clusters/Adrian/functions')
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



Trialname=[{'PS'};{'PT1'};{'PT2'};{'PT3'};{'PT4'};{'PT5_1'};{'PT5_2'};{'PT5_3'};{'PT5_4'}];
for j=1:9 % Post trial index

cd([rat_folder '/' g{k}])    

%cd('/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/RGSfiles_ForAdrian/RGS_event_timestamps/1/Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018')
% Read sleep scoring files. 
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

%Find and load ripple data
files = dir;
files={files.name};
files=files(cellfun(@(x) contains(x,'Cluster_ripple') & ~contains(x,'..') &contains(x,g{k}),files)); 
if isempty(files) | length(files)>2
    error('filename issue')
end

%Extracting ripple C3 data to split it into short and long. 
%load('Cluster_ripple_timestamps_Rat_OS_Ephys_RGS14_Rat1_57986_SD1_CON_27-28_07_2018.mat');
x=load(files{1});
x=x.ripple_timestamps_c3; %Extract C3 timestamps.
x=x{j};
if  iscell(x) %if cell, needed to deal with eventual NaNs. 
    x_start=x(:,1);
    x_peak=x(:,2);
    x_end=x(:,3);
    x_duration=cellfun(@(e_start,e_end) e_end-e_start,x_start,x_end,'UniformOutput',false);
    x_Long=cellfun(@(e) e>0.070,x_duration,'UniformOutput',false);
    x_Short=cellfun(@(e) e<=0.070,x_duration,'UniformOutput',false);

    %start, peak and end of long ripples.
    x_startLong=cellfun(@(e_start,e_long) e_start(e_long),x_start,x_Long,'UniformOutput',false);
    x_peakLong=cellfun(@(e_peak,e_long) e_peak(e_long),x_peak,x_Long,'UniformOutput',false);
    x_endLong=cellfun(@(e_end,e_long) e_end(e_long),x_end,x_Long,'UniformOutput',false);
    ripple_c3Long=[x_startLong x_peakLong x_endLong];
    %start, peak and end of short ripples.
    x_startShort=cellfun(@(e_start,e_short) e_start(e_short),x_start,x_Short,'UniformOutput',false);
    x_peakShort=cellfun(@(e_peak,e_short) e_peak(e_short),x_peak,x_Short,'UniformOutput',false);
    x_endShort=cellfun(@(e_end,e_short) e_end(e_short),x_end,x_Short,'UniformOutput',false);
    ripple_c3Short=[x_startShort x_peakShort x_endShort];
else % if not cell
    if isnan(x)
        ripple_c3Short=NaN;
        ripple_c3Long=NaN;
    else
        error('something is wrong')
    end 
end
load(files{1});
    
ripple_c1=ripple_timestamps_c1{j};
ripple_c2=ripple_timestamps_c2{j};
%ripple_c3=ripple_timestamps_c3{j};

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

if ~iscell(ripple_c3Short)
if isnan(ripple_c3Short)
    if  ~isempty(ripple_c1)
        ripple_c3Short=cell(size(ripple_c1,1),3);
    else
        error('ripple_c1 was not a good choice to find out the number of nrem bouts')
    end
end
end

if ~iscell(ripple_c3Long)
if isnan(ripple_c3Long)
    if  ~isempty(ripple_c1)
        ripple_c3Long=cell(size(ripple_c1,1),3);
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
    trial_durations.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Bout_ripple_c1.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Bout_ripple_c2.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Bout_ripple_c3Short.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Bout_ripple_c3Long.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];

    Day_Bout_spindle.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Bout_spindles_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Bout_delta.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Bout_delta_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];

    Day_Pbout_ripple_c1.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Pbout_ripple_c2.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Pbout_ripple_c3Short.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Pbout_ripple_c3Long.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];

    Day_Pbout_spindle.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Pbout_spindles_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Pbout_delta.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];
    Day_Pbout_delta_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];

    
    continue
end

for i=1:length(nrem_end) %Iterate nrem bouts
%Start-End bouts    
bout_time=nrem_start(i):1/fn:nrem_end(i);
bout_ripple_c1{i}=zeros(size(bout_time));
bout_ripple_c2{i}=zeros(size(bout_time));
bout_ripple_c3Short{i}=zeros(size(bout_time));
bout_ripple_c3Long{i}=zeros(size(bout_time));

bout_spindle{i}=zeros(size(bout_time));
bout_delta{i}=zeros(size(bout_time));
bout_spindles_hpc{i}=zeros(size(bout_time));
bout_delta_hpc{i}=zeros(size(bout_time));
%Peak bouts
pbout_time=nrem_start(i):1/fn:nrem_end(i);
pbout_ripple_c1{i}=zeros(size(bout_time));
pbout_ripple_c2{i}=zeros(size(bout_time));
pbout_ripple_c3Short{i}=zeros(size(bout_time));
pbout_ripple_c3Long{i}=zeros(size(bout_time));

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

ripple_c3Short_start=ripple_c3Short{i,1};
ripple_c3Long_start=ripple_c3Long{i,1};
ripple_c3Short_end=ripple_c3Short{i,3};
ripple_c3Long_end=ripple_c3Long{i,3};

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
[bout_ripple_c3Short]=get_ticks(bout_time,bout_ripple_c3Short,ripple_c3Short_start, ripple_c3Short_end,i,fn);
[bout_ripple_c3Long]=get_ticks(bout_time,bout_ripple_c3Long,ripple_c3Long_start, ripple_c3Long_end,i,fn);

[bout_spindle]=get_ticks(bout_time,bout_spindle,spindles_start, spindles_end,i,fn);
[bout_spindles_hpc]=get_ticks(bout_time,bout_spindles_hpc,spindles_hpc_start, spindles_hpc_end,i,fn);
[bout_delta]=get_ticks(bout_time,bout_delta,delta_start, delta_end,i,fn);
[bout_delta_hpc]=get_ticks(bout_time,bout_delta_hpc,delta_hpc_start, delta_hpc_end,i,fn);


%Get peak
ripple_c1_peak=ripple_c1{i,2};
ripple_c2_peak=ripple_c2{i,2};
ripple_c3Short_peak=ripple_c3Short{i,2};
ripple_c3Long_peak=ripple_c3Long{i,2};

spindles_peak=spindles{i,3};
spindles_hpc_peak=spindles_hpc{i,3};
delta_peak=delta{i,3};
delta_hpc_peak=delta_hpc{i,3};

[pbout_ripple_c1]=get_ticks_peak(bout_time,pbout_ripple_c1,ripple_c1_peak,i,fn);
[pbout_ripple_c2]=get_ticks_peak(bout_time,pbout_ripple_c2,ripple_c2_peak,i,fn);
[pbout_ripple_c3Short]=get_ticks_peak(bout_time,pbout_ripple_c3Short,ripple_c3Short_peak,i,fn);
[pbout_ripple_c3Long]=get_ticks_peak(bout_time,pbout_ripple_c3Long,ripple_c3Long_peak,i,fn);

[pbout_spindle]=get_ticks_peak(bout_time,pbout_spindle,spindles_peak,i,fn);
[pbout_spindles_hpc]=get_ticks_peak(bout_time,pbout_spindles_hpc,spindles_hpc_peak,i,fn);
[pbout_delta]=get_ticks_peak(bout_time,pbout_delta,delta_peak,i,fn);
[pbout_delta_hpc]=get_ticks_peak(bout_time,pbout_delta_hpc,delta_hpc_peak,i,fn);


clear ripple_c1_peak ripple_c2_peak ripple_c3Short_peak ripple_c3Long_peak spindles_peak spindles_hpc_peak delta_peak delta_hpc_peak
clear ripple_c1_start ripple_c1_end ripple_c2_start ripple_c2_end ripple_c3Short_start ripple_c3Short_end ripple_c3Long_start ripple_c3Long_end spindles_start spindles_end spindles_hpc_start spindles_hpc_end delta_start delta_end delta_hpc_start delta_hpc_end
end

bout_ripple_c1={horzcat(bout_ripple_c1{:});};
bout_ripple_c2={horzcat(bout_ripple_c2{:});};
bout_ripple_c3Short={horzcat(bout_ripple_c3Short{:});};
bout_ripple_c3Long={horzcat(bout_ripple_c3Long{:});};

bout_spindle={horzcat(bout_spindle{:});};
bout_spindles_hpc={horzcat(bout_spindles_hpc{:});};
bout_delta={horzcat(bout_delta{:});};
bout_delta_hpc={horzcat(bout_delta_hpc{:});};

pbout_ripple_c1={horzcat(pbout_ripple_c1{:});};
pbout_ripple_c2={horzcat(pbout_ripple_c2{:});};
pbout_ripple_c3Short={horzcat(pbout_ripple_c3Short{:});};
pbout_ripple_c3Long={horzcat(pbout_ripple_c3Long{:});};

pbout_spindle={horzcat(pbout_spindle{:});};
pbout_spindles_hpc={horzcat(pbout_spindles_hpc{:});};
pbout_delta={horzcat(pbout_delta{:});};
pbout_delta_hpc={horzcat(pbout_delta_hpc{:});};



Bout_ripple_c1{j}=bout_ripple_c1{1};
Bout_ripple_c2{j}=bout_ripple_c2{1};
Bout_ripple_c3Short{j}=bout_ripple_c3Short{1};
Bout_ripple_c3Long{j}=bout_ripple_c3Long{1};

Bout_spindle{j}=bout_spindle{1};
Bout_spindles_hpc{j}=bout_spindles_hpc{1};
Bout_delta{j}=bout_delta{1};
Bout_delta_hpc{j}=bout_delta_hpc{1};

Pbout_ripple_c1{j}=pbout_ripple_c1{1};
Pbout_ripple_c2{j}=pbout_ripple_c2{1};
Pbout_ripple_c3Short{j}=pbout_ripple_c3Short{1};
Pbout_ripple_c3Long{j}=pbout_ripple_c3Long{1};

Pbout_spindle{j}=pbout_spindle{1};
Pbout_spindles_hpc{j}=pbout_spindles_hpc{1};
Pbout_delta{j}=pbout_delta{1};
Pbout_delta_hpc{j}=pbout_delta_hpc{1};

clear bout_ripple_c1 bout_ripple_c2 bout_ripple_c3Short bout_ripple_c3Long bout_spindle bout_spindles_hpc bout_delta bout_delta_hpc 
clear pbout_ripple_c1 pbout_ripple_c2 pbout_ripple_c3Short pbout_ripple_c3Long pbout_spindle pbout_spindles_hpc pbout_delta pbout_delta_hpc 
clear states
clear ripple_c1 ripple_c2 ripple_c3Short ripple_c3Long spindles spindles_hpc delta delta_hpc
clear ripple_timestamps_c1 ripple_timestamps_c2 ripple_timestamps_c3Short ripple_timestamps_c3Long ripple_timestamps_c4
clear spindles_bout_specific_timestamps spindles_bout_specific_timestamps_hpc
clear delta_bst_total_data delta_bst_total_data_hpc
clear delta_timestamps_SD delta_timestamps_SD_hpc
clear pbout_time bout_time transitions pattern
clear nrem nrem_end nrem_start
clear x x_duration x_end x_endLong x_endShort x_Long x_peak x_peakLong x_peakShort x_Short x_start x_startLong x_startShort
% if ~isempty(Bout_delta{j})
trial_durations.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[length(Bout_delta{j}) ];
% else
% trial_durations.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=[0];    
% end
Day_Bout_ripple_c1.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Bout_ripple_c1{j});
Day_Bout_ripple_c2.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Bout_ripple_c2{j});
Day_Bout_ripple_c3Short.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Bout_ripple_c3Short{j});
Day_Bout_ripple_c3Long.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Bout_ripple_c3Long{j});

Day_Bout_spindle.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Bout_spindle{j});
Day_Bout_spindles_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Bout_spindles_hpc{j});
Day_Bout_delta.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Bout_delta{j});
Day_Bout_delta_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Bout_delta_hpc{j});

Day_Pbout_ripple_c1.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Pbout_ripple_c1{j});
Day_Pbout_ripple_c2.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Pbout_ripple_c2{j});
Day_Pbout_ripple_c3Short.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Pbout_ripple_c3Short{j});
Day_Pbout_ripple_c3Long.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Pbout_ripple_c3Long{j});

Day_Pbout_spindle.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Pbout_spindle{j});
Day_Pbout_spindles_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Pbout_spindles_hpc{j});
Day_Pbout_delta.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Pbout_delta{j});
Day_Pbout_delta_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))]).(Trialname{j})=(Pbout_delta_hpc{j});

end
 
%xo 
%trial_durations(k,:)=[cellfun('length',Bout_delta) sum(cellfun('length',Bout_delta))];
%trial_durations.(['Rat' num2str(veh_rats(l))]).(ConditionString)=[cellfun('length',Bout_delta) sum(cellfun('length',Bout_delta))];
%trial_durations.(ConditionString).(['Rat' num2str(veh_rats(l))])=[cellfun('length',Bout_delta) sum(cellfun('length',Bout_delta))];


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

% Day_Bout_ripple_c1.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_ripple_c1{:});
% Day_Bout_ripple_c2.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_ripple_c2{:});
% Day_Bout_ripple_c3Short.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_ripple_c3Short{:});
% Day_Bout_ripple_c3Long.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_ripple_c3Long{:});
% 
% Day_Bout_spindle.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_spindle{:});
% Day_Bout_spindles_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_spindles_hpc{:});
% Day_Bout_delta.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_delta{:});
% Day_Bout_delta_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Bout_delta_hpc{:});
% 
% Day_Pbout_ripple_c1.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_ripple_c1{:});
% Day_Pbout_ripple_c2.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_ripple_c2{:});
% Day_Pbout_ripple_c3Short.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_ripple_c3Short{:});
% Day_Pbout_ripple_c3Long.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_ripple_c3Long{:});
% 
% Day_Pbout_spindle.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_spindle{:});
% Day_Pbout_spindles_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_spindles_hpc{:});
% Day_Pbout_delta.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_delta{:});
% Day_Pbout_delta_hpc.(ConditionString).(['Rat' num2str(veh_rats(l))])=horzcat(Pbout_delta_hpc{:});

% Day_Pbout_ripple_c1.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_ripple_c1{:});
% Day_Pbout_ripple_c2.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_ripple_c2{:});
% Day_Pbout_ripple_c3.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_ripple_c3{:});
% Day_Pbout_spindle.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_spindle{:});
% Day_Pbout_spindles_hpc.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_spindles_hpc{:});
% Day_Pbout_delta.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_delta{:});
% Day_Pbout_delta_hpc.(['Rat' num2str(veh_rats(l))]).(ConditionString)=horzcat(Pbout_delta_hpc{:});

%xo
clear ConditionString
clear Bout_ripple_c1 Bout_ripple_c2 Bout_ripple_c3Short Bout_ripple_c3Long Bout_spindle Bout_spindles_hpc Bout_delta Bout_delta_hpc 
clear Pbout_ripple_c1 Pbout_ripple_c2 Pbout_ripple_c3Short Pbout_ripple_c3Long Pbout_spindle Pbout_spindles_hpc Pbout_delta Pbout_delta_hpc 

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
% win_train=[zeros(N,1) (nrem_end-nrem_start)'];