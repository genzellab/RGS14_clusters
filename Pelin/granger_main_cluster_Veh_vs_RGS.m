%% Granger Analysis

clc
clear
cd('/home/genzellab/Desktop/Pelin/rgs_granger_cluster_veh-rgs');
addpath('/home/genzellab/Desktop/Pelin/rgs_granger_cluster_veh-rgs/fieldtrip-20250318');
addpath('/home/genzellab/Desktop/Pelin/rgs_granger_cluster_veh-rgs/functions');
load('waveforms_cluster3_veh.mat'); % change
load('waveforms_cluster3_rgs.mat'); % change

%% What would you like to analyse?
input_veh = waveforms_cluster3_raw_veh(:,1);  % change
input_rgs = waveforms_cluster3_raw_rgs(:,1); % change
clearvars -except -regexp input

% select how many ripples
nRipple=2000;

% input_veh
R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),input_veh));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
input_veh=input_veh(r_nl);
input_veh = input_veh(1:nRipple);

% input_rgs
R = (cellfun(@(equis1) max(abs(hilbert(equis1(2,3001-50:3001+50)))),input_rgs));

[~,r_nl]=sort(abs(R-median(R)),'ascend');
R=R(r_nl);
input_rgs=input_rgs(r_nl);
input_rgs = input_rgs(1:nRipple);

% freqrange
freqrange =  [100:2:300] ; % [0:0.5:20] or [20:1:100] or [100:2:300]

clearvars -except -regexp input freqrange

%% Compute granger
[granger,granger2]=granger_automation(input_veh,input_rgs,freqrange);

%% PLOTTING

    %% PFC-->HPC,2s       
    i=1;
    j=2;
    
    tf_p=squeeze(granger.grangerspctrm(i,j,:,:));
    tf_p2=squeeze(granger2.grangerspctrm(i,j,:,:));
    
    %% Normalize the colorbar
    zmin= min([min(tf_p, [],'all'), min(tf_p2, [],'all')],[],'all');
    zmax= max([max(tf_p, [], 'all'), max(tf_p2, [],'all')],[],'all');
    clim_pfc2hpc =[zmin zmax];
    
    % input_veh   
    imagesc(-1:0.01:1,granger.freq,tf_p,clim_pfc2hpc); 

    % save values as csv file
    csvFileName = 'pfc2hpc_c3_raw_veh_100300.csv';
    writematrix(tf_p, csvFileName);
    fprintf('Matrix saved to %s\n', csvFileName);

    axis xy % flip vertically
    colorbar
    colormap(hot(256))
    
    xlim([-1 1])
    xlabel('time')
    ylabel('frequency')
    title('PFC to HPC - C3 (Veh)')
    
    saveas(gcf,'pfc2hpc_veh_c3_100300_2s.fig');
    saveas(gcf,'pfc2hpc_veh_c3_100300_2s.pdf');
    close all
    
    % input_rgs      
    imagesc(-1:0.01:1,granger2.freq, tf_p2,clim_pfc2hpc); 
    % save values as csv file
    csvFileName = 'pfc2hpc_c3_raw_rgs_100300.csv';
    writematrix(tf_p2, csvFileName);
    fprintf('Matrix saved to %s\n', csvFileName);

    axis xy % flip vertically
    colorbar
    colormap(hot(256))
    
    xlim([-1 1])
    xlabel('time')
    ylabel('frequency')
    title('PFC to HPC - C3 (RGS)') % change accordingly
    
    saveas(gcf,'pfc2hpc_rgs_c3_100300_2s.fig'); % change accordingly
    saveas(gcf,'pfc2hpc_rgs_c3_100300_2s.pdf');
    close all
    
    % contrast        
    imagesc(-1.1:0.01:1.1,granger.freq,tf_p-tf_p2);

    % save values as csv file
    csvFileName = 'pfc2hpc_constrast_c3_raw_veh-rgs_100300.csv';
    M=tf_p-tf_p2;
    writematrix(M, csvFileName);
    fprintf('Matrix saved to %s\n', csvFileName);

    axis xy % flip vertically
    colorbar
    colormap(colorbar_treatment) % change accordingly 
    xlim([-1 1])
    xlabel('time')
    ylabel('frequency')
    title('PFC to HPC - Contrast: C3 (Veh-RGS)'); % change accordingly
    
    saveas(gcf,'pfc2hpc_contrast_veh-rgs_c3_100300_2s.fig'); % change accordingly
    saveas(gcf,'pfc2hpc_contrast_veh-rgs_c3_100300_2s.pdf');
    close all
    
    %% Stats
    
    %% input_veh
    p = input_veh;
    % q = input1_Bp;
    
    %% Iteration of GC trials Veh 
    iter = 30;
     m = 400;
    %grangerspctrm_concat = zeros(2,2,length(freqrange)-1,length([-1.1:0.01:1.1]),iter); % if you start from 0 Hz
       grangerspctrm_concat = zeros(2,2,length(freqrange),length([-1.1:0.01:1.1]),iter);

    for i = 1:iter
        i
        randorder = randperm(length(p));
        %temp_q = q(randorder);
        temp_p = p(randorder);
        %q_ = temp_q(1:m);
        p_ = temp_p(1:m);
        
        % Compute time frequency gc
        fn = 1000;
        leng = length(p_);
        ro = 3000;
        tm = create_timecell(ro,leng);
        label = [{'PFC'}; {'HPC'}];
        
        Data.label = label;
        Data.time = tm;
        Data.trial = p_.';
        
        cfg.bsfilter = 'yes';
        cfg.bsfreq = [49 51];
        Data = ft_preprocessing(cfg,Data); 
        
        [granger_tf] = createauto_timefreq(Data,freqrange,[-1.1:0.01:1.1]);
        grangerspctrm_concat(:,:,:,:,i) = granger_tf.grangerspctrm;
    end
    
    granger_tf= grangerspctrm_concat;   
    
    %% input_rgs
    p = input_rgs;
    % q = input2_Bp;
    
    % Iteration of GC trials 
    iter = 30;
    m = 400;
    % grangerspctrm_concat = zeros(2,2,length(freqrange)-1,length([-1.1:0.01:1.1]),iter); % if you start from 0 Hz
    grangerspctrm_concat = zeros(2,2,length(freqrange),length([-1.1:0.01:1.1]),iter); 

    for i = 1:iter
        i
        randorder = randperm(length(p));
       % temp_q = q(randorder);
        temp_p = p(randorder);
        %q_ = temp_q(1:m);
        p_ = temp_p(1:m);
        
        % Compute time frequency gc
        fn = 1000;
        leng = length(p_);
        ro = 3000;
        tm = create_timecell(ro,leng);
        label = [{'PFC'}; {'HPC'}];
        
        Data.label = label;
        Data.time = tm;
        Data.trial = p_.';
        
        cfg.bsfilter = 'yes';
        cfg.bsfreq = [49 51];
        Data = ft_preprocessing(cfg,Data); 
        
        
        [granger_tf2] = createauto_timefreq(Data,freqrange,[-1.1:0.01:1.1]);
        grangerspctrm_concat2(:,:,:,:,i) = granger_tf2.grangerspctrm;
    end
    
    granger_tf2= grangerspctrm_concat2;
    
    a=1; %pfc
    b=2; %hpc
    
    [zmap]=stats_high_granger(granger_tf,granger_tf2,a,b);
    J=imagesc(granger.time,granger.freq,zmap);

    % save values as csv file
    csvFileName = 'pfc2hpc_contrast_stats_c3_raw_veh-rgs_100300.csv';
    M=zmap;
    writematrix(M, csvFileName);
    fprintf('Matrix saved to %s\n', csvFileName);

    axis xy % flip vertically
    colorbar()
    colormap('colorbar_treatment') % change accordingly
    J=title('PFC to HPC - Stats for Contrast: C3 (Veh-RGS)'); % change accordingly
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'pfc2hpc_stats_contrast_veh-rgs_c3_100300_2s.fig'); % change accordingly
    saveas(gcf,'pfc2hpc_stats_contrast_veh-rgs_c3_100300_2s.pdf'); % change accordingly
    close all
    
    %% HPC->PFC 2s
    i=2;
    j=1;
    
    tf_p=squeeze(granger.grangerspctrm(i,j,:,:));
    tf_p2=squeeze(granger2.grangerspctrm(i,j,:,:));
   
   
    zmin= min([min(tf_p2, [],'all'), min(tf_p, [],'all')],[],'all');
    zmax= max([max(tf_p2, [], 'all'), max(tf_p2, [],'all')],[],'all');
    clim_hpc2pfc =[zmin zmax];
    
    % input_veh  
    imagesc(-1:0.01:1,granger.freq,tf_p,clim_hpc2pfc); 

     %save values as csv file
    csvFileName = 'hpc2pfc_c3_raw_veh_100300.csv';
    M=tf_p;
    writematrix(M, csvFileName);
    fprintf('Matrix saved to %s\n', csvFileName);

    axis xy % flip vertically
    colorbar
    colormap(hot(256))
    
    xlim([-1 1])
    xlabel('time')
    ylabel('frequency')
    title('HPC to PFC - C3 (Veh)') % change accordingly
    
    saveas(gcf,'hpc2pfc_veh_c3_100300_2s.fig'); % change accordingly
    saveas(gcf,'hpc2pfc_veh_c3_100300_2s.pdf');
    close all
    
    % input_rgs      
    imagesc(-1:0.01:1,granger2.freq, tf_p2,clim_hpc2pfc); 
     %save values as csv file
    csvFileName = 'hpc2pfc_c3_raw_rgs_100300.csv';
    M=tf_p2;
    writematrix(M, csvFileName);
    fprintf('Matrix saved to %s\n', csvFileName);

    axis xy % flip vertically
    colorbar
    colormap(hot(256))
    
    xlim([-1 1])
    xlabel('time')
    ylabel('frequency')
    title('HPC to PFC - C3 (RGS)') % change accordingly
    
    saveas(gcf,'hpc2pfc_rgs_c3_100300_2s.fig'); % change accordingly
    saveas(gcf,'hpc2pfc_rgs_c3_100300_2s.pdf');
    close all
       
    % contrast        
    imagesc(-1.1:0.01:1.1, granger.freq, tf_p-tf_p2); 

    % save values as csv file
    csvFileName = 'hpc2pfc_contrast_c3_raw_veh-rgs_100300.csv';
    M=tf_p-tf_p2;
    writematrix(M, csvFileName);
    fprintf('Matrix saved to %s\n', csvFileName);

    axis xy % flip vertically
    colorbar
    colormap(colorbar_treatment) % change accordingly
    xlim([-1 1])
    xlabel('time')
    ylabel('frequency')
    title('HPC to PFC - Contrast: C3 (Veh-RGS)'); % change accordingly
    
    saveas(gcf,'hpc2pfc_contrast_veh-rgs_c3_100300_2s.fig'); % change accordingly
    saveas(gcf,'hpc2pfc_contrast_veh-rgs_c3_100300_2s.pdf');
    close all
    
    %%stats
    
    %% input_veh
    p = input_veh;
    %q = input1_Bp;
    
    %% Iteration of GC trials Veh 
    iter = 30;
    m = 400;
    %grangerspctrm_concat = zeros(2,2,length(freqrange)-1,length([-1.1:0.01:1.1]),iter); % if you start from 0 Hz
    grangerspctrm_concat = zeros(2,2,length(freqrange),length([-1.1:0.01:1.1]),iter);
    for i = 1:iter
        i
        randorder = randperm(length(p));
       % temp_q = q(randorder);
        temp_p = p(randorder);
       % q_ = temp_q(1:m);
        p_ = temp_p(1:m);
        
        fn = 1000;
        leng = length(p_);
        ro = 3000;
        tm = create_timecell(ro,leng);
        label = [{'PFC'}; {'HPC'}];
        
        Data.label = label;
        Data.time = tm;
        Data.trial = p_.';
        
        cfg.bsfilter = 'yes';
        cfg.bsfreq = [49 51];
        Data = ft_preprocessing(cfg,Data); 
        
        [granger_tf] = createauto_timefreq(Data,freqrange,[-1.1:0.01:1.1]);
        grangerspctrm_concat(:,:,:,:,i) = granger_tf.grangerspctrm;   
    end
    
    granger_tf= grangerspctrm_concat;   
    
    
    %%  input_rgs
    p = input_rgs;
    %q = input2_Bp;
    
    %% Iteration of GC trials 
    iter = 30;
    m = 400;
    %grangerspctrm_concat = zeros(2,2,length(freqrange)-1,length([-1.1:0.01:1.1]),iter); % if you start from 0 Hz
    grangerspctrm_concat = zeros(2,2,length(freqrange),length([-1.1:0.01:1.1]),iter);
    for i = 1:iter
        i
        randorder = randperm(length(p));
        %temp_q = q(randorder);
        temp_p = p(randorder);
        %q_ = temp_q(1:m);
        p_ = temp_p(1:m);
        
        % Compute time frequency gc
        fn = 1000;
        leng = length(p_);
        ro = 3000;
        tm = create_timecell(ro,leng);
        label = [{'PFC'}; {'HPC'}];
        
        Data.label = label;
        Data.time = tm;
        Data.trial = p_.';
        
        cfg.bsfilter = 'yes';
        cfg.bsfreq = [49 51];
        Data = ft_preprocessing(cfg,Data); 
        
        [granger_tf2] = createauto_timefreq(Data,freqrange,[-1.1:0.01:1.1]);
        grangerspctrm_concat2(:,:,:,:,i) = granger_tf2.grangerspctrm;  
    end
    
    granger_tf2= grangerspctrm_concat2;
    
    % Relative to 2nd input
    a=2; %hpc
    b=1; %pfc
    
    [zmap]=stats_high_granger(granger_tf,granger_tf2,a,b);
    J=imagesc(granger.time,granger.freq,zmap);

    % save values as csv file
    csvFileName = 'hpc2pfc_contrast_stats_c3_raw_veh-rgs_100300.csv';
    M=zmap;
    writematrix(M, csvFileName);
    fprintf('Matrix saved to %s\n', csvFileName);

    axis xy % flip vertically
    colorbar()
    colormap('colorbar_treatment') % change accordingly
    J=title('HPC to PFC - Stats for Contrast: C3 (Veh-RGS)'); % change accordingly
    J.FontSize=12;
    xlabel('Time (s)')
    ylabel('Frequency (Hz)')
    xlim([-1 1])
    
    saveas(gcf,'hpc2pfc_stats_contrast_veh-rgs_c3_100300_2s.fig'); % change accordingly
    saveas(gcf,'hpc2pfc_stats_contrast_veh-rgs_c3_100300_2s.pdf');
    close all