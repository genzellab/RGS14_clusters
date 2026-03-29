%% Pelin Ozsezer - 22 March 2026
%{
This script was developed for the RGS clusters paper.

Previously, 2,000 ripples were selected without balancing the contribution
from each animal. This created an imbalance in the dataset, since some
animals could contribute more events than others.

To generate a balanced dataset, the data are first separated by rat.
Ripple magnitude is then computed around the event center, and events are
ranked according to how close their magnitude is to the median ripple
magnitude within each rat.

Instead of selecting the largest ripples, this median-matched approach
selects the most representative ripples from each animal while avoiding
bias toward unusually large or small events. A subset of 500 ripples is
then selected from each of the 4 rats, resulting in a total of 2,000
events per condition with equal representation across animals.

The script processes waveform data from 3 clusters, separates the data
according to rat identity, computes median-matched ripple magnitude, and
saves the resulting datasets for downstream Granger causality analysis
and artifact rejection.

RATS - VEH: 1, 2, 6, 9
RATS - RGS: 3, 4, 7, 8
%}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% SECTION 1 - DATA SPLIT BY RAT %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear
format compact

%% VEHICLE - CLUSTER 1
load('waveforms_cluster1_veh.mat');

data_bp = waveforms_cluster1_bp_veh;
data_raw = waveforms_cluster1_raw_veh;

col6_bp = data_bp(:,6);
col6_raw = data_raw(:,6);

col6_bp = cell2mat(col6_bp);
col6_raw = cell2mat(col6_raw);

uniqueVals = unique(col6_raw);

% split

waveforms_cluster1_bp_rat1_veh = data_bp(col6_bp == uniqueVals(1), :);
waveforms_cluster1_raw_rat1_veh = data_raw(col6_raw == uniqueVals(1), :);

waveforms_cluster1_bp_rat2_veh = data_bp(col6_bp == uniqueVals(2), :);
waveforms_cluster1_raw_rat2_veh = data_raw(col6_raw == uniqueVals(2), :);

waveforms_cluster1_bp_rat6_veh = data_bp(col6_bp == uniqueVals(3), :);
waveforms_cluster1_raw_rat6_veh = data_raw(col6_raw == uniqueVals(3), :);

waveforms_cluster1_bp_rat9_veh = data_bp(col6_bp == uniqueVals(4), :);
waveforms_cluster1_raw_rat9_veh = data_raw(col6_raw == uniqueVals(4), :);


% clear except...
clearvars -except ...
    waveforms_cluster1_bp_rat1_veh ...
    waveforms_cluster1_raw_rat1_veh ...
    waveforms_cluster1_bp_rat2_veh ...
    waveforms_cluster1_raw_rat2_veh ...
    waveforms_cluster1_bp_rat6_veh ...
    waveforms_cluster1_raw_rat6_veh ...
    waveforms_cluster1_bp_rat9_veh ...
    waveforms_cluster1_raw_rat9_veh

save('waveforms_byRat_cluster1_veh.mat', '-v7.3')



%% RGS - CLUSTER 1
clc
clear

load('waveforms_cluster1_rgs.mat')

data_bp = waveforms_cluster1_bp_rgs;
data_raw = waveforms_cluster1_raw_rgs;

col6_bp = data_bp(:,6);
col6_raw = data_raw(:,6);

col6_bp = cell2mat(col6_bp);
col6_raw = cell2mat(col6_raw);

uniqueVals = unique(col6_raw);
uniqueVals

% split

waveforms_cluster1_bp_rat3_rgs = data_bp(col6_bp == uniqueVals(1), :);
waveforms_cluster1_raw_rat3_rgs = data_raw(col6_raw == uniqueVals(1), :);

waveforms_cluster1_bp_rat4_rgs = data_bp(col6_bp == uniqueVals(2), :);
waveforms_cluster1_raw_rat4_rgs = data_raw(col6_raw == uniqueVals(2), :);

waveforms_cluster1_bp_rat7_rgs = data_bp(col6_bp == uniqueVals(3), :);
waveforms_cluster1_raw_rat7_rgs = data_raw(col6_raw == uniqueVals(3), :);

waveforms_cluster1_bp_rat8_rgs = data_bp(col6_bp == uniqueVals(4), :);
waveforms_cluster1_raw_rat8_rgs = data_raw(col6_raw == uniqueVals(4), :);


% clear except...
clearvars -except ...
    waveforms_cluster1_bp_rat3_rgs ...
    waveforms_cluster1_raw_rat3_rgs ...
    waveforms_cluster1_bp_rat4_rgs ...
    waveforms_cluster1_raw_rat4_rgs ...
    waveforms_cluster1_bp_rat7_rgs ...
    waveforms_cluster1_raw_rat7_rgs ...
    waveforms_cluster1_bp_rat8_rgs ...
    waveforms_cluster1_raw_rat8_rgs

save('waveforms_byRat_cluster1_rgs.mat', '-v7.3')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% VEHICLE - CLUSTER 2
clc
clear
load('waveforms_cluster2_veh.mat');

data_bp = waveforms_cluster2_bp_veh;
data_raw = waveforms_cluster2_raw_veh;

col6_bp = data_bp(:,6);
col6_raw = data_raw(:,6);

col6_bp = cell2mat(col6_bp);
col6_raw = cell2mat(col6_raw);

uniqueVals = unique(col6_raw);

% split

waveforms_cluster2_bp_rat1_veh = data_bp(col6_bp == uniqueVals(1), :);
waveforms_cluster2_raw_rat1_veh = data_raw(col6_raw == uniqueVals(1), :);

waveforms_cluster2_bp_rat2_veh = data_bp(col6_bp == uniqueVals(2), :);
waveforms_cluster2_raw_rat2_veh = data_raw(col6_raw == uniqueVals(2), :);

waveforms_cluster2_bp_rat6_veh = data_bp(col6_bp == uniqueVals(3), :);
waveforms_cluster2_raw_rat6_veh = data_raw(col6_raw == uniqueVals(3), :);

waveforms_cluster2_bp_rat9_veh = data_bp(col6_bp == uniqueVals(4), :);
waveforms_cluster2_raw_rat9_veh = data_raw(col6_raw == uniqueVals(4), :);


% clear except...
clearvars -except ...
    waveforms_cluster2_bp_rat1_veh ...
    waveforms_cluster2_raw_rat1_veh ...
    waveforms_cluster2_bp_rat2_veh ...
    waveforms_cluster2_raw_rat2_veh ...
    waveforms_cluster2_bp_rat6_veh ...
    waveforms_cluster2_raw_rat6_veh ...
    waveforms_cluster2_bp_rat9_veh ...
    waveforms_cluster2_raw_rat9_veh

save('waveforms_byRat_cluster2_veh.mat', '-v7.3')



%% RGS - CLUSTER 2
clc
clear

load('waveforms_cluster2_rgs.mat')

data_bp = waveforms_cluster2_bp_rgs;
data_raw = waveforms_cluster2_raw_rgs;

col6_bp = data_bp(:,6);
col6_raw = data_raw(:,6);

col6_bp = cell2mat(col6_bp);
col6_raw = cell2mat(col6_raw);

uniqueVals = unique(col6_raw);
uniqueVals

% split

waveforms_cluster2_bp_rat3_rgs = data_bp(col6_bp == uniqueVals(1), :);
waveforms_cluster2_raw_rat3_rgs = data_raw(col6_raw == uniqueVals(1), :);

waveforms_cluster2_bp_rat4_rgs = data_bp(col6_bp == uniqueVals(2), :);
waveforms_cluster2_raw_rat4_rgs = data_raw(col6_raw == uniqueVals(2), :);

waveforms_cluster2_bp_rat7_rgs = data_bp(col6_bp == uniqueVals(3), :);
waveforms_cluster2_raw_rat7_rgs = data_raw(col6_raw == uniqueVals(3), :);

waveforms_cluster2_bp_rat8_rgs = data_bp(col6_bp == uniqueVals(4), :);
waveforms_cluster2_raw_rat8_rgs = data_raw(col6_raw == uniqueVals(4), :);


% clear except...
clearvars -except ...
    waveforms_cluster2_bp_rat3_rgs ...
    waveforms_cluster2_raw_rat3_rgs ...
    waveforms_cluster2_bp_rat4_rgs ...
    waveforms_cluster2_raw_rat4_rgs ...
    waveforms_cluster2_bp_rat7_rgs ...
    waveforms_cluster2_raw_rat7_rgs ...
    waveforms_cluster2_bp_rat8_rgs ...
    waveforms_cluster2_raw_rat8_rgs

save('waveforms_byRat_cluster2_rgs.mat', '-v7.3')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% VEHICLE - CLUSTER 3
clc
clear
load('waveforms_cluster3_veh.mat');

data_bp = waveforms_cluster3_bp_veh;
data_raw = waveforms_cluster3_raw_veh;

col6_bp = data_bp(:,6);
col6_raw = data_raw(:,6);

col6_bp = cell2mat(col6_bp);
col6_raw = cell2mat(col6_raw);

uniqueVals = unique(col6_raw);

% split

waveforms_cluster3_bp_rat1_veh = data_bp(col6_bp == uniqueVals(1), :);
waveforms_cluster3_raw_rat1_veh = data_raw(col6_raw == uniqueVals(1), :);

waveforms_cluster3_bp_rat2_veh = data_bp(col6_bp == uniqueVals(2), :);
waveforms_cluster3_raw_rat2_veh = data_raw(col6_raw == uniqueVals(2), :);

waveforms_cluster3_bp_rat6_veh = data_bp(col6_bp == uniqueVals(3), :);
waveforms_cluster3_raw_rat6_veh = data_raw(col6_raw == uniqueVals(3), :);

waveforms_cluster3_bp_rat9_veh = data_bp(col6_bp == uniqueVals(4), :);
waveforms_cluster3_raw_rat9_veh = data_raw(col6_raw == uniqueVals(4), :);


% clear except...
clearvars -except ...
    waveforms_cluster3_bp_rat1_veh ...
    waveforms_cluster3_raw_rat1_veh ...
    waveforms_cluster3_bp_rat2_veh ...
    waveforms_cluster3_raw_rat2_veh ...
    waveforms_cluster3_bp_rat6_veh ...
    waveforms_cluster3_raw_rat6_veh ...
    waveforms_cluster3_bp_rat9_veh ...
    waveforms_cluster3_raw_rat9_veh

save('waveforms_byRat_cluster3_veh.mat', '-v7.3')



%% RGS - CLUSTER 3
clc
clear

load('waveforms_cluster3_rgs.mat')

data_bp = waveforms_cluster3_bp_rgs;
data_raw = waveforms_cluster3_raw_rgs;

col6_bp = data_bp(:,6);
col6_raw = data_raw(:,6);

col6_bp = cell2mat(col6_bp);
col6_raw = cell2mat(col6_raw);

uniqueVals = unique(col6_raw);
uniqueVals

% split

waveforms_cluster3_bp_rat3_rgs = data_bp(col6_bp == uniqueVals(1), :);
waveforms_cluster3_raw_rat3_rgs = data_raw(col6_raw == uniqueVals(1), :);

waveforms_cluster3_bp_rat4_rgs = data_bp(col6_bp == uniqueVals(2), :);
waveforms_cluster3_raw_rat4_rgs = data_raw(col6_raw == uniqueVals(2), :);

waveforms_cluster3_bp_rat7_rgs = data_bp(col6_bp == uniqueVals(3), :);
waveforms_cluster3_raw_rat7_rgs = data_raw(col6_raw == uniqueVals(3), :);

waveforms_cluster3_bp_rat8_rgs = data_bp(col6_bp == uniqueVals(4), :);
waveforms_cluster3_raw_rat8_rgs = data_raw(col6_raw == uniqueVals(4), :);


% clear except...
clearvars -except ...
    waveforms_cluster3_bp_rat3_rgs ...
    waveforms_cluster3_raw_rat3_rgs ...
    waveforms_cluster3_bp_rat4_rgs ...
    waveforms_cluster3_raw_rat4_rgs ...
    waveforms_cluster3_bp_rat7_rgs ...
    waveforms_cluster3_raw_rat7_rgs ...
    waveforms_cluster3_bp_rat8_rgs ...
    waveforms_cluster3_raw_rat8_rgs

save('waveforms_byRat_cluster3_rgs.mat', '-v7.3')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%% SECTION 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% COMPUTE MEDIAN-MATCHED RIPPLE MAGNITUDE AND SELECT TOP 500 %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%
%% VEH %%
%%%%%%%%%

%% Prepare data for Granger Analysis!

%% Cluster 1 %%

%% Rat 1
clc
clear
load('waveforms_byRat_cluster1_veh'); 

GC_cluster1_veh           = waveforms_cluster1_raw_rat1_veh(:,1);
GC_Bp_cluster1_veh        = waveforms_cluster1_bp_rat1_veh(:,1);
GC_time_cluster1_veh     = waveforms_cluster1_raw_rat1_veh(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster1_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster1_veh=GC_cluster1_veh(r_nl);
GC_cluster1_veh = GC_cluster1_veh(1:505);

GC_Bp_cluster1_veh=GC_Bp_cluster1_veh(r_nl);
GC_Bp_cluster1_veh= GC_Bp_cluster1_veh(1:505);

GC_time_cluster1_veh=GC_time_cluster1_veh(r_nl,:);
GC_time_cluster1_veh = GC_time_cluster1_veh(1:505,:);

fn=1000;
leng=length(GC_cluster1_veh);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster1_veh.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_veh=[];
for i=1:size(x,1)  
   if max(x(i,:))>100 || min(x(i,:))<-100
       c1_veh=[c1_veh;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster1_rat1_veh_median_wa       =GC_cluster1_veh;
GC_Bp_cluster1_rat1_veh_median_wa    =GC_Bp_cluster1_veh;
GC_time_cluster1_rat1_veh_median_wa  =GC_time_cluster1_veh;
i= c1_veh';
GC_cluster1_rat1_veh_median_wa(i,:)       =[];
GC_Bp_cluster1_rat1_veh_median_wa(i,:)    =[];
GC_time_cluster1_rat1_veh_median_wa(i,:)  =[];

clearvars -except GC_cluster1_rat1_veh_median_wa...
GC_Bp_cluster1_rat1_veh_median_wa...
GC_time_cluster1_rat1_veh_median_wa

save GC_cluster1_rat1_veh_median_wa.mat
close all

%% Rat 2
clc
clear
load('waveforms_byRat_cluster1_veh'); 

GC_cluster1_veh           = waveforms_cluster1_raw_rat2_veh(:,1);
GC_Bp_cluster1_veh        = waveforms_cluster1_bp_rat2_veh(:,1);
GC_time_cluster1_veh     = waveforms_cluster1_raw_rat2_veh(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster1_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster1_veh=GC_cluster1_veh(r_nl);
GC_cluster1_veh = GC_cluster1_veh(1:500);

GC_Bp_cluster1_veh=GC_Bp_cluster1_veh(r_nl);
GC_Bp_cluster1_veh= GC_Bp_cluster1_veh(1:500);

GC_time_cluster1_veh=GC_time_cluster1_veh(r_nl,:);
GC_time_cluster1_veh = GC_time_cluster1_veh(1:500,:);

fn=1000;
leng=length(GC_cluster1_veh);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster1_veh.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_veh=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_veh=[c1_veh;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster1_rat2_veh_median_wa       =GC_cluster1_veh;
GC_Bp_cluster1_rat2_veh_median_wa    =GC_Bp_cluster1_veh;
GC_time_cluster1_rat2_veh_median_wa  =GC_time_cluster1_veh;
i= c1_veh';
GC_cluster1_rat2_veh_median_wa(i,:)       =[];
GC_Bp_cluster1_rat2_veh_median_wa(i,:)    =[];
GC_time_cluster1_rat2_veh_median_wa(i,:)  =[];

clearvars -except GC_cluster1_rat2_veh_median_wa...
GC_Bp_cluster1_rat2_veh_median_wa...
GC_time_cluster1_rat2_veh_median_wa

save GC_cluster1_rat2_veh_median_wa.mat
close all

%% Rat 6
clc
clear
load('waveforms_byRat_cluster1_veh'); 

GC_cluster1_veh           = waveforms_cluster1_raw_rat6_veh(:,1);
GC_Bp_cluster1_veh        = waveforms_cluster1_bp_rat6_veh(:,1);
GC_time_cluster1_veh     = waveforms_cluster1_raw_rat6_veh(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster1_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster1_veh=GC_cluster1_veh(r_nl);
GC_cluster1_veh = GC_cluster1_veh(1:500);

GC_Bp_cluster1_veh=GC_Bp_cluster1_veh(r_nl);
GC_Bp_cluster1_veh= GC_Bp_cluster1_veh(1:500);

GC_time_cluster1_veh=GC_time_cluster1_veh(r_nl,:);
GC_time_cluster1_veh = GC_time_cluster1_veh(1:500,:);

fn=1000;
leng=length(GC_cluster1_veh);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster1_veh.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_veh=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_veh=[c1_veh;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster1_rat6_veh_median_wa       =GC_cluster1_veh;
GC_Bp_cluster1_rat6_veh_median_wa    =GC_Bp_cluster1_veh;
GC_time_cluster1_rat6_veh_median_wa  =GC_time_cluster1_veh;
i= c1_veh';
GC_cluster1_rat6_veh_median_wa(i,:)       =[];
GC_Bp_cluster1_rat6_veh_median_wa(i,:)    =[];
GC_time_cluster1_rat6_veh_median_wa(i,:)  =[];

clearvars -except GC_cluster1_rat6_veh_median_wa...
GC_Bp_cluster1_rat6_veh_median_wa...
GC_time_cluster1_rat6_veh_median_wa

save GC_cluster1_rat6_veh_median_wa.mat
close all

%% Rat 9
clc
clear
load('waveforms_byRat_cluster1_veh'); 

GC_cluster1_veh           = waveforms_cluster1_raw_rat9_veh(:,1);
GC_Bp_cluster1_veh        = waveforms_cluster1_bp_rat9_veh(:,1);
GC_time_cluster1_veh     = waveforms_cluster1_raw_rat9_veh(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster1_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster1_veh=GC_cluster1_veh(r_nl);
GC_cluster1_veh = GC_cluster1_veh(1:500);

GC_Bp_cluster1_veh=GC_Bp_cluster1_veh(r_nl);
GC_Bp_cluster1_veh= GC_Bp_cluster1_veh(1:500);

GC_time_cluster1_veh=GC_time_cluster1_veh(r_nl,:);
GC_time_cluster1_veh = GC_time_cluster1_veh(1:500,:);

fn=1000;
leng=length(GC_cluster1_veh);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster1_veh.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_veh=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_veh=[c1_veh;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster1_rat9_veh_median_wa       =GC_cluster1_veh;
GC_Bp_cluster1_rat9_veh_median_wa    =GC_Bp_cluster1_veh;
GC_time_cluster1_rat9_veh_median_wa  =GC_time_cluster1_veh;
i= c1_veh';
GC_cluster1_rat9_veh_median_wa(i,:)       =[];
GC_Bp_cluster1_rat9_veh_median_wa(i,:)    =[];
GC_time_cluster1_rat9_veh_median_wa(i,:)  =[];

clearvars -except GC_cluster1_rat9_veh_median_wa...
GC_Bp_cluster1_rat9_veh_median_wa...
GC_time_cluster1_rat9_veh_median_wa

save GC_cluster1_rat9_veh_median_wa.mat
close all

%% Cluster 2 %%

%% Rat 1
clc
clear
load('waveforms_byRat_cluster2_veh'); 

GC_cluster2_veh           = waveforms_cluster2_raw_rat1_veh(:,1);
GC_Bp_cluster2_veh        = waveforms_cluster2_bp_rat1_veh(:,1);
GC_time_cluster2_veh     = waveforms_cluster2_raw_rat1_veh(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster2_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster2_veh=GC_cluster2_veh(r_nl);
GC_cluster2_veh = GC_cluster2_veh(1:501);

GC_Bp_cluster2_veh=GC_Bp_cluster2_veh(r_nl);
GC_Bp_cluster2_veh= GC_Bp_cluster2_veh(1:501);

GC_time_cluster2_veh=GC_time_cluster2_veh(r_nl,:);
GC_time_cluster2_veh = GC_time_cluster2_veh(1:501,:);

fn=1000;
leng=length(GC_cluster2_veh);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster2_veh.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_veh=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_veh=[c1_veh;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster2_rat1_veh_median_wa       =GC_cluster2_veh;
GC_Bp_cluster2_rat1_veh_median_wa    =GC_Bp_cluster2_veh;
GC_time_cluster2_rat1_veh_median_wa  =GC_time_cluster2_veh;
i= c1_veh';
GC_cluster2_rat1_veh_median_wa(i,:)       =[];
GC_Bp_cluster2_rat1_veh_median_wa(i,:)    =[];
GC_time_cluster2_rat1_veh_median_wa(i,:)  =[];

clearvars -except GC_cluster2_rat1_veh_median_wa...
GC_Bp_cluster2_rat1_veh_median_wa...
GC_time_cluster2_rat1_veh_median_wa

save GC_cluster2_rat1_veh_median_wa.mat
close all

%% Rat 2
clc
clear
load('waveforms_byRat_cluster2_veh'); 

GC_cluster2_veh           = waveforms_cluster2_raw_rat2_veh(:,1);
GC_Bp_cluster2_veh        = waveforms_cluster2_bp_rat2_veh(:,1);
GC_time_cluster2_veh     = waveforms_cluster2_raw_rat2_veh(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster2_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster2_veh=GC_cluster2_veh(r_nl);
GC_cluster2_veh = GC_cluster2_veh(1:502);

GC_Bp_cluster2_veh=GC_Bp_cluster2_veh(r_nl);
GC_Bp_cluster2_veh= GC_Bp_cluster2_veh(1:502);

GC_time_cluster2_veh=GC_time_cluster2_veh(r_nl,:);
GC_time_cluster2_veh = GC_time_cluster2_veh(1:502,:);

fn=1000;
leng=length(GC_cluster2_veh);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster2_veh.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_veh=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_veh=[c1_veh;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster2_rat2_veh_median_wa       =GC_cluster2_veh;
GC_Bp_cluster2_rat2_veh_median_wa    =GC_Bp_cluster2_veh;
GC_time_cluster2_rat2_veh_median_wa  =GC_time_cluster2_veh;
i= c1_veh';
GC_cluster2_rat2_veh_median_wa(i,:)       =[];
GC_Bp_cluster2_rat2_veh_median_wa(i,:)    =[];
GC_time_cluster2_rat2_veh_median_wa(i,:)  =[];

clearvars -except GC_cluster2_rat2_veh_median_wa...
GC_Bp_cluster2_rat2_veh_median_wa...
GC_time_cluster2_rat2_veh_median_wa

save GC_cluster2_rat2_veh_median_wa.mat
close all

%% Rat 6
clc
clear
load('waveforms_byRat_cluster2_veh'); 

GC_cluster2_veh           = waveforms_cluster2_raw_rat6_veh(:,1);
GC_Bp_cluster2_veh        = waveforms_cluster2_bp_rat6_veh(:,1);
GC_time_cluster2_veh     = waveforms_cluster2_raw_rat6_veh(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster2_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster2_veh=GC_cluster2_veh(r_nl);
GC_cluster2_veh = GC_cluster2_veh(1:501);

GC_Bp_cluster2_veh=GC_Bp_cluster2_veh(r_nl);
GC_Bp_cluster2_veh= GC_Bp_cluster2_veh(1:501);

GC_time_cluster2_veh=GC_time_cluster2_veh(r_nl,:);
GC_time_cluster2_veh = GC_time_cluster2_veh(1:501,:);

fn=1000;
leng=length(GC_cluster2_veh);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster2_veh.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_veh=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_veh=[c1_veh;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster2_rat6_veh_median_wa       =GC_cluster2_veh;
GC_Bp_cluster2_rat6_veh_median_wa    =GC_Bp_cluster2_veh;
GC_time_cluster2_rat6_veh_median_wa  =GC_time_cluster2_veh;
i= c1_veh';
GC_cluster2_rat6_veh_median_wa(i,:)       =[];
GC_Bp_cluster2_rat6_veh_median_wa(i,:)    =[];
GC_time_cluster2_rat6_veh_median_wa(i,:)  =[];

clearvars -except GC_cluster2_rat6_veh_median_wa...
GC_Bp_cluster2_rat6_veh_median_wa...
GC_time_cluster2_rat6_veh_median_wa

save GC_cluster2_rat6_veh_median_wa.mat
close all

%% Rat 9
clc
clear
load('waveforms_byRat_cluster2_veh'); 

GC_cluster2_veh           = waveforms_cluster2_raw_rat9_veh(:,1);
GC_Bp_cluster2_veh        = waveforms_cluster2_bp_rat9_veh(:,1);
GC_time_cluster2_veh     = waveforms_cluster2_raw_rat9_veh(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster2_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster2_veh=GC_cluster2_veh(r_nl);
GC_cluster2_veh = GC_cluster2_veh(1:500);

GC_Bp_cluster2_veh=GC_Bp_cluster2_veh(r_nl);
GC_Bp_cluster2_veh= GC_Bp_cluster2_veh(1:500);

GC_time_cluster2_veh=GC_time_cluster2_veh(r_nl,:);
GC_time_cluster2_veh = GC_time_cluster2_veh(1:500,:);

fn=1000;
leng=length(GC_cluster2_veh);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster2_veh.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_veh=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_veh=[c1_veh;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster2_rat9_veh_median_wa       =GC_cluster2_veh;
GC_Bp_cluster2_rat9_veh_median_wa    =GC_Bp_cluster2_veh;
GC_time_cluster2_rat9_veh_median_wa  =GC_time_cluster2_veh;
i= c1_veh';
GC_cluster2_rat9_veh_median_wa(i,:)       =[];
GC_Bp_cluster2_rat9_veh_median_wa(i,:)    =[];
GC_time_cluster2_rat9_veh_median_wa(i,:)  =[];

clearvars -except GC_cluster2_rat9_veh_median_wa...
GC_Bp_cluster2_rat9_veh_median_wa...
GC_time_cluster2_rat9_veh_median_wa

save GC_cluster2_rat9_veh_median_wa.mat
close all


%% Cluster 3 %% 

%% Rat 1
clc
clear
load('waveforms_byRat_cluster3_veh'); 

GC_cluster3_veh           = waveforms_cluster3_raw_rat1_veh(:,1);
GC_Bp_cluster3_veh        = waveforms_cluster3_bp_rat1_veh(:,1);
GC_time_cluster3_veh     = waveforms_cluster3_raw_rat1_veh(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster3_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster3_veh=GC_cluster3_veh(r_nl);
GC_cluster3_veh = GC_cluster3_veh(1:500);

GC_Bp_cluster3_veh=GC_Bp_cluster3_veh(r_nl);
GC_Bp_cluster3_veh= GC_Bp_cluster3_veh(1:500);

GC_time_cluster3_veh=GC_time_cluster3_veh(r_nl,:);
GC_time_cluster3_veh = GC_time_cluster3_veh(1:500,:);

fn=1000;
leng=length(GC_cluster3_veh);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster3_veh.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_veh=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_veh=[c1_veh;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster3_rat1_veh_median_wa       =GC_cluster3_veh;
GC_Bp_cluster3_rat1_veh_median_wa    =GC_Bp_cluster3_veh;
GC_time_cluster3_rat1_veh_median_wa  =GC_time_cluster3_veh;
i= c1_veh';
GC_cluster3_rat1_veh_median_wa(i,:)       =[];
GC_Bp_cluster3_rat1_veh_median_wa(i,:)    =[];
GC_time_cluster3_rat1_veh_median_wa(i,:)  =[];

clearvars -except GC_cluster3_rat1_veh_median_wa...
GC_Bp_cluster3_rat1_veh_median_wa...
GC_time_cluster3_rat1_veh_median_wa

save GC_cluster3_rat1_veh_median_wa.mat
close all

%% Rat 2
clc
clear
load('waveforms_byRat_cluster3_veh'); 

GC_cluster3_veh           = waveforms_cluster3_raw_rat2_veh(:,1);
GC_Bp_cluster3_veh        = waveforms_cluster3_bp_rat2_veh(:,1);
GC_time_cluster3_veh     = waveforms_cluster3_raw_rat2_veh(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster3_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster3_veh=GC_cluster3_veh(r_nl);
GC_cluster3_veh = GC_cluster3_veh(1:500);

GC_Bp_cluster3_veh=GC_Bp_cluster3_veh(r_nl);
GC_Bp_cluster3_veh= GC_Bp_cluster3_veh(1:500);

GC_time_cluster3_veh=GC_time_cluster3_veh(r_nl,:);
GC_time_cluster3_veh = GC_time_cluster3_veh(1:500,:);

fn=1000;
leng=length(GC_cluster3_veh);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster3_veh.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_veh=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_veh=[c1_veh;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster3_rat2_veh_median_wa       =GC_cluster3_veh;
GC_Bp_cluster3_rat2_veh_median_wa    =GC_Bp_cluster3_veh;
GC_time_cluster3_rat2_veh_median_wa  =GC_time_cluster3_veh;
i= c1_veh';
GC_cluster3_rat2_veh_median_wa(i,:)       =[];
GC_Bp_cluster3_rat2_veh_median_wa(i,:)    =[];
GC_time_cluster3_rat2_veh_median_wa(i,:)  =[];

clearvars -except GC_cluster3_rat2_veh_median_wa...
GC_Bp_cluster3_rat2_veh_median_wa...
GC_time_cluster3_rat2_veh_median_wa

save GC_cluster3_rat2_veh_median_wa.mat
close all

%% Rat 6
clc
clear
load('waveforms_byRat_cluster3_veh'); 

GC_cluster3_veh           = waveforms_cluster3_raw_rat6_veh(:,1);
GC_Bp_cluster3_veh        = waveforms_cluster3_bp_rat6_veh(:,1);
GC_time_cluster3_veh     = waveforms_cluster3_raw_rat6_veh(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster3_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster3_veh=GC_cluster3_veh(r_nl);
GC_cluster3_veh = GC_cluster3_veh(1:500);

GC_Bp_cluster3_veh=GC_Bp_cluster3_veh(r_nl);
GC_Bp_cluster3_veh= GC_Bp_cluster3_veh(1:500);

GC_time_cluster3_veh=GC_time_cluster3_veh(r_nl,:);
GC_time_cluster3_veh = GC_time_cluster3_veh(1:500,:);

fn=1000;
leng=length(GC_cluster3_veh);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster3_veh.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_veh=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_veh=[c1_veh;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster3_rat6_veh_median_wa       =GC_cluster3_veh;
GC_Bp_cluster3_rat6_veh_median_wa    =GC_Bp_cluster3_veh;
GC_time_cluster3_rat6_veh_median_wa  =GC_time_cluster3_veh;
i= c1_veh';
GC_cluster3_rat6_veh_median_wa(i,:)       =[];
GC_Bp_cluster3_rat6_veh_median_wa(i,:)    =[];
GC_time_cluster3_rat6_veh_median_wa(i,:)  =[];

clearvars -except GC_cluster3_rat6_veh_median_wa...
GC_Bp_cluster3_rat6_veh_median_wa...
GC_time_cluster3_rat6_veh_median_wa

save GC_cluster3_rat6_veh_median_wa.mat
close all

%% Rat 9
clc
clear
load('waveforms_byRat_cluster3_veh'); 

GC_cluster3_veh           = waveforms_cluster3_raw_rat9_veh(:,1);
GC_Bp_cluster3_veh        = waveforms_cluster3_bp_rat9_veh(:,1);
GC_time_cluster3_veh     = waveforms_cluster3_raw_rat9_veh(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster3_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster3_veh=GC_cluster3_veh(r_nl);
GC_cluster3_veh = GC_cluster3_veh(1:500);

GC_Bp_cluster3_veh=GC_Bp_cluster3_veh(r_nl);
GC_Bp_cluster3_veh= GC_Bp_cluster3_veh(1:500);

GC_time_cluster3_veh=GC_time_cluster3_veh(r_nl,:);
GC_time_cluster3_veh = GC_time_cluster3_veh(1:500,:);

fn=1000;
leng=length(GC_cluster3_veh);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster3_veh.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_veh=[];
for i=1:size(x,1)  
   if max(x(i,:))>100 || min(x(i,:))<-100
       c1_veh=[c1_veh;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster3_rat9_veh_median_wa       =GC_cluster3_veh;
GC_Bp_cluster3_rat9_veh_median_wa    =GC_Bp_cluster3_veh;
GC_time_cluster3_rat9_veh_median_wa  =GC_time_cluster3_veh;
i= c1_veh';
GC_cluster3_rat9_veh_median_wa(i,:)       =[];
GC_Bp_cluster3_rat9_veh_median_wa(i,:)    =[];
GC_time_cluster3_rat9_veh_median_wa(i,:)  =[];

clearvars -except GC_cluster3_rat9_veh_median_wa...
GC_Bp_cluster3_rat9_veh_median_wa...
GC_time_cluster3_rat9_veh_median_wa

save GC_cluster3_rat9_veh_median_wa.mat
close all



%% Concatenate 500 ripples from each rat into a total of 2,000 ripples %%

% Cluster 1
clc
clear
load("GC_cluster1_rat1_veh_median_wa.mat");
load("GC_cluster1_rat2_veh_median_wa.mat");
load("GC_cluster1_rat6_veh_median_wa.mat");
load("GC_cluster1_rat9_veh_median_wa.mat");

GC_cluster1_veh_median_wa = [GC_cluster1_rat1_veh_median_wa;...
    GC_cluster1_rat2_veh_median_wa;...
    GC_cluster1_rat6_veh_median_wa;...
    GC_cluster1_rat9_veh_median_wa];

GC_Bp_cluster1_veh_median_wa = [GC_Bp_cluster1_rat1_veh_median_wa;...
    GC_Bp_cluster1_rat2_veh_median_wa;...
    GC_Bp_cluster1_rat6_veh_median_wa;...
    GC_Bp_cluster1_rat9_veh_median_wa];

clearvars -except GC_cluster1_veh_median_wa GC_Bp_cluster1_veh_median_wa 

save("GC_cluster1_veh_median_wa.mat", "-v7.3");

% Cluster 2
clc
clear
load("GC_cluster2_rat1_veh_median_wa.mat");
load("GC_cluster2_rat2_veh_median_wa.mat");
load("GC_cluster2_rat6_veh_median_wa.mat");
load("GC_cluster2_rat9_veh_median_wa.mat");

GC_cluster2_veh_median_wa = [GC_cluster2_rat1_veh_median_wa;...
    GC_cluster2_rat2_veh_median_wa;...
    GC_cluster2_rat6_veh_median_wa;...
    GC_cluster2_rat9_veh_median_wa];

GC_Bp_cluster2_veh_median_wa = [GC_Bp_cluster2_rat1_veh_median_wa;...
    GC_Bp_cluster2_rat2_veh_median_wa;...
    GC_Bp_cluster2_rat6_veh_median_wa;...
    GC_Bp_cluster2_rat9_veh_median_wa];

clearvars -except GC_cluster2_veh_median_wa GC_Bp_cluster2_veh_median_wa 

save("GC_cluster2_veh_median_wa.mat", "-v7.3");

% Cluster 3
clc
clear
load("GC_cluster3_rat1_veh_median_wa.mat");
load("GC_cluster3_rat2_veh_median_wa.mat");
load("GC_cluster3_rat6_veh_median_wa.mat");
load("GC_cluster3_rat9_veh_median_wa.mat");

GC_cluster3_veh_median_wa = [GC_cluster3_rat1_veh_median_wa;...
    GC_cluster3_rat2_veh_median_wa;...
    GC_cluster3_rat6_veh_median_wa;...
    GC_cluster3_rat9_veh_median_wa];

GC_Bp_cluster3_veh_median_wa = [GC_Bp_cluster3_rat1_veh_median_wa;...
    GC_Bp_cluster3_rat2_veh_median_wa;...
    GC_Bp_cluster3_rat6_veh_median_wa;...
    GC_Bp_cluster3_rat9_veh_median_wa];

clearvars -except GC_cluster3_veh_median_wa GC_Bp_cluster3_veh_median_wa 

save("GC_cluster3_veh_median_wa.mat", "-v7.3");



%%%%%%%%%
%% RGS %%
%%%%%%%%%
%% Prepare data for Granger Analysis!

%% Cluster 1 %%

%% Rat 3
clc
clear
load('waveforms_byRat_cluster1_rgs'); 

GC_cluster1_rgs           = waveforms_cluster1_raw_rat3_rgs(:,1);
GC_Bp_cluster1_rgs        = waveforms_cluster1_bp_rat3_rgs(:,1);
GC_time_cluster1_rgs     = waveforms_cluster1_raw_rat3_rgs(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster1_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster1_rgs=GC_cluster1_rgs(r_nl);
GC_cluster1_rgs = GC_cluster1_rgs(1:501);

GC_Bp_cluster1_rgs=GC_Bp_cluster1_rgs(r_nl);
GC_Bp_cluster1_rgs= GC_Bp_cluster1_rgs(1:501);

GC_time_cluster1_rgs=GC_time_cluster1_rgs(r_nl,:);
GC_time_cluster1_rgs = GC_time_cluster1_rgs(1:501,:);

fn=1000;
leng=length(GC_cluster1_rgs);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster1_rgs.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_rgs=[];
for i=1:size(x,1)  
   if max(x(i,:))>120 || min(x(i,:))<-200
       c1_rgs=[c1_rgs;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster1_rat3_rgs_median_wa       =GC_cluster1_rgs;
GC_Bp_cluster1_rat3_rgs_median_wa    =GC_Bp_cluster1_rgs;
GC_time_cluster1_rat3_rgs_median_wa  =GC_time_cluster1_rgs;
i= c1_rgs';
GC_cluster1_rat3_rgs_median_wa(i,:)       =[];
GC_Bp_cluster1_rat3_rgs_median_wa(i,:)    =[];
GC_time_cluster1_rat3_rgs_median_wa(i,:)  =[];

clearvars -except GC_cluster1_rat3_rgs_median_wa...
GC_Bp_cluster1_rat3_rgs_median_wa...
GC_time_cluster1_rat3_rgs_median_wa

save GC_cluster1_rat3_rgs_median_wa.mat
close all

%% Rat 4
clc
clear
load('waveforms_byRat_cluster1_rgs'); 

GC_cluster1_rgs           = waveforms_cluster1_raw_rat4_rgs(:,1);
GC_Bp_cluster1_rgs        = waveforms_cluster1_bp_rat4_rgs(:,1);
GC_time_cluster1_rgs     = waveforms_cluster1_raw_rat4_rgs(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster1_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster1_rgs=GC_cluster1_rgs(r_nl);
GC_cluster1_rgs = GC_cluster1_rgs(1:500);

GC_Bp_cluster1_rgs=GC_Bp_cluster1_rgs(r_nl);
GC_Bp_cluster1_rgs= GC_Bp_cluster1_rgs(1:500);

GC_time_cluster1_rgs=GC_time_cluster1_rgs(r_nl,:);
GC_time_cluster1_rgs = GC_time_cluster1_rgs(1:500,:);

fn=1000;
leng=length(GC_cluster1_rgs);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster1_rgs.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_rgs=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_rgs=[c1_rgs;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster1_rat4_rgs_median_wa       =GC_cluster1_rgs;
GC_Bp_cluster1_rat4_rgs_median_wa    =GC_Bp_cluster1_rgs;
GC_time_cluster1_rat4_rgs_median_wa  =GC_time_cluster1_rgs;
i= c1_rgs';
GC_cluster1_rat4_rgs_median_wa(i,:)       =[];
GC_Bp_cluster1_rat4_rgs_median_wa(i,:)    =[];
GC_time_cluster1_rat4_rgs_median_wa(i,:)  =[];

clearvars -except GC_cluster1_rat4_rgs_median_wa...
GC_Bp_cluster1_rat4_rgs_median_wa...
GC_time_cluster1_rat4_rgs_median_wa

save GC_cluster1_rat4_rgs_median_wa.mat
close all

%% Rat 7
clc
clear
load('waveforms_byRat_cluster1_rgs'); 

GC_cluster1_rgs           = waveforms_cluster1_raw_rat7_rgs(:,1);
GC_Bp_cluster1_rgs        = waveforms_cluster1_bp_rat7_rgs(:,1);
GC_time_cluster1_rgs     = waveforms_cluster1_raw_rat7_rgs(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster1_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster1_rgs=GC_cluster1_rgs(r_nl);
GC_cluster1_rgs = GC_cluster1_rgs(1:500);

GC_Bp_cluster1_rgs=GC_Bp_cluster1_rgs(r_nl);
GC_Bp_cluster1_rgs= GC_Bp_cluster1_rgs(1:500);

GC_time_cluster1_rgs=GC_time_cluster1_rgs(r_nl,:);
GC_time_cluster1_rgs = GC_time_cluster1_rgs(1:500,:);

fn=1000;
leng=length(GC_cluster1_rgs);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster1_rgs.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_rgs=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_rgs=[c1_rgs;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster1_rat7_rgs_median_wa       =GC_cluster1_rgs;
GC_Bp_cluster1_rat7_rgs_median_wa    =GC_Bp_cluster1_rgs;
GC_time_cluster1_rat7_rgs_median_wa  =GC_time_cluster1_rgs;
i= c1_rgs';
GC_cluster1_rat7_rgs_median_wa(i,:)       =[];
GC_Bp_cluster1_rat7_rgs_median_wa(i,:)    =[];
GC_time_cluster1_rat7_rgs_median_wa(i,:)  =[];

clearvars -except GC_cluster1_rat7_rgs_median_wa...
GC_Bp_cluster1_rat7_rgs_median_wa...
GC_time_cluster1_rat7_rgs_median_wa

save GC_cluster1_rat7_rgs_median_wa.mat
close all

%% Rat 8
clc
clear
load('waveforms_byRat_cluster1_rgs'); 

GC_cluster1_rgs           = waveforms_cluster1_raw_rat8_rgs(:,1);
GC_Bp_cluster1_rgs        = waveforms_cluster1_bp_rat8_rgs(:,1);
GC_time_cluster1_rgs     = waveforms_cluster1_raw_rat8_rgs(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster1_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster1_rgs=GC_cluster1_rgs(r_nl);
GC_cluster1_rgs = GC_cluster1_rgs(1:500);

GC_Bp_cluster1_rgs=GC_Bp_cluster1_rgs(r_nl);
GC_Bp_cluster1_rgs= GC_Bp_cluster1_rgs(1:500);

GC_time_cluster1_rgs=GC_time_cluster1_rgs(r_nl,:);
GC_time_cluster1_rgs = GC_time_cluster1_rgs(1:500,:);

fn=1000;
leng=length(GC_cluster1_rgs);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster1_rgs.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_rgs=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_rgs=[c1_rgs;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster1_rat8_rgs_median_wa       =GC_cluster1_rgs;
GC_Bp_cluster1_rat8_rgs_median_wa    =GC_Bp_cluster1_rgs;
GC_time_cluster1_rat8_rgs_median_wa  =GC_time_cluster1_rgs;
i= c1_rgs';
GC_cluster1_rat8_rgs_median_wa(i,:)       =[];
GC_Bp_cluster1_rat8_rgs_median_wa(i,:)    =[];
GC_time_cluster1_rat8_rgs_median_wa(i,:)  =[];

clearvars -except GC_cluster1_rat8_rgs_median_wa...
GC_Bp_cluster1_rat8_rgs_median_wa...
GC_time_cluster1_rat8_rgs_median_wa

save GC_cluster1_rat8_rgs_median_wa.mat
close all

%% Cluster 2 %%

%% Rat 3
clc
clear
load('waveforms_byRat_cluster2_rgs'); 

GC_cluster2_rgs           = waveforms_cluster2_raw_rat3_rgs(:,1);
GC_Bp_cluster2_rgs        = waveforms_cluster2_bp_rat3_rgs(:,1);
GC_time_cluster2_rgs     = waveforms_cluster2_raw_rat3_rgs(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster2_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster2_rgs=GC_cluster2_rgs(r_nl);
GC_cluster2_rgs = GC_cluster2_rgs(1:500);

GC_Bp_cluster2_rgs=GC_Bp_cluster2_rgs(r_nl);
GC_Bp_cluster2_rgs= GC_Bp_cluster2_rgs(1:500);

GC_time_cluster2_rgs=GC_time_cluster2_rgs(r_nl,:);
GC_time_cluster2_rgs = GC_time_cluster2_rgs(1:500,:);

fn=1000;
leng=length(GC_cluster2_rgs);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster2_rgs.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_rgs=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_rgs=[c1_rgs;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster2_rat3_rgs_median_wa       =GC_cluster2_rgs;
GC_Bp_cluster2_rat3_rgs_median_wa    =GC_Bp_cluster2_rgs;
GC_time_cluster2_rat3_rgs_median_wa  =GC_time_cluster2_rgs;
i= c1_rgs';
GC_cluster2_rat3_rgs_median_wa(i,:)       =[];
GC_Bp_cluster2_rat3_rgs_median_wa(i,:)    =[];
GC_time_cluster2_rat3_rgs_median_wa(i,:)  =[];

clearvars -except GC_cluster2_rat3_rgs_median_wa...
GC_Bp_cluster2_rat3_rgs_median_wa...
GC_time_cluster2_rat3_rgs_median_wa

save GC_cluster2_rat3_rgs_median_wa.mat
close all

%% Rat 4
clc
clear
load('waveforms_byRat_cluster2_rgs'); 

GC_cluster2_rgs           = waveforms_cluster2_raw_rat4_rgs(:,1);
GC_Bp_cluster2_rgs        = waveforms_cluster2_bp_rat4_rgs(:,1);
GC_time_cluster2_rgs     = waveforms_cluster2_raw_rat4_rgs(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster2_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster2_rgs=GC_cluster2_rgs(r_nl);
GC_cluster2_rgs = GC_cluster2_rgs(1:500);

GC_Bp_cluster2_rgs=GC_Bp_cluster2_rgs(r_nl);
GC_Bp_cluster2_rgs= GC_Bp_cluster2_rgs(1:500);

GC_time_cluster2_rgs=GC_time_cluster2_rgs(r_nl,:);
GC_time_cluster2_rgs = GC_time_cluster2_rgs(1:500,:);

fn=1000;
leng=length(GC_cluster2_rgs);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster2_rgs.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_rgs=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_rgs=[c1_rgs;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster2_rat4_rgs_median_wa       =GC_cluster2_rgs;
GC_Bp_cluster2_rat4_rgs_median_wa    =GC_Bp_cluster2_rgs;
GC_time_cluster2_rat4_rgs_median_wa  =GC_time_cluster2_rgs;
i= c1_rgs';
GC_cluster2_rat4_rgs_median_wa(i,:)       =[];
GC_Bp_cluster2_rat4_rgs_median_wa(i,:)    =[];
GC_time_cluster2_rat4_rgs_median_wa(i,:)  =[];

clearvars -except GC_cluster2_rat4_rgs_median_wa...
GC_Bp_cluster2_rat4_rgs_median_wa...
GC_time_cluster2_rat4_rgs_median_wa

save GC_cluster2_rat4_rgs_median_wa.mat
close all

%% Rat 7
clc
clear
load('waveforms_byRat_cluster2_rgs'); 

GC_cluster2_rgs           = waveforms_cluster2_raw_rat7_rgs(:,1);
GC_Bp_cluster2_rgs        = waveforms_cluster2_bp_rat7_rgs(:,1);
GC_time_cluster2_rgs     = waveforms_cluster2_raw_rat7_rgs(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster2_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster2_rgs=GC_cluster2_rgs(r_nl);
GC_cluster2_rgs = GC_cluster2_rgs(1:501);

GC_Bp_cluster2_rgs=GC_Bp_cluster2_rgs(r_nl);
GC_Bp_cluster2_rgs= GC_Bp_cluster2_rgs(1:501);

GC_time_cluster2_rgs=GC_time_cluster2_rgs(r_nl,:);
GC_time_cluster2_rgs = GC_time_cluster2_rgs(1:501,:);

fn=1000;
leng=length(GC_cluster2_rgs);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster2_rgs.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_rgs=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_rgs=[c1_rgs;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster2_rat7_rgs_median_wa       =GC_cluster2_rgs;
GC_Bp_cluster2_rat7_rgs_median_wa    =GC_Bp_cluster2_rgs;
GC_time_cluster2_rat7_rgs_median_wa  =GC_time_cluster2_rgs;
i= c1_rgs';
GC_cluster2_rat7_rgs_median_wa(i,:)       =[];
GC_Bp_cluster2_rat7_rgs_median_wa(i,:)    =[];
GC_time_cluster2_rat7_rgs_median_wa(i,:)  =[];

clearvars -except GC_cluster2_rat7_rgs_median_wa...
GC_Bp_cluster2_rat7_rgs_median_wa...
GC_time_cluster2_rat7_rgs_median_wa

save GC_cluster2_rat7_rgs_median_wa.mat
close all

%% Rat 8
clc
clear
load('waveforms_byRat_cluster2_rgs'); 

GC_cluster2_rgs           = waveforms_cluster2_raw_rat8_rgs(:,1);
GC_Bp_cluster2_rgs        = waveforms_cluster2_bp_rat8_rgs(:,1);
GC_time_cluster2_rgs     = waveforms_cluster2_raw_rat8_rgs(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster2_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster2_rgs=GC_cluster2_rgs(r_nl);
GC_cluster2_rgs = GC_cluster2_rgs(1:502);

GC_Bp_cluster2_rgs=GC_Bp_cluster2_rgs(r_nl);
GC_Bp_cluster2_rgs= GC_Bp_cluster2_rgs(1:502);

GC_time_cluster2_rgs=GC_time_cluster2_rgs(r_nl,:);
GC_time_cluster2_rgs = GC_time_cluster2_rgs(1:502,:);

fn=1000;
leng=length(GC_cluster2_rgs);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster2_rgs.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_rgs=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_rgs=[c1_rgs;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster2_rat8_rgs_median_wa       =GC_cluster2_rgs;
GC_Bp_cluster2_rat8_rgs_median_wa    =GC_Bp_cluster2_rgs;
GC_time_cluster2_rat8_rgs_median_wa  =GC_time_cluster2_rgs;
i= c1_rgs';
GC_cluster2_rat8_rgs_median_wa(i,:)       =[];
GC_Bp_cluster2_rat8_rgs_median_wa(i,:)    =[];
GC_time_cluster2_rat8_rgs_median_wa(i,:)  =[];

clearvars -except GC_cluster2_rat8_rgs_median_wa...
GC_Bp_cluster2_rat8_rgs_median_wa...
GC_time_cluster2_rat8_rgs_median_wa

save GC_cluster2_rat8_rgs_median_wa.mat
close all


%% Cluster 3 %% 

%% Rat 3
clc
clear
load('waveforms_byRat_cluster3_rgs'); 

GC_cluster3_rgs           = waveforms_cluster3_raw_rat3_rgs(:,1);
GC_Bp_cluster3_rgs        = waveforms_cluster3_bp_rat3_rgs(:,1);
GC_time_cluster3_rgs     = waveforms_cluster3_raw_rat3_rgs(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster3_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster3_rgs=GC_cluster3_rgs(r_nl);
GC_cluster3_rgs = GC_cluster3_rgs(1:501);

GC_Bp_cluster3_rgs=GC_Bp_cluster3_rgs(r_nl);
GC_Bp_cluster3_rgs= GC_Bp_cluster3_rgs(1:501);

GC_time_cluster3_rgs=GC_time_cluster3_rgs(r_nl,:);
GC_time_cluster3_rgs = GC_time_cluster3_rgs(1:501,:);

fn=1000;
leng=length(GC_cluster3_rgs);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster3_rgs.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_rgs=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_rgs=[c1_rgs;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster3_rat3_rgs_median_wa       =GC_cluster3_rgs;
GC_Bp_cluster3_rat3_rgs_median_wa    =GC_Bp_cluster3_rgs;
GC_time_cluster3_rat3_rgs_median_wa  =GC_time_cluster3_rgs;
i= c1_rgs';
GC_cluster3_rat3_rgs_median_wa(i,:)       =[];
GC_Bp_cluster3_rat3_rgs_median_wa(i,:)    =[];
GC_time_cluster3_rat3_rgs_median_wa(i,:)  =[];

clearvars -except GC_cluster3_rat3_rgs_median_wa...
GC_Bp_cluster3_rat3_rgs_median_wa...
GC_time_cluster3_rat3_rgs_median_wa

save GC_cluster3_rat3_rgs_median_wa.mat
close all

%% Rat 4
clc
clear
load('waveforms_byRat_cluster3_rgs'); 

GC_cluster3_rgs           = waveforms_cluster3_raw_rat4_rgs(:,1);
GC_Bp_cluster3_rgs        = waveforms_cluster3_bp_rat4_rgs(:,1);
GC_time_cluster3_rgs     = waveforms_cluster3_raw_rat4_rgs(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster3_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster3_rgs=GC_cluster3_rgs(r_nl);
GC_cluster3_rgs = GC_cluster3_rgs(1:503);

GC_Bp_cluster3_rgs=GC_Bp_cluster3_rgs(r_nl);
GC_Bp_cluster3_rgs= GC_Bp_cluster3_rgs(1:503);

GC_time_cluster3_rgs=GC_time_cluster3_rgs(r_nl,:);
GC_time_cluster3_rgs = GC_time_cluster3_rgs(1:503,:);

fn=1000;
leng=length(GC_cluster3_rgs);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster3_rgs.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_rgs=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_rgs=[c1_rgs;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster3_rat4_rgs_median_wa       =GC_cluster3_rgs;
GC_Bp_cluster3_rat4_rgs_median_wa    =GC_Bp_cluster3_rgs;
GC_time_cluster3_rat4_rgs_median_wa  =GC_time_cluster3_rgs;
i= c1_rgs';
GC_cluster3_rat4_rgs_median_wa(i,:)       =[];
GC_Bp_cluster3_rat4_rgs_median_wa(i,:)    =[];
GC_time_cluster3_rat4_rgs_median_wa(i,:)  =[];

clearvars -except GC_cluster3_rat4_rgs_median_wa...
GC_Bp_cluster3_rat4_rgs_median_wa...
GC_time_cluster3_rat4_rgs_median_wa

save GC_cluster3_rat4_rgs_median_wa.mat
close all

%% Rat 7
clc
clear
load('waveforms_byRat_cluster3_rgs'); 

GC_cluster3_rgs           = waveforms_cluster3_raw_rat7_rgs(:,1);
GC_Bp_cluster3_rgs        = waveforms_cluster3_bp_rat7_rgs(:,1);
GC_time_cluster3_rgs     = waveforms_cluster3_raw_rat7_rgs(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster3_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster3_rgs=GC_cluster3_rgs(r_nl);
GC_cluster3_rgs = GC_cluster3_rgs(1:500);

GC_Bp_cluster3_rgs=GC_Bp_cluster3_rgs(r_nl);
GC_Bp_cluster3_rgs= GC_Bp_cluster3_rgs(1:500);

GC_time_cluster3_rgs=GC_time_cluster3_rgs(r_nl,:);
GC_time_cluster3_rgs = GC_time_cluster3_rgs(1:500,:);

fn=1000;
leng=length(GC_cluster3_rgs);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster3_rgs.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_rgs=[];
for i=1:size(x,1)  
   if max(x(i,:))>200 || min(x(i,:))<-200
       c1_rgs=[c1_rgs;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster3_rat7_rgs_median_wa       =GC_cluster3_rgs;
GC_Bp_cluster3_rat7_rgs_median_wa    =GC_Bp_cluster3_rgs;
GC_time_cluster3_rat7_rgs_median_wa  =GC_time_cluster3_rgs;
i= c1_rgs';
GC_cluster3_rat7_rgs_median_wa(i,:)       =[];
GC_Bp_cluster3_rat7_rgs_median_wa(i,:)    =[];
GC_time_cluster3_rat7_rgs_median_wa(i,:)  =[];

clearvars -except GC_cluster3_rat7_rgs_median_wa...
GC_Bp_cluster3_rat7_rgs_median_wa...
GC_time_cluster3_rat7_rgs_median_wa

save GC_cluster3_rat7_rgs_median_wa.mat
close all

%% Rat 8
clc
clear
load('waveforms_byRat_cluster3_rgs'); 

GC_cluster3_rgs           = waveforms_cluster3_raw_rat8_rgs(:,1);
GC_Bp_cluster3_rgs        = waveforms_cluster3_bp_rat8_rgs(:,1);
GC_time_cluster3_rgs     = waveforms_cluster3_raw_rat8_rgs(:,2:4);

R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),GC_Bp_cluster3_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
GC_cluster3_rgs=GC_cluster3_rgs(r_nl);
GC_cluster3_rgs = GC_cluster3_rgs(1:501);

GC_Bp_cluster3_rgs=GC_Bp_cluster3_rgs(r_nl);
GC_Bp_cluster3_rgs= GC_Bp_cluster3_rgs(1:501);

GC_time_cluster3_rgs=GC_time_cluster3_rgs(r_nl,:);
GC_time_cluster3_rgs = GC_time_cluster3_rgs(1:501,:);

fn=1000;
leng=length(GC_cluster3_rgs);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=GC_cluster3_rgs.';

% NOTCH
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

% Run bandpass filter for plotting
cfg.bpfilter = 'yes';
cfg.bpfreq = [100 300];
Data = ft_preprocessing(cfg,Data);

% VISUALLY INSPECT
% Detect artifact (overlay all ripples)
x=[];
for i=1:length(Data.trial)
    i
    v=Data.trial{1,i}(2,:);
    x=[x;v];
end

c1_rgs=[];
for i=1:size(x,1)  
   if max(x(i,:))>100 || min(x(i,:))<-100
       c1_rgs=[c1_rgs;i];
   else
        plot(x(i,:),'b-')
        hold on
   end
        
end
ylim([-300 300])

GC_cluster3_rat8_rgs_median_wa       =GC_cluster3_rgs;
GC_Bp_cluster3_rat8_rgs_median_wa    =GC_Bp_cluster3_rgs;
GC_time_cluster3_rat8_rgs_median_wa  =GC_time_cluster3_rgs;
i= c1_rgs';
GC_cluster3_rat8_rgs_median_wa(i,:)       =[];
GC_Bp_cluster3_rat8_rgs_median_wa(i,:)    =[];
GC_time_cluster3_rat8_rgs_median_wa(i,:)  =[];

clearvars -except GC_cluster3_rat8_rgs_median_wa...
GC_Bp_cluster3_rat8_rgs_median_wa...
GC_time_cluster3_rat8_rgs_median_wa

save GC_cluster3_rat8_rgs_median_wa.mat
close all



%% Concatenate 500 ripples from each rat into a total of 2,000 ripples %%

% Cluster 1
clc
clear
load("GC_cluster1_rat3_rgs_median_wa.mat");
load("GC_cluster1_rat4_rgs_median_wa.mat");
load("GC_cluster1_rat7_rgs_median_wa.mat");
load("GC_cluster1_rat8_rgs_median_wa.mat");

GC_cluster1_rgs_median_wa = [GC_cluster1_rat3_rgs_median_wa;...
    GC_cluster1_rat4_rgs_median_wa;...
    GC_cluster1_rat7_rgs_median_wa;...
    GC_cluster1_rat8_rgs_median_wa];

GC_Bp_cluster1_rgs_median_wa = [GC_Bp_cluster1_rat3_rgs_median_wa;...
    GC_Bp_cluster1_rat4_rgs_median_wa;...
    GC_Bp_cluster1_rat7_rgs_median_wa;...
    GC_Bp_cluster1_rat8_rgs_median_wa];

clearvars -except GC_cluster1_rgs_median_wa GC_Bp_cluster1_rgs_median_wa 

save("GC_cluster1_rgs_median_wa.mat", "-v7.3");

% Cluster 2
clc
clear
load("GC_cluster2_rat3_rgs_median_wa.mat");
load("GC_cluster2_rat4_rgs_median_wa.mat");
load("GC_cluster2_rat7_rgs_median_wa.mat");
load("GC_cluster2_rat8_rgs_median_wa.mat");

GC_cluster2_rgs_median_wa = [GC_cluster2_rat3_rgs_median_wa;...
    GC_cluster2_rat4_rgs_median_wa;...
    GC_cluster2_rat7_rgs_median_wa;...
    GC_cluster2_rat8_rgs_median_wa];

GC_Bp_cluster2_rgs_median_wa = [GC_Bp_cluster2_rat3_rgs_median_wa;...
    GC_Bp_cluster2_rat4_rgs_median_wa;...
    GC_Bp_cluster2_rat7_rgs_median_wa;...
    GC_Bp_cluster2_rat8_rgs_median_wa];

clearvars -except GC_cluster2_rgs_median_wa GC_Bp_cluster2_rgs_median_wa 

save("GC_cluster2_rgs_median_wa.mat", "-v7.3");

% Cluster 3
clc
clear
load("GC_cluster3_rat3_rgs_median_wa.mat");
load("GC_cluster3_rat4_rgs_median_wa.mat");
load("GC_cluster3_rat7_rgs_median_wa.mat");
load("GC_cluster3_rat8_rgs_median_wa.mat");

GC_cluster3_rgs_median_wa = [GC_cluster3_rat3_rgs_median_wa;...
    GC_cluster3_rat4_rgs_median_wa;...
    GC_cluster3_rat7_rgs_median_wa;...
    GC_cluster3_rat8_rgs_median_wa];

GC_Bp_cluster3_rgs_median_wa = [GC_Bp_cluster3_rat3_rgs_median_wa;...
    GC_Bp_cluster3_rat4_rgs_median_wa;...
    GC_Bp_cluster3_rat7_rgs_median_wa;...
    GC_Bp_cluster3_rat8_rgs_median_wa];

clearvars -except GC_cluster3_rgs_median_wa GC_Bp_cluster3_rgs_median_wa 

save("GC_cluster3_rgs_median_wa.mat", "-v7.3");
