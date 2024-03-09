function [triplet2_afterc3short,triplet3_afterc3short]=ripple_after_c3short(triplet1_label,triplet2_label,triplet3_label)

    triplet1_c3short_ind=(triplet1_label==3);
    if sum(triplet1_c3short_ind)>0 % If there are first ripples in triplets being c3Short
      triplet2_afterc3short=triplet2_label(triplet1_c3short_ind);
      triplet3_afterc3short=triplet3_label(triplet1_c3short_ind);  
    else
      triplet2_afterc3short=[];    
      triplet3_afterc3short=[];    
    end
end