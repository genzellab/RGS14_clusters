clc
clear
format compact
format longG
addpath(genpath('/Users/pelinozsezer/Desktop/Others/pca_on_filtered_data/functions'));

clusters = 1:3;                          
treatments = {'veh', 'rgs'};            
fs = 1000;
timeasleep = 0;
print_hist = 0;                        

for c = clusters
    for t = 1:length(treatments)
        clearvars -except clusters treatments fs timeasleep print_hist c t
        treatment = treatments{t};

        % folder & variablee names
        filename = sprintf('waveforms_cluster%d_%s.mat', c, treatment);
        varname = sprintf('waveforms_cluster%d_bp_%s', c, treatment);
        fprintf('Processing %s\n', filename);

        if isfile(filename)
            S = load(filename);
            data = S.(varname); 
        else
            warning('%s not found', filename);
            continue;
        end
        clearvars S;

        % process data
        I=cellfun(@isempty,data(:,1));
        I=not(I);
        data = data(I,:);
        
        L=cellfun(@length, data(:,1),'UniformOutput', false);
        L=cell2mat(L);
        data=data(L~=1,:);
        
        datax=[];
        for i=1:length(data(:,1))
            duration_start = 3001-(data{i,3}-data{i,2})*1000;
            duration_end   = 3001+(data{i,4}-data{i,3})*1000;
            datax{i}=(data{i}(2,floor(duration_start):round(duration_end)));
        end
        datax=datax';

        % delta_specs
        [x,y,z,w,h,q,l,p,si_mixed,th,PCA_features] = delta_specs(datax, timeasleep, print_hist, fs);
        PCA_features=PCA_features(:,2:end); 
        
        % csv
        csvname = sprintf('waveforms_cluster%d_%s.csv', c, treatment);
        writematrix(PCA_features, csvname);
        fprintf('Saved results to %s\n', csvname);

    end
end




