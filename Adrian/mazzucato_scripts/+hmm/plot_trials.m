PlotParam=[];
itrial=1;
if length(spikes)==8 
    %C1,C2, C3 short and C3 long ripples
    LegendNew{1}='RC1';
    LegendNew{2}='RC2';
    LegendNew{3}='RC3short';
    LegendNew{4}='RC3long';
    LegendNew{5}='Sh';
    LegendNew{6}='Sc';
    LegendNew{7}='Dh';
    LegendNew{8}='Dc';
    
else
    %C1,C2 and C3 ripples
    LegendNew{1}='RC1';
    LegendNew{2}='RC2';
    LegendNew{3}='RC3';
    LegendNew{4}='Sh';
    LegendNew{5}='Sc';
    LegendNew{6}='Dh';
    LegendNew{7}='Dc';    
end

%for itrial=1:ntrials
    %figure(3); 
    %clf;
    filename=fullfile(hmmdir,['Plot_trial' num2str(itrial) '.pdf']);
    PlotParam=struct('win',win_train(itrial,:),'colors',colors,'fntsz',8,'gnunits',gnunits);
    DATA=struct('win',win_train(itrial,:),'seq',hmm_postfit(itrial).sequence,'pstates',...
        hmm_results(itrial).pStates,'rates',hmm_results(itrial).rates);
    DATA.Spikes(1:gnunits)=spikes(itrial,1:gnunits);
%     figure(1); clf;
    [i2,colshade]=hmm.fun_HMMRasterplot_lowerhalf(DATA,HmmParam,PlotParam,LegendNew);
    %saveas(gcf,filename,'pdf');
%end