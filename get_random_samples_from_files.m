%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

function [random_selected, label_random_selected] = get_random_samples_from_files(number_folds, n_samples,folder_dataset_Hog_01, folder_dataset_Hog_02, folder_dataset_Hog_03, folder_dataset_HueHist, folder_dataset_Haar)
    
    number_of_samples_to_choose = ceil(n_samples/number_folds);
    random_signs = randi([0 42], 1, number_of_samples_to_choose);
    random_signs=sort(random_signs);
    
    
    folders={folder_dataset_Hog_01, folder_dataset_Hog_02, folder_dataset_Hog_03, folder_dataset_HueHist, folder_dataset_Haar}
    
    random_selected = [];
    label_random_selected = [];
    formatSpec = '%g';
    
    
    
    for i = 1:number_of_samples_to_choose
        sign = random_signs(i)
        if sign < 10
            aux_sign = strcat('\0000',int2str(i),'\');
        else
            aux_sign = strcat('\000',int2str(i),'\');
        end
        
        
        
        for j = 1 : 5
            actual_folder = strcat(folders{j},aux_sign);
            d = dir([actual_folder, '\*.txt']);
            if j == 1%para selecionar os mesmos ficheiros dos outros datasets
  
                number_files=length(d);
                random_file = randi([0 number_files],1,1);
                if sign ==  14
                    label_random_selected = [label_random_selected  1];
                else
                    label_random_selected = [label_random_selected  0];
                end
                
            end
            text_file = strcat(actual_folder,d(random_file).name);
            fileID = fopen(text_file);

            content = fscanf(fileID,formatSpec);
            if j==1
                random_selected = [random_selected; content];
            else
                random_selected = [random_selected content];
            end
            fclose(fileID);
            
        end
        
            
    end
      
end
