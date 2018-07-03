%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

function [complete_others_train_set, label_sign_others, random_files] = get_others_train_set(folder_dataset_Hog_01, folder_dataset_Hog_02, folder_dataset_Hog_03, folder_dataset_HueHist, folder_dataset_Haar)
 
    folders={folder_dataset_Hog_01, folder_dataset_Hog_02, folder_dataset_Hog_03, folder_dataset_HueHist, folder_dataset_Haar}
    
    dataset_others_hog_01 = [];
    dataset_others_hog_02 = [];
    dataset_others_hog_03 = [];
    dataset_others_HueHist = [];
    dataset_others_Haar = [];
    label_sign_others = [];
    
    formatSpec = '%g';
    
    %/////////////////////////////////////
    %get other sign samples
    
    %780/42=18,57
    n_other_files=19;
    %escolher 18 ou 19 de cada um dos outros sinais (0 a 13 e 15 a 42)
    
    
    random_files=[];
    for j = 1:5
        for i = 0:42

            if i < 10
                auxi = strcat('\0000',int2str(i),'\');
            else
                auxi = strcat('\000',int2str(i),'\');
            end

            if i ~= 14
                actual_folder = strcat(folders{j},auxi)

                d = dir([actual_folder, '\*.txt']);
                if j == 1%para selecionar os mesmos ficheiros dos outros datasets

                    %actual_folder = strcat(folders{j},auxi)
                    %d = dir([actual_folder, '\*.txt']);
                    number_files=length(d);
                    n=number_files/30; %30 vem de 0 a 29 o numero dos ficheiros
                    random_files = [random_files; sort(randperm(number_files,n_other_files))]; %uniform

                end


                for k = 1 : n_other_files
                    %seleciona n_other_files
                    aux=i+1;
                    if i>13
                        aux=i;
                    end

                    text_file = strcat(actual_folder,d(random_files(aux,k)).name);
                    fileID = fopen(text_file);

                    content = fscanf(fileID,formatSpec);
                    fclose(fileID);
                    
                    
                    
                    if j==1
                        dataset_others_hog_01 = [dataset_others_hog_01 content];
                       label_sign_others = [label_sign_others i];
                    elseif j==2
                        dataset_others_hog_02 = [dataset_others_hog_02 content];
                    elseif j==3
                        dataset_others_hog_03 = [dataset_others_hog_03 content];
                    elseif j==4
                        dataset_others_HueHist = [dataset_others_HueHist content];
                    elseif j==5
                        dataset_others_Haar = [dataset_others_Haar content];
                    end
                end

            end

        end

    end
    others_samples= [size(dataset_others_hog_01); size(dataset_others_hog_02); size(dataset_others_hog_03); size(dataset_others_HueHist); size(dataset_others_Haar)];

    complete_others_train_set=[dataset_others_hog_01; dataset_others_hog_02; dataset_others_hog_03; dataset_others_HueHist; dataset_others_Haar];

end