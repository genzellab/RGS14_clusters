function hisfit_custom(pts,nbin,lag_c1c2,bw,labelheight)
%Plots both normalized-histogram and kernel density estimation.
%replacing nbin for edges.
a=histogram(lag_c1c2,nbin,'Normalization','probability')
hold on
[f,xi] = ksdensity(lag_c1c2,pts,'Bandwidth',bw); % 70 for c3short-c2 results,20 lower bandwidth= more overfit.
plot(xi,f./max(f).*max(a.Values),'LineWidth',2.5,'Color',[1 0 0]); 
%multiplues by max(a.Values) to have same y-value as largest bin in "a".
% Compute entropy:
p= a.Values(a.Values>0); % avoid bins with zeros. 
H=sum(p.*log2(p))*-1;
%Testing with KDE
probabilities = f / sum(f);  % Normalize probabilities%
H = -sum(probabilities.*log2(probabilities));

text(mean(pts)/2, labelheight, [num2str(H) ' bits'],'FontSize',14)%0.04
hold on
%  xline(median(lag_c1c2),'LineWidth',3,'Color',[0 1 0])
end