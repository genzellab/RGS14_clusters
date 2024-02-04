function [bd_table]=bout_duration_table(StateMetric_HC)
% Creates table with mean bout duration, std of bout durations, counts and
% total time. 

%     cellfun(@mean, StateMetric_HC.individual_durations) %sec
%     cellfun(@std, StateMetric_HC.individual_durations) %sec
%     StateMetric_HC.bout_count
%     StateMetric_HC.total_duration %Minutes.

    bd_table=[cellfun(@mean, StateMetric_HC.individual_durations).'*1000  cellfun(@std, StateMetric_HC.individual_durations).'*1000 StateMetric_HC.bout_count.' StateMetric_HC.total_duration.'];


end