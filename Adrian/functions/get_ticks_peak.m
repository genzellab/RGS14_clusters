function [bout_ripple]=get_ticks_peak(bout_time, bout_ripple,ripple_peak,i,fn) 
    for ii=1:length(ripple_peak)

    ripple_index_peak=find(ismember(bout_time,ripple_peak(ii)));

    bout_ripple{i}(ripple_index_peak)=1;

    end
[bout_ripple{i}]=truncate_exact_bin(bout_ripple{i},10,fn);
bout_ripple{i}=find(bout_ripple{i})/fn;

  end