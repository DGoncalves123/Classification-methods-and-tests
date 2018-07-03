function[Cotimo,AlphaOtimo] = get_c_alpha_svm(data,number_runs)

    [row,col]=size(data.X) %row é a dim, col é nº samples
    c_potencia=[-10:12];
    g_potencia=[-20:0];
    C=2.^c_potencia;
    G=2.^g_potencia;
    err=zeros(number_runs,numel(C),numel(G));
    models=cell(number_runs,numel(C),numel(G));

    for i=1:number_runs
        i
        rand_ind=randperm(col);
        aux=data.X;
        auy=data.y;
        for k=1:col
            aux(k)=data.X(rand_ind(k));
            auy(k)=data.y(rand_ind(k));
        end
        data.X=aux;
        data.y=auy;
        train.X=data.X(:,1:floor(col/2));
        train.y=data.y(:,1:floor(col/2));
        train.dim=size(train.X,1);
        train.num_data=size(train.X,2);
        teste.X=data.X(:,floor(col/2)+1:end);
        teste.y=data.y(:,floor(col/2)+1:end);
        teste.dim=size(teste.X,1);
        teste.num_data=size(teste.X,2);

        for co = 1:numel(C)
            for go = 1:numel(G)
                clear model;
                %lambda=1/(2*(sigma^2))
                %sigma=1/sqrt(2*lamda)-> dai o sqrt em baixo
                %model =fitcsvm(train.X',train.y','KernelFunction','rbf','BoxConstraint',C(co),...
                    %'KernelScale',sqrt(1/(2*G(go))),'Solver','SMO');
                
                t = templateSVM('KernelFunction','rbf','BoxConstraint',C(co),...
                    'KernelScale',sqrt(1/(2*G(go))),'Solver','SMO');
                model = fitcecoc(train.X',train.y','Learners',t); %one vs one
       
                [ypred] = predict(model,teste.X');

                err(i,co,go) = cerror(ypred,teste.y)*100;
                models{i,co,go}=model;
            end
        end
    end

    if number_runs > 1
        merr=squeeze(mean(err));
    else
        merr = squeeze(err);
    end

    %minimo
    [cotimo,alpha,val]=find(merr == min(merr(:)));
    %[ix,iy,val]=find(merr == min(min(merr)));
    Cotimo=C(cotimo(1));
    AlphaOtimo=G(alpha(1));
end