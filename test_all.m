figure();imshow(Iseg)
[x,y]=size(labels);
cwidth=[];
whole=x*y;
threefeature = regionprops(labels,'Area','BoundingBox','Centroid'  );
broder=[threefeature.BoundingBox];%[x y width height]字符的区域
area=[threefeature.Area];%区域面积
centre=[threefeature.Centroid];
%%
for i=1: max(labels(:))  
    leftx=broder((i-1)*4+1);
    lefty=broder((i-1)*4+2);
    width=broder((i-1)*4+3);
    height=broder((i-1)*4+4);
    cenx=floor(centre((i-1)*2+1));
    ceny=floor(centre((i-1)*2+2));
   
    if area(i)<1000||area(i)>0.3*whole
     %labels(connComp.PixelIdxList{i})=0;
    elseif width/height<0.1||width/height>3
      %labels(connComp.PixelIdxList{i})=0;
    else
      %centre_mask(ceny,cenx)=1;
      cwidth=[cwidth,width];
       rectangle('Position',[leftx,lefty,width,height], 'EdgeColor','g');
    end
end
p_image=labels;


