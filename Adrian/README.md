# HMM analysis

- prepare_markov.m: Function created to test the analysis using a single study day. It preprocesses the data of a NREM bout and displays it. Continue the analysis running 'demo2_HMM_Simple.m'

- veh_rgs_data_for_hmm.mat: Structure which contains all data needed for HMM analysis from Vehicle study days of the RGS14 project. Generated from 'prepare_markov_nontrial.m'.

- prepare_markov_nontrial.m: Generates the spikes and spikes_peak structs in the format needed for the hmm analysis.
  
- markov_studyday.m: Same as "prepare_markov_nontrial.m" but customized to specific study days. Prerequisite for "state_characteristics.m".

- state_characteristics.m: Generates plots comparing state total time, number of state bouts and state bout duration between different OS conditions.
  
- [compute_tpm.m](https://github.com/genzellab/RGS14_clusters/blob/main/Adrian/compute_tpm.m): As name suggests, it computes the transition probability matrix and displays the network in a similar fashion as the Poe paper.  
