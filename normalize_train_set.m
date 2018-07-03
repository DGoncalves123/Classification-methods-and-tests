%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

function [normalize_train_set, mu, sigma] = normalize_train_set(train_set)

    n_features=size(train_set,2);
    n_samples=size(train_set,1);
    aux = zeros(size(train_set,1),size(train_set,2));
    
    %se quiser entre 0 e 1
    %normalize_train_set = (train_set - min(train_set)) ./ (max(train_set)- min(train_set));
   
    
    %usando a media e desvio padrao, onde a media é 0 e o desvio padrao 1
    mu=mean(train_set);
    sigma = std(train_set);
    aux = train_set-mu;
    normalize_train_set=aux./sigma;
    
    
end