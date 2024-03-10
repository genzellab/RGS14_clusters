load('/home/adrian/Downloads/Lags_cortical_Seq_dr_dswr_v1.mat')
%% DR
DR1=[dr_CON_c1(:); dr_HC_c1(:);dr_OD_c1;dr_OR_c1];

DR2=[dr_CON_c2(:); dr_HC_c2(:);dr_OD_c2;dr_OR_c2];
DR3=[dr_CON_c3(:); dr_HC_c3(:);dr_OD_c3;dr_OR_c3];

subplot(1,3,1)
histogram(DR1,20,'Normalization','probability')
subplot(1,3,2)
histogram(DR2,20,'Normalization','probability')
subplot(1,3,3)
histogram(DR3,20,'Normalization','probability')
%%
DR=[DR1;DR2;DR3];
histogram(DR,20,'Normalization','probability')
%% DSWR
DSWR1=[dswr_CON_c1(:); dswr_HC_c1(:);dswr_OD_c1;dswr_OR_c1];

DSWR2=[dswr_CON_c2(:); dswr_HC_c2(:);dswr_OD_c2;dswr_OR_c2];
DSWR3=[dswr_CON_c3(:); dswr_HC_c3(:);dswr_OD_c3;dswr_OR_c3];

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
