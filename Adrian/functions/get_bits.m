function H=get_bits(lag_c1c2,nbin)

% Compute the histogram values without plotting
[counts, edges] = histcounts(lag_c1c2, nbin, 'Normalization', 'probability');

% Compute entropy:
p = counts(counts > 0);  % Avoid bins with zeros
H = sum(p .* log2(p)) * -1;

end