%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

function test_set = get_test_set(folder_test_set_Hog_01, folder_test_set_Hog_02, folder_test_set_Hog_03, folder_test_set_HueHist, folder_test_set_Haar)

    folders={folder_test_set_Hog_01, folder_test_set_Hog_02, folder_test_set_Hog_03, folder_test_set_HueHist, folder_test_set_Haar}
    
    test_set_hog_01 = [];
    test_set_hog_02 = [];
    test_set_hog_03 = [];
    test_set_HueHist = [];
    test_set_Haar = [];

    formatSpec = '%g';
    
    
    for j = 1:5
        %C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\Haar
        actual_folder = folders{j}
        d = dir([actual_folder, '\*.txt']);
        n_samples=size(d,1);
        
        for i = 1:n_samples
            text_file = strcat(actual_folder,'\',d(i).name);
            fileID = fopen(text_file);

            content = fscanf(fileID,formatSpec);
            fclose(fileID);
            
            if j==1
                test_set_hog_01 = [test_set_hog_01 content];

            elseif j==2
                test_set_hog_02 = [test_set_hog_02 content];

            elseif j==3
                test_set_hog_03 = [test_set_hog_03 content];
            
            elseif j==4
                test_set_HueHist = [test_set_HueHist content];
            
            elseif j==5
                test_set_Haar = [test_set_Haar content];
            end
        end
        
    end
    test_set=[test_set_hog_01; test_set_hog_02; test_set_hog_03; test_set_HueHist; test_set_Haar];
    

end