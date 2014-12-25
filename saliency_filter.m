function [p_image,cwidth] =saliency_filter(bwimg,smap)
[x,y]=size(bwimg);
whole=x*y;
cwidth=[];
connComp = bwconncomp(bwimg); % Find connected components
threefeature = regionprops(connComp,'Area','BoundingBox');
broder=[threefeature.BoundingBox];%[x y width height]字符的区域
area=[threefeature.Area];%区域面积
img_sal_mean=mean(smap(:));
%%
for i=1:connComp.NumObjects  
    leftx=broder((i-1)*4+1);
    lefty=broder((i-1)*4+2);
    width=broder((i-1)*4+3);
    height=broder((i-1)*4+4);
     clu_sal_mean=mean(smap(connComp.PixelIdxList{i}));
    if clu_sal_mean<1.75*img_sal_mean
      bwimg(connComp.PixelIdxList{i})=0;
%     elseif area(i)<50||area(i)>0.3*whole
%       bwimg(connComp.PixelIdxList{i})=0;
%     elseif width/height<0.1||width/height>2
%       bwimg(connComp.PixelIdxList{i})=0;
    else
        cwidth=[cwidth,width];
    end
end
p_image=bwimg;