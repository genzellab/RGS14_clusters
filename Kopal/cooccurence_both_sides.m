function [Co_vech,Co_vecc,count_co_vech,count_co_vecc]= cooccurence_both_sides(h_start,h_end, c_start, c_end)
% Checking with default order
[co_vech, co_vecc, count_co_vech, count_co_vecc] = cooccurrence_vec(h_start,h_end, c_start, c_end);% HPC, Cortex

 if length(co_vech)~= length(co_vecc) % Switching input order to make for-loop wrt to the event with repeated values
 [co_vecc_switch, co_vech_switch, count_co_vecc_switch, count_co_vech_switch] = cooccurrence_vec(c_start, c_end,h_start,h_end);% HPC, Cortex
 else 
     Co_vecc = co_vecc;
     Co_vech = co_vech;
     return
 end

 if length(co_vech_switch)~= length(co_vecc_switch) % Switching input order to make for-loop wrt to the event with repeated values
 warning('Switching didnt work')
 else 
     Co_vecc = co_vecc_switch;
     Co_vech = co_vech_switch;
     return
 end
 
max_length = max(numel(co_vecc), numel(co_vecc_switch));
if numel(co_vecc) == max_length
    Co_vecc = co_vecc;
else 
    Co_vecc = co_vecc_switch;
end 
% Co_vecc = (numel(co_vecc) == max_length) .* co_vecc + (numel(co_vecc_switch) == max_length) .* co_vecc_switch;

max_length = max(numel(co_vech), numel(co_vech_switch));
if numel(co_vech) == max_length
   Co_vech = co_vech;
else 
   Co_vech = co_vech_switch;
end 
% Co_vech = (numel(co_vech) == max_length) * co_vech + (numel(co_vech_switch) == max_length) * co_vech_switch;
end 