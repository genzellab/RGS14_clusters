function hisfit_custom(pts,nbin,lag_c1c2)
%Plots both normalized-histogram and kernel density estimation.
a=histogram(lag_c1c2,nbin,'Normalization','probability')
hold on
[f,xi] = ksdensity(lag_c1c2,pts,'Bandwidth',20); % 20 lower bandwidth= more overfit.
plot(xi,f./max(f).*max(a.Values),'LineWidth',2.5,'Color',[1 0 0]); 
%multiplues by max(a.Values) to have same y-value as largest bin in "a".
end