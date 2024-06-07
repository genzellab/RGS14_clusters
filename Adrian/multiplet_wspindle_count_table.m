%% Creates multipletdata_v1_29012024.xlsx table for Lisa
clear variables
addpath(genpath('/home/adrian/Documents/GitHub/RGS14_clusters/Adrian'))
addpath(genpath('/home/adrian/Documents/GitHub/RGS14_clusters/Kopal'))
addpath(genpath('/home/adrian/Documents/GitHub/ADRITOOLS/'));

% cd('/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/RGSfiles_ForAdrian')
cd('/home/adrian/Documents/GitHub/RGS14_clusters/Adrian')
%load('veh_data_hmm_c3split_with_trials.mat')
load('veh_data_hmm_c3split_with_trials_v2_27052024.mat')
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

[bout_ripple_c1,~,Bout_ripple_c1]=extractSpecificData_with_trials(Day_Bout_ripple_c1,ConditionField(j),RatField(k) ,Trialname(l),fn);
if isempty(bout_ripple_c1)
    continue
end
% bout_ripple_c2=extractSpecificData_with_trials(Day_Bout_ripple_c2,ConditionField(j),RatField(k),Trialname(l),fn);
% bout_ripple_c3Short=extractSpecificData_with_trials(Day_Bout_ripple_c3Short,ConditionField(j),RatField(k),Trialname(l),fn);
% bout_ripple_c3Long=extractSpecificData_with_trials(Day_Bout_ripple_c3Long,ConditionField(j),RatField(k),Trialname(l),fn);
% bout_spindle=extractSpecificData_with_trials(Day_Bout_spindle,ConditionField(j),RatField(k),Trialname(l),fn);
% bout_spindles_hpc=extractSpecificData_with_trials(Day_Bout_spindles_hpc,ConditionField(j),RatField(k),Trialname(l),fn);
% bout_delta=extractSpecificData_with_trials(Day_Bout_delta,ConditionField(j),RatField(k),Trialname(l),fn);
[bout_ripple_c2, ~, Bout_ripple_c2] = extractSpecificData_with_trials(Day_Bout_ripple_c2, ConditionField(j), RatField(k), Trialname(l), fn);
[bout_ripple_c3Short, ~, Bout_ripple_c3Short] = extractSpecificData_with_trials(Day_Bout_ripple_c3Short, ConditionField(j), RatField(k), Trialname(l), fn);
[bout_ripple_c3Long, ~, Bout_ripple_c3Long] = extractSpecificData_with_trials(Day_Bout_ripple_c3Long, ConditionField(j), RatField(k), Trialname(l), fn);
[bout_spindle, ~, Bout_spindle] = extractSpecificData_with_trials(Day_Bout_spindle, ConditionField(j), RatField(k), Trialname(l), fn);
[bout_spindles_hpc, ~, Bout_spindles_hpc] = extractSpecificData_with_trials(Day_Bout_spindles_hpc, ConditionField(j), RatField(k), Trialname(l), fn);
[bout_delta, ~, Bout_delta] = extractSpecificData_with_trials(Day_Bout_delta, ConditionField(j), RatField(k), Trialname(l), fn);

[bout_delta_hpc,length_concatenatedData,Bout_delta_hpc]=extractSpecificData_with_trials(Day_Bout_delta_hpc,ConditionField(j),RatField(k),Trialname(l),fn);

% pbout_ripple_c1=extractSpecificData_with_trials(Day_Pbout_ripple_c1,ConditionField(j),RatField(k),Trialname(l),fn);
% pbout_ripple_c2=extractSpecificData_with_trials(Day_Pbout_ripple_c2,ConditionField(j),RatField(k),Trialname(l),fn);
% pbout_ripple_c3Short=extractSpecificData_with_trials(Day_Pbout_ripple_c3Short,ConditionField(j),RatField(k),Trialname(l),fn);
% pbout_ripple_c3Long=extractSpecificData_with_trials(Day_Pbout_ripple_c3Long,ConditionField(j),RatField(k),Trialname(l),fn);
% pbout_spindle=extractSpecificData_with_trials(Day_Pbout_spindle,ConditionField(j),RatField(k),Trialname(l),fn);
% pbout_spindles_hpc=extractSpecificData_with_trials(Day_Pbout_spindles_hpc,ConditionField(j),RatField(k),Trialname(l),fn);
% pbout_delta=extractSpecificData_with_trials(Day_Pbout_delta,ConditionField(j),RatField(k),Trialname(l),fn);
% pbout_delta_hpc=extractSpecificData_with_trials(Day_Pbout_delta_hpc,ConditionField(j),RatField(k),Trialname(l),fn);
[pbout_ripple_c1, ~, Pbout_ripple_c1] = extractSpecificData_with_trials(Day_Pbout_ripple_c1, ConditionField(j), RatField(k), Trialname(l), fn);
[pbout_ripple_c2, ~, Pbout_ripple_c2] = extractSpecificData_with_trials(Day_Pbout_ripple_c2, ConditionField(j), RatField(k), Trialname(l), fn);
[pbout_ripple_c3Short, ~, Pbout_ripple_c3Short] = extractSpecificData_with_trials(Day_Pbout_ripple_c3Short, ConditionField(j), RatField(k), Trialname(l), fn);
[pbout_ripple_c3Long, ~, Pbout_ripple_c3Long] = extractSpecificData_with_trials(Day_Pbout_ripple_c3Long, ConditionField(j), RatField(k), Trialname(l), fn);
[pbout_spindle, ~, Pbout_spindle] = extractSpecificData_with_trials(Day_Pbout_spindle, ConditionField(j), RatField(k), Trialname(l), fn);
[pbout_spindles_hpc, ~, Pbout_spindles_hpc] = extractSpecificData_with_trials(Day_Pbout_spindles_hpc, ConditionField(j), RatField(k), Trialname(l), fn);
[pbout_delta, ~, Pbout_delta] = extractSpecificData_with_trials(Day_Pbout_delta, ConditionField(j), RatField(k), Trialname(l), fn);
[pbout_delta_hpc, ~, Pbout_delta_hpc] = extractSpecificData_with_trials(Day_Pbout_delta_hpc, ConditionField(j), RatField(k), Trialname(l), fn);


win_train=[zeros(1,1) length_concatenatedData]/fn; %Should be in seconds
[num2str(length_concatenatedData/fn/60/60) ' hours'] 

%% Convert to spikes
% spikes is a struct array with dimension [ntrials,nunits] and field .spk containing spike times


% N = length(nrem_end); % Number of rows
N=1;
M = 8; % Number of columns
clear spikes spikes_peak Spikes Spikes__peak
spikes = struct('spk', cell(N, M));
spikes_peak=struct('spk', cell(N, M));
Spikes = struct('spk', cell(N, M));
Spikes_peak=struct('spk', cell(N, M));

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

        Spikes(i, 1).spk = Bout_ripple_c1.'; 
        Spikes(i, 2).spk = Bout_ripple_c2.'; 
        Spikes(i, 3).spk = Bout_ripple_c3Short.';
        Spikes(i, 4).spk = Bout_ripple_c3Long.';
        Spikes(i, 5).spk = Bout_spindles_hpc.';
        Spikes(i, 6).spk = Bout_spindle.'; 
        Spikes(i, 7).spk = Bout_delta_hpc.';
        Spikes(i, 8).spk = Bout_delta.'; 

        Spikes_peak(i, 1).spk = Pbout_ripple_c1.'; 
        Spikes_peak(i, 2).spk = Pbout_ripple_c2.'; 
        Spikes_peak(i, 3).spk = Pbout_ripple_c3Short.'; 
        Spikes_peak(i, 4).spk = Pbout_ripple_c3Long.';
        Spikes_peak(i, 5).spk = Pbout_spindles_hpc.';
        Spikes_peak(i, 6).spk = Pbout_spindle.'; 
        Spikes_peak(i, 7).spk = Pbout_delta_hpc.';
        Spikes_peak(i, 8).spk = Pbout_delta.'; 
        
%    end
end

%% 
%Only the ripple peaks are relevant for double checking
c1=spikes_peak(1).spk;
c2=spikes_peak(2).spk;
c3Short=spikes_peak(3).spk; %seconds
c3Long=spikes_peak(4).spk; %seconds
spindlesHpc=spikes_peak(5).spk;
spindles=spikes_peak(6).spk;

C1=Spikes_peak(1).spk;
C2=Spikes_peak(2).spk;
C3Short=Spikes_peak(3).spk; %seconds
C3Long=Spikes_peak(4).spk; %seconds

% We get the full duration of events
c1_full=spikes(1).spk;
c2_full=spikes(2).spk;
c3Short_full=spikes(3).spk; %seconds
c3Long_full=spikes(4).spk; %seconds
spindlesHpc_full=spikes(5).spk; %seconds
spindles_full=spikes(6).spk; %seconds
C1_full=Spikes(1).spk;
C2_full=Spikes(2).spk;
C3Short_full=Spikes(3).spk; %seconds
C3Long_full=Spikes(4).spk; %seconds
SpindlesHpc_full=Spikes(5).spk; %seconds
Spindles_full=Spikes(6).spk; %seconds


[c1_start,c1_end]=get_start_end_ts(C1_full,c1);
[c2_start,c2_end]=get_start_end_ts(C2_full,c2);
[c3Short_start,c3Short_end]=get_start_end_ts(C3Short_full,c3Short);
[c3Long_start,c3Long_end]=get_start_end_ts(C3Long_full,c3Long);
[spindlesHpc_start,spindlesHpc_end]=get_start_end_ts(SpindlesHpc_full,spindlesHpc);
[spindles_start,spindles_end]=get_start_end_ts(Spindles_full,spindles);


combined_start=[c1_start; c2_start ;c3Short_start ;c3Long_start];
combined_end=[c1_end; c2_end ;c3Short_end ;c3Long_end];
combined=[c1; c2 ;c3Short ;c3Long];
label=[ones(size(c1));ones(size(c2))*2; ones(size(c3Short))*3; ones(size(c3Long))*4 ];
[combined, id]=sort(combined);
label=label(id);
combined_start=combined_start(id);
combined_end=combined_end(id);
[M_multiplets, Mx_multiplets]=findmultiplets(combined);

singlets=M_multiplets.singlets{1};
singlets_label=label(ismember(combined,singlets));
singlets_start=combined_start(ismember(combined,singlets));
singlets_end=combined_end(ismember(combined,singlets));

[Co_index_ripples_singlet_c1_spindlesHPC,Co_index_spindlesHPC_singlet_c1_spindlesHPC,~,~]= cooccurence_both_sides(singlets_start(singlets_label==1),singlets_end(singlets_label==1), spindlesHpc_start, spindlesHpc_end);
[Co_index_ripples_singlet_c1_spindlesPFC,Co_index_spindlesPFC_singlet_c1_spindlesPFC,~,~]= cooccurence_both_sides(singlets_start(singlets_label==1),singlets_end(singlets_label==1), spindles_start, spindles_end);
[Co_index_ripples_singlet_c2_spindlesHPC,Co_index_spindlesHPC_singlet_c2_spindlesHPC,~,~]= cooccurence_both_sides(singlets_start(singlets_label==2),singlets_end(singlets_label==2), spindlesHpc_start, spindlesHpc_end);
[Co_index_ripples_singlet_c2_spindlesPFC,Co_index_spindlesPFC_singlet_c2_spindlesPFC,~,~]= cooccurence_both_sides(singlets_start(singlets_label==2),singlets_end(singlets_label==2), spindles_start, spindles_end);
[Co_index_ripples_singlet_c3short_spindlesHPC,Co_index_spindlesHPC_singlet_c3short_spindlesHPC,~,~]= cooccurence_both_sides(singlets_start(singlets_label==3),singlets_end(singlets_label==3), spindlesHpc_start, spindlesHpc_end);
[Co_index_ripples_singlet_c3short_spindlesPFC,Co_index_spindlesPFC_singlet_c3short_spindlesPFC,~,~]= cooccurence_both_sides(singlets_start(singlets_label==3),singlets_end(singlets_label==3), spindles_start, spindles_end);
[Co_index_ripples_singlet_c3long_spindlesHPC,Co_index_spindlesHPC_singlet_c3long_spindlesHPC,~,~]= cooccurence_both_sides(singlets_start(singlets_label==4),singlets_end(singlets_label==4), spindlesHpc_start, spindlesHpc_end);
[Co_index_ripples_singlet_c3long_spindlesPFC,Co_index_spindlesPFC_singlet_c3long_spindlesPFC,~,~]= cooccurence_both_sides(singlets_start(singlets_label==4),singlets_end(singlets_label==4), spindles_start, spindles_end);


if ~isempty(M_multiplets.doublets{1})
doublet1=M_multiplets.doublets{1}(:,1);
doublet1_label=label(ismember(combined, doublet1));
doublet1_start=combined_start(ismember(combined,doublet1));
%doublet1_end=combined_end(ismember(combined,doublet1));

doublet2=M_multiplets.doublets{1}(:,2);
doublet2_label=label(ismember(combined, doublet2));
%doublet2_start=combined_start(ismember(combined,doublet2));
doublet2_end=combined_end(ismember(combined,doublet2));

else
doublet1_label=[];
doublet2_label=[];

doublet1_start=[];
%doublet1_end=[];
%doublet2_start=[];
doublet2_end=[];
end

%Find ripples that follow c3short when c3short is the first ripple in a
%doublet
doublet1_c3short_ind=(doublet1_label==3);
if sum(doublet1_c3short_ind)>0 % If there are first ripples in doublets being c3Short
  doublet2_afterc3short=doublet2_label(doublet1_c3short_ind);
  
  doublet1_c3short_start=doublet1_start(doublet1_c3short_ind);
  %doublet1_c3short_end=doublet1_end(doublet1_c3short_ind);

  %doublet2_afterc3short_start=doublet2_start(doublet1_c3short_ind);
  doublet2_afterc3short_end=doublet2_end(doublet1_c3short_ind);
  
else
  doublet2_afterc3short=[];  
  
  doublet1_c3short_start=[];
  %doublet1_c3short_end=[];
  %doublet2_afterc3short_start=[];
  doublet2_afterc3short_end=[];
end

[Co_index_ripples_doublet1_c3short_spindlesHPC,Co_index_spindlesHPC_doublet1_c3short_spindlesHPC,~,~]= cooccurence_both_sides(doublet1_c3short_start,doublet2_afterc3short_end, spindlesHpc_start, spindlesHpc_end);
[Co_index_ripples_doublet1_c3short_spindlesPFC,Co_index_spindlesPFC_doublet1_c3short_spindlesPFC,~,~]= cooccurence_both_sides(doublet1_c3short_start,doublet2_afterc3short_end, spindles_start, spindles_end);


if ~isempty(Co_index_ripples_doublet1_c3short_spindlesHPC)
    %xo
    %count_co_doublet1_c3short_spindlesHPC=length(Co_index_ripples_doublet1_c3short_spindlesHPC);
    label_doublet2_doublet1_c3short_spindlesHPC=doublet2_afterc3short(Co_index_ripples_doublet1_c3short_spindlesHPC);
else
    %count_co_doublet1_c3short_spindlesHPC=0;
    label_doublet2_doublet1_c3short_spindlesHPC=0;
end

if ~isempty(Co_index_ripples_doublet1_c3short_spindlesPFC)
    %xo
    %count_co_doublet1_c3short_spindlesHPC=length(Co_index_ripples_doublet1_c3short_spindlesHPC);
    label_doublet2_doublet1_c3short_spindles=doublet2_afterc3short(Co_index_ripples_doublet1_c3short_spindlesPFC);
else
    %count_co_doublet1_c3short_spindlesHPC=0;
    label_doublet2_doublet1_c3short_spindles=0;
end

if ~isempty(M_multiplets.triplets{1})

triplet1=M_multiplets.triplets{1}(:,1);
triplet1_label=label(ismember(combined, triplet1));
triplet2=M_multiplets.triplets{1}(:,2);
triplet2_label=label(ismember(combined, triplet2));
triplet3=M_multiplets.triplets{1}(:,3);
triplet3_label=label(ismember(combined, triplet3));

%triplet start-end
triplet1_start=combined_start(ismember(combined,triplet1));
triplet3_end=combined_end(ismember(combined,triplet3));


else
triplet1_label=[];
triplet2_label=[];
triplet3_label=[];

triplet1_start=[];
triplet3_end=[];

end
%Find ripples that follow c3short when c3short is the first ripple in a
%triplet
triplet1_c3short_ind=(triplet1_label==3);
if sum(triplet1_c3short_ind)>0 % If there are first ripples in triplets being c3Short

    
  triplet2_afterc3short=triplet2_label(triplet1_c3short_ind);
  triplet3_afterc3short=triplet3_label(triplet1_c3short_ind); 
  
  triplet1_c3short_start=triplet1_start(triplet1_c3short_ind);
  triplet3_c3short_end=triplet3_end(triplet1_c3short_ind); 

  
else
  triplet2_afterc3short=[];    
  triplet3_afterc3short=[];   
  
  triplet1_c3short_start=[];
  triplet3_c3short_end=[];
end

[Co_index_ripples_triplet1_c3short_spindlesHPC,Co_index_spindlesHPC_triplet1_c3short_spindlesHPC,~,~]= cooccurence_both_sides(triplet1_c3short_start,triplet3_c3short_end, spindlesHpc_start, spindlesHpc_end);
[Co_index_ripples_triplet1_c3short_spindlesPFC,Co_index_spindlesPFC_triplet1_c3short_spindlesPFC,~,~]= cooccurence_both_sides(triplet1_c3short_start,triplet3_c3short_end, spindles_start, spindles_end);


if ~isempty(Co_index_ripples_triplet1_c3short_spindlesHPC)
    %xo
    label_triplet2_triplet1_c3short_spindlesHPC=triplet2_afterc3short(Co_index_ripples_triplet1_c3short_spindlesHPC);
    label_triplet3_triplet1_c3short_spindlesHPC=triplet3_afterc3short(Co_index_ripples_triplet1_c3short_spindlesHPC);
    
else
    label_triplet2_triplet1_c3short_spindlesHPC=0;
    label_triplet3_triplet1_c3short_spindlesHPC=0;      
end

if ~isempty(Co_index_ripples_triplet1_c3short_spindlesPFC)
    %xo
    label_triplet2_triplet1_c3short_spindles=triplet2_afterc3short(Co_index_ripples_triplet1_c3short_spindlesPFC);
    label_triplet3_triplet1_c3short_spindles=triplet3_afterc3short(Co_index_ripples_triplet1_c3short_spindlesPFC);
    
else
    label_triplet2_triplet1_c3short_spindles=0;
    label_triplet3_triplet1_c3short_spindles=0;      
end


highermultiplets=[M_multiplets.quatruplets{1}(:); M_multiplets.pentuplets{1}(:); M_multiplets.sextuplets{1}(:); M_multiplets.septuplets{1}(:); M_multiplets.octuplets{1}(:); M_multiplets.nonuplets{1}(:)];
if ~isempty(highermultiplets) % in case there are multiplets

%%%%%%%    
multiplet_types = {'quatruplets', 'pentuplets', 'sextuplets', 'septuplets', 'octuplets', 'nonuplets'};
num_columns_for_each_type = [4, 5, 6, 7, 8, 9];  % Number of columns for each multiplet type

multiplet_outputs = struct();

for multiplet_idx = 1:length(multiplet_types)
    multiplet_name = multiplet_types{multiplet_idx};
    num_columns = num_columns_for_each_type(multiplet_idx);
    
    if ~isempty(M_multiplets.(multiplet_name){1})
        multiplet = M_multiplets.(multiplet_name){1};
        labels_array = cell(1, num_columns);
        starts = cell(1, num_columns);
        ends = cell(1, num_columns);
        
        for column_idx = 1:num_columns
            current_multiplet = multiplet(:, column_idx);
            labels_array{column_idx} = label(ismember(combined, current_multiplet));
            starts{column_idx} = combined_start(ismember(combined, current_multiplet));
            ends{column_idx} = combined_end(ismember(combined, current_multiplet));
        end
        
        [afterc3short2, afterc3short3, start_c3short, end_c3short] = ripple_after_c3short(labels_array{1}, labels_array{2}, labels_array{3}, starts{1}, ends{end});
        
        multiplet_outputs.(multiplet_name) = struct(...
            'labels', {labels_array}, ...
            'starts', {starts}, ...
            'ends', {ends}, ...
            'afterc3short2', afterc3short2, ...
            'afterc3short3', afterc3short3, ...
            'start_c3short', start_c3short, ...
            'end_c3short', end_c3short ...
        );
        
        if ~isempty(start_c3short) && ~isempty(end_c3short)
            %xo
            %Co-occurrence with HPC spindles
            [Co_index_ripplesHpc, Co_index_spindlesHpc, ~, ~] = cooccurence_both_sides(start_c3short, end_c3short, spindlesHpc_start, spindlesHpc_end);
            multiplet_outputs.(multiplet_name).Co_index_ripplesHpc = Co_index_ripplesHpc;
            multiplet_outputs.(multiplet_name).Co_index_spindlesHpc = Co_index_spindlesHpc;
            
            % Co-occurrence with cortical spindles
            [Co_index_ripplesPfc, Co_index_spindlesPfc, ~, ~] = cooccurence_both_sides(start_c3short, end_c3short, spindles_start, spindles_end);
            multiplet_outputs.(multiplet_name).Co_index_ripplesPfc = Co_index_ripplesPfc;
            multiplet_outputs.(multiplet_name).Co_index_spindlesPfc = Co_index_spindlesPfc;
            
        else
            multiplet_outputs.(multiplet_name).Co_index_ripplesHpc = [];
            multiplet_outputs.(multiplet_name).Co_index_spindlesHpc = [];
            multiplet_outputs.(multiplet_name).Co_index_ripplesPfc = [];
            multiplet_outputs.(multiplet_name).Co_index_spindlesPfc = [];
            
        end
    else
        labels_array = cell(1, num_columns);
        starts = cell(1, num_columns);
        ends = cell(1, num_columns);
        afterc3short2 = [];
        afterc3short3 = [];
        start_c3short = [];
        end_c3short = [];
        
        multiplet_outputs.(multiplet_name) = struct(...
            'labels', {labels_array}, ...
            'starts', {starts}, ...
            'ends', {ends}, ...
            'afterc3short2', afterc3short2, ...
            'afterc3short3', afterc3short3, ...
            'start_c3short', start_c3short, ...
            'end_c3short', end_c3short);%;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;...
%            'Co_index_ripples', [], ...
%            'Co_index_spindles', [] ...
%        );
            multiplet_outputs.(multiplet_name).Co_index_ripplesHpc = [];
            multiplet_outputs.(multiplet_name).Co_index_spindlesHpc = [];
            multiplet_outputs.(multiplet_name).Co_index_ripplesPfc = [];
            multiplet_outputs.(multiplet_name).Co_index_spindlesPfc = [];
        
    end
end
    
    
%%%%%%    
% % % % % % %  if ~isempty(M_multiplets.quatruplets{1})
% % % % % % %     quatruplet1=M_multiplets.quatruplets{1}(:,1);
% % % % % % %     quatruplet1_label=label(ismember(combined, quatruplet1));    
% % % % % % %     quatruplet2=M_multiplets.quatruplets{1}(:,2);
% % % % % % %     quatruplet2_label=label(ismember(combined, quatruplet2));
% % % % % % %     quatruplet3=M_multiplets.quatruplets{1}(:,3);
% % % % % % %     quatruplet3_label=label(ismember(combined, quatruplet3));
% % % % % % %     quatruplet4=M_multiplets.quatruplets{1}(:,4);
% % % % % % %     
% % % % % % %     
% % % % % % %     quatruplet1_start=combined_start(ismember(combined,quatruplet1));
% % % % % % %     quatruplet4_end=combined_end(ismember(combined,quatruplet4));
% % % % % % % 
% % % % % % %     
% % % % % % %     [quatruplet2_afterc3short,quatruplet3_afterc3short,quatruplet1_c3short_start,quatruplet4_c3short_end]=ripple_after_c3short(quatruplet1_label,quatruplet2_label,quatruplet3_label,quatruplet1_start,quatruplet4_end);
% % % % % % %     
% % % % % % %     [Co_index_ripples_quatruplet1_c3short_spindlesHPC,Co_index_spindlesHPC_quatruplet1_c3short_spindlesHPC,~,~]= cooccurence_both_sides(quatruplet1_c3short_start,quatruplet4_c3short_end, spindlesHpc_start, spindlesHpc_end);
% % % % % % %     
% % % % % % %  else
% % % % % % %      quatruplet1_label=[];
% % % % % % %      quatruplet2_label=[];
% % % % % % %      quatruplet3_label=[];
% % % % % % %      quatruplet2_afterc3short=[];
% % % % % % %      quatruplet3_afterc3short=[];
% % % % % % %      
% % % % % % %      quatruplet1_start=[];
% % % % % % %      quatruplet4_end=[];
% % % % % % %      
% % % % % % %      quatruplet1_c3short_start=[];
% % % % % % %      quatruplet4_c3short_end=[];
% % % % % % %      
% % % % % % %      Co_index_ripples_quatruplet1_c3short_spindlesHPC=[];
% % % % % % %      Co_index_spindlesHPC_quatruplet1_c3short_spindlesHPC=[];
% % % % % % %  end
% % % % % % %  
% % % % % % %  if ~isempty(M_multiplets.pentuplets{1})
% % % % % % %     pentuplet1=M_multiplets.pentuplets{1}(:,1);
% % % % % % %     pentuplet1_label=label(ismember(combined, pentuplet1));
% % % % % % %     pentuplet2=M_multiplets.pentuplets{1}(:,2);
% % % % % % %     pentuplet2_label=label(ismember(combined, pentuplet2));
% % % % % % %     pentuplet3=M_multiplets.pentuplets{1}(:,3);
% % % % % % %     pentuplet3_label=label(ismember(combined, pentuplet3));
% % % % % % %     
% % % % % % %     pentuplet5=M_multiplets.pentuplets{1}(:,5);
% % % % % % % 
% % % % % % %     
% % % % % % %     pentuplet1_start=combined_start(ismember(combined,pentuplet1));
% % % % % % %     pentuplet5_end=combined_end(ismember(combined,pentuplet5));
% % % % % % % 
% % % % % % %         
% % % % % % %     [pentuplet2_afterc3short,pentuplet3_afterc3short,pentuplet1_c3short_start,pentuplet5_c3short_end]=ripple_after_c3short(pentuplet1_label,pentuplet2_label,pentuplet3_label,pentuplet1_start,pentuplet5_end);    
% % % % % % %     [Co_index_ripples_pentuplet1_c3short_spindlesHPC,Co_index_spindlesHPC_pentuplet1_c3short_spindlesHPC,~,~]= cooccurence_both_sides(pentuplet1_c3short_start,pentuplet5_c3short_end, spindlesHpc_start, spindlesHpc_end);
% % % % % % % 
% % % % % % %     
% % % % % % %  else
% % % % % % %      pentuplet1_label=[];     
% % % % % % %      pentuplet2_label=[];
% % % % % % %      pentuplet3_label=[];
% % % % % % %      pentuplet2_afterc3short=[];
% % % % % % %      pentuplet3_afterc3short=[];
% % % % % % %      
% % % % % % %      pentuplet1_start=[];
% % % % % % %      pentuplet5_end=[];
% % % % % % %      pentuplet1_c3short_start=[];
% % % % % % %      pentuplet5_c3short_end=[];
% % % % % % %      Co_index_ripples_pentuplet1_c3short_spindlesHPC=[];
% % % % % % %      Co_index_spindlesHPC_pentuplet1_c3short_spindlesHPC=[];
% % % % % % %  end
% % % % % % % 
% % % % % % %  if ~isempty(M_multiplets.sextuplets{1})
% % % % % % %     sextuplet1=M_multiplets.sextuplets{1}(:,1);
% % % % % % %     sextuplet1_label=label(ismember(combined, sextuplet1));
% % % % % % %     sextuplet2=M_multiplets.sextuplets{1}(:,2);
% % % % % % %     sextuplet2_label=label(ismember(combined, sextuplet2));
% % % % % % %     sextuplet3=M_multiplets.sextuplets{1}(:,3);
% % % % % % %     sextuplet3_label=label(ismember(combined, sextuplet3));
% % % % % % % [sextuplet2_afterc3short,sextuplet3_afterc3short]=ripple_after_c3short(sextuplet1_label,sextuplet2_label,sextuplet3_label);        
% % % % % % %  else
% % % % % % %      sextuplet1_label=[];     
% % % % % % %      sextuplet2_label=[];
% % % % % % %      sextuplet3_label=[];
% % % % % % %      sextuplet2_afterc3short=[];
% % % % % % %      sextuplet3_afterc3short=[];
% % % % % % %  end
% % % % % % %  
% % % % % % %  if ~isempty(M_multiplets.septuplets{1})
% % % % % % %     septuplet1=M_multiplets.septuplets{1}(:,1);
% % % % % % %     septuplet1_label=label(ismember(combined, septuplet1));     
% % % % % % %     septuplet2=M_multiplets.septuplets{1}(:,2);
% % % % % % %     septuplet2_label=label(ismember(combined, septuplet2));
% % % % % % %     septuplet3=M_multiplets.septuplets{1}(:,3);
% % % % % % %     septuplet3_label=label(ismember(combined, septuplet3));
% % % % % % % [septuplet2_afterc3short,septuplet3_afterc3short]=ripple_after_c3short(septuplet1_label,septuplet2_label,septuplet3_label);        
% % % % % % %  else
% % % % % % %     septuplet1_label=[]; 
% % % % % % %     septuplet2_label=[];
% % % % % % %     septuplet3_label=[];
% % % % % % %     septuplet2_afterc3short=[];
% % % % % % %     septuplet3_afterc3short=[];
% % % % % % %  end
% % % % % % %    
% % % % % % %  if ~isempty(M_multiplets.octuplets{1})
% % % % % % %     octuplet1=M_multiplets.octuplets{1}(:,1);
% % % % % % %     octuplet1_label=label(ismember(combined, octuplet1));
% % % % % % %     octuplet2=M_multiplets.octuplets{1}(:,2);
% % % % % % %     octuplet2_label=label(ismember(combined, octuplet2));
% % % % % % %     octuplet3=M_multiplets.octuplets{1}(:,3);
% % % % % % %     octuplet3_label=label(ismember(combined, octuplet3));
% % % % % % %     [octuplet2_afterc3short,octuplet3_afterc3short]=ripple_after_c3short(octuplet1_label,octuplet2_label,octuplet3_label);    
% % % % % % %  else
% % % % % % %      octuplet1_label=[];     
% % % % % % %      octuplet2_label=[];
% % % % % % %      octuplet3_label=[];
% % % % % % %      octuplet2_afterc3short=[];
% % % % % % %      octuplet3_afterc3short=[];
% % % % % % %  end
% % % % % % %  
% % % % % % %  if ~isempty(M_multiplets.nonuplets{1})
% % % % % % %     nonuplet1=M_multiplets.nonuplets{1}(:,1);
% % % % % % %     nonuplet1_label=label(ismember(combined, nonuplet1));  
% % % % % % %     nonuplet2=M_multiplets.nonuplets{1}(:,2);
% % % % % % %     nonuplet2_label=label(ismember(combined, nonuplet2));
% % % % % % %     nonuplet3=M_multiplets.nonuplets{1}(:,3);
% % % % % % %     nonuplet3_label=label(ismember(combined, nonuplet3));
% % % % % % %     [nonuplet2_afterc3short,nonuplet3_afterc3short]=ripple_after_c3short(nonuplet1_label,nonuplet2_label,nonuplet3_label);    
% % % % % % %  else
% % % % % % %      nonuplet1_label=[];
% % % % % % %      nonuplet2_label=[];
% % % % % % %      nonuplet3_label=[];
% % % % % % %      nonuplet2_afterc3short=[];
% % % % % % %      nonuplet3_afterc3short=[];
% % % % % % %  end
 
%  multiplet1_label=[quatruplet1_label pentuplet1_label sextuplet1_label septuplet1_label octuplet1_label nonuplet1_label]
%  multiplet2_label=[quatruplet2_label pentuplet2_label sextuplet2_label septuplet2_label octuplet2_label nonuplet2_label];
%  multiplet3_label=[quatruplet3_label pentuplet3_label sextuplet3_label septuplet3_label octuplet3_label nonuplet3_label];


%  multiplet2_afterc3short=[quatruplet2_afterc3short pentuplet2_afterc3short sextuplet2_afterc3short septuplet2_afterc3short octuplet2_afterc3short nonuplet2_afterc3short];
%  multiplet3_afterc3short=[quatruplet3_afterc3short pentuplet3_afterc3short sextuplet3_afterc3short septuplet3_afterc3short octuplet3_afterc3short nonuplet3_afterc3short];
multiplet2_afterc3short=[multiplet_outputs.quatruplets.afterc3short2 multiplet_outputs.pentuplets.afterc3short2 multiplet_outputs.sextuplets.afterc3short2 multiplet_outputs.septuplets.afterc3short2 multiplet_outputs.octuplets.afterc3short2 multiplet_outputs.nonuplets.afterc3short2];
multiplet2_afterc3short = [multiplet_outputs.quatruplets.afterc3short3, ...
                           multiplet_outputs.pentuplets.afterc3short3, ...
                           multiplet_outputs.sextuplets.afterc3short3, ...
                           multiplet_outputs.septuplets.afterc3short3, ...
                           multiplet_outputs.octuplets.afterc3short3, ...
                           multiplet_outputs.nonuplets.afterc3short3];

% multiplet2_afterc3short=[];
%  multiplet3_afterc3short=[];
else 
%  multiplet1_label=[];    
%  multiplet2_label=[];
%  multiplet3_label=[];
 multiplet2_afterc3short=[];
 multiplet3_afterc3short=[];

multiplet_types = {'quatruplets', 'pentuplets', 'sextuplets', 'septuplets', 'octuplets', 'nonuplets'};

for emptyhigh = 1:length(multiplet_types)
    multiplet_name = multiplet_types{emptyhigh};
    multiplet_outputs.(multiplet_name).Co_index_ripplesHpc = [];
    multiplet_outputs.(multiplet_name).Co_index_spindlesHpc = [];
    multiplet_outputs.(multiplet_name).Co_index_ripplesPfc = [];
    multiplet_outputs.(multiplet_name).Co_index_spindlesPfc = [];
end
 
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
sum(multiplet3_afterc3short==1) sum(multiplet3_afterc3short==2) sum(multiplet3_afterc3short==3) sum(multiplet3_afterc3short==4)...
length(Co_index_ripples_singlet_c1_spindlesHPC)...
length(Co_index_ripples_singlet_c2_spindlesHPC)...
length(Co_index_ripples_singlet_c3short_spindlesHPC)...
length(Co_index_ripples_singlet_c3long_spindlesHPC)...
length(Co_index_ripples_doublet1_c3short_spindlesHPC) ...
length(Co_index_ripples_triplet1_c3short_spindlesHPC)...
length(multiplet_outputs.quatruplets.Co_index_ripplesHpc)...
length(Co_index_ripples_singlet_c1_spindlesPFC)...
length(Co_index_ripples_singlet_c2_spindlesPFC)...
length(Co_index_ripples_singlet_c3short_spindlesPFC)...
length(Co_index_ripples_singlet_c3long_spindlesPFC)...
length(Co_index_ripples_doublet1_c3short_spindlesPFC)...
 length(Co_index_ripples_triplet1_c3short_spindlesPFC)...
length(multiplet_outputs.quatruplets.Co_index_ripplesPfc)];%...
%length(multiplet_outputs.pentuplets.Co_index_ripplesHpc)...
% length(multiplet_outputs.sextuplets.Co_index_ripplesHpc)...
% length(multiplet_outputs.septuplets.Co_index_ripplesHpc)...
% length(multiplet_outputs.octuplets.Co_index_ripplesHpc)...
% length(multiplet_outputs.nonuplets.Co_index_ripplesHpc)...

% length(multiplet_outputs.pentuplets.Co_index_ripplesPfc)...
% length(multiplet_outputs.sextuplets.Co_index_ripplesPfc)...
% length(multiplet_outputs.septuplets.Co_index_ripplesPfc)...
% length(multiplet_outputs.octuplets.Co_index_ripplesPfc)...
% length(multiplet_outputs.nonuplets.Co_index_ripplesPfc)];
    newRow = [ table({(ConditionField{j})}, 'VariableNames', {'Condition'}) ,table({(RatField{k})}, 'VariableNames', {'RatID'}) ,table({(Trialname{l})}, 'VariableNames', {'Trial'}),array2table(vec)];
    tableData = [tableData; newRow];

        end
        
    end
end
xo
cd('/home/adrian/Documents/rgs_clusters_figs')
% filename = 'multipletdata_v1_29012024.xlsx';
%filename = 'multipletdata_v3_16022024.xlsx';
filename = 'multipletdata_v5_04062024.xlsx';

writetable(tableData,filename,'Sheet',1)