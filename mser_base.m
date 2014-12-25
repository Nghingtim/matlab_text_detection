function [rec ,pp_image,centre_mask] =mser_base(img)
%%
% smap=Random_Center_Surround_Saliency(img);
%%
grayImg=rgb2gray(img);
%%
mserRegions = detectMSERFeatures(grayImg);
mserRegionsPixels = vertcat(cell2mat(mserRegions.PixelList)); 
%把mser区域的坐标系数取出来，然后将相应系数的地方赋值为真。取出mser区域。
mserMask = false(size(grayImg));
ind = sub2ind(size(mserMask), mserRegionsPixels(:,2), mserRegionsPixels(:,1));
mserMask(ind) = true;
bwimg=mserMask;

%%
[p_image,cwidth] =conComp_analysis(bwimg);
%[p_image,cwidth] =saliency_filter(bwimg,map);
wi= median(cwidth(:));
%hi= min(cwidth(:));
se1=strel('line',wi,0);
%se2=strel('line',hi,0);
p_image_dilate= imclose(p_image,se1);
%p_image_dilate = imopen(p_image_dilate,se2);
[rec,pp_image]=f_conComp_analysis(p_image_dilate);
end
