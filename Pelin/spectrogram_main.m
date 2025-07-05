%% SPECTROGRAM

clc
clear
addpath('/home/genzellab/Desktop/Pelin/fieldtrip');
addpath('/home/genzellab/Desktop/Pelin-RGS14clusters/functions');
load('GC_ripple_4clusters_median_wa.mat');

%% What would you like to analyse?
input1 = GC_cluster2_veh_median_wa; % e.g., GC_cluster2_veh_median_wa
input2 = GC_cluster3_veh_median_wa; % e.g., GC_cluster3_veh_median_wa

% for normalization, add other cluster
input3 = GC_cluster1_veh_median_wa; % e.g., GC_cluster1_veh_median_wa

channel   = 'PFC'; % 'HPC' or 'PFC'
freqrange =  [100:2:300]; % [0:0.5:20] or [20:1:100] or [100:2:300]

%% Compute spectrogram
[freq,freq2,subs_freq,zlim] = spectrogram_automation(input1,input2,input3,channel,freqrange);

%% PLOTTING

% input1
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = channel;
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq); 
g=title('PFC - Veh: Cluster 2'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'cluster2_100300_2s_veh.fig');
saveas(gcf,'cluster2_100300_2s_veh.jpg'); % change accordingly
saveas(gcf,'cluster2_100300_2s_veh.pdf');
close all

% input2
cfg              = [];
cfg.zlim         = zlim;
cfg.channel      = channel;
cfg.colormap     = colormap(hot);

ft_singleplotTFR(cfg, freq2); 
g=title('PFC - Veh: Cluster 3'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'cluster3_100300_2s_veh.fig');
saveas(gcf,'cluster3_100300_2s_veh.jpg');
saveas(gcf,'cluster3_100300_2s_veh.pdf');
close all

% Contrast
cfg              = [];
cfg.channel      = channel;

ft_singleplotTFR(cfg, subs_freq); 
colormap(colorbar_cluster23); % change accordingly
g=title('PFC - Contrast: Vehicle (Cluster2-3)'); % change accordingly
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'contrast_vehicle_c23_100300_2s.fig'); % change accordingly
saveas(gcf,'contrast_vehicle_c23_100300_2s.jpg'); % change accordingly
saveas(gcf,'contrast_vehicle_c23_100300_2s.pdf'); % change accordingly
close all

%% STATS

% relative to 2nd input 
zmap=stats_high_spec(freq2,freq,1); % PFC=1 & HPC=2; output= freq x time

zmap(zmap == 0) = NaN; % convert 0s to nans in zmap - 0s are significantly not different
J=imagesc(freq.time,freq2.freq,zmap)
xlabel('Time (s)'), ylabel('Frequency (Hz)')
set(gca,'xlim',xlim,'ydir','no')
set(J,'AlphaData',~isnan(zmap))
colorbar()
colormap('colorbar_cluster23') % change accordingly

J=title('PFC - Stats for Contrast: Veh (Cluster2-3)');
J.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
xlim([-1 1])

saveas(gcf,'stats_contrast_vehicle_c23_100300_2s.fig'); % change accordingly
saveas(gcf,'stats_contrast_vehicle_c23_100300_2s.jpg'); % change accordingly
saveas(gcf,'stats_contrast_vehicle_c23_100300_2s.pdf'); % change accordingly
close all

