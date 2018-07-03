%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

function [eig_values_maiores_um] = Kaiser_Test(train_data)
    
    covarianceMatrix = cov(train_data);
    eig_values = eig(covarianceMatrix);
    
    %se eig value >1 deve ser considerada aquela feature
   	eig_values_maiores_um = sum(eig_values > 1);
    
end