clear all;clc;close all;
[fn pn fi]=uigetfile('*.*','choose a picture');
colorImage=imread([pn fn]);
%%
% figure; imshow(colorImage); title('Original image')
%%
grayImage = rgb2gray(colorImage);
mserRegions = detectMSERFeatures(grayImage);
mserRegionsPixels = vertcat(cell2mat(mserRegions.PixelList)); 

%%
figure; imshow(colorImage); hold on;
plot(mserRegions, 'showPixelList', true,'showEllipses',false);
title('MSER regions');


%%
%把mser区域的坐标系数取出来，然后将相应系数的地方赋值为真。取出mser区域。
mserMask = false(size(grayImage));
ind = sub2ind(size(mserMask), mserRegionsPixels(:,2), mserRegionsPixels(:,1));
mserMask(ind) = true;
figure; imshow(mserMask);
%imwrite(mserMask,'mserMask2.jpg');
%%
smap=Random_Center_Surround_Saliency(colorImage);
%%
figure; imshow(colorImage); %title('Original image')
[p_image,cwidth] =conComp_analysis(mserMask);
%[p_image,cwidth]=saliency_filter(mserMask,smap);
wi= median(cwidth(:));
se1=strel('line',wi,0);
p_image_dilate = imclose(p_image,se1);
[rec,pp_image]=f_conComp_analysis(p_image_dilate);
% %%
% %figure;imshow(colorImage)
%    % Create labels with floating point numbers
%    label_str = cell(3,1);
%       label_str{1} = ('YOU');
%       label_str{2} = ('ARE');
%       label_str{3} = ('HERE');
% 
%    position = rec(1:3,:);%[x y width height]
%   
%    RGB = insertObjectAnnotation(colorImage, 'rectangle', position, label_str, ...
%          'TextBoxOpacity', 0.9, 'FontSize', 18);
%    figure, imshow(RGB), title('Annotated chips');