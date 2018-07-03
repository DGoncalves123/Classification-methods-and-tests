%set2 = load('labels_training_6.mat');
%set2 = set2.labels_training_6;
set2=aii;
um =[0,1,2,3,4,5,7,8]; 
dois = [9,10,15,16];
tres=[33,34,35,36,37,38,39,40];
qua=[18,19,20,21,22,23,24,25,26,27,28,29,30,31,11];
cin=[6,41,42,32];
seis=[12,13,14,17];
for idx = 1:length(set2)
    element = set2(idx);
    %if element>8
     %   element
    %end
    if ismember(element,um)
        set2(idx)=1;
    elseif ismember(element,dois)
        set2(idx)=2;
    elseif ismember(element,tres)
        set2(idx)=3;
    elseif ismember(element,qua)
        set2(idx)=4;
    elseif ismember(element,cin)
        set2(idx)=5;
    elseif ismember(element,seis)
        set2(idx)=6;
    end
end

save('labels_6_test_set.mat','set2');
tosave = set2;