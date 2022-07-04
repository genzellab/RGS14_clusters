
clear variables
cd('/Volumes/Samsung_T5/Milan_DA/RGS14_Ephys_da/Data_RGS14_Downsampled_First_Session')
addpath('/Users/kopalagarwal/Samsung_T5/Milan_DA/OS_ephys_da/ADRITOOLS')

rat_folder=getfolder;
prompt = {'Enter the rat index'};
dlgtitle = 'Rat Index';
k = str2double(inputdlg(prompt,dlgtitle));
cd(rat_folder{k}) 

SD_folders  = getfolder;

for j = 1:length(SD_folders) % Study Day Index
       load(strcat('ripple_total_data_',SD_folders{j},'.mat'))
       load(strcat('spindles_total_data_',SD_folders{j},'.mat'))
       load(strcat('delta_timestamps_',SD_folders{j},'.mat'))
       delta_total_data = delta_timestamps_SD;
       current_sd = SD_folders{j};
        current_sd = strsplit(current_sd, '_');
        idx = find(contains(current_sd, 'sd', 'IgnoreCase',true));
        SDn = current_sd{idx}(1,3:end);
        cd ('/Volumes/Samsung_T5/Milan_DA/SWR_Cluster_SDwise_pelin')
        ClSDw =  getfolder;
        cd(ClSDw{k})
        path = cd;
        dinfo = dir(path);
        dinfo = {dinfo.name};
        dinfo = dinfo(4:end);
        idx2 = find(contains(dinfo,'trialwise_', 'IgnoreCase',true));
        dinfo = dinfo(idx2);
        idx3 = find(contains(dinfo, ['SD',SDn,'_'], 'IgnoreCase',true));
        dinfo_sd = dinfo(idx3);
       clus1 = load(dinfo_sd{contains(dinfo_sd,'c1')});
       name = fieldnames(clus1);
       clus1 = clus1.(name{2});
       clus2 = load(dinfo_sd{contains(dinfo_sd,'c2')});
       name = fieldnames(clus2);
       clus2 = clus2.(name{2});
       clus3 = load(dinfo_sd{contains(dinfo_sd,'c3')});
        name = fieldnames(clus3);
       clus3 = clus3.(name{2});
       clus4 = load(dinfo_sd{contains(dinfo_sd,'c4')});
        name = fieldnames(clus4);
       clus4 = clus4.(name{2});         
cd('/Volumes/Samsung_T5/Milan_DA/RGS14_Ephys_da/Data_RGS14_Downsampled_First_Session') 
cd(rat_folder{k})  

    for i = 1:9 % Post Trial Index
        
        spindles = spindles_total_data{i};
        deltas = delta_total_data{i};
        ripples = ripple_total_data{i};
        ripples_c1 = cell2mat(clus1{i}(:,2:4));
        ripples_c2 = cell2mat(clus2{i}(:,2:4));
        ripples_c3 = cell2mat(clus3{i}(:,2:4));
        ripples_c4 = cell2mat(clus4{i}(:,2:4));
%% Extarcting Concatenated NREM timestamps per cluster 
if ~isnan(ripples)
    
        if ~isempty(ripples_c1)
        idx4 = ismember(ripples(:,1:3),ripples_c1,'rows'); 
        con_r_c1 = ripples(idx4, 5:7);                   % Cluster 1
        else
         con_r_c1 = [];   
        end
        
        if ~isempty(ripples_c2)
        idx5 = ismember(ripples(:,1:3),ripples_c2,'rows');
        con_r_c2 = ripples(idx5, 5:7);                   % Cluster 2
        else
         con_r_c2 = [];   
        end
        
        if ~isempty(ripples_c3)
        idx6 = ismember(ripples(:,1:3),ripples_c3,'rows');
        con_r_c3 = ripples(idx6, 5:7);                   % Cluster 3
        else
         con_r_c3 = [];   
        end
        
        if ~isempty(ripples_c4)
        idx7 = ismember(ripples(:,1:3),ripples_c4,'rows');
        con_r_c4 = ripples(idx7, 5:7);                   % Cluster 4
        else 
            con_r_c4 = [];
        end 
end 
        %% Delta-spindle sequence detection
        seq_del_spin = [];
           if ~isnan(deltas) 
               if ~isnan(spindles)
                   co=[];
                   v_c1 = 0;
                   seq_indices =  find(co);   
                    win=0.1;
                    min_diff=100; %milliseconds
                    max_diff=1300; %milliseconds
                
                    for c = 1:length(deltas)
                        co = (spindles(:,7)>(deltas(c,2)+min_diff/1000)) & (spindles(:,7)<(deltas(c,2)+max_diff/1000));                   
                        if sum(co)~=0
                        seq_indices =  find(co);   
                              for f = 1 :length(seq_indices)
                                  v_c1 = v_c1+1;
                                  seq_del_spin(v_c1,1) = deltas(c,1);
                                  seq_del_spin(v_c1,2) = deltas(c,2);
                                  seq_del_spin(v_c1,3) = deltas(c,3);
                                  seq_del_spin(v_c1,4) = spindles(seq_indices(f),6);
                                  seq_del_spin(v_c1,5) = spindles(seq_indices(f),7);
                                  seq_del_spin(v_c1,6) = spindles(seq_indices(f),8);
                              end                         
                        end
                    end
               else 
                   seq_del_spin = NaN;
               end
           else 
               seq_del_spin = NaN;
           end
  %% Delta-ripple and ripple-delta sequence detection
      if ~isnan(ripples)
          if ~isnan(deltas)
        co = [];
        co2 = [];
        v_c1 = 0;
        v2_c1=0;
        v_c2 = 0;
        v2_c2=0;
        v_c3 = 0;
        v2_c3=0;
        v_c4 = 0;
        v2_c4=0;
        min_dif = 50; %milliseconds
        max_dif = 400; %milliseconds
        min_differ2 = 50; %milliseconds
        max_differ2 = 250; %milliseconds 
        
        seq_del_rip_c1 = [];
        seq_rip_del_c1 = [];
        
        seq_del_rip_c2 = [];
        seq_rip_del_c2 = [];
        
        seq_del_rip_c3 = [];
        seq_rip_del_c3 = [];
        
        seq_del_rip_c4 = [];
        seq_rip_del_c4 = [];
        
            for c=1:length(deltas)
                
                if  ~isempty(con_r_c1)
                co_c1 = (con_r_c1(:,2)>deltas(c,2)+min_dif/1000) & (con_r_c1(:,2)<deltas(c,2)+max_dif/1000);          % Del-Rip
                co2_c1 = (con_r_c1(:,2)<deltas(c,2)-min_differ2/1000) & (con_r_c1(:,2)>deltas(c,2)-max_differ2/1000); % Rip-Del
                
                else 
                    co_c1 = 0;
                    co2_c1 = 0;
                end
                if  ~isempty(con_r_c2)
                co_c2 = (con_r_c2(:,2)>deltas(c,2)+min_dif/1000) & (con_r_c2(:,2)<deltas(c,2)+max_dif/1000);
                co2_c2 = (con_r_c2(:,2)<deltas(c,2)-min_differ2/1000) & (con_r_c2(:,2)>deltas(c,2)-max_differ2/1000);
                else 
                    co_c2 = 0;
                    co2_c2 = 0;
                end 
                if  ~isempty(con_r_c3)
                co_c3 = (con_r_c3(:,2)>deltas(c,2)+min_dif/1000) & (con_r_c3(:,2)<deltas(c,2)+max_dif/1000);
                co2_c3 = (con_r_c3(:,2)<deltas(c,2)-min_differ2/1000) & (con_r_c3(:,2)>deltas(c,2)-max_differ2/1000);
                else 
                    co_c3 = 0;
                    co2_c3 = 0;
                end 
               if  ~isempty(con_r_c4)
                co_c4 = (con_r_c4(:,2)>deltas(c,2)+min_dif/1000) & (con_r_c4(:,2)<deltas(c,2)+max_dif/1000);
                co2_c4 = (con_r_c4(:,2)<deltas(c,2)-min_differ2/1000) & (con_r_c4(:,2)>deltas(c,2)-max_differ2/1000);
               else 
                   co_c4 = 0;
                   co2_c4 = 0;
               end
               
                % Cluster 1
                
               if sum(co_c1)~=0
                   seq_indices = find(co_c1,1);
                    for f=1:length(seq_indices)
                    v_c1 = v_c1+1;
                    seq_del_rip_c1(v_c1,1) = deltas(c,1);
                    seq_del_rip_c1(v_c1,2) = deltas(c,2);
                    seq_del_rip_c1(v_c1,3) = deltas(c,3);
                    seq_del_rip_c1(v_c1,4) = con_r_c1(seq_indices(f),1);
                    seq_del_rip_c1(v_c1,5) = con_r_c1(seq_indices(f),2);
                    seq_del_rip_c1(v_c1,6) = con_r_c1(seq_indices(f),3);
                    end
               end
               if sum(co2_c1)~=0
                   seq_indices2 = find(co2_c1,1);
                    for f=1:length(seq_indices2)
                    v2_c1 = v2_c1+1;
                    seq_rip_del_c1(v2_c1,1) = con_r_c1(seq_indices2(f),1);
                    seq_rip_del_c1(v2_c1,2) = con_r_c1(seq_indices2(f),2);
                    seq_rip_del_c1(v2_c1,3) = con_r_c1(seq_indices2(f),3);
                    seq_rip_del_c1(v2_c1,4) = deltas(c,1);
                    seq_rip_del_c1(v2_c1,5) = deltas(c,2);
                    seq_rip_del_c1(v2_c1,6) = deltas(c,3);
                    end
               end
               
               % Cluster 2
               
               if sum(co_c2)~=0
                   seq_indices = find(co_c2,1);
                    for f = 1:length(seq_indices)
                    v_c2 = v_c2+1;
                    seq_del_rip_c2(v_c2,1) = deltas(c,1);
                    seq_del_rip_c2(v_c2,2) = deltas(c,2);
                    seq_del_rip_c2(v_c2,3) = deltas(c,3);
                    seq_del_rip_c2(v_c2,4) = con_r_c2(seq_indices(f),1);
                    seq_del_rip_c2(v_c2,5) = con_r_c2(seq_indices(f),2);
                    seq_del_rip_c2(v_c2,6) = con_r_c2(seq_indices(f),3);
                    end
               end
               if sum(co2_c2)~=0
                   seq_indices2 = find(co2_c2,1);
                    for f = 1:length(seq_indices2)
                    v2_c2 = v2_c2+1;
                    seq_rip_del_c2(v2_c2,1) = con_r_c2(seq_indices2(f),1);
                    seq_rip_del_c2(v2_c2,2) = con_r_c2(seq_indices2(f),2);
                    seq_rip_del_c2(v2_c2,3) = con_r_c2(seq_indices2(f),3);
                    seq_rip_del_c2(v2_c2,4) = deltas(c,1);
                    seq_rip_del_c2(v2_c2,5) = deltas(c,2);
                    seq_rip_del_c2(v2_c2,6) = deltas(c,3);
                    end
               end
               
               % Cluster 3
               
               if sum(co_c3)~=0
                   seq_indices = find(co_c3,1);
                    for f = 1:length(seq_indices)
                    v_c3 = v_c3+1;
                    seq_del_rip_c3(v_c3,1) = deltas(c,1);
                    seq_del_rip_c3(v_c3,2) = deltas(c,2);
                    seq_del_rip_c3(v_c3,3) = deltas(c,3);
                    seq_del_rip_c3(v_c3,4) = con_r_c3(seq_indices(f),1);
                    seq_del_rip_c3(v_c3,5) = con_r_c3(seq_indices(f),2);
                    seq_del_rip_c3(v_c3,6) = con_r_c3(seq_indices(f),3);
                    end
               end
               if sum(co2_c3)~=0
                   seq_indices2 = find(co2_c3,1);
                    for f = 1:length(seq_indices2)
                    v2_c3 = v2_c3+1;
                    seq_rip_del_c3(v2_c3,1) = con_r_c3(seq_indices2(f),1);
                    seq_rip_del_c3(v2_c3,2) = con_r_c3(seq_indices2(f),2);
                    seq_rip_del_c3(v2_c3,3) = con_r_c3(seq_indices2(f),3);
                    seq_rip_del_c3(v2_c3,4) = deltas(c,1);
                    seq_rip_del_c3(v2_c3,5) = deltas(c,2);
                    seq_rip_del_c3(v2_c3,6) = deltas(c,3);
                    end
               end
               
               % Cluster 4
              
               if sum(co_c4)~=0
                   seq_indices = find(co_c4,1);
                    for f = 1:length(seq_indices)
                    v_c4 = v_c4+1;
                    seq_del_rip_c4(v_c4,1) = deltas(c,1);
                    seq_del_rip_c4(v_c4,2) = deltas(c,2);
                    seq_del_rip_c4(v_c4,3) = deltas(c,3);
                    seq_del_rip_c4(v_c4,4) = con_r_c4(seq_indices(f),1);
                    seq_del_rip_c4(v_c4,5) = con_r_c4(seq_indices(f),2);
                    seq_del_rip_c4(v_c4,6) = con_r_c4(seq_indices(f),3);
                    end
               end
               if sum(co2_c4)~=0
                   seq_indices2 = find(co2_c4,1);
                    for f = 1:length(seq_indices2)
                    v2_c4 = v2_c4+1;
                    seq_rip_del_c4(v2_c4,1) = con_r_c4(seq_indices2(f),1);
                    seq_rip_del_c4(v2_c4,2) = con_r_c4(seq_indices2(f),2);
                    seq_rip_del_c4(v2_c4,3) = con_r_c4(seq_indices2(f),3);
                    seq_rip_del_c4(v2_c4,4) = deltas(c,1);
                    seq_rip_del_c4(v2_c4,5) = deltas(c,2);
                    seq_rip_del_c4(v2_c4,6) = deltas(c,3);
                    end
               end
                 
            end
          else
              
          seq_del_rip_c1 = NaN;
          seq_rip_del_c1 = NaN;
          
          seq_del_rip_c2 = NaN;
          seq_rip_del_c2 = NaN;
          
          seq_del_rip_c3 = NaN;
          seq_rip_del_c3 = NaN;
          
          seq_del_rip_c4 = NaN;
          seq_rip_del_c4 = NaN;
          
          end 
      else
          
      seq_del_rip_c1 = NaN;
      seq_rip_del_c1 = NaN;
      
      seq_del_rip_c2 = NaN;
      seq_rip_del_c2 = NaN;
      
      seq_del_rip_c3 = NaN;
      seq_rip_del_c3 = NaN;
          
      seq_del_rip_c4 = NaN;
      seq_rip_del_c4 = NaN;
          
      end
 %% Ripple-delta-spindle sequence detection Cluster 1 
 
if ~isnan(seq_del_spin)
  if ~isnan(seq_rip_del_c1)
     if ~isempty(seq_rip_del_c1)
        v_c1=0;
        coo = [];
        seq_rip_del_spin_c1 = [];
            for c = 1:size(seq_del_spin,1)
                coo = seq_del_spin(c,1)==seq_rip_del_c1(:,4);
                if sum(coo)~=0
                    seq_indices = find(coo);
                    for f = 1:length(seq_indices)
                    v_c1 = v_c1+1;
                    seq_rip_del_spin_c1(v_c1,1) = seq_rip_del_c1(seq_indices(f),1);
                    seq_rip_del_spin_c1(v_c1,2) = seq_rip_del_c1(seq_indices(f),2);
                    seq_rip_del_spin_c1(v_c1,3) = seq_rip_del_c1(seq_indices(f),3);
                    seq_rip_del_spin_c1(v_c1,4) = seq_rip_del_c1(seq_indices(f),4);
                    seq_rip_del_spin_c1(v_c1,5) = seq_rip_del_c1(seq_indices(f),5);
                    seq_rip_del_spin_c1(v_c1,6) = seq_rip_del_c1(seq_indices(f),6);
                    seq_rip_del_spin_c1(v_c1,7) = seq_del_spin(c,4);
                    seq_rip_del_spin_c1(v_c1,8) = seq_del_spin(c,5);
                    seq_rip_del_spin_c1(v_c1,9) = seq_del_spin(c,6);
                    end
                end
            end
          else 
          seq_rip_del_spin_c1 = NaN;
      end
else 
     seq_rip_del_spin_c1 = NaN;
  end
else 
     seq_rip_del_spin_c1 = NaN;
end 
%% Ripple-delta-spindle sequence detection Cluster 2

if ~isnan(seq_del_spin)
  if ~isnan(seq_rip_del_c2)
     if ~isempty(seq_rip_del_c2)
        v_c2=0;
        coo = [];
        seq_rip_del_spin_c2 = [];
            for c = 1:size(seq_del_spin,1)
                coo = seq_del_spin(c,1)==seq_rip_del_c2(:,4);
                if sum(coo)~=0
                    seq_indices = find(coo);
                    for f = 1:length(seq_indices)
                    v_c2 = v_c2+1;
                    seq_rip_del_spin_c2(v_c2,1) = seq_rip_del_c2(seq_indices(f),1);
                    seq_rip_del_spin_c2(v_c2,2) = seq_rip_del_c2(seq_indices(f),2);
                    seq_rip_del_spin_c2(v_c2,3) = seq_rip_del_c2(seq_indices(f),3);
                    seq_rip_del_spin_c2(v_c2,4) = seq_rip_del_c2(seq_indices(f),4);
                    seq_rip_del_spin_c2(v_c2,5) = seq_rip_del_c2(seq_indices(f),5);
                    seq_rip_del_spin_c2(v_c2,6) = seq_rip_del_c2(seq_indices(f),6);
                    seq_rip_del_spin_c2(v_c2,7) = seq_del_spin(c,4);
                    seq_rip_del_spin_c2(v_c2,8) = seq_del_spin(c,5);
                    seq_rip_del_spin_c2(v_c2,9) = seq_del_spin(c,6);
                    end
                end
            end
          else 
          seq_rip_del_spin_c2 = NaN;
      end
else 
     seq_rip_del_spin_c2 = NaN;
  end
else 
     seq_rip_del_spin_c2 = NaN;
end 

%% Ripple-delta-spindle sequence detection Cluster 3

if ~isnan(seq_del_spin)
  if ~isnan(seq_rip_del_c3)
     if ~isempty(seq_rip_del_c3)
        v_c3=0;
        coo = [];
        seq_rip_del_spin_c3 = [];
            for c = 1:size(seq_del_spin,1)
                coo = seq_del_spin(c,1)==seq_rip_del_c3(:,4);
                if sum(coo)~=0
                    seq_indices = find(coo);
                    for f = 1:length(seq_indices)
                    v_c3 = v_c3+1;
                    seq_rip_del_spin_c3(v_c3,1) = seq_rip_del_c3(seq_indices(f),1);
                    seq_rip_del_spin_c3(v_c3,2) = seq_rip_del_c3(seq_indices(f),2);
                    seq_rip_del_spin_c3(v_c3,3) = seq_rip_del_c3(seq_indices(f),3);
                    seq_rip_del_spin_c3(v_c3,4) = seq_rip_del_c3(seq_indices(f),4);
                    seq_rip_del_spin_c3(v_c3,5) = seq_rip_del_c3(seq_indices(f),5);
                    seq_rip_del_spin_c3(v_c3,6) = seq_rip_del_c3(seq_indices(f),6);
                    seq_rip_del_spin_c3(v_c3,7) = seq_del_spin(c,4);
                    seq_rip_del_spin_c3(v_c3,8) = seq_del_spin(c,5);
                    seq_rip_del_spin_c3(v_c3,9) = seq_del_spin(c,6);
                    end
                end
            end
          else 
          seq_rip_del_spin_c3 = NaN;
      end
else 
     seq_rip_del_spin_c3 = NaN;
  end
else 
     seq_rip_del_spin_c3 = NaN;
end 

%% Ripple-delta-spindle sequence detection Cluster 4

if ~isnan(seq_del_spin)
  if ~isnan(seq_rip_del_c4)
     if ~isempty(seq_rip_del_c4)
        v_c4=0;
        coo = [];
        seq_rip_del_spin_c4 = [];
            for c = 1:size(seq_del_spin,1)
                coo = seq_del_spin(c,1)==seq_rip_del_c4(:,4);
                if sum(coo)~=0
                    seq_indices = find(coo);
                    for f = 1:length(seq_indices)
                    v_c4 = v_c4+1;
                    seq_rip_del_spin_c4(v_c4,1) = seq_rip_del_c4(seq_indices(f),1);
                    seq_rip_del_spin_c4(v_c4,2) = seq_rip_del_c4(seq_indices(f),2);
                    seq_rip_del_spin_c4(v_c4,3) = seq_rip_del_c4(seq_indices(f),3);
                    seq_rip_del_spin_c4(v_c4,4) = seq_rip_del_c4(seq_indices(f),4);
                    seq_rip_del_spin_c4(v_c4,5) = seq_rip_del_c4(seq_indices(f),5);
                    seq_rip_del_spin_c4(v_c4,6) = seq_rip_del_c4(seq_indices(f),6);
                    seq_rip_del_spin_c4(v_c4,7) = seq_del_spin(c,4);
                    seq_rip_del_spin_c4(v_c4,8) = seq_del_spin(c,5);
                    seq_rip_del_spin_c4(v_c4,9) = seq_del_spin(c,6);
                    end
                end
            end
          else 
          seq_rip_del_spin_c4 = NaN;
      end
else 
     seq_rip_del_spin_c4 = NaN;
  end
else 
     seq_rip_del_spin_c4 = NaN;
end 

 %% Delta-ripple-spindle sequence detection Cluster 1 
 
if ~isnan(seq_del_spin)
  if ~isnan(seq_del_rip_c1)
     if ~isempty(seq_del_rip_c1)
        v_c1=0;
        coo = [];
        seq_del_rip_spin_c1 = [];
            for c = 1:size(seq_del_spin,1)
                coo = seq_del_spin(c,1)==seq_del_rip_c1(:,1);
                if sum(coo)~=0
                    seq_indices = find(coo);
                    for f = 1:length(seq_indices)
                    v_c1 = v_c1+1;
                    seq_del_rip_spin_c1(v_c1,1) = seq_del_rip_c1(seq_indices(f),1);
                    seq_del_rip_spin_c1(v_c1,2) = seq_del_rip_c1(seq_indices(f),2);
                    seq_del_rip_spin_c1(v_c1,3) = seq_del_rip_c1(seq_indices(f),3);
                    seq_del_rip_spin_c1(v_c1,4) = seq_del_rip_c1(seq_indices(f),4);
                    seq_del_rip_spin_c1(v_c1,5) = seq_del_rip_c1(seq_indices(f),5);
                    seq_del_rip_spin_c1(v_c1,6) = seq_del_rip_c1(seq_indices(f),6);
                    seq_del_rip_spin_c1(v_c1,7) = seq_del_spin(c,4);
                    seq_del_rip_spin_c1(v_c1,8) = seq_del_spin(c,5);
                    seq_del_rip_spin_c1(v_c1,9) = seq_del_spin(c,6);
                    end
                end
            end
          else 
          seq_del_rip_spin_c1 = NaN;
      end
else 
     seq_del_rip_spin_c1 = NaN;
  end
else 
     seq_del_rip_spin_c1 = NaN;
end 
%% Delta-ripple-spindle sequence detection Cluster 2

if ~isnan(seq_del_spin)
  if ~isnan(seq_del_rip_c2)
     if ~isempty(seq_del_rip_c2)
        v_c2=0;
        coo = [];
        seq_del_rip_spin_c2 = [];
            for c = 1:size(seq_del_spin,1)
                coo = seq_del_spin(c,1)==seq_del_rip_c2(:,1);
                if sum(coo)~=0
                    seq_indices = find(coo);
                    for f = 1:length(seq_indices)
                    v_c2 = v_c2+1;
                    seq_del_rip_spin_c2(v_c2,1) = seq_del_rip_c2(seq_indices(f),1);
                    seq_del_rip_spin_c2(v_c2,2) = seq_del_rip_c2(seq_indices(f),2);
                    seq_del_rip_spin_c2(v_c2,3) = seq_del_rip_c2(seq_indices(f),3);
                    seq_del_rip_spin_c2(v_c2,4) = seq_del_rip_c2(seq_indices(f),4);
                    seq_del_rip_spin_c2(v_c2,5) = seq_del_rip_c2(seq_indices(f),5);
                    seq_del_rip_spin_c2(v_c2,6) = seq_del_rip_c2(seq_indices(f),6);
                    seq_del_rip_spin_c2(v_c2,7) = seq_del_spin(c,4);
                    seq_del_rip_spin_c2(v_c2,8) = seq_del_spin(c,5);
                    seq_del_rip_spin_c2(v_c2,9) = seq_del_spin(c,6);
                    end
                end
            end
          else 
          seq_del_rip_spin_c2 = NaN;
      end
else 
     seq_del_rip_spin_c2 = NaN;
  end
else 
     seq_del_rip_spin_c2 = NaN;
end 

%% Delta-ripple-spindle sequence detection Cluster 3

if ~isnan(seq_del_spin)
  if ~isnan(seq_del_rip_c3)
     if ~isempty(seq_del_rip_c3)
        v_c3=0;
        coo = [];
        seq_del_rip_spin_c3 = [];
            for c = 1:size(seq_del_spin,1)
                coo = seq_del_spin(c,1)==seq_del_rip_c3(:,1);
                if sum(coo)~=0
                    seq_indices = find(coo);
                    for f = 1:length(seq_indices)
                    v_c3 = v_c3+1;
                    seq_del_rip_spin_c3(v_c3,1) = seq_del_rip_c3(seq_indices(f),1);
                    seq_del_rip_spin_c3(v_c3,2) = seq_del_rip_c3(seq_indices(f),2);
                    seq_del_rip_spin_c3(v_c3,3) = seq_del_rip_c3(seq_indices(f),3);
                    seq_del_rip_spin_c3(v_c3,4) = seq_del_rip_c3(seq_indices(f),4);
                    seq_del_rip_spin_c3(v_c3,5) = seq_del_rip_c3(seq_indices(f),5);
                    seq_del_rip_spin_c3(v_c3,6) = seq_del_rip_c3(seq_indices(f),6);
                    seq_del_rip_spin_c3(v_c3,7) = seq_del_spin(c,4);
                    seq_del_rip_spin_c3(v_c3,8) = seq_del_spin(c,5);
                    seq_del_rip_spin_c3(v_c3,9) = seq_del_spin(c,6);
                    end
                end
            end
          else 
          seq_del_rip_spin_c3 = NaN;
      end
else 
     seq_del_rip_spin_c3 = NaN;
  end
else 
     seq_del_rip_spin_c3 = NaN;
end 

%% Delta-ripple-spindle sequence detection Cluster 4

if ~isnan(seq_del_spin)
  if ~isnan(seq_del_rip_c4)
     if ~isempty(seq_del_rip_c4)
        v_c4=0;
        coo = [];
        seq_del_rip_spin_c4 = [];
            for c = 1:size(seq_del_spin,1)
                coo = seq_del_spin(c,1)== seq_del_rip_c4(:,1);
                if sum(coo)~=0
                    seq_indices = find(coo);
                    for f = 1:length(seq_indices)
                    v_c4 = v_c4+1;
                    seq_del_rip_spin_c4(v_c4,1) = seq_del_rip_c4(seq_indices(f),1);
                    seq_del_rip_spin_c4(v_c4,2) = seq_del_rip_c4(seq_indices(f),2);
                    seq_del_rip_spin_c4(v_c4,3) = seq_del_rip_c4(seq_indices(f),3);
                    seq_del_rip_spin_c4(v_c4,4) = seq_del_rip_c4(seq_indices(f),4);
                    seq_del_rip_spin_c4(v_c4,5) = seq_del_rip_c4(seq_indices(f),5);
                    seq_del_rip_spin_c4(v_c4,6) = seq_del_rip_c4(seq_indices(f),6);
                    seq_del_rip_spin_c4(v_c4,7) = seq_del_spin(c,4);
                    seq_del_rip_spin_c4(v_c4,8) = seq_del_spin(c,5);
                    seq_del_rip_spin_c4(v_c4,9) = seq_del_spin(c,6);
                    end
                end
            end
          else 
          seq_del_rip_spin_c4 = NaN;
      end
else 
     seq_del_rip_spin_c4 = NaN;
  end
else 
     seq_del_rip_spin_c4 = NaN;
end 
 %% Formatting Variables
 
    seq_del_spin_total{i} = seq_del_spin;
    seq_del_spin_count{i} = size(seq_del_spin,1);
    if isnan(seq_del_spin) 
       seq_del_spin_count{i} = 0;
    end
    % Delta Ripple Total 
    seq_del_rip_total_c1{i} = seq_del_rip_c1;
    seq_del_rip_count_c1{i} = size(seq_del_rip_c1,1);
    if isnan(seq_del_rip_c1) 
        seq_del_rip_count_c1{i} = 0;
    end
    seq_del_rip_total_c2{i} = seq_del_rip_c2;
    seq_del_rip_count_c2{i} = size(seq_del_rip_c2,1);
    if isnan(seq_del_rip_c2) 
        seq_del_rip_count_c2{i} = 0;
    end
    seq_del_rip_total_c3{i} = seq_del_rip_c3;
    seq_del_rip_count_c3{i} = size(seq_del_rip_c3,1);
    if isnan(seq_del_rip_c3) 
        seq_del_rip_count_c3{i} = 0;
    end
    seq_del_rip_total_c4{i} = seq_del_rip_c4;
    seq_del_rip_count_c4{i} = size(seq_del_rip_c4,1);
    if isnan(seq_del_rip_c4) 
        seq_del_rip_count_c4{i} = 0;
    end
    
    % Ripple Delta Total 
    seq_rip_del_total_c1{i} = seq_rip_del_c1;
    seq_rip_del_count_c1{i} = size(seq_rip_del_c1,1);
    if isnan(seq_rip_del_c1) 
        seq_rip_del_count_c1{i} = 0;
    end
    seq_rip_del_total_c2{i} = seq_rip_del_c2;
    seq_rip_del_count_c2{i} = size(seq_rip_del_c2,1);
    if isnan(seq_rip_del_c2) 
        seq_rip_del_count_c2{i} = 0;
    end
    seq_rip_del_total_c3{i} = seq_rip_del_c3;
    seq_rip_del_count_c3{i} = size(seq_rip_del_c3,1);
    if isnan(seq_rip_del_c3) 
        seq_rip_del_count_c3{i} = 0;
    end
    seq_rip_del_total_c4{i} = seq_rip_del_c4;
    seq_rip_del_count_c4{i} = size(seq_rip_del_c4,1);
    if isnan(seq_rip_del_c4) 
        seq_rip_del_count_c4{i} = 0;
    end
    % Delta Ripple Spindle
    seq_del_rip_spin_total_c1{i} = seq_del_rip_spin_c1;
    seq_del_rip_spin_count_c1{i} = size(seq_del_rip_spin_c1,1);
    if isnan(seq_del_rip_spin_c1) 
        seq_del_rip_spin_count_c1{i} = 0;
    end
    seq_del_rip_spin_total_c2{i} = seq_del_rip_spin_c2;
    seq_del_rip_spin_count_c2{i} = size(seq_del_rip_spin_c2,1);
    if isnan(seq_del_rip_spin_c2) 
        seq_del_rip_spin_count_c2{i} = 0;
    end
    seq_del_rip_spin_total_c3{i} = seq_del_rip_spin_c3;
    seq_del_rip_spin_count_c3{i} = size(seq_del_rip_spin_c3,1);
    if isnan(seq_del_rip_spin_c3) 
        seq_del_rip_spin_count_c3{i} = 0;
    end
    seq_del_rip_spin_total_c4{i} = seq_del_rip_spin_c4;
    seq_del_rip_spin_count_c4{i} = size(seq_del_rip_spin_c4,1);
    if isnan(seq_del_rip_spin_c4) 
            seq_del_rip_spin_count_c4{i} = 0;
    end
    % Ripple Delta Spindle
    seq_rip_del_spin_total_c1{i} = seq_rip_del_spin_c1;
    seq_rip_del_spin_count_c1{i} = size(seq_rip_del_spin_c1,1);
    if isnan(seq_rip_del_spin_c1) 
        seq_rip_del_spin_count_c1{i} = 0;
    end
    seq_rip_del_spin_total_c2{i} = seq_rip_del_spin_c2;
    seq_rip_del_spin_count_c2{i} = size(seq_rip_del_spin_c2,1);
    if isnan(seq_rip_del_spin_c2) 
        seq_rip_del_spin_count_c2{i} = 0;
    end
    seq_rip_del_spin_total_c3{i} = seq_rip_del_spin_c3;
    seq_rip_del_spin_count_c3{i} = size(seq_rip_del_spin_c3,1);
    if isnan(seq_rip_del_spin_c3) 
        seq_rip_del_spin_count_c3{i} = 0;
    end
    seq_rip_del_spin_total_c4{i} = seq_rip_del_spin_c4;
    seq_rip_del_spin_count_c4{i} = size(seq_rip_del_spin_c4,1);
    if isnan(seq_rip_del_spin_c4) 
            seq_rip_del_spin_count_c4{i} = 0;
    end
    
    end
    
       save(strcat('Clus1-4_Seq_Del_SWR_CS_',SD_folders{j},'.mat'),'seq_del_rip_spin_total_c1','seq_del_rip_spin_count_c1','seq_del_rip_spin_total_c2','seq_del_rip_spin_count_c2','seq_del_rip_spin_total_c3','seq_del_rip_spin_count_c3','seq_del_rip_spin_total_c4','seq_del_rip_spin_count_c4')
       save(strcat('Clus1-4_Seq_Del_SWR_',SD_folders{j},'.mat'),'seq_del_rip_total_c1','seq_del_rip_count_c1','seq_del_rip_total_c2','seq_del_rip_count_c2','seq_del_rip_total_c3','seq_del_rip_count_c3','seq_del_rip_total_c4','seq_del_rip_count_c4')
       save(strcat('Clus1-4_Seq_SWR_Del_',SD_folders{j},'.mat'),'seq_rip_del_total_c1','seq_rip_del_count_c1','seq_rip_del_total_c2','seq_rip_del_count_c2','seq_rip_del_total_c3','seq_rip_del_count_c3','seq_rip_del_total_c4','seq_rip_del_count_c4')
       save(strcat('Clus1-4_Seq_SWR_Del_CS_',SD_folders{j},'.mat'),'seq_rip_del_spin_total_c1','seq_rip_del_spin_count_c1','seq_rip_del_spin_total_c2','seq_rip_del_spin_count_c2','seq_rip_del_spin_total_c3','seq_rip_del_spin_count_c3','seq_rip_del_spin_total_c4','seq_rip_del_spin_count_c4') 
end
