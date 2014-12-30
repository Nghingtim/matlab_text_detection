clc;
close all;
clear all;
warning off;
prelen=47;
root='E:\Matlabdip_new\Text_locating\SceneTrialTest';
train=read_train(root);
l_train=length(train);
e_rec={};
%%
for i=1:l_train
    i
    imagepath=train{i};
    img=imread(imagepath);
    e_rec{i}=mser_base(img);
    bbox=insertShape(img,'FilledRectangle',e_rec{i},'Color','blue','Opacity',0.4);
    imwrite(bbox,strcat('E:\test_result_tt\',strrep(train{i}(prelen:end),'/','_')));
end




