close all; clear all; clc;
run('./VLFEAT/toolbox/vl_setup');
[fn,pn,fi]=uigetfile('*.*','choose a picture');
img=(imread([pn fn]));
%%
ratio = 0.5;
kernelsize = 2;
maxdist=20;
[Iseg,labels,map] = vl_quickseg(img, ratio, kernelsize, maxdist);
Iseg_gray=uint8(round(rgb2gray(Iseg)*255));


%%
figure(1);imshow(Iseg);
figure; imshow(Iseg_gray);
caxis([0 max(max(Iseg_gray))]); axis image, colormap('jet'), colorbar;
axis normal;
%%
smap=Random_Center_Surround_Saliency(img);
img_sal_mean=mean(smap(:));
figure; imshow(smap);
caxis([0 max(max(smap))]); axis image, colormap('jet'), colorbar;

%%
figure();imshow(img);
l_image=im2bw(Iseg_gray,0.7);
d_image=~im2bw(Iseg_gray,0.3);
m_image=(Iseg_gray<0.6*255)&(Iseg_gray>0.3*255);
m_image=~m_image;
%%
figure();imshow(img);
[p_image1,centre_mask1] =conComp_analysis(d_image);
se1=strel('line',30,0);
p_image_dilate1 = imclose(p_image1,se1);
[rec1,pp_image1]=f_conComp_analysis(p_image_dilate1);

%%
[p_image2,centre_mask2] =conComp_analysis(l_image);
se2=strel('line',30,0);
p_image_dilate2 = imclose(p_image2,se2);
[rec2,pp_image2]=f_conComp_analysis(p_image_dilate2);

%%
[p_image3,centre_mask3] =conComp_analysis(m_image);
se3=strel('line',30,0);
p_image_dilate3 = imclose(p_image3,se3);
[rec3,pp_image3]=f_conComp_analysis(p_image_dilate3);
%%
pimage=saliency_filter(d_image,smap);
%%
pimage1=saliency_filter(l_image,smap);
%%
pimage2=saliency_filter(m_image,smap);