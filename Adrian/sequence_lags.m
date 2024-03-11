load('/home/adrian/Downloads/Lags_cortical_Seq_dr_dswr.mat')
%% DR
close all
uplim=[0.04];
labelheight=0.0375;
lagLimLow=[0.05];
lagLim=[0.4];
binsize=0.01
nbin=lagLimLow:binsize:lagLim;

pts = linspace(lagLimLow,lagLim,100);

DR1=[dr_CON_c1(:); dr_HC_c1(:);dr_OD_c1;dr_OR_c1];

DR2=[dr_CON_c2(:); dr_HC_c2(:);dr_OD_c2;dr_OR_c2];
DR3=[dr_CON_c3(:); dr_HC_c3(:);dr_OD_c3;dr_OR_c3];


bw=0.025;
allscreen()
subplot(1,3,1)
hisfit_custom(pts,nbin,DR1,bw,labelheight)

ylabel('Proportion')
xlabel('Time (sec)')
title('DR lag from DR (C1)')
ylim([0 uplim])
xlim([lagLimLow lagLim])

figpar=gca;
figpar.FontSize=13;
subplot(1,3,2)
hisfit_custom(pts,nbin,DR2,bw,labelheight)
xlabel('Time (sec)')
title('DR lag from DR (C2)')
ylim([0 uplim])

xlim([lagLimLow lagLim])

figpar=gca;
figpar.FontSize=13;
subplot(1,3,3)
%histogram(DR3,20,'Normalization','probability')
hisfit_custom(pts,nbin,DR3,bw,labelheight)

xlabel('Time (sec)')
title('DR lag from DR (C3)')
ylim([0 uplim])
xlim([lagLimLow lagLim])

figpar=gca;
figpar.FontSize=13;
%%
DR=[DR1;DR2;DR3];
% histogram(DR,20,'Normalization','probability')
%hisfit_custom(pts,nbin,DR,bw,labelheight)

%% DSWR
DSWR1=[dswr_CON_c1(:); dswr_HC_c1(:);dswr_OD_c1;dswr_OR_c1];

DSWR2=[dswr_CON_c2(:); dswr_HC_c2(:);dswr_OD_c2;dswr_OR_c2];
DSWR3=[dswr_CON_c3(:); dswr_HC_c3(:);dswr_OD_c3;dswr_OR_c3];
DSWR1(DSWR1<0)=[];
DSWR2(DSWR2<0)=[];
DSWR3(DSWR3<0)=[];

labelheight=0.011;
nbin=20;
lagLimLow=0;
lagLim=4;
pts = linspace(lagLimLow,lagLim,100);
uplim=[0.012];
nbin=lagLimLow:binsize:lagLim;

bw=0.1;
allscreen()
subplot(1,3,1)
hisfit_custom(pts,nbin,DSWR1,bw,labelheight)
ylim([0 uplim])
title('DR lag from DSwR (C1)')
figpar=gca;
figpar.FontSize=13;
xlim([0 4])
xlabel('Time (sec)')
ylabel('Proportion')
subplot(1,3,2)
hisfit_custom(pts,nbin,DSWR2,bw,labelheight)
ylim([0 uplim])
title('DR lag from DSwR (C2)')
figpar=gca;
figpar.FontSize=13;
xlim([0 4])
xlabel('Time (sec)')

subplot(1,3,3)
hisfit_custom(pts,nbin,DSWR3,bw,labelheight)
ylim([0 uplim])
title('DR lag from DSwR (C3)')
figpar=gca;
figpar.FontSize=13;
xlim([0 4])
xlabel('Time (sec)')
%%

DSWR1=[ds_dswr_CON_c1(:); ds_dswr_HC_c1(:);ds_dswr_OD_c1;ds_dswr_OR_c1];

DSWR2=[ds_dswr_CON_c2(:); ds_dswr_HC_c2(:);ds_dswr_OD_c2;ds_dswr_OR_c2];
DSWR3=[ds_dswr_CON_c3(:); ds_dswr_HC_c3(:);ds_dswr_OD_c3;ds_dswr_OR_c3];
% DSWR1(DSWR1<0)=[];
% DSWR2(DSWR2<0)=[];
% DSWR3(DSWR3<0)=[];
uplim=0.035;
labelheight=0.0225;
% nbin=100;
lagLimLow=0;
lagLim=1.5;
nbin=lagLimLow:binsize:lagLim;

pts = linspace(lagLimLow,lagLim,100);
bw=0.02;
allscreen()
subplot(1,3,1)
hisfit_custom(pts,nbin,DSWR1,bw,labelheight)
ylim([0 uplim])
title('DS lag from DSwR (C1)')
figpar=gca;
figpar.FontSize=13;
xlim([0 1.5])
xlabel('Time (sec)')
ylabel('Proportion')
subplot(1,3,2)
hisfit_custom(pts,nbin,DSWR2,bw,labelheight)
ylim([0 uplim])
title('DS lag from DSwR (C2)')
figpar=gca;
figpar.FontSize=13;
xlim([0 1.5])
xlabel('Time (sec)')

subplot(1,3,3)
hisfit_custom(pts,nbin,DSWR3,bw,labelheight)
ylim([0 uplim])
title('DS lag from DSwR (C3)')
figpar=gca;
figpar.FontSize=13;
xlim([0 1.5])
xlabel('Time (sec)')

%%
% 
subplot(1,3,1)
histogram(DSWR1,100,'Normalization','probability')
xlim([-4 4])
xline(0,'LineWidth',2)
subplot(1,3,2)
histogram(DSWR2,100,'Normalization','probability')
xlim([-4 4])
xline(0,'LineWidth',2)
subplot(1,3,3)
histogram(DSWR3,100,'Normalization','probability')
xlim([-4 4])
xline(0,'LineWidth',2)
