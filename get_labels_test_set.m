%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

function label_all_test_set = get_label_test_set (path)
    [xls_data,col_names]=xlsread(path);
    labels_all_test_set = xls_data(:,7);
end