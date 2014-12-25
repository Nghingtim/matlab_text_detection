close all; clear all; clc;
%run('./VLFEAT/toolbox/vl_setup');
[fn,pn,fi]=uigetfile('*.*','choose a picture');
img=(imread([pn fn]));
whole=size(img,1)*size(img,2);
imggray=rgb2gray(img);
[bw,thresh]=edge(imggray,'log');
%%
L = watershed(img);
rgb = label2rgb(L,'jet',[.5 .5 .5]);
%figure, imshow(rgb,'InitialMagnification','fit')
%title('Watershed transform of D')
%%
threefeature = regionprops(L,'Area','BoundingBox','Centroid'  );
broder=[threefeature.BoundingBox];%[x y width height]字符的区域
area=[threefeature.Area];%区域面积
centre=[threefeature.Centroid];
figure();imshow(img);
%%
for i=1:size(threefeature,1)  
    leftx=broder((i-1)*4+1);
    lefty=broder((i-1)*4+2);
    width=broder((i-1)*4+3);
    height=broder((i-1)*4+4);
    cenx=floor(centre((i-1)*2+1));
    ceny=floor(centre((i-1)*2+2));
   
    if area(i)<80||area(i)>0.3*whole
     % bwimg(connComp.PixelIdxList{i})=0;
    elseif width/height<0.1||width/height>2
     % bwimg(connComp.PixelIdxList{i})=0;
    else
      %centre_mask(ceny,cenx)=1;
     % cwidth=[cwidth,width];
        rectangle('Position',[leftx,lefty,width,height], 'EdgeColor','g');
    end
end