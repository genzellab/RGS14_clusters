function [StateMetric]=state_metrics(hmm_postfit,num_states)
%Extract individual bout durations, total cumulative durations
%and total number of bouts. 

    %num_states=10; %number of states
    for state=1:num_states
    st_ind=find(hmm_postfit.sequence(4,:)==state);

    st_duration{state}=hmm_postfit.sequence(3,st_ind);
    st_total_duration(state)=sum(st_duration{state})/60; %minutes
    st_bout_count(state)=length(st_duration{state});

    end
    StateMetric.individual_durations=st_duration;
    StateMetric.total_duration=st_total_duration;
    StateMetric.bout_count=st_bout_count;
end