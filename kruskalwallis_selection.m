%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

function [train_set, selected_features_with_rank, only_selected_features_and_sorted] = kruskalwallis_selection(train_set,label_set,number_features_choose)
    
    selected_features_with_rank = [];
    n_features = size(train_set,2);
    n_samples = size(train_set,1);
    aux=zeros(n_features,2);
    rank=cell(n_features,2);
    
    for i=1:n_features
        [p,anovatab]=kruskalwallis(train_set(:,i),label_set,'off'); %
        
        aux(i,1)=p;
        aux(i,2)=anovatab{2,5}; %get Chi-sq of table
        rank{i,1}=i;
        rank{i,2}=anovatab{2,5};
    end

    [Y,I]=sort([rank{:,2}],2,'descend');
    stotal=[sprintf('K-W Feature Ranking')];
    for i=1:n_features
        stotal=[stotal,sprintf('%d-->%.2f\n',rank{I(i),1},rank{I(i),2})];
        if i <= number_features_choose
            selected_features_with_rank = [selected_features_with_rank; rank{I(i),1} rank{I(i),2}];
        end
    end
    
    %ordenar pelo indice das features
    only_selected_features_and_sorted = sort(selected_features_with_rank(1:end,1));

    %aplicar features selecionadas
    train_set=train_set(:,only_selected_features_and_sorted(1:end,1));


    
    
end
