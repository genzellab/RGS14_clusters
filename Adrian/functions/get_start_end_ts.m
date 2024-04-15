function [c1_start,c1_end]=get_start_end_ts(c1_full)

split_c1=find(diff(c1_full(1:end)*1000)>10);
c1_end=c1_full(split_c1(:));
c1_start=c1_full(split_c1(:)+1);
c1_start=[c1_full(1); c1_start];
c1_end=[ c1_end ;c1_full(end)];

end