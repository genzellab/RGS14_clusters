%Computes lags between different ripple types. 
% Purpose is to determine if behaviour is more doublet-like or
% singlet-like.

%Start by running the second half of "prepare_markov_nontrial_splitC3.m"
%This would generate the spikes_peak variable you need here. 

c1=spikes_peak(1).spk;
c2=spikes_peak(2).spk;
c3Short=spikes_peak(3).spk; %seconds
c3Long=spikes_peak(4).spk; %seconds

%%
lagLim=0.500; %0.500
lagLimLow=0;
%C1
[lag_c1c2]=doublets_vec(c1,c2,lagLimLow,lagLim);
[lag_c1c3Short]=doublets_vec(c1,c3Short,lagLimLow,lagLim);
[lag_c1c3Long]=doublets_vec(c1,c3Long,lagLimLow,lagLim);
[lag_c1c1]=doublets_vec(c1,c1,lagLimLow,lagLim);

%C2
[lag_c2c1]=doublets_vec(c2,c1,lagLimLow,lagLim);
[lag_c2c3Short]=doublets_vec(c2,c3Short,lagLimLow,lagLim);
[lag_c2c3Long]=doublets_vec(c2,c3Long,lagLimLow,lagLim);
[lag_c2c2]=doublets_vec(c2,c2,lagLimLow,lagLim);

%C3Short
[lag_c3Shortc1]=doublets_vec(c3Short,c1,lagLimLow,lagLim);
[lag_c3Shortc2]=doublets_vec(c3Short,c2,lagLimLow,lagLim);
[lag_c3Shortc3Long]=doublets_vec(c3Short,c3Long,lagLimLow,lagLim);
[lag_c3Shortc3Short]=doublets_vec(c3Short,c3Short,lagLimLow,lagLim);


%C3Long
[lag_c3Longc1]=doublets_vec(c3Long,c1,lagLimLow,lagLim);
[lag_c3Longc2]=doublets_vec(c3Long,c2,lagLimLow,lagLim);
[lag_c3Longc3Short]=doublets_vec(c3Long,c3Short,lagLimLow,lagLim);
[lag_c3Longc3Long]=doublets_vec(c3Long,c3Long,lagLimLow,lagLim);
%%

% List of all variables
all_variables = {lag_c1c2, lag_c1c3Short, lag_c1c3Long, lag_c1c1, ...
                  lag_c2c1, lag_c2c3Short, lag_c2c3Long, lag_c2c2, ...
                  lag_c3Shortc1, lag_c3Shortc2, lag_c3Shortc3Long, lag_c3Shortc3Short, ...
                  lag_c3Longc1, lag_c3Longc2, lag_c3Longc3Short, lag_c3Longc3Long};

% Find the minimum length among variables
min_length = min(cellfun(@length, all_variables))

all_lengths = (cellfun(@length, all_variables));

% Randomly sample each variable to have the minimum length
% List of lag variables
lag_variables = {'lag_c1c2', 'lag_c1c3Short', 'lag_c1c3Long', 'lag_c1c1', ...
                 'lag_c2c1', 'lag_c2c3Short', 'lag_c2c3Long', 'lag_c2c2', ...
                 'lag_c3Shortc1', 'lag_c3Shortc2', 'lag_c3Shortc3Long', 'lag_c3Shortc3Short', ...
                 'lag_c3Longc1', 'lag_c3Longc2', 'lag_c3Longc3Short', 'lag_c3Longc3Long'};
lag_down_variables= {'lag_down_c1c2', 'lag_down_c1c3Short', 'lag_down_c1c3Long', 'lag_down_c1c1', ...
                 'lag_down_c2c1', 'lag_down_c2c3Short', 'lag_down_c2c3Long', 'lag_down_c2c2', ...
                 'lag_down_c3Shortc1', 'lag_down_c3Shortc2', 'lag_down_c3Shortc3Long', 'lag_down_c3Shortc3Short', ...
                 'lag_down_c3Longc1', 'lag_down_c3Longc2', 'lag_down_c3Longc3Short', 'lag_down_c3Longc3Long'};
%%
iter=1000;
H_list=zeros(iter,length(lag_variables));
nbin=10;
for p=1:iter % 500 iterations
    % Set a seed for reproducibility
    rng(p);  

    % Loop through each lag variable
    for i = 1:length(lag_variables)
        % Randomly sample the lag variable to have the desired length
        eval([lag_down_variables{i} '= datasample(' lag_variables{i} ', min_length, ''Replace'', false);']);
      
        H_list(p,i)=get_bits(eval(lag_down_variables{i}),nbin);
    end
end
%%
values=mean(H_list);
std_devs=std(H_list);
z_values=zscore(H_list);
CoefVar=std_devs./values.*100;
SEM=std_devs./sqrt(all_lengths);
%%
% Create boxplot
boxplot(H_list, 'Labels', lag_variables);

% Add labels and title
xlabel('Labels');
ylabel('Values');
title('Boxplot of Values for Each Label');
%%
% values=SEM;
% Create bar plot
bar(1:numel(lag_variables), values);
hold on;
errorbar(1:numel(lag_variables), values, SEM, 'r.', 'LineWidth', 1.5);

% Customize the plot
xticks(1:numel(lag_variables));
xticklabels(lag_variables);
xlabel('Lag Variables');
ylabel('Values');
title('Bar Plot of Lag Variables');

% Rotate x-axis labels for better readability
xtickangle(45);

% Display the values on top of the bars
text(1:numel(lag_variables), values, num2str(values', '%.4f'), ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
 %ylim([3.1 3.3])
%% (COMPLETE) Plots normalized histograms and custumized kernel density estimate.
nbin=10;%100;
ylimval=.3%0.08;
pts = linspace(lagLimLow,lagLim*1000,1000);
allscreen()

subplot(4,4,1)
hisfit_custom(pts,nbin,lag_c1c1)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c1-c1')
ylabel('Proportion of events')
subplot(4,4,2)
hisfit_custom(pts,nbin,lag_c1c2)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c1-c2')
subplot(4,4,3)
hisfit_custom(pts,nbin,lag_c1c3Short)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c1-c3Short')
subplot(4,4,4)
hisfit_custom(pts,nbin,lag_c1c3Long)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c1-c3Long')

subplot(4,4,5)
hisfit_custom(pts,nbin,lag_c2c1)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c2-c1')
ylabel('Proportion of events')
subplot(4,4,6)
hisfit_custom(pts,nbin,lag_c2c2)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c2-c2')

subplot(4,4,7)
hisfit_custom(pts,nbin,lag_c2c3Short)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c2-c3Short')
subplot(4,4,8)
hisfit_custom(pts,nbin,lag_c2c3Long)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c2-c3Long')

subplot(4,4,9)
hisfit_custom(pts,nbin,lag_c3Shortc1)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Short-c1')
ylabel('Proportion of events')

subplot(4,4,10)
hisfit_custom(pts,nbin,lag_c3Shortc2)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Short-c2')

subplot(4,4,11)
hisfit_custom(pts,nbin,lag_c3Shortc3Short)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Short-c3Short')

subplot(4,4,12)
hisfit_custom(pts,nbin,lag_c3Shortc3Long)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Short-c3Long')

subplot(4,4,13)
hisfit_custom(pts,nbin,lag_c3Longc1)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Long-c1')
xlabel('Interripple Interval (ms)')
ylabel('Proportion of events')

subplot(4,4,14)
hisfit_custom(pts,nbin,lag_c3Longc2)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Long-c2')
xlabel('Interripple Interval (ms)')

subplot(4,4,15)
hisfit_custom(pts,nbin,lag_c3Longc3Short)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Long-c3Short')
xlabel('Interripple Interval (ms)')

subplot(4,4,16)
hisfit_custom(pts,nbin,lag_c3Longc3Long)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Long-c3Long')
xlabel('Interripple Interval (ms)')

%% Plots normalized histograms and custumized kernel density estimate.
nbin=100;
ylimval=0.08;
pts = linspace(lagLimLow,lagLim*1000,1000);
allscreen()

subplot(4,3,1)
hisfit_custom(pts,nbin,lag_c1c2)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c1-c2')
ylabel('Proportion of events')
subplot(4,3,2)
hisfit_custom(pts,nbin,lag_c1c3Short)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c1-c3Short')
subplot(4,3,3)
hisfit_custom(pts,nbin,lag_c1c3Long)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c1-c3Long')

subplot(4,3,4)
hisfit_custom(pts,nbin,lag_c2c1)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c2-c1')
ylabel('Proportion of events')

subplot(4,3,5)
hisfit_custom(pts,nbin,lag_c2c3Short)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c2-c3Short')
subplot(4,3,6)
hisfit_custom(pts,nbin,lag_c2c3Long)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c2-c3Long')

subplot(4,3,7)
hisfit_custom(pts,nbin,lag_c3Shortc1)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Short-c1')
ylabel('Proportion of events')

subplot(4,3,8)
hisfit_custom(pts,nbin,lag_c3Shortc2)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Short-c2')
subplot(4,3,9)
hisfit_custom(pts,nbin,lag_c3Shortc3Long)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Short-c3Long')


subplot(4,3,10)
hisfit_custom(pts,nbin,lag_c3Longc1)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Long-c1')
xlabel('Interripple Interval (ms)')
ylabel('Proportion of events')

subplot(4,3,11)
hisfit_custom(pts,nbin,lag_c3Longc2)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Long-c2')
xlabel('Interripple Interval (ms)')

subplot(4,3,12)
hisfit_custom(pts,nbin,lag_c3Longc3Short)
xlim([lagLimLow lagLim]*1000)
ylim([0 ylimval])
title('c3Long-c3Short')
xlabel('Interripple Interval (ms)')

% printing_image('IRI_3000ms')
%% Non-normalized plots (Uses default histfit, doesn't allow playing with bandwidth)
subplot(4,3,1)
histfit(lag_c1c2,nbin,'kernel');
xlim([lagLimLow lagLim]*1000)
title('c1-c2')
subplot(4,3,2)
histfit(lag_c1c3Short,nbin,'kernel');
xlim([lagLimLow lagLim]*1000)
title('c1-c3Short')
subplot(4,3,3)
histfit(lag_c1c3Long,nbin,'kernel');
xlim([lagLimLow lagLim]*1000)
title('c1-c3Long')

subplot(4,3,4)
histfit(lag_c2c1,nbin,'kernel');
xlim([lagLimLow lagLim]*1000)
title('c2-c1')
subplot(4,3,5)
histfit(lag_c2c3Short,nbin,'kernel');
xlim([lagLimLow lagLim]*1000)
title('c2-c3Short')
subplot(4,3,6)
histfit(lag_c2c3Long,nbin,'kernel');
xlim([lagLimLow lagLim]*1000)
title('c2-c3Long')

subplot(4,3,7)
histfit(lag_c3Shortc1,nbin,'kernel');
xlim([lagLimLow lagLim]*1000)
title('c3Short-c1')
subplot(4,3,8)
histfit(lag_c3Shortc2,nbin,'kernel');
xlim([lagLimLow lagLim]*1000)
title('c3Short-c2')
subplot(4,3,9)
histfit(lag_c3Shortc3Long,nbin,'kernel')
xlim([lagLimLow lagLim]*1000)
title('c3Short-c3Long')


subplot(4,3,10)
histfit(lag_c3Longc1,nbin,'kernel');
xlim([lagLimLow lagLim]*1000)
title('c3Long-c1')
xlabel('Interripple Interval (ms)')
subplot(4,3,11)
histfit(lag_c3Longc2,nbin,'kernel');
xlim([lagLimLow lagLim]*1000)
title('c3Long-c2')
xlabel('Interripple Interval (ms)')

subplot(4,3,12)
histfit(lag_c3Longc3Short,nbin,'kernel');
xlim([lagLimLow lagLim]*1000)
title('c3Long-c3Short')
xlabel('Interripple Interval (ms)')

% printing_image('doublets_lags')