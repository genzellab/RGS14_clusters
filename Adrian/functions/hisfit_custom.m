function hisfit_custom(pts,nbin,lag_c1c2)
%Plots both normalized-histogram and kernel density estimation.
a=histogram(lag_c1c2,nbin,'Normalization','probability')
hold on
[f,xi] = ksdensity(lag_c1c2,pts,'Bandwidth',20); % 20 lower bandwidth= more overfit.
plot(xi,f./max(f).*max(a.Values),'LineWidth',2.5,'Color',[1 0 0]); 
%multiplues by max(a.Values) to have same y-value as largest bin in "a".
% Compute entropy:
p= a.Values(a.Values>0); % avoid bins with zeros. 
H=sum(p.*log2(p))*-1;
text(mean(pts)/2, 0.04, [num2str(H) ' bits'])
hold on
 xline(median(lag_c1c2),'LineWidth',3,'Color',[0 1 0])
end