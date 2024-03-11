function [H,f,xi]=get_bits_kde(lag_c1c2,pts,bw)

[f,xi] = ksdensity(lag_c1c2,pts,'Bandwidth',bw); % 20 lower bandwidth= more overfit.
probabilities = f / sum(f);  % Normalize probabilities
H = -sum(probabilities.*log2(probabilities));

end