function [bout_ripple]=get_ticks(bout_time, bout_ripple,ripple_start, ripple_end,i,fn) 
    for ii=1:length(ripple_start)

      % Ripple=[Ripple ripple_start(ii):1/fn :ripple_end(ii)] ;
    ripple_index_start=find(ismember(bout_time,ripple_start(ii)));
    ripple_index_end=find(ismember(bout_time,ripple_end(ii)));

    bout_ripple{i}(ripple_index_start:ripple_index_end)=1;

    end
%     bout_ripple{i}=find(bout_ripple{i})/fn;
[bout_ripple{i}]=truncate_exact_bin(bout_ripple{i},10,fn);
  end