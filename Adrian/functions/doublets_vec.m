function [lag]=doublets_vec(a_p,n_p,lagLimLow,lagLimUP)
%%% This function finds co occurrences between event 1 and event 2
%    input:
%           a_s, a_e: start and stop of event 1
%           n_s, n_e: start and stop of event 2
%    output:,
%           co_vec1 : index of cooccurring event 1
%           co_vec2 : index of cooccurring event 2
%           count_co_vec1 : total count of cooccurring event 1
%           count_co_vec2 : total count of cooccurring event 2

% To correct for repititions, use unique(co_vec1) or unique(co_vec2)
    

    co_vec1=[];%HPC
    co_vec2=[];%Cortex
    total_event=[];
    lag=[];
    for i=1:length(a_p) %iterate across first ripple. 

        j = find(  n_p>a_p(i)+lagLimLow & n_p<=a_p(i)+lagLimUP ); %not beyond 200 ms
        
        if length(j)>1
            j=j(1); %keep only the first ripple. 
        end
        
        if ~isempty(j)
            if sum(ismember(co_vec2,j))>0 % When a closer ripple is found, remove the previous one.
                co_vec1(end)=[];
                co_vec2(end)=[];
                lag(end)=[];
            end
            co_vec1 = [co_vec1; i];
            co_vec2 = [co_vec2; j];  
            lag=[lag ; n_p(j)-a_p(i)];
        end
%         if ~isempty(j)
%             co_vec1 = [co_vec1; i];
%             co_vec2 = [co_vec2; j];
%         end        
        
    end
    
    count_co_vec1 = length(unique(co_vec1));
    count_co_vec2 = length(unique(co_vec2));
    [length(co_vec1) length(co_vec2)];
    lag=lag*1000; % milliseconds
end