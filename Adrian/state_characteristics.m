%     hmm_postfit(i_trial).sequence: array of dimension [4,nseq] where columns represent detected states (intervals with prob(state)>0.8), in the order they appear in trial
%         i_trial, and rows represent state [onset,offset,duration,label].

%Total duration.
%state=1;
for state=1:10
st_ind=find(hmm_postfit.sequence(4,:)==state);

st_duration{state}=hmm_postfit.sequence(3,st_ind);
st_total_duration(state)=sum(st_duration{state})/60; %minutes
st_bout_count(state)=length(st_duration{state});

end
%%
bar(1:10,(st_total_duration)/60,'FaceColor',[0 0 1])
ylabel('Hours')
h=gca;
h.XAxis.FontSize=14;
h.YAxis.FontSize=14;
xlabel('State')
h.Title.FontSize=16;
h.Title.String='State total duration';
ylim([0 5])
%%
bar(1:10,((st_bout_count)),'FaceColor',[1 0 0])
ylabel('Counts')
h=gca;
h.XAxis.FontSize=14;
h.YAxis.FontSize=14;
xlabel('State')
h.Title.FontSize=16;
h.Title.String='State bout count'
%%
% bar(1:10,(st_total_duration./st_bout_count))
% violin(cellfun(@transpose,st_duration,'UniformOutput',false))
addpath('/home/adrian/Downloads/violin')

% Create a 1x10 cell array with varying data lengths in each cell
% data_cell = cell(1, 10);
% for i = 1:numel(data_cell)
%     N = randi([10, 30]);  % Generate a random value for N
%     data_cell{i} = randn(N, 1);  % Generate random data of length N
% end
data_cell=cellfun(@transpose,st_duration,'UniformOutput',false);

% Find the maximum length of data
max_length = max(cellfun(@numel, data_cell));

% Pad each data cell with NaNs to make them the same length
padded_data = cellfun(@(x) [x; nan(max_length - numel(x), 1)], data_cell, 'UniformOutput', false);

% Convert the padded cell array into a numeric array for boxplot
numeric_data = cell2mat(padded_data');

array_10 = reshape(numeric_data, length(numeric_data)/10, 10);
%%
close all
violin2(array_10)
ylim([0 1])
h=gca;
h.XTick=[1:10];
xlabel('State')
ylabel('Seconds')
h.Title.String='State bout durations'
h.Title.FontSize=16;
h.XAxis.FontSize=14;
h.YAxis.FontSize=14;

%%
% Create a cell array for x-axis labels
labels = cellstr(num2str((1:numel(data_cell))'));

% Create a boxplot for the numeric data
figure;
boxplot(numeric_data, 'Labels', labels);
title('Boxplot of Varying Length Data');
ylabel('Values');
xlabel('Cell Index');
