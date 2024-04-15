%% Creates multipletdata_v1_29012024.xlsx table for Lisa
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
tableData = table();  % Initialize an empty table
for j=1:numel(ConditionField)
    for k=1:numel(RatField)
        for l=1:numel(Trialname)

bout_ripple_c1=extractSpecificData_with_trials(Day_Bout_ripple_c1,ConditionField(j),RatField(k) ,Trialname(l),fn);
if isempty(bout_ripple_c1)
    continue
end
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

%%
c1=spikes_peak(1).spk;
c2=spikes_peak(2).spk;
c3Short=spikes_peak(3).spk; %seconds
c3Long=spikes_peak(4).spk; %seconds

c1_full=spikes(1).spk;
c2_full=spikes(2).spk;
c3Short_full=spikes(3).spk; %seconds
c3Long_full=spikes(4).spk; %seconds
spindlesHpc_full=spikes(5).spk; %seconds

[c1_start,c1_end]=get_start_end_ts(c1_full);

split_c1=find(diff(c1_full(1:end)*1000)>10);
c1_end=c1_full(split_c1(:));
c1_start=c1_full(split_c1(:)+1);
c1_start=[c1_full(1); c1_start];
c1_end=[ c1_end ;c1_full(end)];


combined=[c1; c2 ;c3Short ;c3Long];
label=[ones(size(c1));ones(size(c2))*2; ones(size(c3Short))*3; ones(size(c3Long))*4 ];
[combined, id]=sort(combined);
label=label(id);
[M_multiplets, Mx_multiplets]=findmultiplets(combined);

singlets=M_multiplets.singlets{1};
singlets_label=label(ismember(combined,singlets));
if ~isempty(M_multiplets.doublets{1})
doublet1=M_multiplets.doublets{1}(:,1);
doublet1_label=label(ismember(combined, doublet1));
doublet2=M_multiplets.doublets{1}(:,2);
doublet2_label=label(ismember(combined, doublet2));
else
doublet1_label=[];
doublet2_label=[];
end

%Find ripples that follow c3short when c3short is the first ripple in a
%doublet
doublet1_c3short_ind=(doublet1_label==3);
if sum(doublet1_c3short_ind)>0 % If there are first ripples in doublets being c3Short
  doublet2_afterc3short=doublet2_label(doublet1_c3short_ind);
else
  doublet2_afterc3short=[];    
end


if ~isempty(M_multiplets.triplets{1})

triplet1=M_multiplets.triplets{1}(:,1);
triplet1_label=label(ismember(combined, triplet1));
triplet2=M_multiplets.triplets{1}(:,2);
triplet2_label=label(ismember(combined, triplet2));
triplet3=M_multiplets.triplets{1}(:,3);
triplet3_label=label(ismember(combined, triplet3));
else
triplet1_label=[];
triplet2_label=[];
triplet3_label=[];
end
%Find ripples that follow c3short when c3short is the first ripple in a
%triplet
triplet1_c3short_ind=(triplet1_label==3);
if sum(triplet1_c3short_ind)>0 % If there are first ripples in triplets being c3Short
  triplet2_afterc3short=triplet2_label(triplet1_c3short_ind);
  triplet3_afterc3short=triplet3_label(triplet1_c3short_ind);  
else
  triplet2_afterc3short=[];    
  triplet3_afterc3short=[];    
end


highermultiplets=[M_multiplets.quatruplets{1}(:); M_multiplets.pentuplets{1}(:); M_multiplets.sextuplets{1}(:); M_multiplets.septuplets{1}(:); M_multiplets.octuplets{1}(:); M_multiplets.nonuplets{1}(:)];
if ~isempty(highermultiplets) % in case there are multiplets

 if ~isempty(M_multiplets.quatruplets{1})
    quatruplet1=M_multiplets.quatruplets{1}(:,1);
    quatruplet1_label=label(ismember(combined, quatruplet1));    
    quatruplet2=M_multiplets.quatruplets{1}(:,2);
    quatruplet2_label=label(ismember(combined, quatruplet2));
    quatruplet3=M_multiplets.quatruplets{1}(:,3);
    quatruplet3_label=label(ismember(combined, quatruplet3));
    [quatruplet2_afterc3short,quatruplet3_afterc3short]=ripple_after_c3short(quatruplet1_label,quatruplet2_label,quatruplet3_label);   
    
 else
     quatruplet1_label=[];
     quatruplet2_label=[];
     quatruplet3_label=[];
     quatruplet2_afterc3short=[];
     quatruplet3_afterc3short=[];
 end
 
 if ~isempty(M_multiplets.pentuplets{1})
    pentuplet1=M_multiplets.pentuplets{1}(:,1);
    pentuplet1_label=label(ismember(combined, pentuplet1));
    pentuplet2=M_multiplets.pentuplets{1}(:,2);
    pentuplet2_label=label(ismember(combined, pentuplet2));
    pentuplet3=M_multiplets.pentuplets{1}(:,3);
    pentuplet3_label=label(ismember(combined, pentuplet3));
[pentuplet2_afterc3short,pentuplet3_afterc3short]=ripple_after_c3short(pentuplet1_label,pentuplet2_label,pentuplet3_label);    
    
 else
     pentuplet1_label=[];     
     pentuplet2_label=[];
     pentuplet3_label=[];
     pentuplet2_afterc3short=[];
     pentuplet3_afterc3short=[];
 end

 if ~isempty(M_multiplets.sextuplets{1})
    sextuplet1=M_multiplets.sextuplets{1}(:,1);
    sextuplet1_label=label(ismember(combined, sextuplet1));
    sextuplet2=M_multiplets.sextuplets{1}(:,2);
    sextuplet2_label=label(ismember(combined, sextuplet2));
    sextuplet3=M_multiplets.sextuplets{1}(:,3);
    sextuplet3_label=label(ismember(combined, sextuplet3));
[sextuplet2_afterc3short,sextuplet3_afterc3short]=ripple_after_c3short(sextuplet1_label,sextuplet2_label,sextuplet3_label);        
 else
     sextuplet1_label=[];     
     sextuplet2_label=[];
     sextuplet3_label=[];
     sextuplet2_afterc3short=[];
     sextuplet3_afterc3short=[];
 end
 
 if ~isempty(M_multiplets.septuplets{1})
    septuplet1=M_multiplets.septuplets{1}(:,1);
    septuplet1_label=label(ismember(combined, septuplet1));     
    septuplet2=M_multiplets.septuplets{1}(:,2);
    septuplet2_label=label(ismember(combined, septuplet2));
    septuplet3=M_multiplets.septuplets{1}(:,3);
    septuplet3_label=label(ismember(combined, septuplet3));
[septuplet2_afterc3short,septuplet3_afterc3short]=ripple_after_c3short(septuplet1_label,septuplet2_label,septuplet3_label);        
 else
    septuplet1_label=[]; 
    septuplet2_label=[];
    septuplet3_label=[];
    septuplet2_afterc3short=[];
    septuplet3_afterc3short=[];
 end
   
 if ~isempty(M_multiplets.octuplets{1})
    octuplet1=M_multiplets.octuplets{1}(:,1);
    octuplet1_label=label(ismember(combined, octuplet1));
    octuplet2=M_multiplets.octuplets{1}(:,2);
    octuplet2_label=label(ismember(combined, octuplet2));
    octuplet3=M_multiplets.octuplets{1}(:,3);
    octuplet3_label=label(ismember(combined, octuplet3));
    [octuplet2_afterc3short,octuplet3_afterc3short]=ripple_after_c3short(octuplet1_label,octuplet2_label,octuplet3_label);    
 else
     octuplet1_label=[];     
     octuplet2_label=[];
     octuplet3_label=[];
     octuplet2_afterc3short=[];
     octuplet3_afterc3short=[];
 end
 
 if ~isempty(M_multiplets.nonuplets{1})
    nonuplet1=M_multiplets.nonuplets{1}(:,1);
    nonuplet1_label=label(ismember(combined, nonuplet1));  
    nonuplet2=M_multiplets.nonuplets{1}(:,2);
    nonuplet2_label=label(ismember(combined, nonuplet2));
    nonuplet3=M_multiplets.nonuplets{1}(:,3);
    nonuplet3_label=label(ismember(combined, nonuplet3));
    [nonuplet2_afterc3short,nonuplet3_afterc3short]=ripple_after_c3short(nonuplet1_label,nonuplet2_label,nonuplet3_label);    
 else
     nonuplet1_label=[];
     nonuplet2_label=[];
     nonuplet3_label=[];
     nonuplet2_afterc3short=[];
     nonuplet3_afterc3short=[];
 end
 
%  multiplet1_label=[quatruplet1_label pentuplet1_label sextuplet1_label septuplet1_label octuplet1_label nonuplet1_label]
%  multiplet2_label=[quatruplet2_label pentuplet2_label sextuplet2_label septuplet2_label octuplet2_label nonuplet2_label];
%  multiplet3_label=[quatruplet3_label pentuplet3_label sextuplet3_label septuplet3_label octuplet3_label nonuplet3_label];

 multiplet2_afterc3short=[quatruplet2_afterc3short pentuplet2_afterc3short sextuplet2_afterc3short septuplet2_afterc3short octuplet2_afterc3short nonuplet2_afterc3short];
 multiplet3_afterc3short=[quatruplet3_afterc3short pentuplet3_afterc3short sextuplet3_afterc3short septuplet3_afterc3short octuplet3_afterc3short nonuplet3_afterc3short];

else 
%  multiplet1_label=[];    
%  multiplet2_label=[];
%  multiplet3_label=[];
 multiplet2_afterc3short=[];
 multiplet3_afterc3short=[];
    
end

vec=[length(combined) length(c1) length(c2) length(c3Short) length(c3Long) length(singlets_label) sum(singlets_label==1) sum(singlets_label==2) sum(singlets_label==3) sum(singlets_label==4)...
length(doublet1_label) sum(doublet1_label==1) sum(doublet1_label==2) sum(doublet1_label==3) sum(doublet1_label==4)...
length(doublet2_label) sum(doublet2_label==1) sum(doublet2_label==2) sum(doublet2_label==3) sum(doublet2_label==4)...
length(triplet1_label) sum(triplet1_label==1) sum(triplet1_label==2) sum(triplet1_label==3) sum(triplet1_label==4) ...
length(triplet2_label) sum(triplet2_label==1) sum(triplet2_label==2) sum(triplet2_label==3) sum(triplet2_label==4) ...
length(triplet3_label) sum(triplet3_label==1) sum(triplet3_label==2) sum(triplet3_label==3) sum(triplet3_label==4) ...
length(highermultiplets) sum(doublet2_afterc3short==1) sum(doublet2_afterc3short==2) sum(doublet2_afterc3short==3) sum(doublet2_afterc3short==4)...
sum(triplet2_afterc3short==1) sum(triplet2_afterc3short==2) sum(triplet2_afterc3short==3) sum(triplet2_afterc3short==4)...
sum(triplet3_afterc3short==1) sum(triplet3_afterc3short==2) sum(triplet3_afterc3short==3) sum(triplet3_afterc3short==4)...
sum(multiplet2_afterc3short==1) sum(multiplet2_afterc3short==2) sum(multiplet2_afterc3short==3) sum(multiplet2_afterc3short==4)...
sum(multiplet3_afterc3short==1) sum(multiplet3_afterc3short==2) sum(multiplet3_afterc3short==3) sum(multiplet3_afterc3short==4)];
    newRow = [ table({(ConditionField{j})}, 'VariableNames', {'Condition'}) ,table({(RatField{k})}, 'VariableNames', {'RatID'}) ,table({(Trialname{l})}, 'VariableNames', {'Trial'}),array2table(vec)];
    tableData = [tableData; newRow];
    
        end
        
    end
end
xo
cd('/home/adrian/Documents/rgs_clusters_figs')
% filename = 'multipletdata_v1_29012024.xlsx';
filename = 'multipletdata_v3_16022024.xlsx';
writetable(tableData,filename,'Sheet',1)