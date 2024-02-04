function [StateMetric]=state_metrics(hmm_postfit,num_states,total_duration)
%Extract individual bout durations, total cumulative durations
%and total number of bouts. 
% total duration is in minutes
    %num_states=10; %number of states
    for state=1:num_states
    st_ind=find(hmm_postfit.sequence(4,:)==state);

    st_duration{state}=hmm_postfit.sequence(3,st_ind);
    st_total_duration(state)=sum(st_duration{state})/60; %minutes
    st_bout_count(state)=length(st_duration{state});

    end
    % state+1 is the undetermined state. 
    st_total_duration(state+1)=total_duration-sum(st_total_duration); %Time during which model couldn't assign a state. 
    st_bout_count(state+1)=[length(find(hmm_postfit.sequence(1,[2:end])-hmm_postfit.sequence(2,[1:end-1]))) ]; % Computes number of
    %undetermined bouts. 
    duration_undetermined_bouts=hmm_postfit.sequence(1,[2:end])-hmm_postfit.sequence(2,[1:end-1]);
    duration_undetermined_bouts=duration_undetermined_bouts(find(duration_undetermined_bouts)); %remove zero values
    st_duration{state+1}=duration_undetermined_bouts;
%     sum(st_duration{state+1})/60
%     length(st_duration{state+1})
    StateMetric.individual_durations=st_duration;
    StateMetric.total_duration=st_total_duration;
    StateMetric.bout_count=st_bout_count;
end