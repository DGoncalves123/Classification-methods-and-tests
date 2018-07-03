%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

function [complete_stop_train_set, label_sign_stop] = get_stop_train_set(folder_dataset_Hog_01, folder_dataset_Hog_02, folder_dataset_Hog_03, folder_dataset_HueHist, folder_dataset_Haar)
    
    folders={folder_dataset_Hog_01, folder_dataset_Hog_02, folder_dataset_Hog_03, folder_dataset_HueHist, folder_dataset_Haar}
    
    dataset_stop_hog_01 = [];
    dataset_stop_hog_02 = [];
    dataset_stop_hog_03 = [];
    dataset_stop_HueHist = [];
    dataset_stop_Haar = [];
    label_sign_stop = [];

    formatSpec = '%g';
    
    
    
    n_features=0;
    %/////////////////////////////////////
    %get stop samples
    %stop é a pasta 14
    for j = 1:5
        actual_folder = strcat(folders{j},'\00014') 

        for k = 0:25
            for l = 0:29

                auxk=k;
                auxl=l;

                if k < 10
                    auxk = strcat('\0000',int2str(k));
                else
                    auxk = strcat('\000',int2str(k));
                end

                if l < 10
                    auxl = strcat('_0000',int2str(l));
                else
                    auxl = strcat('_000',int2str(l));
                end 

                text_file = strcat(actual_folder,auxk,auxl,'.txt');
                fileID = fopen(text_file);

                content = fscanf(fileID,formatSpec);
                fclose(fileID);
                
                
                
                if j==1
                    dataset_stop_hog_01=[dataset_stop_hog_01 content];
                    label_sign_stop = [label_sign_stop 14];
                elseif j==2
                    dataset_stop_hog_02=[dataset_stop_hog_02 content];
                elseif j==3
                    dataset_stop_hog_03=[dataset_stop_hog_03 content];
                elseif j==4
                    dataset_stop_HueHist = [dataset_stop_HueHist content];
                elseif j==5
                    dataset_stop_Haar = [dataset_stop_Haar content];
                end
            end
        end

    end

    stop_samples= [size(dataset_stop_hog_01); size(dataset_stop_hog_02); size(dataset_stop_hog_03); size(dataset_stop_HueHist); size(dataset_stop_Haar)];
    complete_stop_train_set=[dataset_stop_hog_01; dataset_stop_hog_02; dataset_stop_hog_03; dataset_stop_HueHist; dataset_stop_Haar];
    
    
end