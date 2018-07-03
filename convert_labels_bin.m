%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

function bin_labels_test_set = convert_labels_bin(labels_all_test_set)
    
    bin_labels_test_set = zeros(size(labels_all_test_set,1),1);
    
    for i = 1:size(labels_all_test_set,1)
        if labels_all_test_set(i) == 14
            bin_labels_test_set(i) = 1;
        end
            
    end
end