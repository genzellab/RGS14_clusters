function transition_network_poe(Transition_matrix,colors)
%Generates transitions figure similar to Gina Poe's.
clc
% Example transition probability matrix for 10 states
%transition_matrix = rand(10, 10);  % Replace with your transition probabilities
% transition_matrix=tpm'; % first approach;
transition_matrix=Transition_matrix'; % second approach

% Create a directed graph from the transition matrix
num_states = size(transition_matrix, 1);
transition_matrix(transition_matrix==0)=0.000001; % Used to avoid exact zero entries.
% Plot the graph with 'force' layout and customized edge properties
% figure;
allscreen()
p = plot(digraph(transition_matrix), 'Layout', 'force', 'EdgeLabel', transition_matrix(:), 'ArrowSize', 20);
%p = plot(digraph(transition_matrix), 'Layout', 'force',  'ArrowSize', 20);
% EdgesValues=digraph(transition_matrix).Edges;
% EdgesValues=EdgesValues.Weight;
EdgesValues=transition_matrix(:);
node_ind=1:1+length(transition_matrix):numel(transition_matrix); %indexes of nodes.
EdgesValues(node_ind)=0;
EdgesValues(EdgesValues<0.01)=0;
EdgesValues_colorbar=EdgesValues; %not scaled values.
EdgesValues=EdgesValues./max(EdgesValues);


% EdgesValues(EdgesValues~=0&EdgesValues<0.05)=EdgesValues(EdgesValues~=0&EdgesValues<0.05)+0.5;
EdgesColors=[1-EdgesValues 1-EdgesValues 1-EdgesValues]; %1- is to make lower values whiter.
%hist(EdgesValues,100)

% Customize the appearance of arrows
p.ArrowPosition = 0.3;  % Adjust arrow position along the edge
%p.NodeColor = 'r';
p.NodeColor = colors;
p.MarkerSize=10*[zscore([diag(transition_matrix).'])+abs(min(zscore([diag(transition_matrix).'])))+1];
% p.MarkerSize = 10;
p.LineWidth = 4;
p.ArrowSize = 30;

p.EdgeColor=EdgesColors;
p.NodeFontSize=20;%20;

EdgeLabels=p.EdgeLabel;
EdgeLine    = cell(1, length(EdgeLabels));
EdgeLine(:) = {'-'};


%Remove Labels of Edges with 0 values
for ind=1:length(EdgeLabels)
    if EdgesValues(ind)==0 
        if  ~ismember(ind,node_ind)
            EdgeLabels{ind}='';
        end
        EdgeLine{ind}='none';
    end
end
p.EdgeLabel=EdgeLabels;
p.LineStyle=EdgeLine;
% p.ShowArrows=EdgeArrow;
p.EdgeAlpha=1;


% Add labels to the nodes
node_labels = cellstr(num2str((1:num_states)'));
p.NodeLabel = node_labels;

% Add new labels that are to the upper, right of the nodes
text(p.XData+.095, p.YData+.01 ,p.NodeLabel, ...
    'VerticalAlignment','middle',...
    'HorizontalAlignment', 'left',...
    'FontSize', 20)
% Remove old labels
p.NodeLabel = {}; 

% cb=colorbar;
% cb.Label.String = 'Percentage of transitions';
% cb.Limits=[min(EdgesValues_colorbar) max(EdgesValues_colorbar)];
C=gray(15);
C(end+1,:)=1;
colormap(flipud(C))

cb=colorbar()
%cb.Limits=[min(EdgesValues_colorbar) max(EdgesValues_colorbar)];
cb.TickLabels=num2cell(linspace(0,max(EdgesValues_colorbar),11));
cb.Label.String = 'Proportion of transitions per state';
cb.Location='east';
cb.Label.FontSize=14;
%cb=colorbar('Ticks',linspace(0,max(EdgesValues_colorbar),11),...
%     'TickLabels',["" "0.01" "0.5" "1" "1.5" "2" "5" "10" "15" "20" "25" "50" "75" "100" "250" "500" ">500"]);
% colormap(gray)
set(gca,'Visible','off')
set(gcf,'color','w');
xo
cd('/home/adrian/Documents/rgs_clusters_figs')
printing('veh_moving')
printing_image('veh_moving')
% printing('veh_HC')
% printing_image('veh_HC')
end