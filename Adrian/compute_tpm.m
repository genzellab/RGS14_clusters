% close all
% trm=hmm_bestfit.tpm;
% trm(find(eye(size(trm))))=zeros(1,10);
% 
% imagesc(hmm_bestfit.tpm);colorbar()
% figure()
% imagesc(transition_matrix); colorbar()
% figure()
% imagesc(trm); colorbar()

% figure()
% imagesc(trm./max(trm)); colorbar()

%%
% Sample vector of states
% states = [1, 2, 1, 3, 2, 1, 3, 3, 2, 1];
states=[hmm_postfit.sequence(4,:)];
state_dur=[hmm_postfit.sequence(3,:)];
BinSize=0.010;
stateepochs=round(state_dur/BinSize);
% Preallocate the newstates array
total_length = sum(stateepochs);
newstates = zeros(1, total_length);

% Create indices for each state based on its duration
indices = cumsum([1 stateepochs(1:end-1)]);
% Use array indexing for efficient assignment
for i = 1:length(states)
    newstates(indices(i):indices(i) + stateepochs(i) - 1) = states(i);
end
%%
states=newstates;
% newstates=[];
% parfor i=1:length(states)
%     newstates=[newstates repelem(states(i),stateepochs(i))];
% end

% Define the number of unique states
num_states = max(states);

% Initialize transition matrix with zeros
transition_matrix = zeros(num_states, num_states);

% Count transitions
for i = 1:length(states) - 1
    current_state = states(i);
    next_state = states(i + 1);
    transition_matrix(current_state, next_state) = transition_matrix(current_state, next_state) + 1;
end

% Normalize counts to obtain probabilities
transition_matrix = transition_matrix ./ sum(transition_matrix, 2);

% disp('Transition Probability Matrix:');
% disp(transition_matrix
%%
% [~,I]=sort(diag(transition_matrix),'descend');
[~,I]=sort(diag(tpm0),'descend');
Transition_matrix=transition_matrix(I,I); 
