function [freq,freq2,subs_freq,zlim]=spectrogram_automation(input1,input2,input3,channel,freqrange)
bottom=min([size(input1,1) size(input2,1) size(input3,1)]);
input1=input1(randperm(length(input1)));
input1=input1(1:bottom);
input2=input2(randperm(length(input2)));
input2=input2(1:bottom);
input3=input3(randperm(length(input3)));
input3=input3(1:bottom);

%% input1
clear Data
fn=1000;
leng=length(input1);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=input1.';

% Notch filter
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

[freq]=time_frequency(Data,freqrange,[-1.1:0.01:1.1]);  % use 10 ms for the analysis

%% input2
clear Data
fn=1000;
leng=length(input2);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=input2.';

% Notch filter
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

[freq2]=time_frequency(Data,freqrange,[-1.1:0.01:1.1]);  % use 10 ms for the analysis

%% Contrast
cfg_m = [];
cfg_m.operation = 'subtract';
cfg_m.parameter = 'powspctrm';
subs_freq = ft_math(cfg_m,  freq, freq2);

%% Normalize the limits of colorbar
clear Data
fn=1000;
leng=length(input3);
ro=3000;
tm = create_timecell(ro,leng);

label=[{'PFC'}; {'HPC'}];
Data.label=label;
Data.time=tm;
Data.trial=input3.';

% Notch filter
cfg.bsfilter = 'yes';
cfg.bsfreq = [49 51];
Data = ft_preprocessing(cfg,Data);

[add]=time_frequency(Data,freqrange,[-1.1:0.01:1.1]);  % use 10 ms for the analysis

cfg              = [];
cfg.channel      = channel;
[ zmin1, zmax1] = ft_getminmax(cfg, freq);
[zmin2, zmax2] = ft_getminmax(cfg, freq2);
[zmin3, zmax3] = ft_getminmax(cfg, add);
zlim=[min([zmin1 zmin2 zmin3]) max([zmax1 zmax2 zmax3])];

end