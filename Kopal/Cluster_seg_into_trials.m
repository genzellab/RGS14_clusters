clear variables

addpath(genpath('/Volumes/Samsung_T5/Milan_DA/OS_ephys_da/CorticoHippocampal'))
addpath ('/Volumes/Samsung_T5/Milan_DA/OS_ephys_da/ADRITOOLS')
cd('/Volumes/Samsung_T5/Milan_DA/SWR_Cluster_SDwise_pelin')

rat_folder = getfolder;

for k = 7:8
cd(rat_folder{k});
path = cd;
dinfo = dir(path);
dinfo = {dinfo.name};
dinfo = dinfo(4:end);
    for j = 1:length(dinfo)
    trial = [{'ps'},{'pt1'},{'pt2'},{'pt3'},{'pt4'},{'pt5.1'},{'pt5.2'},{'pt5.3'},{'pt5.4'}];
    ripple_table = load(dinfo{j});

    fname  = fieldnames(ripple_table);
    ripple_table = ripple_table.(fname{1});

        for i = 1:length(trial)
            current_trial =  trial{i};
            t = find(contains(ripple_table(:,9),current_trial)); 
            cluster_ripple_table{i} = ripple_table(t,:);
        end 

    cluster_ripple_count = cellfun('size',cluster_ripple_table,1);
    save (strcat('trialwise_',dinfo{j}),'cluster_ripple_table','cluster_ripple_count')

    end 
cd ..
end 


