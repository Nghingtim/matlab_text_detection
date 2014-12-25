function rec =quick_base(img)

ratio = 0.5;kernelsize = 2;maxdist=20;
[Iseg,labels, map] = vl_quickseg(img, ratio, kernelsize, maxdist);
Iseg_gray=uint8(round(rgb2gray(Iseg)*255));
%%
l_image=im2bw(Iseg_gray,0.7);
d_image=~im2bw(Iseg_gray,0.3);
m_image=(Iseg_gray<0.6*255)&(Iseg_gray>0.3*255);
%%
[p_image1,centre_mask1] =conComp_analysis(l_image);
se1=strel('line',30,0);
p_image_dilate1 = imclose(p_image1,se1);
[rec1,pp_image1]=f_conComp_analysis(p_image_dilate1);

%%
[p_image2,centre_mask2] =conComp_analysis(d_image);
se2=strel('line',30,0);
p_image_dilate2 = imclose(p_image2,se2);
[rec2,pp_image2]=f_conComp_analysis(p_image_dilate2);
%%
[p_image3,centre_mask3] =conComp_analysis(m_image);
se3=strel('line',30,0);
p_image_dilate3 = imclose(p_image3,se3);
[rec3,pp_image3]=f_conComp_analysis(p_image_dilate3);
%%
rec=[rec1;rec2;rec3];