clear all;clc;close all;
[fn pn fi]=uigetfile('*.*','choose a picture');
Img=imread([pn fn]);

%I1 = impyramid(Img, 'reduce');
% I2 = impyramid(I1, 'reduce');
% I3 = impyramid(I2, 'reduce'); 
% figure, imshow(Img)
% figure, imshow(I1)
% figure, imshow(I2)
% figure, imshow(I3)
I1=Img;
r=I1(:,:,1);
g=I1(:,:,2);
b=I1(:,:,3);
s =10;
c= [r(:),g(:),b(:)];
%%
figure,scatter3(r(:),g(:),b(:),s,im2double(c),'.');
title(' color Space');
xlabel('R');ylabel('G');zlabel('B');