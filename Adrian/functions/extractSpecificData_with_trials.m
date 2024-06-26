function [concatenatedData_timestamps,length_concatenatedData,concatenatedData] = extractSpecificData_with_trials(structData,ConditionField,RatField,Trialname,fn)
%concatenatedData includes all samples, with values 1 or 0 depending if
%oscillation was active.
%length_concatenatedData (measured length from variable above)
%
concatenatedData = [];
    
    % Iterate over each field in the struct
% fields=    [ {'OD' } %Object space Conditions.
%     {'HC' }
%     {'CON'}
%     {'OR' }];

    for i = 1:numel(ConditionField)
        fieldValue = structData.(ConditionField{i});
%         fields2=    [ {'Rat1' } %Only Vehicle rats from RGS14 dataset.
%             {'Rat2' }
%             {'Rat6'}
%             {'Rat9' }];
            for j=1:numel(RatField)
        % Check if the field value is a struct
         % Recursively call the function for nested structs
                 nestedData = fieldValue.(RatField{j});
                    for k=1:numel(Trialname)
                        nestedData_trial=nestedData.(Trialname{k});
                        concatenatedData = [concatenatedData nestedData_trial];
                    end
            end
              
    end
    down_samp=1;
%     concatenatedData=downsample(concatenatedData,down_samp);
    length_concatenatedData=length(concatenatedData);
    concatenatedData_timestamps=find(concatenatedData)/(fn/down_samp);
end