close all; clear all; clc;
run('./VLFEAT/toolbox/vl_setup');
[fn,pn,fi]=uigetfile('*.*','choose a picture');
colorImage=(imread([pn fn]));
ratio = 0.5;
kernelsize = 2;
maxdist=20;
[Iseg,labels, map] = vl_quickseg(colorImage, ratio, kernelsize, maxdist);
%%
grayImage=rgb2gray(Iseg);
mserRegions = detectMSERFeatures(uint8(grayImage));
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

%%
% figure(1);imshow(Iseg);
% figure; imshow(Iseg_gray);
% caxis([0 max(max(Iseg_gray))]); axis image, colormap('jet'), colorbar;
% axis normal;
%%
% smap=Random_Center_Surround_Saliency(img);
% img_sal_mean=mean(smap(:));
% figure; imshow(smap);
% caxis([0 max(max(smap))]); axis image, colormap('jet'), colorbar;
 %%
% % nColors=max(labels(:));
% % segmented_images = cell(1,nColors);
% % i=1;
% % color = zeros(size(smap));
% % for k = 1:nColors
% %     cluster_salient=smap(labels==k);
% %     clu_sal_mean=mean(cluster_salient(:));
% %     if clu_sal_mean<1.75*img_sal_mean
% %         color(labels==k) = 0;
% %     else
% %         color(labels==k) = 1;
% %     end
% % end
% figure();imshow(img);
 %%
% l_image=im2bw(Iseg_gray,0.6);
% d_image=~im2bw(Iseg_gray,0.3);
% m_image=(Iseg_gray<0.6*255)&(Iseg_gray>0.3*255);
% %%
% [p_limage,cwidth]=saliency_filter(l_image,smap);
% wi= median(cwidth(:));
% se1=strel('line',wi,0);
% p_limage_dilate = imclose(p_limage,se1);
% [rec,pp_limage]=f_conComp_analysis(p_limage_dilate);
% 
 %%
% 
% [p_dimage,cwidth]=saliency_filter(d_image,smap);
% wi= median(cwidth(:));
% se1=strel('line',wi,0);
% p_dimage_dilate = imclose(p_dimage,se1);
% [rec,pp_dimage]=f_conComp_analysis(p_dimage_dilate);
