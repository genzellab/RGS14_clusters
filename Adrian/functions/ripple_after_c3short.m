function [triplet2_afterc3short,triplet3_afterc3short,triplet1_c3short_start,triplet3_c3short_end]=ripple_after_c3short(triplet1_label,triplet2_label,triplet3_label,triplet1_start,triplet3_end)

    triplet1_c3short_ind=(triplet1_label==3);
    if sum(triplet1_c3short_ind)>0 % If there are first ripples in triplets being c3Short
      triplet2_afterc3short=triplet2_label(triplet1_c3short_ind);
      triplet3_afterc3short=triplet3_label(triplet1_c3short_ind); 
      
      triplet1_c3short_start=triplet1_start(triplet1_c3short_ind);
      triplet3_c3short_end=triplet3_end(triplet1_c3short_ind); 
      
      
    else
      triplet2_afterc3short=[];    
      triplet3_afterc3short=[];    
      triplet1_c3short_start=[];   
      triplet3_c3short_end=[];  
    end
end