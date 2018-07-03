%Elaborado por:
%André Silva, 2013135219
%Diogo Gonçalves, 2013140087

function [predictions,erro,X,Y] = predictor(classifier,projected_features,label_set,test_data,test_label_set,reductor_type,dim,preserved,grafico,cross,roc_mode,roc)
    %FEATURES x SAMPLES for data
    %1 x SAMPLES for labels
    %return 2 x number of data to print  (first is the name, second is the number)
    disp('predictor')
    %size(projected_features);
    %size(label_set);
    %size(test_data);
    %size(test_label_set);
    %dim=size(projected_features,1);
    %Fisher Linear Discriminant
    %Minimum Euclidian Distance
    %Minimum Mahalanobis Distance
    %Multiclass SVM
    X=[];
    Y=[];
    if strcmp(grafico,'Graph')
        grafico = 1;
    else
        grafico=0;
    end
    erro={};
    disp(unique(label_set))
    disp(unique(test_label_set))
    if strcmp(classifier,'Fisher Linear Discriminant') % só funciona para binario
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if strcmp(cross,'K-Folds')
            CVO = cvpartition(label_set,'kfold',10);
            err=0;
            for i = 1:CVO.NumTestSets
                trIdx = CVO.training(i);
                teIdx = CVO.test(i);
                test_data2=projected_features(:,teIdx);
                means=[];
                projected_features2=projected_features(:,trIdx);
                label_set2=label_set(1,trIdx);%treino
                label_set3=label_set(1,teIdx);%teste
                predictions=zeros(size(label_set3));
                pf.X=projected_features2; %tem de ser dim x num_data
                pf.y=label_set2;  %1 x num_data
                modelfld = fld(pf); 
                predictions = linclass(test_data2,modelfld);
                
                if err~=0
                    err=(err+cerror(predictions,label_set3))/2;
                else
                    err=cerror(predictions,label_set3);
                end
            end
            cvloss={'Kfolds loss:'; err};
            erro = [erro, cvloss];%erro de cross validation
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        pf.X=projected_features; %tem de ser dim x num_data
        pf.y=label_set;  %1 x num_data
        modelfld = fld(pf); 
        predictions = linclass(test_data,modelfld);
        
        %disp('size prediction fld');
        %size(predictions);
        %figure; ppatterns(pf); pline(modelfld);
        disp('oioi')
        disp(unique(predictions))
        err=cerror(predictions,test_label_set);
        tloss={'Test loss (cerror):'; err};
        erro=[erro, tloss];
        [cm,order] = confusionmat(test_label_set',predictions);
        confusionMat = {'Confusion Matrix:'; cm};
        %erro=[erro, confusionMat];
        orderConfMat = {'Order of Classes:'; order};
        %erro=[erro, orderConfMat];
        if grafico==1
            test_struct.X = test_data;
            test_struct.y = test_label_set;
            figure; ppatterns(test_struct); 
            title(strcat('Fisher LDA',', ,',reductor_type,', ,Dim: ',num2str(dim),', ,Error: ',num2str(err),', ,InfoPreserved: ',num2str(preserved)));
            legend(string(unique(predictions)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label
            if size(projected_features,1)>2
               %plane3 %para desenhar plano
                plane3(modelfld);
            else

                pline(modelfld);
            end
            
            %desenhar original
            test_struct.X = test_data;
            test_struct.y = test_label_set;
            figure; ppatterns(test_struct); 
            title(strcat('Original, ,Dim: ',num2str(dim)));
            legend(string(unique(test_label_set)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label
        end
        %if roc==1
        %    l=predictions;
        %    predictions = predictions(1:length(predictions))'>1;
        %    mdl = fitglm(test_data',predictions,'Distribution','binomial','Link','logit');  
        %    scores = mdl.Fitted.Probability;
        %    [X,Y] = perfcurve(l,scores,2);
        %elseif strcmp(roc_mode,'Sim')
        %    l=predictions;
        %    predictions = predictions(1:length(predictions))'>1;
        %    mdl = fitglm(test_data',predictions,'Distribution','binomial','Link','logit');  
        %    scores = mdl.Fitted.Probability;
        %    [X,Y] = perfcurve(l,scores,2);
        %    figure;
        %    plot(X,Y)
        %   xlabel('False positive rate'); ylabel('True positive rate')
        %   title('ROC for classification by logistic regression')
        %end


    %testar com minumum mahal
    elseif strcmp(classifier,'Minimum Mahalanobis Distance')
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if strcmp(cross,'K-Folds')
            CVO = cvpartition(label_set,'kfold',10);
            err=0;
            for i = 1:CVO.NumTestSets
                trIdx = CVO.training(i);
                teIdx = CVO.test(i);
                test_data2=projected_features(:,teIdx);
                predictions=zeros(size(test_data2));
                means=[];
                projected_features2=projected_features(:,trIdx);
                label_set2=label_set(1,trIdx);%treino
                label_set3=label_set(1,teIdx);%teste
                predictions=zeros(size(label_set3));
                mean1=mean(projected_features2(:,label_set2==1),2);
                mean2=mean(projected_features2(:,label_set2==2),2);
                cov1=cov(projected_features2(:,label_set2==1)');
                cov2=cov(projected_features2(:,label_set2==2)');
                cov1=cov1';
                cov2=cov2';
                C=(cov1+cov2)/2;
                i2=(mean1-mean2)'/C;
                %SIMPLIFICAMOS PORQUE O MATLAB DIZIA QUE ASSIM ERA MAIS RAPIDO
                %inversaC = inv(C);
                %dif_means = mean1-mean2;
                %sum_means = mean1+mean2;
                %d = dif_means' * inversaC * ( test_data(:,i)' - 0.5 * sum_means);

                for i=1:size(test_data2,2)
                    d=i2*(test_data2(:,i)-0.5*(mean1+mean2));

                    if d>0
                        predictions(i)=1;
                    else
                        predictions(i)=2;
                    end
                end
                if err~=0
                    err=(err+cerror(predictions,label_set3))/2;
                else
                    err=cerror(predictions,label_set3);
                end
            end
            cvloss={'Kfolds loss:'; err};
            erro = [erro, cvloss];%erro de cross validation
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        predictions=zeros(size(test_data(1,:)));
        mean1=mean(projected_features(:,label_set==1),2);
        mean2=mean(projected_features(:,label_set==2),2);
        cov1=cov(projected_features(:,label_set==1)');
        cov2=cov(projected_features(:,label_set==2)');
        cov1=cov1';
        cov2=cov2';
        C=(cov1+cov2)/2;
        i2=(mean1-mean2)'/C;
        %SIMPLIFICAMOS PORQUE O MATLAB DIZIA QUE ASSIM ERA MAIS RAPIDO
        %inversaC = inv(C);
        %dif_means = mean1-mean2;
        %sum_means = mean1+mean2;
        %d = dif_means' * inversaC * ( test_data(:,i)' - 0.5 * sum_means);

        for i=1:size(test_data,2)
            d=i2*(test_data(:,i)-0.5*(mean1+mean2));

            if d>0
                predictions(i)=1;
            else
                predictions(i)=2;
            end
        end
        err=cerror(predictions,test_label_set);

        test_struct.X = test_data;
        test_struct.y = predictions;
        
        tloss={'Test loss (cerror):'; err};
        erro=[erro, tloss];
        [cm,order] = confusionmat(test_label_set',predictions);
        confusionMat = {'Confusion Matrix:'; cm};
        %erro=[erro, confusionMat];
        orderConfMat = {'Order of Classes:'; order};
        %erro=[erro, orderConfMat];
        if grafico==1
            figure; ppatterns(test_struct); 
            title(strcat('Mahalanobis',', ,',reductor_type,', ,Dim: ',num2str(dim),', ,Error: ',num2str(err),', ,InfoPreserved: ',num2str(preserved)));
            legend(string(unique(predictions)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label
            
            
            %desenhar original
            test_struct.X = test_data;
            test_struct.y = test_label_set;
            figure; ppatterns(test_struct); 
            title(strcat('Original, ,Dim: ',num2str(dim)));
            legend(string(unique(test_label_set)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label
            
          
        end
        %{
        if roc==1
            l=predictions;
            predictions = predictions(1:length(predictions))'>1;
            mdl = fitglm(test_data',predictions,'Distribution','binomial','Link','logit');  
            scores = mdl.Fitted.Probability;
            [X,Y] = perfcurve(l,scores,2);
        elseif strcmp(roc_mode,'Sim')
            l=predictions;
            predictions = predictions(1:length(predictions))'>1;
            mdl = fitglm(test_data',predictions,'Distribution','binomial','Link','logit');  
            scores = mdl.Fitted.Probability;
            [X,Y] = perfcurve(l,scores,2);
            figure;
            plot(X,Y)
           xlabel('False positive rate'); ylabel('True positive rate')
           title('ROC for classification by logistic regression')
        end
        %}

    elseif strcmp(classifier,'Minimum Euclidean Distance')
        num_classes=max(label_set);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if strcmp(cross,'K-Folds')
            CVO = cvpartition(label_set,'kfold',10);
            err=0;
            for i = 1:CVO.NumTestSets
                trIdx = CVO.training(i);
                teIdx = CVO.test(i);
                test_data2=projected_features(:,teIdx);%teste
                predictions=zeros(size(test_data2));
                means=[];
                projected_features2=projected_features(:,trIdx);%treino
                label_set2=label_set(1,trIdx);%treino
                label_set3=label_set(1,teIdx);%teste
                predictions=zeros(size(label_set3));
                for i=1:num_classes
                    m=mean(projected_features2(:,label_set2==i),2);
                    means = [means m];
                end
                for i=1:size(test_data2,2)
                    mean1=means(:,1);
                    k1=1;
                    for k=1:num_classes-1
                        d=(mean1-means(:,k+1))'*(test_data2(:,i)-0.5*(mean1+means(:,k+1)));
                        if d>0
                            predictions(i)=k1;
                        else
                            predictions(i)=k+1;
                            means1=means(:,k+1);
                            k1=k+1;
                        end
                    end
                end
                if err~=0
                    err=(err+cerror(predictions,label_set3))/2;
                else
                    err=cerror(predictions,label_set3);
                end
            end
            cvloss={'Kfolds loss:'; err};
            erro = [erro, cvloss];%erro de cross validation
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        predictions=zeros(size(test_data(1,:)));
        means=[];
        for i=1:num_classes
            m=mean(projected_features(:,label_set==i),2);
            means = [means m];
        end
        for i=1:size(test_data,2)
            mean1=means(:,1);
            k1=1;
            for k=1:num_classes-1
                d=(mean1-means(:,k+1))'*(test_data(:,i)-0.5*(mean1+means(:,k+1)));
                if d>0
                    predictions(i)=k1;
                else
                    predictions(i)=k+1;
                    means1=means(:,k+1);
                    k1=k+1;
                end
            end
        end
        err=cerror(predictions,test_label_set);
        
        
        test_struct.X = test_data;
        test_struct.y = predictions;
        %size(predictions);
        %size(test_label_set);
        tloss={'Test loss (cerror):'; err};
        erro=[erro, tloss];
        [cm,order] = confusionmat(test_label_set',predictions);
        confusionMat = {'Confusion Matrix:'; cm};
        %erro=[erro, confusionMat];
        orderConfMat = {'Order of Classes:'; order};
        %erro=[erro, orderConfMat];
        
        test_struct.X = test_data;
        test_struct.y = predictions;
        if grafico==1
            figure; ppatterns(test_struct); 
            title(strcat('Euclidian',', ,',reductor_type,', ,Dim: ',num2str(dim),', ,Error: ',num2str(err),', ,InfoPreserved: ',num2str(preserved)));
            legend(string(unique(predictions)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label
            
            
            %desenhar original
            test_struct.X = test_data;
            test_struct.y = test_label_set;
            figure; ppatterns(test_struct); 
            title(strcat('Original, ,Dim: ',num2str(dim)));
            legend(string(unique(test_label_set)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label

            %nao tenho model, nao consegui representar plano
        end
        %{
        if roc==1
            l=predictions;
            predictions = predictions(1:length(predictions))'>1;
            mdl = fitglm(test_data',predictions,'Distribution','binomial','Link','logit');  
            scores = mdl.Fitted.Probability;
            [X,Y] = perfcurve(l,scores,2);
        elseif strcmp(roc_mode,'Sim')
            l=predictions;
            predictions = predictions(1:length(predictions))'>1;
            mdl = fitglm(test_data',predictions,'Distribution','binomial','Link','logit');  
            scores = mdl.Fitted.Probability;
            [X,Y] = perfcurve(l,scores,2);
            figure;
            plot(X,Y)
           xlabel('False positive rate'); ylabel('True positive rate')
           title('ROC for classification by logistic regression')
        end
        %}

    elseif strcmp(classifier,'Multiclass SVM Auto') %One vs One
        t = templateSVM('Standardize',1);
        Mdl = fitcecoc(projected_features',label_set','Learners',t); %one vs one
        if strcmp(cross,'K-Folds')
            CVMdl = crossval(Mdl);
            cvloss={'Kfolds loss:'; kfoldLoss(CVMdl)};
            erro = [erro, cvloss];%erro de cross validation
        end
        predictions=predict(Mdl,test_data');
        err=cerror(predictions,test_label_set')
        tloss={'Test loss (cerror):'; err};
        erro=[erro, tloss];
        [cm,order] = confusionmat(test_label_set',predictions);
        confusionMat = {'Confusion Matrix:'; cm};
        %erro=[erro, confusionMat];
        orderConfMat = {'Order of Classes:'; order};
        %erro=[erro, orderConfMat];
            
        test_struct.X = test_data;
        test_struct.y = test_label_set;
        if grafico==1
            figure; ppatterns(test_struct); 
            title(strcat('SVM Auto',', ,',reductor_type,', ,Dim: ',num2str(dim),', ,Error: ',num2str(err),', ,InfoPreserved: ',num2str(preserved)));
            legend(string(unique(test_label_set)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label
            
            %if size(projected_features,1)>2
               %plane3 %para desenhar plano
            %    plane3(Mdl);
            %else

                %pline(Mdl);
            %end  
            
            %desenhar original
            test_struct.X = test_data;
            test_struct.y = test_label_set;
            figure; ppatterns(test_struct); 
            title(strcat('Original, ,Dim: ',num2str(dim)));
            legend(string(unique(predictions)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label

          
        end
        

    elseif strcmp(classifier,'Multiclass SVM Manual')

        data.X=projected_features; %tem de ser dim x num_data
        data.y=label_set;  %1 x num_data
        number_runs=1;
        [Cotimo,AlphaOtimo] = get_c_alpha_svm(data, number_runs)

        %lambda=1/(2*(sigma^2))
        %sigma=1/sqrt(2*lamda)-> dai o sqrt em baixo
        %model =fitcsvm(projected_features',label_set','KernelFunction','rbf','BoxConstraint',Cotimo,...
        %    'KernelScale',sqrt(1/(2*AlphaOtimo)),'Solver','SMO'); %alpha do learning rate
        
        t = templateSVM('KernelFunction','rbf','BoxConstraint',Cotimo,...
                    'KernelScale',sqrt(1/(2*AlphaOtimo)),'Solver','SMO');
        model = fitcecoc(projected_features',label_set','Learners',t); %one vs one, and %alpha do learning rate
       
        
        if strcmp(cross,'K-Folds')
            CVMdl = crossval(model);
            cvloss={'Kfolds loss:'; kfoldLoss(CVMdl)};
            erro = [erro, cvloss];%erro de cross validation
        end
        predictions=predict(model,test_data');
        err = cerror(predictions,test_label_set');
        tloss={'Test loss (cerror):'; err};
        erro=[erro, tloss];
        [cm,order] = confusionmat(test_label_set',predictions);
        confusionMat = {'Confusion Matrix:'; cm};
        %erro=[erro, confusionMat];
        orderConfMat = {'Order of Classes:'; order};
        %erro=[erro, orderConfMat];
        cotimo_aux = {'C otimo:'; Cotimo};
        erro=[erro, cotimo_aux];
        alpha_otimo_aux = {'Alpha Otimo:'; AlphaOtimo};
        erro=[erro, alpha_otimo_aux];
        
        
        test_struct.X = test_data;
        test_struct.y = test_label_set;
        if grafico==1
            figure; ppatterns(test_struct); 
            title(strcat('SVM Manual',', ,',reductor_type,', ,Dim: ',num2str(dim),', ,Error: ',num2str(err),', ,InfoPreserved: ',num2str(preserved)));
            legend(string(unique(predictions)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label
            
            %if size(projected_features,1)>2
               %plane3 %para desenhar plano
            %    plane3(model);
            %else

            %    pline(model);
            %end  
            
            %desenhar original
            test_struct.X = test_data;
            test_struct.y = test_label_set;
            figure; ppatterns(test_struct); 
            title(strcat('Original, ,Dim: ',num2str(dim)));
            legend(string(unique(test_label_set)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label

          
        end


    elseif strcmp(classifier,'KNN Mahalanobis')

        aux=[];
        for k=1:50 %arranjar o melhor valor de para k
            k
            Mdl = fitcknn(projected_features',label_set','NumNeighbors',k,'Standardize',1, 'Distance','mahalanobis');
            CVMdl = crossval(Mdl);
            cvloss= kfoldLoss(CVMdl);
            aux = [aux;cvloss];
        end
        [col,row]=min(aux);
        kmin_row = {'K minim Mahalanobis:'; row};
        erro=[erro, kmin_row];
        kmin_loss = {'Kfolds loss:'; min(aux)};
        erro=[erro, kmin_loss];
        model = fitcknn(projected_features',label_set','NumNeighbors',row,'Standardize',1 ,'Distance','mahalanobis');
        predictions=predict(model,test_data');
        err=cerror(predictions,test_label_set');
        tloss={'Test loss (cerror):'; err};
        erro=[erro, tloss];
        [cm,order] = confusionmat(test_label_set',predictions);
        confusionMat = {'Confusion Matrix:'; cm};
        %erro=[erro, confusionMat];
        orderConfMat = {'Order of Classes:'; order};
        %erro=[erro, orderConfMat];
        
        test_struct.X = test_data;
        test_struct.y = test_label_set;
        if grafico==1
            figure; ppatterns(test_struct); 
            title(strcat('KNN Mahalanobis',', ,',reductor_type,', ,Dim: ',num2str(dim),', ,Error: ',num2str(err),', ,InfoPreserved: ',num2str(preserved)));
            legend(string(unique(predictions)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label
            
            %if size(projected_features,1)>2
               %plane3 %para desenhar plano
            %    plane3(model);
            %else

            %    pline(model);
            %end  
            
            %desenhar original
            test_struct.X = test_data;
            test_struct.y = test_label_set;
            figure; ppatterns(test_struct); 
            title(strcat('Original, ,Dim: ',num2str(dim)));
            legend(string(unique(test_label_set)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label

          
        end


    elseif strcmp(classifier,'KNN Euclidean')


        aux=[];
        for k=1:50 % achar o melhor valor de k
            k
            Mdl = fitcknn(projected_features',label_set','NumNeighbors',k,'Standardize',1,'Distance','euclidean');
            CVMdl = crossval(Mdl);
            cvloss= kfoldLoss(CVMdl);
            aux = [aux;cvloss];
        end
        [col,row]=min(aux);
        kmin_row = {'K minim Euclidean:'; row};
        erro=[erro, kmin_row];
        kmin_loss = {'Kfolds loss:'; min(aux)};
        erro=[erro, kmin_loss];
        model = fitcknn(projected_features',label_set','NumNeighbors',row,'Standardize',1,'Distance','euclidean');
        predictions=predict(model,test_data');
        err=cerror(predictions,test_label_set');
        tloss={'Test loss (cerror):'; err};
        erro=[erro, tloss];
        [cm,order] = confusionmat(test_label_set',predictions);
        confusionMat = {'Confusion Matrix:'; cm};
        %erro=[erro, confusionMat];
        orderConfMat = {'Order of Classes:'; order};
        %erro=[erro, orderConfMat];
        
        test_struct.X = test_data;
        test_struct.y = test_label_set;
        if grafico==1
            figure; ppatterns(test_struct); 
            title(strcat('KNN Euclidean',', ,',reductor_type,', ,Dim: ',num2str(dim),', ,Error: ',num2str(err),', ,InfoPreserved: ',num2str(preserved)));
            legend(string(unique(predictions)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label
            
            %if size(projected_features,1)>2
               %plane3 %para desenhar plano
            %    plane3(model);
            %else

            %    pline(model);
            %end  
            
            %desenhar original
            test_struct.X = test_data;
            test_struct.y = test_label_set;
            figure; ppatterns(test_struct); 
            title(strcat('Original, ,Dim: ',num2str(dim)));
            legend(string(unique(test_label_set)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label

          
        end

    elseif strcmp(classifier,'N-Bayes')

        Mdl = fitcnb(projected_features',label_set');

        if strcmp(cross,'K-Folds')
                CVMdl = crossval(Mdl);
                cvloss={'Kfolds loss:'; kfoldLoss(CVMdl)};
                erro = [erro, cvloss];%erro de cross validation
        end
		
        predictions=predict(Mdl,test_data');
        err = cerror(predictions,test_label_set');
        tloss={'Test loss (cerror):'; err};
        erro=[erro, tloss];
        [cm,order] = confusionmat(test_label_set',predictions);
        confusionMat = {'Confusion Matrix:'; cm};
        %erro=[erro, confusionMat];
        orderConfMat = {'Order of Classes:'; order};
        %erro=[erro, orderConfMat];
        if strcmp(roc_mode,'Sim') %so funciona para binario
            label_set=label_set'; %0 e 1
            resp=label_set==1;
            resp=resp';
            pred=projected_features';
            mdlNB = fitcnb(pred,resp);
            [~,score_nb,~] = resubPredict(mdlNB);
            [Xnb,Ynb,Tnb,AUCnb] = perfcurve(resp,score_nb(:,mdlNB.ClassNames),'true');
            figure;
            hold on
            plot(Xnb,Ynb)
            legend('N-bayes','Location','Best')
            xlabel('False positive rate'); ylabel('True positive rate');
            title('ROC Curve for nbayes')
            hold off
        end
        
        test_struct.X = test_data;
        test_struct.y = test_label_set;
        if grafico==1
            figure; ppatterns(test_struct); 
            title(strcat('N-Bayes',', ,',reductor_type,', ,Dim: ',num2str(dim),', ,Error: ',num2str(err),', ,InfoPreserved: ',num2str(preserved)));
            legend(string(unique(predictions)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label
            
            %if size(projected_features,1)>2
               %plane3 %para desenhar plano
            %    plane3(Mdl);
            %else

            %    pline(Mdl);
            %end  
            
            %desenhar original
            test_struct.X = test_data;
            test_struct.y = test_label_set;
            figure; ppatterns(test_struct); 
            title(strcat('Original, ,Dim: ',num2str(dim)));
            legend(string(unique(test_label_set)));
            xlabel('Feature 1') % x-axis label
            ylabel('Feature 2') % y-axis label
            zlabel('Feature 3') % <-axis label

          
        end
        
    end
    
    CP = classperf(test_label_set);
    classperf(CP, predictions);
    d = {'Specificity:'; CP.Specificity};
    erro=[erro, d];
    d = {'Sensitivity:'; CP.Sensitivity};
    erro=[erro, d];
    accuracy = 1-err;
    d = {'Accuracy:'; accuracy};
    erro=[erro, d];
    %%%NAO DA POR ISSO MUDEI PARA 1 PARA NUNCA ENTRAR
    if (length(unique(test_label_set))==2)
        disp('fim')
        disp(test_label_set(1:5))
        disp(predictions(1:5))
        disp(unique(test_label_set))
        disp(unique(predictions))
        
        [x, y, T, auc] = perfcurve(test_label_set', predictions, 2);

        disp(auc)

        d = {'AUC:'; auc};
        erro=[erro, d];
    end
    disp('confusion Matrix:')
    confusionMat=confusionMat{2}
    disp('calculo precision')
    precision =  diag(confusionMat)./sum(confusionMat,2)
	precision(isnan(precision))=0;
    precision_mean = {'Precision mean:'; mean(precision)};
    erro=[erro, precision_mean];
    disp('calculo recall')
    recall =  diag(confusionMat)./sum(confusionMat,1)'
	recall(isnan(recall))=0;
    recall_mean = {'Recall mean:'; mean(recall)};
    erro=[erro, recall_mean];
    disp('f1scores')
    f1Scores =  2*(precision.*recall)./(precision+recall)
    f1scores_print = {'f1scores:'; f1Scores};
    %erro=[erro, f1scores_print];
    disp('mean f1scores')
    f1Scores(isnan(f1Scores))=0;
    meanF1 =  mean(f1Scores)
    f1scores_mean_print = {'F1scores mean:'; meanF1};
    erro=[erro, f1scores_mean_print];
    disp('Fim do calculo das métricas de avaliação do modelo')
end

