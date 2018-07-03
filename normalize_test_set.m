%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

function [normalize_test_set] = normalize_test_set(test_set, mu, sigma)

    aux = zeros(size(test_set,1),size(test_set,2));
    
    %se quiser entre 0 e 1
    %normalize_train_set = (train_set - min(train_set)) ./ (max(train_set)- min(train_set));
   
    %usando a media e desvio padrao, onde a media é 0 e o desvio padrao 1
    aux = test_set-mu;
    normalize_test_set = aux./sigma;
    
    
end