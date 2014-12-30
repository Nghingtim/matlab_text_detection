function rec =quick_base(img)

ratio = 0.5;kernelsize = 2;maxdist=20;
[Iseg,labels, map] = vl_quickseg(img, ratio, kernelsize, maxdist);
Iseg_gray=uint8(round(rgb2gray(Iseg)*255));
%%
l_image=im2bw(Iseg_gray,0.7);
d_image=~im2bw(Iseg_gray,0.3);
m_image=(Iseg_gray<0.6*255)&(Iseg_gray>0.3*255);
m_image=~m_image;
%%
smap=Random_Center_Surround_Saliency(img);
%%
pimage=saliency_filter(d_image,smap);
pimage1=saliency_filter(l_image,smap);
pimage2=saliency_filter(m_image,smap);
%% Dark_image
[p_image1,centre_mask1] =conComp_analysis(pimage);
%se1=strel('line',30,0);
wi= median(centre_mask1(:));
se1=strel('line',wi,0);
p_image_dilate1 = imclose(p_image1,se1);
[rec1,pp_image1]=f_conComp_analysis(p_image_dilate1);

%% Light_image
[p_image2,centre_mask2] =conComp_analysis(pimage1);
% se2=strel('line',30,0);
wi= median(centre_mask2(:));
se2=strel('line',wi,0);
p_image_dilate2 = imclose(p_image2,se2);
[rec2,pp_image2]=f_conComp_analysis(p_image_dilate2);
%% Middle_image
[p_image3,centre_mask3] =conComp_analysis(pimage2);
% se3=strel('line',30,0);
wi= median(centre_mask3(:));
se3=strel('line',wi,0);
p_image_dilate3 = imclose(p_image3,se3);
[rec3,pp_image3]=f_conComp_analysis(p_image_dilate3);
%%
rec=[rec1;rec2;rec3];