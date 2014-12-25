%----------------------------------------------------------
% Vikram T N, Tscherepanow M and Wrede B. A saliency map based on sampling an image into random rectangular regions of interest
% Pattern Recognition (Inpress). 
% http://www.sciencedirect.com/science/article/pii/S0031320312000714?v=s5
%----------------------------------------------------------


function [SM] = Random_Center_Surround_Saliency(img)



%---------------------------------------------------------
% Clean the input image for any noise using a Gaussian filter
%---------------------------------------------------------
gfrgb = imfilter(img, fspecial('gaussian', 3, 3), 'symmetric', 'conv');

%---------------------------------------------------------
% Perform sRGB to CIE Lab color space conversion (using D65)
%---------------------------------------------------------
%cform = makecform('srgb2lab', 'AdaptedWhitePoint', whitepoint('d65'));
cform = makecform('srgb2lab');
lab = applycform(gfrgb,cform);

%---------------------------------------------------------
% Compute Lab average values (note that in the paper this
% average is found from the unblurred original image, but
% the results are quite similar)
%---------------------------------------------------------
l = double(lab(:,:,1)); 
a = double(lab(:,:,2)); 
b = double(lab(:,:,3)); 

[r,c] = size(l);

%---------------------------------------------------------
%Initialize the saliency map vectors for L,a and b channels
%---------------------------------------------------------
Map_L(1:r,1:c) = 0.0;
Map_a(1:r,1:c) = 0.0;
Map_b(1:r,1:c) = 0.0;

Map_Points(1:r,1:c) = 0.0;

%---------------------------------------------------------
% n = the number of random rectangles that are in consideration
% n = 1000 should be enough in most cases
% Details of the algorithm are given in the Pattern Recognition article
%---------------------------------------------------------
n = 1000;

 for i=1:n
     

    x1 = floor(rand()*(r-1))+1;
    y1 = floor(rand()*(c-1))+1;
    
    x2 = floor(rand()*(r-1))+1;
    y2 = floor(rand()*(c-1))+1;

    if(x2 <r && y2 < c && x1 > 0 && y1 > 0)
    
    l1 = x1;
    u1 = y1;
    
    l2 = x2;
    u2 = y2;
    
    if(x1>x2)
        l1 = x2;
        l2 = x1;
    end
    
    if(y1>y2)
        u1 = y2;
        u2 = y1;
    end

    
     ml = mean2(l(l1:l2,u1:u2));
     Map_L(l1:l2,u1:u2) = Map_L(l1:l2,u1:u2) + abs((l(l1:l2,u1:u2) - ml));
     
    
     ma = mean2(a(l1:l2,u1:u2));
     Map_a(l1:l2,u1:u2) = Map_a(l1:l2,u1:u2) + abs((a(l1:l2,u1:u2) - ma));
     
     mb = mean2(b(l1:l2,u1:u2));
     Map_b(l1:l2,u1:u2) = Map_b(l1:l2,u1:u2) + abs((b(l1:l2,u1:u2) - mb)); 
    end
    
end

%---------------------------------------------------------
% Fusion of the saliency values from the different channels
%---------------------------------------------------------
sm1 = ((Map_L).^(2) + (Map_a).^(2) + (Map_b).^(2)).^(1/2);

%---------------------------------------------------------
% Median filtering to distribute saliency values
%---------------------------------------------------------
sm1 = medfilt2(sm1,[11 11]);

%---------------------------------------------------------
% Normalize the final saliency map (SM) in [0,255]
%---------------------------------------------------------
SM = uint8(((sm1 - min(sm1(:)))/(max(sm1(:))))*255);

%---------------------------------------------------------
% Perform histogram equalization only if necessary(depending on input image)
SM = histeq(SM);
%---------------------------------------------------------
      
end