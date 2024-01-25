
c1=spikes_peak(1).spk;
c2=spikes_peak(2).spk;
c3Short=spikes_peak(3).spk; %seconds
c3Long=spikes_peak(4).spk; %seconds

combined=[c1; c2 ;c3Short ;c3Long];
label=[ones(size(c1));ones(size(c2))*2; ones(size(c3Short))*3; ones(size(c3Long))*4 ];
[combined, id]=sort(combined);
label=label(id);
[M_multiplets, Mx_multiplets]=findmultiplets(combined);
%%
close all
allscreen()
subplot(1,2,1)
doublet1=M_multiplets.doublets{1}(:,1);
doublet1_label=label(ismember(combined, doublet1));
d1=histogram(doublet1_label,'Normalization','probability');
ylim([0 0.7])
xlim([0.5 4.5])
ylabel('Probability')
d1.Parent.XTick=[1 2 3 4];
d1.Parent.XTickLabel{1}='C1';
d1.Parent.XTickLabel{2}='C2';
d1.Parent.XTickLabel{3}='C3 Short';
d1.Parent.XTickLabel{4}='C3 Long';
d1t=title('First ripple of Doublet')
d1t.FontSize=14;
grid minor

a=gca;
a.YLabel.FontSize=14;
a.FontSize=14;

d2=subplot(1,2,2)

doublet2=M_multiplets.doublets{1}(:,2);
doublet2_label=label(ismember(combined, doublet2));
d2=histogram(doublet2_label,'Normalization','probability');
d2.Parent.XTick=[1 2 3 4];
d2.Parent.XTickLabel{1}='C1';
d2.Parent.XTickLabel{2}='C2';
d2.Parent.XTickLabel{3}='C3 Short';
d2.Parent.XTickLabel{4}='C3 Long';
grid minor
ylim([0 0.7])
xlim([0.5 4.5])
ylabel('Probability')

d2t=title('Second ripple of Doublet')
d2t.FontSize=14;

a=gca;
a.YLabel.FontSize=14;
a.FontSize=14;

%%
%triplets
allscreen()
subplot(1,3,1)
triplet1=M_multiplets.triplets{1}(:,1);
triplet1_label=label(ismember(combined, triplet1));
t1=histogram(triplet1_label,'Normalization','probability');
grid minor
ylim([0 0.7])
xlim([0.5 4.5])
ylabel('Probability')
t1.Parent.XTick=[1 2 3 4];
t1.Parent.XTickLabel{1}='C1';
t1.Parent.XTickLabel{2}='C2';
t1.Parent.XTickLabel{3}='C3 Short';
t1.Parent.XTickLabel{4}='C3 Long';
t1t=title('First ripple of Triplet')
t1t.FontSize=14;
a=gca;
a.YLabel.FontSize=14;
a.FontSize=14;

subplot(1,3,2)
%triplets
triplet2=M_multiplets.triplets{1}(:,2);
triplet2_label=label(ismember(combined, triplet2));
t2=histogram(triplet2_label,'Normalization','probability');
grid minor
ylim([0 0.7])
xlim([0.5 4.5])
ylabel('Probability')
t2.Parent.XTick=[1 2 3 4];
t2.Parent.XTickLabel{1}='C1';
t2.Parent.XTickLabel{2}='C2';
t2.Parent.XTickLabel{3}='C3 Short';
t2.Parent.XTickLabel{4}='C3 Long';
t2t=title('Second ripple of Triplet')
t2t.FontSize=14;
a=gca;
a.YLabel.FontSize=14;
a.FontSize=14;
subplot(1,3,3)

%triplets
triplet3=M_multiplets.triplets{1}(:,3);
triplet3_label=label(ismember(combined, triplet3));
t3=histogram(triplet3_label,'Normalization','probability');
grid minor
ylim([0 0.7])
xlim([0.5 4.5])
ylabel('Probability')

t3.Parent.XTick=[1 2 3 4];
t3.Parent.XTickLabel{1}='C1';
t3.Parent.XTickLabel{2}='C2';
t3.Parent.XTickLabel{3}='C3 Short';
t3.Parent.XTickLabel{4}='C3 Long';
t3t=title('Third ripple of Triplet')
t3t.FontSize=14;
a=gca;
a.YLabel.FontSize=14;
a.FontSize=14;