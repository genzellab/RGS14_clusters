function transition_network_poe(tpm)

clc
% Example transition probability matrix for 10 states
%transition_matrix = rand(10, 10);  % Replace with your transition probabilities
transition_matrix=tpm';
% Create a directed graph from the transition matrix
num_states = size(transition_matrix, 1);

% Plot the graph with 'force' layout and customized edge properties
figure;
p = plot(digraph(transition_matrix), 'Layout', 'force', 'EdgeLabel', transition_matrix(:), 'ArrowSize', 20);

% Customize the appearance of arrows
p.ArrowPosition = 0.7;  % Adjust arrow position along the edge
p.NodeColor = 'r';
p.MarkerSize = 10;
p.LineWidth = 4;
p.ArrowSize = 30;
p.EdgeColor=[0 0 1];
p.NodeFontSize=20;
% Add labels to the nodes
node_labels = cellstr(num2str((1:num_states)'));
p.NodeLabel = node_labels;

% Find edges with larger transition probabilities
larger_prob_edges = transition_matrix > 0.70;  % Modify the threshold as needed
smaller_prob_edges = transition_matrix < 0.05;  % Modify the threshold as needed


% Adjust edge properties for larger probability edges
highlight(p, 'Edges', find(larger_prob_edges), 'LineWidth', 4, 'EdgeColor', 'k','ArrowSize',20);
highlight(p, 'Edges', find(smaller_prob_edges), 'LineWidth', 1, 'EdgeColor', 'g','ArrowSize',10);

% % Find edges with smaller transition probabilities (below 0.6)
% smaller_prob_edges = transition_matrix < 0.6;
% 
% % Adjust edge transparency for smaller probability edges
% p.EdgeAlpha(smaller_prob_edges) = 0.2;  % Modify the alpha value as needed

% Save the figure as an image
output_filename = 'transition_network.png';
% saveas(gcf, output_filename);

% Display completion message
disp(['Graph visualization saved as: ' output_filename]);
end