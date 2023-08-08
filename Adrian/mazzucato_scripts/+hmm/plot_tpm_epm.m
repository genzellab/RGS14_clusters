tpm0=hmm_bestfit.tpm;
epm0=hmm_bestfit.epm/HmmParam.BinSize; epm0(:,end)=[]; %epm0=epm0';
col=colors;
% sort states from the longest lived
[B,I]=sort(diag(tpm0),'descend');
tpm=tpm0(I,I); epm=(epm0(I,:)); col=col(I,:);
c=colshade(i2,:)
% c=flipud(c);
[~, idx] = ismember(c, col, 'rows');
% col_reordered = col(idx, :);
epm=epm(idx,:);
% Choose a small positive threshold
epsilon = 1e-3;

% Threshold the array to prevent extremely small values
thresholded_data = max(epm, epsilon);

% Apply logarithm to the thresholded array
epm = log10(thresholded_data);

% TPM
minExp=4;
tpm(tpm<10^(-minExp))=10^(-minExp);
% figure(1); clf;
allscreen()
colormap('gray');
imagesc((log10(tpm)));
hC=colorbar;% set(hC,'ColorScale','log')
l = fliplr(-linspace(0,minExp,minExp+1)); % Tick mark positions
Lab=[]; Lab{1}=1;
for i_l=2:numel(l); Lab{i_l}=sprintf('10^{-%d}',i_l-1); end
ylabel(hC,'prob(i$\to$j)','FontSize',20,'interpreter','latex');
set(hC,'Ytick',l,'YTicklabel',fliplr(Lab));
aux.figset(gca,'State','State','Transition Probability',20);
filename=fullfile(hmmdir,'Tpm.pdf');
% saveas(gcf,filename,'pdf');
%% EPM
% figure(2); clf;
allscreen()
%subplot(12,1,1);
% for i_c=1:size(col,1)
%     [~,~]=aux.jbfill([i_c-0.5,i_c+0.5],...
%         ones(1,2),zeros(1,2),col(i_c,:),0,0,1); hold on
% end
% xlim([0.5,i_c+0.5]); title('raster colors'); set(gca,'ytick',[]);
subplot(12,1,[1 12]);
colormap('gray');
hi=imagesc(fliplr(epm)'); hC=colorbar;% set(hC,'ColorScale','log')
set(gca,'ytick',[1:1:size(epm,2)],'yticklabel',[{'Dc'}; {'Dh'}; {'Sc'}; {'Sh'}; {'RC3'}; {'RC2'}; {'RC1'}]);
set(gca,'xtick',[1:1:size(epm,1)],'xticklabel',(i2));

%set(gca,'ytick',[1,size(epm,2)],'yticklabel',[size(epm,2),1]);

ylabel(hC,'log10( Occurrence rate )  [events/s]','FontSize',15);
aux.figset(gca,'State',[],'Emission Probability',15);
filename=fullfile(hmmdir,'Epm.pdf');
% saveas(gcf,filename,'pdf');
