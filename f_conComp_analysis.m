function [rec,pp_image] =f_conComp_analysis(P_image)
[x,y]=size(P_image);
whole=x*y;
rec=[];
connComp = bwconncomp(P_image); % Find connected components
threefeature = regionprops(connComp,'Area','BoundingBox');
broder=[threefeature.BoundingBox];%[x y width height]字符的区域
area=[threefeature.Area];%区域面积
%%
for i=1:connComp.NumObjects
    leftx=broder((i-1)*4+1);
    lefty=broder((i-1)*4+2);
    width=broder((i-1)*4+3);
    height=broder((i-1)*4+4);
    
    %    data=grayimg_reserve(lefty:lefty+height-1,leftx:leftx+width-1);
    %    stda(i,:)=statxture(data);
    if area(i)<500||area(i)>whole*0.4
        P_image(connComp.PixelIdxList{i})=0;
     elseif width/height<2
        P_image(connComp.PixelIdxList{i})=0;
        %     elseif stda(i,4)<0
        %     P_image(connComp.PixelIdxList{i})=0;
    else
        rect=[leftx,lefty,width,height];
        rec=[rec;rect];
        rectangle('Position',[leftx,lefty,width,height], 'EdgeColor','g');
        %         zone{1,j}.data=grayimg_reserve(lefty:lefty+height-1,leftx:leftx+width-1);
        %         zone{1,j}.location=[leftx,lefty,width,height];
        %         zone{1,j}.label=j;
        %         j=j+1;
    end
end
pp_image=P_image;