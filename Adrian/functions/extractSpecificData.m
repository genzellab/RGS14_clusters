function [concatenatedData,length_concatenatedData] = extractSpecificData(structData,ConditionField,RatField,fn)
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

            concatenatedData = [concatenatedData nestedData];
        
            end
              
    end
    down_samp=1;
%     concatenatedData=downsample(concatenatedData,down_samp);
    length_concatenatedData=length(concatenatedData);
    concatenatedData=find(concatenatedData)/(fn/down_samp);
end