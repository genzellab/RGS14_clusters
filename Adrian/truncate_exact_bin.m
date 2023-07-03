function [truncatedSignal]=truncate_exact_bin(x,bin_milliseconds,samplingRate)
%bin_milliseconds: 10ms bin.
    % Calculate the desired length of the truncated signal in samples
    desiredLengthSec = numel(x) / samplingRate; % Length of the original signal in seconds
    desiredLengthMs = desiredLengthSec * 1000; % Length of the original signal in milliseconds
    truncatedLengthMs = floor(desiredLengthMs / bin_milliseconds) * bin_milliseconds; % Length of the truncated signal in milliseconds
    truncatedLengthSamples = truncatedLengthMs * samplingRate / 1000; % Length of the truncated signal in samples

    % Calculate the number of samples to remove from the end of the signal
    numSamplesToRemove = numel(x) - truncatedLengthSamples;

    % Truncate the signal by removing the calculated number of samples
    truncatedSignal = x(1:end-numSamplesToRemove);


end