clear all;
clc;
close all;
run('./VLFEAT/toolbox/vl_setup');
[fn pn fi]=uigetfile('*.*','choose a picture');
colorImage=imread([pn fn]);
%% MSER based extraction
grayImage = rgb2gray(colorImage);
mserRegions = detectMSERFeatures(grayImage);
mserRegionsPixels = vertcat(cell2mat(mserRegions.PixelList)); 
mserMask = false(size(grayImage));
ind = sub2ind(size(mserMask), mserRegionsPixels(:,2), mserRegionsPixels(:,1));
mserMask(ind) = true;    % mserMask«¯”Ú
%% Quick shift based extraction 
ratio = 0.5;
kernelsize = 2;
maxdist=20;
[Iseg,labels, map] = vl_quickseg(colorImage, ratio, kernelsize, maxdist);
Iseg_gray=uint8(round(rgb2gray(Iseg)*255));
l_image=im2bw(Iseg_gray,graythresh(Iseg_gray));
d_image=~l_image;
%% interger
all=mserMask+d_image;
%% Salieny filter
smap=Random_Center_Surround_Saliency(colorImage);
%% piror information limited
figure; imshow(colorImage); title('Original image')
%[p_image,cwidth] =conComp_analysis(mserMask);
[p_image,cwidth]=saliency_filter(all,smap);
wi= median(cwidth(:));
se1=strel('line',wi,0);
p_image_dilate = imclose(p_image,se1);
[rec,pp_image]=f_conComp_analysis(p_image_dilate);