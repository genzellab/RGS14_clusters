function [x,y,z,w,h,q,l,p,si_mixed,th,PCA_features] = delta_specs_faster(si, timeasleep, print_hist, fs)
% Computes main features of events detected using a parfor loop

    % Default outputs
    th = NaN;
    si_mixed.g1 = NaN;
    si_mixed.i1 = NaN;
    si_mixed.g2 = NaN;
    si_mixed.i2 = NaN;

    if isempty(si)
        x = NaN; y = NaN; z = NaN; w = NaN; h = NaN; q = NaN; l = NaN; p = NaN;
        PCA_features = [];
        return;
    end

    n = length(si);
    temp_features = cell(n, 1);  % Preallocate cell array for parallel safe writing

    parfor i = 1:n
        signal = si{i};

        features = NaN(1, 9); % Initialize this iteration’s features

        if ~isempty(signal)
            try
                features(1) = mean(instfreq(signal, fs));                      % Instantaneous frequency
                features(2) = meanfreq(signal, fs);                            % Average frequency
                features(3) = max(abs(hilbert(signal)));                       % Amplitude
                features(4) = trapz((1:length(signal)) ./ fs, abs(signal));    % Area under curve
                features(5) = length(signal) / fs;                             % Duration
                features(6) = peak2peak(signal);                               % Peak-to-peak
                features(7) = power_signal(signal);                            % Power
                features(8) = entropy(signal);                                 % Entropy
                features(9) = length(findpeaks(signal));                       % Number of peaks
            catch
                % skip errors silently
            end
        end

        temp_features{i} = features;  % Store results
    end

    % Convert cell array to matrix
    PCA_features = cell2mat(temp_features);

    % Compute medians (ignore NaNs)
    x = median(PCA_features(:,1), 'omitnan');
    y = median(PCA_features(:,2), 'omitnan');
    z = median(PCA_features(:,3), 'omitnan');
    l = median(PCA_features(:,4), 'omitnan');
    q = median(PCA_features(:,5), 'omitnan');
    p = median(PCA_features(:,6), 'omitnan');

    % Count and rate
    w = n;
    h = w / (timeasleep * 60);

    % Optional histograms
    if print_hist == 1
        % plotting can go here if needed
    end
end
