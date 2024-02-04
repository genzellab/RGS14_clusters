cd('/home/adrian/Documents/rgs_clusters_figs')
num_states=11; %Number of states
%     hmm_postfit(i_trial).sequence: array of dimension [4,nseq] where columns represent detected states (intervals with prob(state)>0.8), in the order they appear in trial
%         i_trial, and rows represent state [onset,offset,duration,label].
states_HC=load('hmmdecoding_HC_c3split_11states.mat');
states_OS=load('hmmdecoding_OS_c3split_11states.mat');
states_stable=load('hmmdecoding_stable_c3split_11states.mat');
states_moving=load('hmmdecoding_moving_c3split_11states.mat');

%These values were obtained from the length_concatenatedData variable in
%'markov_studyday_splitC3.m'. Units are in samples. 
HC_total_duration=38095000;
Stable_total_duration=27847000;
Moving_total_duration=    73612000;
OS_total_duration=101459000;
fn=1000;

[StateMetric_HC]=state_metrics(states_HC.hmm_postfit,num_states,HC_total_duration/fn/60); % total duration in minutes
[StateMetric_OS]=state_metrics(states_OS.hmm_postfit,num_states,OS_total_duration/fn/60);
[StateMetric_stable]=state_metrics(states_stable.hmm_postfit,num_states,Stable_total_duration/fn/60);
[StateMetric_moving]=state_metrics(states_moving.hmm_postfit,num_states,Moving_total_duration/fn/60);

xo
%bout duration tables
bd_table_HC=bout_duration_table(StateMetric_HC);
bd_table_OS=bout_duration_table(StateMetric_OS);
bd_table_stable=bout_duration_table(StateMetric_stable);
bd_table_moving=bout_duration_table(StateMetric_moving);

column_names = {'Mean duration (ms)', 'SD (ms)', 'Counts', 'Total duration (min)'};
T = table(bd_table_HC(:, 1), bd_table_HC(:, 2), bd_table_HC(:, 3), bd_table_HC(:, 4), 'VariableNames', column_names);
filename = 'DurationStatesBouts_c3split_11states.xlsx';
writetable(T,filename,'Sheet','HC','Range','A1:Z15')

column_names = {'Mean duration (ms)', 'SD (ms)', 'Counts', 'Total duration (min)'};
T = table(bd_table_OS(:, 1), bd_table_OS(:, 2), bd_table_OS(:, 3), bd_table_OS(:, 4), 'VariableNames', column_names);
filename = 'DurationStatesBouts_c3split_11states.xlsx';
writetable(T,filename,'Sheet','OS','Range','A1:Z15')

column_names = {'Mean duration (ms)', 'SD (ms)', 'Counts', 'Total duration (min)'};
T = table(bd_table_stable(:, 1), bd_table_stable(:, 2), bd_table_stable(:, 3), bd_table_stable(:, 4), 'VariableNames', column_names);
filename = 'DurationStatesBouts_c3split_11states.xlsx';
writetable(T,filename,'Sheet','stable','Range','A1:Z15')

column_names = {'Mean duration (ms)', 'SD (ms)', 'Counts', 'Total duration (min)'};
T = table(bd_table_moving(:, 1), bd_table_moving(:, 2), bd_table_moving(:, 3), bd_table_moving(:, 4), 'VariableNames', column_names);
filename = 'DurationStatesBouts_c3split_11states.xlsx';
writetable(T,filename,'Sheet','moving','Range','A1:Z15')

%Total duration.
%state=1;

% num_states=10; %number of states
% for state=1:num_states
% st_ind=find(hmm_postfit.sequence(4,:)==state);
% 
% st_duration{state}=hmm_postfit.sequence(3,st_ind);
% st_total_duration(state)=sum(st_duration{state})/60; %minutes
% st_bout_count(state)=length(st_duration{state});
% 
% end
%% TOTAL DURATION
%bar(1:10,(StateMetric_HC.total_duration)/sum(StateMetric_HC.total_duration),'FaceColor',[0 0 1])
totaldur_HM=(StateMetric_HC.total_duration)/sum(StateMetric_HC.total_duration); 
% totaldur_HM(3)=[];
totaldur_OS=(StateMetric_OS.total_duration)/sum(StateMetric_OS.total_duration);
% totaldur_OS(3)=[];
totaldur_stable=(StateMetric_stable.total_duration)/sum(StateMetric_stable.total_duration);
% totaldur_stable(3)=[];
totaldur_moving=(StateMetric_moving.total_duration)/sum(StateMetric_moving.total_duration);
% totaldur_moving(3)=[];
allscreen()

td=[totaldur_HM;totaldur_OS;totaldur_stable;totaldur_moving].'*100;
%T = table(td);
% Assign column names
column_names = {'HM', 'OS', 'Stable', 'Moving'};
T = table(td(:, 1), td(:, 2), td(:, 3), td(:, 4), 'VariableNames', column_names);

filename = 'TotalDurationStates_c3split_11states.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z15')

bar(td)
L=legend('Homecage','OS','Stable','Moving');
L.FontSize=14;
% ylabel('Hours')
ylabel('Percentage of time')
h=gca;
h.XAxis.FontSize=14;
h.YAxis.FontSize=14;
xlabel('State')
h.Title.FontSize=16;
% h.Title.String='State total time (zoomed in)';
h.Title.String='State total time  (zoomed in)';

h.Children(4).FaceColor=[0.5 0.5 0.5];
h.Children(3).FaceColor=[0 1 0.3];
h.Children(2).FaceColor=[0 0 1];
h.Children(1).FaceColor=[1 0.3 0];

h.XTickLabel(end)={'Undetermined'}
%printing_image('State total time (zoomed in)')
%ylim([0 10])
%% Total duration minus Homecage (TDMH)
allscreen()
tdmh=[totaldur_OS-totaldur_HM;totaldur_stable-totaldur_HM;totaldur_moving-totaldur_HM].'*100;
bar(tdmh)
T = table(tdmh);
filename = 'TotalDurationMinusHC_c3split_11states.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z15')

L=legend('OS-HC','Stable-HC','Moving-HC');
L.FontSize=14;
% ylabel('Hours')
ylabel('Percentage of time')
h=gca;
h.XAxis.FontSize=14;
h.YAxis.FontSize=14;
xlabel('State')
h.Title.FontSize=16;
% h.Title.String='State total time (zoomed in)';
h.Title.String='State total time (Condition - Homecage)';

h.Children(3).FaceColor=[0 1 0.3];
h.Children(2).FaceColor=[0 0 1];
h.Children(1).FaceColor=[1 0.3 0];

%printing_image('State total time (zoomed in)')
% ylim([0 10])

%% Bout count
boutcount_HM=(StateMetric_HC.bout_count)/sum(StateMetric_HC.bout_count); 
boutcount_OS=(StateMetric_OS.bout_count)/sum(StateMetric_OS.bout_count);
boutcount_stable=(StateMetric_stable.bout_count)/sum(StateMetric_stable.bout_count);
boutcount_moving=(StateMetric_moving.bout_count)/sum(StateMetric_moving.bout_count);

allscreen()
bc=[boutcount_HM;boutcount_OS;boutcount_stable;boutcount_moving].'*100;
column_names = {'HM', 'OS', 'Stable', 'Moving'};
T = table(bc(:, 1), bc(:, 2), bc(:, 3), bc(:, 4), 'VariableNames', column_names);

filename = 'BoutCount_c3split_11states.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z15')


bar(bc)

L=legend('Homecage','OS','Stable','Moving');
L.FontSize=14;
% ylabel('Hours')
ylabel('Percentage of bouts')
h=gca;
h.XAxis.FontSize=14;
h.YAxis.FontSize=14;
xlabel('State')
h.Title.FontSize=16;
% h.Title.String='State total time (zoomed in)';
h.Title.String='State bout counts ';

h.Children(4).FaceColor=[0.5 0.5 0.5];
h.Children(3).FaceColor=[0 1 0.3];
h.Children(2).FaceColor=[0 0 1];
h.Children(1).FaceColor=[1 0.3 0];
%printing('States bout counts')
%% Bout count minus Homecage (BCMH)
allscreen()
bcmh=[boutcount_OS-boutcount_HM;boutcount_stable-boutcount_HM;boutcount_moving-boutcount_HM].'*100;
bar(bcmh)
T = table(bcmh);
filename = 'BoutCountMinusHC_c3split_11states.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1:Z15')

L=legend('OS-HC','Stable-HC','Moving-HC');
L.FontSize=14;
% ylabel('Hours')
ylabel('Percentage of bouts')
h=gca;
h.XAxis.FontSize=14;
h.YAxis.FontSize=14;
xlabel('State')
h.Title.FontSize=16;
% h.Title.String='State total time (zoomed in)';
h.Title.String='State bout counts (Condition - Homecage)';

h.Children(3).FaceColor=[0 1 0.3];
h.Children(2).FaceColor=[0 0 1];
h.Children(1).FaceColor=[1 0.3 0];

%printing_image('State bout counts minus HC')
%%

%%
% bar(1:10,((st_bout_count)),'FaceColor',[1 0 0])
% ylabel('Counts')
% h=gca;
% h.XAxis.FontSize=14;
% h.YAxis.FontSize=14;
% xlabel('State')
% h.Title.FontSize=16;
% h.Title.String='State bout count'
%%
% bar(1:10,(st_total_duration./st_bout_count))
% violin(cellfun(@transpose,st_duration,'UniformOutput',false))
addpath('/home/adrian/Downloads/violin')
[array10_HC]=convert2matrix(StateMetric_HC.individual_durations);
[array10_OS]=convert2matrix(StateMetric_OS.individual_durations);
[array10_stable]=convert2matrix(StateMetric_stable.individual_durations);
[array10_moving]=convert2matrix(StateMetric_moving.individual_durations);

%%
close all
allscreen()
violin2(interleave2(array10_HC, array10_stable, 'col'))
ylim([0 1])
h=gca;
h.XTick=[1:20];
h.XTickLabel=[    {'1' }
    {'1' }
    {'2' }
    {'2' }
    {'3' }
    {'3' }
    {'4' }
    {'4' }
    {'5' }
    {'5'}
    {'6'}
    {'6'}
    {'7'}
    {'7'}
    {'8'}
    {'8'}
    {'9'}
    {'9'}
    {'10'}
    {'10'}
    ];
xlabel('State')
ylabel('Seconds')
h.Title.String='State bout durations (HC vs Stable)'
h.Title.FontSize=16;
h.XAxis.FontSize=14;
h.YAxis.FontSize=14;
% 
% h.Children(3).FaceColor=[0 1 0.3];
% h.Children(9).FaceColor=[0 1 0.3];
% h.Children(15).FaceColor=[0 1 0.3];
% h.Children(21).FaceColor=[0 1 0.3];
% h.Children(27).FaceColor=[0 1 0.3];
% h.Children(33).FaceColor=[0 1 0.3];
% h.Children(39).FaceColor=[0 1 0.3];
% h.Children(45).FaceColor=[0 1 0.3];
% h.Children(51).FaceColor=[0 1 0.3];
% h.Children(57).FaceColor=[0 1 0.3];

%sTABLE
h.Children(3).FaceColor=[0 0 1]; %[1 0.3 0]
h.Children(9).FaceColor=[0 0 1];
h.Children(15).FaceColor=[0 0 1];
h.Children(21).FaceColor=[0 0 1];
h.Children(27).FaceColor=[0 0 1];
h.Children(33).FaceColor=[0 0 1];
h.Children(39).FaceColor=[0 0 1];
h.Children(45).FaceColor=[0 0 1];
h.Children(51).FaceColor=[0 0 1];
h.Children(57).FaceColor=[0 0 1];

%mOVING
% h.Children(3).FaceColor=[1 0.3 0]; %[1 0.3 0]
% h.Children(9).FaceColor=[1 0.3 0];
% h.Children(15).FaceColor=[1 0.3 0];
% h.Children(21).FaceColor=[1 0.3 0];
% h.Children(27).FaceColor=[1 0.3 0];
% h.Children(33).FaceColor=[1 0.3 0];
% h.Children(39).FaceColor=[1 0.3 0];
% h.Children(45).FaceColor=[1 0.3 0];
% h.Children(51).FaceColor=[1 0.3 0];
% h.Children(57).FaceColor=[1 0.3 0];

h.Children(3+3).FaceColor=[0.5 0.5 0.5];
h.Children(9+3).FaceColor=[0.5 0.5 0.5];
h.Children(15+3).FaceColor=[0.5 0.5 0.5];
h.Children(21+3).FaceColor=[0.5 0.5 0.5];
h.Children(27+3).FaceColor=[0.5 0.5 0.5];
h.Children(33+3).FaceColor=[0.5 0.5 0.5];
h.Children(39+3).FaceColor=[0.5 0.5 0.5];
h.Children(45+3).FaceColor=[0.5 0.5 0.5];
h.Children(51+3).FaceColor=[0.5 0.5 0.5];
h.Children(57+3).FaceColor=[0.5 0.5 0.5];

%printing_image('bout_durations_HC_vs_OS')
printing_image('bout_durations_HC_vs_stable')
%printing_image('bout_durations_HC_vs_moving')

% 
% h.Children(3).FaceColor=[0 1 0.3];
% h.Children(2).FaceColor=[0 0 1];
% h.Children(1).FaceColor=[1 0.3 0];
%%
% % Create a cell array for x-axis labels
% labels = cellstr(num2str((1:numel(data_cell))'));
% 
% % Create a boxplot for the numeric data
% figure;
% boxplot(numeric_data, 'Labels', labels);
% title('Boxplot of Varying Length Data');
% ylabel('Values');
% xlabel('Cell Index');
