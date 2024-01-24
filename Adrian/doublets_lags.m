%Computes lags between different ripple types. 
% Purpose is to determine if behaviour is more doublet-like or
% singlet-like.

c1=spikes_peak(1).spk;
c2=spikes_peak(2).spk;
c3Short=spikes_peak(3).spk; %seconds
c3Long=spikes_peak(4).spk; %seconds

%%
lagLim=0.20; %0.500
lagLimLow=0;
%C1
[lag_c1c2]=doublets_vec(c1,c2,lagLimLow,lagLim);
[lag_c1c3Short]=doublets_vec(c1,c3Short,lagLimLow,lagLim);
[lag_c1c3Long]=doublets_vec(c1,c3Long,lagLimLow,lagLim);
%C2
[lag_c2c1]=doublets_vec(c2,c1,lagLimLow,lagLim);
[lag_c2c3Short]=doublets_vec(c2,c3Short,lagLimLow,lagLim);
[lag_c2c3Long]=doublets_vec(c2,c3Long,lagLimLow,lagLim);
%C3Short
[lag_c3Shortc1]=doublets_vec(c3Short,c1,lagLimLow,lagLim);
[lag_c3Shortc2]=doublets_vec(c3Short,c2,lagLimLow,lagLim);
[lag_c3Shortc3Long]=doublets_vec(c3Short,c3Long,lagLimLow,lagLim);
%C3Long
[lag_c3Longc1]=doublets_vec(c3Long,c1,lagLimLow,lagLim);
[lag_c3Longc2]=doublets_vec(c3Long,c2,lagLimLow,lagLim);
[lag_c3Longc3Short]=doublets_vec(c3Long,c3Short,lagLimLow,lagLim);
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