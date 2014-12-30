clear all;
load('t_rec.mat');
load('t_imgname.mat');
% load('e_rec.mat');
% load('erec.mat');
% load('q_e_rec.mat');
load('e_imgname.mat');
load('all_rec.mat')
e_rec=all_rec;% e_rec为实验得到的框的数据
%e_rec=q_e_rec;
sum=0;
for i=1:length(e_imgname)
    for te_i=1:length(t_imgname)
        if strcmp(e_imgname{i},t_imgname{te_i})
            t_i=te_i;
            break;
        end
    end
    if ~isempty(e_rec{i})
        for j=1:size(e_rec{i},1)
            e_area=e_rec{i}(j,3)*e_rec{i}(j,4);
            for k=1:size(t_rec{t_i},1)
                t_area=t_rec{t_i}(k,3)*t_rec{t_i}(k,4);
                xx1 = max(e_rec{i}(j,1), t_rec{t_i}(k,1));
                yy1 = max(e_rec{i}(j,2), t_rec{t_i}(k,2));
                xx2 = min(e_rec{i}(j,1)+e_rec{i}(j,3), t_rec{t_i}(k,1)+t_rec{t_i}(k,3));
                yy2 = min(e_rec{i}(j,2)+e_rec{i}(j,4), t_rec{t_i}(k,2)+t_rec{t_i}(k,4));
                w = xx2-xx1+1;
                h = yy2-yy1+1;
                if w > 0 && h > 0
                    m=2*w*h/(e_area+t_area);
                    sum=sum+m;
                end
            end
        end
    end
end
e=0;
for l=1:length(e_imgname)
    e=e+size(e_rec{l},1);
end
precision=sum/e


%%
r_sum=0;
for i=1:length(t_imgname)
    for et_i=1:length(e_imgname)
        if strcmp(t_imgname{i},e_imgname{et_i})
            e_i=et_i;
            break;
        end
    end
    if ~isempty(t_rec{i})&&~isempty(e_rec{e_i})
        for j=1:size(t_rec{i},1)
            t_area=t_rec{i}(j,3)*t_rec{i}(j,4); 
            for k=1:size(e_rec{e_i},1)
                e_area=e_rec{e_i}(k,3)*e_rec{e_i}(k,4);
                xx1 = max(t_rec{i}(j,1), e_rec{e_i}(k,1));
                yy1 = max(t_rec{i}(j,2), e_rec{e_i}(k,2));
                xx2 = min(t_rec{i}(j,1)+t_rec{i}(j,3), e_rec{e_i}(k,1)+e_rec{e_i}(k,3));
                yy2 = min(t_rec{i}(j,2)+t_rec{i}(j,4), e_rec{e_i}(k,2)+e_rec{e_i}(k,4));
                w = xx2-xx1+1;
                h = yy2-yy1+1;
                if w > 0 && h > 0
                    m=2*w*h/(e_area+t_area);
                    r_sum=r_sum+m;
                end
            end
        end
    end
end
t=0;
for l=1:length(t_imgname)
    t=t+size(t_rec{l},1);
end
recall=r_sum/t
f=1/(0.5/precision+0.5/recall)

