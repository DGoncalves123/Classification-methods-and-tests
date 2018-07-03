%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087


function [dataset, label] = get_all_datasets(folder_dataset_Hog_01, folder_dataset_Hog_02, folder_dataset_Hog_03, folder_dataset_HueHist, folder_dataset_Haar)
    
    %folder_dataset_Hog_01 = 'C:\Users\Utilizador\Desktop\datasets\GTSRB_Final_Training_HOG\GTSRB\Final_Training\HOG\HOG_01';
    %folder_dataset_Hog_02 = 'C:\Users\Utilizador\Desktop\datasets\GTSRB_Final_Training_HOG\GTSRB\Final_Training\HOG\HOG_02';
    %folder_dataset_Hog_03 = 'C:\Users\Utilizador\Desktop\datasets\GTSRB_Final_Training_HOG\GTSRB\Final_Training\HOG\HOG_03';
    %folder_dataset_HueHist = 'C:\Users\Utilizador\Desktop\datasets\GTSRB\Final_Training\HueHist';
    %folder_dataset_Haar = 'C:\Users\Utilizador\Desktop\datasets\GTSRB\Final_Training\Haar';
    %folder_label_test_set = 'C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\GT-final_test.CSV';
    %folder_test_set_Hog_01 = 'C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\HOG\HOG_01';
    %folder_test_set_Hog_02 = 'C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\HOG\HOG_02';
    %folder_test_set_Hog_03 = 'C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\HOG\HOG_03';
    %folder_test_set_HueHist = 'C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\HueHist';
    %folder_test_set_Haar = 'C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\Haar';

    folders={folder_dataset_Hog_01, folder_dataset_Hog_02, folder_dataset_Hog_03, folder_dataset_HueHist, folder_dataset_Haar}
    
    dataset_hog_01 = [];
    dataset_hog_02 = [];
    dataset_hog_03 = [];
    dataset_HueHist = [];
    dataset_Haar = [];
    label_aux = [];
    
    formatSpec = '%g';
    %'C:\Users\Utilizador\Desktop\datasets\GTSRB\Final_Training\Haar\00001\'
    %actual_folder = strcat('C:\Users\Utilizador\Desktop\datasets\GTSRB\Final_Training\Haar\00001\');
    %        d = dir([actual_folder, '\*.txt']);
    for j = 1:5
        for i = 0:42

            if i < 10
                auxi = strcat('\0000',int2str(i),'\');
            else
                auxi = strcat('\000',int2str(i),'\');
            end

            
            actual_folder = strcat(folders{j},auxi);

            d = dir([actual_folder, '\*.txt']);
                
            for l = 1:size(d,1)
                
                text_file = strcat(actual_folder,d(l).name);
                fileID = fopen(text_file);

                content = fscanf(fileID,formatSpec);
                fclose(fileID);


                if j==1
                    dataset_hog_01 = [dataset_hog_01 content];

                elseif j==2
                    dataset_hog_02 = [dataset_hog_02 content];

                elseif j==3
                    dataset_hog_03 = [dataset_hog_03 content];
                elseif j==4
                    dataset_HueHist = [dataset_HueHist content];
                elseif j==5
                    dataset_Haar = [dataset_Haar content];
                end
                

                if j == 1
                    
                    label_aux = [label_aux i+1];
                    
                end

            end

        end

    end
   
    dataset=[dataset_hog_01; dataset_hog_02; dataset_hog_03; dataset_HueHist; dataset_Haar];
    label = label_aux;
end