%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087


function [projected_features, preserved, model] = reductor(n_p_features,dimension_changer,selected_features,label_set, num_classes)

%disp(dimension_changer)
%size(selected_features)
%n_p_features


%testar com pca
if strcmp(dimension_changer,'pca')
    modelpca = pca(selected_features',n_p_features);
    projected_features = linproj(selected_features',modelpca);
    preserved = sum(modelpca.eigval(1:n_p_features).^2)/sum(modelpca.eigval(1:end).^2);
    model=modelpca;
end




%testar com lda
if strcmp(dimension_changer,'lda')
    %disp('selected_features')
    %size(selected_features)
    %size(label_set)
    pf.X=selected_features';%fica dim X num_samples
    pf.y=label_set; %classes de 1 a nclasses
    model=lda(pf,n_p_features);
    projected_features = linproj(pf,model);
    
    if n_p_features < num_classes
        aux=n_p_features;
    else
        aux=num_classes-1;
    end
    projected_features = projected_features.X(1:aux,:); %n-1 classes portanto so posso pegar na primeira coluna, se nao da valores complexos
    
        
        
    %disp('projected_features')
    %size(projected_features)
    preserved = sum(model.eigval(1:n_p_features).^2)/sum(model.eigval(1:end).^2);
end



