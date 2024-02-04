cd /home/adrian/Documents/rgs_clusters_figs
load('c3split_sweep_states_200_iteration.mat')

allscreen()
plot(OUT.HiddenTotal,OUT.LLtot.m2LL,'LineWidth',2)
xlabel('States')
ylabel('Bayesian information criterion (BIC)')
hold on
xline(OUT.StatesSelected,'LineWidth',2)
pl=gca;
pl.XTick=OUT.HiddenTotal
pl.FontSize=16;        

figure()
load('c3split_sweep_states_200_iteration_AIC.mat')

allscreen()
plot(OUT.HiddenTotal,OUT.LLtot.m2LL,'LineWidth',2)
xlabel('States')
ylabel('Akaike information criterion (AIC)')
hold on
xline(OUT.StatesSelected,'LineWidth',2)
pl=gca;
pl.XTick=OUT.HiddenTotal
pl.FontSize=16;        
