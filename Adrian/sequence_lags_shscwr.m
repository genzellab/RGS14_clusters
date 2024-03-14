filename='/home/adrian/Downloads/ClusterHPC_start_peak _alignment_RGS14.xlsx';
[num_data, txt_data, raw_data] = xlsread(filename, 'Coupled ShwRh (Rh-Sh)','C2:D13662');
%%
ind_c1=(num_data(:,1))==1;
ind_c2=(num_data(:,1))==2;
ind_c3=(num_data(:,1))==3;
%R-S
lag_c1=num_data(ind_c1,2);
lag_c2=num_data(ind_c2,2);
lag_c3=num_data(ind_c3,2);

DR1=lag_c1/1000;
DR2=lag_c2/1000;
DR3=lag_c3/1000;
%%
close all
uplim=[0.05];
labelheight=uplim/2;
lagLimLow=[-3000]/1000;
lagLim=[3000]/1000;
binsize=0.01
nbin=lagLimLow:binsize:lagLim;

pts = linspace(lagLimLow,lagLim,100);



bw=.01;
allscreen()
subplot(1,3,1)
hisfit_custom(pts,nbin,DR1,bw,labelheight)

ylabel('Proportion')
xlabel('Time (sec)')
title('R-Sh lag of ShwR coupled to Sc (C1)')
ylim([0 uplim])
xlim([lagLimLow lagLim])

figpar=gca;
figpar.FontSize=13;
subplot(1,3,2)
hisfit_custom(pts,nbin,DR2,bw,labelheight)
xlabel('Time (sec)')
title('R-Sh lag of ShwR coupled to Sc (C2)')
ylim([0 uplim])

xlim([lagLimLow lagLim])

figpar=gca;
figpar.FontSize=13;
subplot(1,3,3)
%histogram(DR3,20,'Normalization','probability')
hisfit_custom(pts,nbin,DR3,bw,labelheight)

xlabel('Time (sec)')
title('R-Sh lag of ShwR coupled to Sc (C3)')
ylim([0 uplim])
xlim([lagLimLow lagLim])

figpar=gca;
figpar.FontSize=13;
