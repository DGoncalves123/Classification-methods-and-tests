%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

%function [dataset, label] = get_all_balanced_dataset(ex_folder_dataset_Haar)
    ex_folder_dataset_Haar = 'C:\Users\Utilizador\Desktop\datasets\GTSRB\Final_Training\Haar';
   
    size_of_each_folder = [];
    for i = 0:42

        if i < 10
            auxi = strcat('\0000',int2str(i),'\');
        else
            auxi = strcat('\000',int2str(i),'\');
        end
        

        actual_folder = strcat(ex_folder_dataset_Haar,auxi);

        d = dir([actual_folder, '\*.txt']);

        size_of_each_folder = [size_of_each_folder; size(d,1);];
        
    end
  
    
    all_dataset = load('dataset.mat');
    all_dataset = all_dataset.dataset;
    all_dataset = all_dataset';
    
    
    label_all_dataset = load('label_all_dataset');
    label_all_dataset = label_all_dataset.label_aux;
    label_all_dataset = label_all_dataset';
    
    
   
    
    number_min_of_samples_from_signs = min(size_of_each_folder)
    
   
    
    all_balanced_dataset=[];
    labels_all_balanced_dataset=[];
    
    count=0;
    for i = 0:42
        i
        count
        c=randperm(size_of_each_folder(i+1),number_min_of_samples_from_signs);
        all_balanced_dataset=[all_balanced_dataset; all_dataset(c+count,:)];
        labels_all_balanced_dataset = [labels_all_balanced_dataset; label_all_dataset(c+count,:)];
        count = count + size_of_each_folder(i+1);    

        
        
    end
    size(all_balanced_dataset)
    size(labels_all_balanced_dataset)
    save('all_balanced_dataset.mat','all_balanced_dataset');
    save('labels_all_balanced_dataset.mat','labels_all_balanced_dataset');
    
    
%end
