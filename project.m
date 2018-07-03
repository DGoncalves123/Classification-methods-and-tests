%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

function result = project(num_classes,sel_method, red_method,number_dimen, class_method, val_method, vis_method,roc_mode,ROC)
    %num_classes,sel_method, red_method,number_dimen, class_method, val_method, vis_method,roc_mode,ROC
    %um_classes=6;
    %sel_method="Kruskal-Wallis";
    %red_method='PCA';
    %number_dimen='Kaiser';
    %class_method='Fisher Linear Discriminant';
    %val_method='K-Folds';
    %vis_method='Graph';
    %roc_mode='Nao';%Nao
    %ROC=0;

    folder_dataset_Hog_01 = 'C:\Users\Utilizador\Desktop\datasets\GTSRB_Final_Training_HOG\GTSRB\Final_Training\HOG\HOG_01';
    folder_dataset_Hog_02 = 'C:\Users\Utilizador\Desktop\datasets\GTSRB_Final_Training_HOG\GTSRB\Final_Training\HOG\HOG_02';
    folder_dataset_Hog_03 = 'C:\Users\Utilizador\Desktop\datasets\GTSRB_Final_Training_HOG\GTSRB\Final_Training\HOG\HOG_03';
    folder_dataset_HueHist = 'C:\Users\Utilizador\Desktop\datasets\GTSRB\Final_Training\HueHist';
    folder_dataset_Haar = 'C:\Users\Utilizador\Desktop\datasets\GTSRB\Final_Training\Haar';
    folder_label_test_set = 'C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\GT-final_test.CSV';
    folder_test_set_Hog_01 = 'C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\HOG\HOG_01';
    folder_test_set_Hog_02 = 'C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\HOG\HOG_02';
    folder_test_set_Hog_03 = 'C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\HOG\HOG_03';
    folder_test_set_HueHist = 'C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\HueHist';
    folder_test_set_Haar = 'C:\Users\Utilizador\Desktop\datasets\teste\GTSRB\Final_Test\Haar';

    %///////////////////GET DATA/////////////////////
    
    if (num_classes==2)
        disp('2 Classes')
        %[complete_stop_train_set, label_sign_stop] = get_stop_train_set(folder_dataset_Hog_01, folder_dataset_Hog_02, folder_dataset_Hog_03, folder_dataset_HueHist, folder_dataset_Haar);
        %[complete_others_train_set, label_sign_others] = get_others_train_set(folder_dataset_Hog_01, folder_dataset_Hog_02, folder_dataset_Hog_03, folder_dataset_HueHist, folder_dataset_Haar);

        complete_stop_train_set = load('complete_stop_train_set.mat');
        complete_stop_train_set = complete_stop_train_set.complete_stop_train_set;

        complete_others_train_set = load('complete_others_train_set.mat');
        complete_others_train_set = complete_others_train_set.complete_others_train_set;

        %label_sign_stop = load('label_sign_stop.mat');
        %label_sign_stop = label_sign_stop.label_sign_stop;
        label_sign_stop = ones(1,size(complete_stop_train_set,2));

        %label_sign_others = load('label_sign_others.mat');
        %label_sign_others = label_sign_others.label_sign_others;
        label_sign_others = zeros(1,size(complete_others_train_set,2));


        %complete_label_set = load('label_set.mat');
        %complete_label_set = complete_label_set.complete_label_set;

        %juntar os samples de modo a ter o meu dataset de treino final balanceado
        train_set = [complete_stop_train_set complete_others_train_set];
        label_set = [label_sign_stop label_sign_others];
        %obter labels test set
        %labels_all_test_set = get_labels_test_set(folder_label_test_set);
        %labels_all_test_set = load('labels_all_test_set.mat');
        %labels_all_test_set = labels_all_test_set.labels_all_test_set;
        %bin_labels_test_set = convert_labels_bin(labels_all_test_set);
        bin_labels_test_set = load('bin_labels_test_set.mat');
        bin_labels_test_set = bin_labels_test_set.bin_labels_test_set;
        
        actual_label_test_set=bin_labels_test_set;%(1:300,:)??????????
        actual_label_test_set=actual_label_test_set+1;
        
    elseif (num_classes == 6)
        disp('6 classes')
        samples_train_set = load('samples_selected.mat');

        label_samples_train_set = load('label_samples_selected.mat');
        
        train_set = samples_train_set.samples_selected';
        label_set = label_samples_train_set.label_samples_selected';
        
        labels_samples_test_set = load('labels_6_test_set.mat');
        
        actual_label_test_set=labels_samples_test_set.set2;
        
    elseif (num_classes == 43)
        %label_set = load('label_all_dataset.mat');
        %label_set = label_set.label_aux;
        %train_set = load('dataset.mat');
        %train_set = train_set.dataset;
        
        label_set = load('labels_all_balanced_dataset');
        label_set= label_set.labels_all_balanced_dataset';
        label_set=label_set-1;
        train_set = load('all_balanced_dataset');
        train_set = train_set.all_balanced_dataset';
        
        
        labels_test_set = load('labels_all_test_set.mat');
        labels_test_set = labels_test_set.labels_all_test_set;
        labels_test_set = labels_test_set+1;
        disp('43 CLASSES')
        
        actual_label_test_set=labels_test_set(:,:);%(1:300,:)??????????
    end  
    
  
    
    %obter test set
    %test_set = get_test_set(folder_test_set_Hog_01, folder_test_set_Hog_02, folder_test_set_Hog_03, folder_test_set_HueHist, folder_test_set_Haar);
    test_set_final = load('test_set.mat');
    test_set_final = test_set_final.test_set;
    %para experimentar com 300 exemplos de teste????????????????
    actual_test_set=test_set_final;%(1:300,:)?????????????
    %disp('test')
    %size(test_set_final)

    %[dataset,label]=get_all_datasets(folder_dataset_Hog_01, folder_dataset_Hog_02, folder_dataset_Hog_03, folder_dataset_HueHist, folder_dataset_Haar);

    
    %train-FeturesXsamples  label-1Xsamples test-SamplesXfeatures  labels-SamplesX1  
    %////////////////END OF GET DATA/////////////////////
    disp('NORMALIZACAO')

    %normalizar/scale data, inverto matriz para que as colunas sejam as features e as
    %linhas os samples. No seu regresso as colunas sao as features e os samples
    %as linhas.
    [train_set, mu, sigma] = normalize_train_set(train_set');
    actual_test_set = normalize_test_set(actual_test_set,mu,sigma);
    %também ha a função scalestd mas é necessario criar uma estrutura



    %[h,p]=kstest(train_set);%Perform kolmogorov smirnov test
    %Single sample Kolmogorov-Smirnov goodness-of-fit hypothesis test.
    %test to determine if a random sample X could have come from a standard 
    %normal distribution,N(0,1).

    %if h==1
    %    disp('Null hypotesus rejected -> The feature sample is no normal')
    %else
    %    disp('Null hypotesis accepted -> the feature sample is normal')
    %end



    %baralhar samples
    r=randperm(length(train_set(:,1)));
    train_set=train_set(r,:);
    label_set=label_set(r);
    
    %o lda e assim classifica de 1 a nClasses
    label_set=label_set+1;
    
    
    %min(label_set)
    %max(label_set)
    %min(labels_test_set)
    %max(labels_test_set)
    
    disp('Selection')
    if strcmp(sel_method,'Kruskal-Wallis')
        %kruskal wallis
        number_features_choose = 1000;
        novo_aux=train_set;
        [train_set, selected_features_with_rank, only_selected_features_and_sorted] = kruskalwallis_selection(train_set,label_set, number_features_choose);
        %seleciona neste caso as 1000 features mais discriminantes, neste caso a
        %ultima feature do ranking tem um score de 619.7 e a primeira tem um score de 1042.5

        %ver variancia preservada com a selecção de features
        orig.X=novo_aux';
        orig.y=label_set;
        orig.eigval=eig(cov(novo_aux'));
        selected.X=train_set';
        selected.Y=label_set;
        selected.eigval=eig(cov(novo_aux'));
        variancia_preserved_from_selection = sum(selected.eigval(1:end).^2)/sum(orig.eigval(1:end).^2);

        %aplicar features selecionadas ao test
        test_set_final=actual_test_set(:,only_selected_features_and_sorted(1:end,1));
    elseif strcmp(sel_method,'AUC')
        %SO PARA BINARIO
        
    elseif strcmp(sel_method,'Fisher-Score')
        %size(train_set')
        %size(label_set')
        [index,score]=feature_rank(train_set',label_set');
        %remover cenas com f-score < 1     NUMERO ALEATORIO TEMOS DE VER
        %MELHOR
        score2 = find(score>0.5);
        index=index(score2);
        train_set=train_set(:,index(1:end,1));
        test_set_final=actual_test_set(:,index(1:end,1));
    end
    %obter dimensão para o pca, posso mudar este dim_from_kaiser para as...
    %dimensoes que quiser
    if strcmp(number_dimen,'Kaiser')
        new_dim = Kaiser_Test(train_set);
    else
        new_dim = str2num(char(number_dimen));
    end
    disp('REDUCTION')
    if strcmp(red_method,'PCA')
        %testar com pca e lda
        %lda ou pca
        reductor_type = 'pca';
        [projected_features, preserved, model] = reductor(new_dim,reductor_type,train_set,label_set);
        %falta test_data, usar o model anterior com
        %'test_data=linproj(test_data',model);' isto nao da
        %test_data=linproj(train_set',model);
        %disp('test_set_final')
        %size(test_set_final)
        test_data = linproj(test_set_final',model);
    elseif strcmp(red_method,'LDA')
        reductor_type = 'lda';
        [projected_features, preserved, model] = reductor(new_dim,reductor_type,train_set,label_set, num_classes);
        test_data = linproj(test_set_final',model);
        if new_dim < num_classes
            novo_aux=new_dim;
        else
            novo_aux=num_classes-1;
        end
        test_data = test_data(1:novo_aux,:);
    end
    



    %minimum_mahal, minimum_eucl, fld
    %disp('oioioi')
    %size(train_set)
    %size(test_data)
    %size(label_set)
    %size(projected_features)
    if ROC==1
        erro={};
        [~,erro2,X,Y] = predictor('Fisher Linear Discriminant',projected_features,label_set,test_data,actual_label_test_set',reductor_type, new_dim, preserved,'  NADA',val_method,roc_mode,1);%label_set
        erro=[erro, erro2];
        [~,erro2,X2,Y2] = predictor('Minimum Mahalanobis Distance',projected_features,label_set,test_data,actual_label_test_set',reductor_type, new_dim, preserved,'NADA ',val_method,roc_mode,1);%label_set
        erro=[erro, erro2];
        [~,erro2,X3,Y3] = predictor('Minimum Euclidean Distance',projected_features,label_set,test_data,actual_label_test_set',reductor_type, new_dim, preserved,'NADA ',val_method,roc_mode,1);%label_set
        erro=[erro, erro2];
        figure;
        plot(X,Y,X2,Y2,X3,Y3);
       xlabel('False positive rate'); ylabel('True positive rate')
       title('ROC for classification by logistic regression for the 3 different binary classifiers')
    else
        [~,erro,~,~] = predictor(class_method,projected_features,label_set,test_data,actual_label_test_set',reductor_type, new_dim, preserved,vis_method,val_method,roc_mode,0);%label_set
    end
    
    
    
    result=erro
    

%end






