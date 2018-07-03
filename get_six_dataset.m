%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

%function [dataset, label] = get_six_dataset(ex_folder_dataset_Haar)
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
    
    size_of_each_folder

    %all_dataset = load('dataset.mat');
    %all_dataset = all_dataset.dataset;
    %all_dataset = all_dataset';

    label_all_dataset = load('label_all_dataset');
    label_all_dataset = label_all_dataset.label_aux;
    label_all_dataset = label_all_dataset';

    um =[0,1,2,3,4,5,7,8]; 
    rand_ind_um = randi(length(um),1,1);
    dois = [9,10,15,16];
    rand_ind_dois = randi(length(dois),1,1);
    tres=[33,34,35,36,37,38,39,40];
    rand_ind_tres = randi(length(tres),1,1);
    quatro=[18,19,20,21,22,23,24,25,26,27,28,29,30,30,11];
    rand_ind_quatro = randi(length(quatro),1,1);
    cinco=[6,41,42,32];
    rand_ind_cinco = randi(length(cinco),1,1);
    seis=[12,13,14,17];
    rand_ind_seis = randi(length(seis),1,1);
    
    
    


    %aux_sign_rand = [rand_ind_um; rand_ind_dois; rand_ind_tres; rand_ind_quatro; rand_ind_cinco; rand_ind_seis]
    %aux_sign_rand = sort(aux_sign_rand);

    %num_samples_of_selected_signs = [];
    %for i = 1:6
    %    num_samples_of_selected_signs = [num_samples_of_selected_signs; size_of_each_folder(aux_sign_rand(i)+1)];
    %end
    %num_samples_of_selected_signs
    
    
    
    number_min_of_samples_from_signs = min(size_of_each_folder)
    %4 é o numero de sinais minimo de um grupo
    number_samples_for_group = number_min_of_samples_from_signs * 4
    
    number_samples = [number_samples_for_group/8 ; number_samples_for_group/4; number_samples_for_group/8; number_samples_for_group/15; number_samples_for_group/4; number_samples_for_group/4]
    
    
   
    
    samples_selected=[];
    label_samples_selected=[];
    
    count=1;
    for i = 0:42
        
        if ismember(i,um)
            %samples_selected=[samples_selected;all_dataset(count:count+number_samples(1),:)];
            label_samples_selected = [label_samples_selected; label_all_dataset(count:count+number_samples(1),:)./label_all_dataset(count:count+number_samples(1),:)-1];
            count = count + size_of_each_folder(i+1);
            
        
        elseif ismember(i,dois) 
            %samples_selected=[samples_selected;all_dataset(count:count+number_samples(2),:)];
            label_samples_selected = [label_samples_selected; (label_all_dataset(count:count+number_samples(2),:)./label_all_dataset(count:count+number_samples(2),:))*1];
            count = count + size_of_each_folder(i+1);
            
        
        elseif ismember(i,tres)
            %samples_selected=[samples_selected;all_dataset(count:count+number_samples(3),:)];
            label_samples_selected = [label_samples_selected; (label_all_dataset(count:count+number_samples(3),:)./label_all_dataset(count:count+number_samples(3),:))*2];
            count = count + size_of_each_folder(i+1);
            
        
        elseif ismember(i,quatro)
            %samples_selected=[samples_selected;all_dataset(count:count+number_samples(4),:)];
            label_samples_selected = [label_samples_selected; (label_all_dataset(count:count+number_samples(4),:)./label_all_dataset(count:count+number_samples(4),:))*3];
            count = count + size_of_each_folder(i+1);
            
            
        elseif ismember(i,cinco)
            %samples_selected=[samples_selected;all_dataset(count:count+number_samples(5),:)];
            label_samples_selected = [label_samples_selected; (label_all_dataset(count:count+number_samples(5),:)./label_all_dataset(count:count+number_samples(5),:))*4];
            count = count + size_of_each_folder(i+1);
            
            
        elseif ismember(i,seis)
            %samples_selected=[samples_selected;all_dataset(count:count+number_samples(6),:)];
            label_samples_selected = [label_samples_selected; (label_all_dataset(count:count+number_samples(6),:)./label_all_dataset(count:count+number_samples(6),:))*5];
            count = count + size_of_each_folder(i+1);
            
                        
        end
        

        %size(samples_selected)
        
        
    end
    size(label_samples_selected)
    save('label_samples_selected.mat','label_samples_selected');
    
    
%end
