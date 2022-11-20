clc;
clear;
close all;
tic;
% im = imread('Ancuti.png');
im = imread('E:\Thesis\chapter3\A1.jpg');
% im = imresize(im,0.5);
firstInput = double(histeq_img(im)); % input1
secondInput = double(contrast_stretch(im));  % (firstInput);

% secondInput = dehaze(double(im));
% figure,imshow([uint8(firstInput),uint8(secondInput)]);
%% pyramid decompostion
%Weight maps of the First Input
luminanceWeightmap1 = luminanceWeightmap(firstInput);
saliencyWeightmap1 = saliencyWeightmap(firstInput);
% subplot(1,2,1),imshow(luminanceWeightmap1);

% subplot(1,2,2),imshow(saliencyWeightmap1);title('saliencyWeightmap of First input');
%Resultant Weight map of the first input
resultedWeightmap1 = (luminanceWeightmap1 + saliencyWeightmap1) ;

%Weightmaps of the Second Input
luminanceWeightmap2 = luminanceWeightmap(secondInput);
% subplot(1,2,1), imshow(luminanceWeightmap2);title('luminanceWeightmap of Second input');
saliencyWeightmap2 = saliencyWeightmap(secondInput);
% subplot(1,2,2), imshow(saliencyWeightmap2);title('saliencyWeightmap of Second input');

%Resultant Weight map of the second input
resultedWeightmap2 = (luminanceWeightmap2 + saliencyWeightmap2);

%Normalized Weight maps of the Inputs
normaizedWeightmap1 = resultedWeightmap1 ./ (0.01+ resultedWeightmap2 +resultedWeightmap1);
normaizedWeightmap2 = resultedWeightmap2 ./ (0.01+ resultedWeightmap2 +resultedWeightmap1);
% [CA1,CH1,CV1,CD1] = dwt2(normaizedWeightmap1,'db4');
% [CA2,CH2,CV2,CD2] = dwt2(normaizedWeightmap2,'db4');
% [CAR1,CHR1,CVR1,CDR1] = dwt2(firstInput(:,:,1),'db4');
% [CAG1,CHG1,CVG1,CDG1] = dwt2(firstInput(:,:,2),'db4');
% [CAB1,CHB1,CVB1,CDB1] = dwt2(firstInput(:,:,3),'db4');
% [CAR2,CHR2,CVR2,CDR2] = dwt2(secondInput(:,:,1),'db4');
% [CAG2,CHG2,CVG2,CDG2] = dwt2(secondInput(:,:,2),'db4');
% [CAB2,CHB2,CVB2,CDB2] = dwt2(secondInput(:,:,3),'db4');
% CAR = CAR1.*CA1 + CAR2.*CA2;
% CHR = CHR1.*CH1 + CHR2.*CH2;
% CVR = CVR1.*CV1 + CVR2.*CV2;
% CDR = CDR1.*CD1 + CDR2.*CD2;
% CAG = CAG1.*CA1 + CAG2.*CA2;
% CHG = CHG1.*CH1 + CHG2.*CH2;
% CVG = CVG1.*CV1 + CVG2.*CV2;
% CDG = CDG1.*CD1 + CDG2.*CD2;
% CAB = CAB1.*CA1 + CAB2.*CA2;
% CHB = CHB1.*CH1 + CHB2.*CH2;
% CVB = CVB1.*CV1 + CVB2.*CV2;
% CDB = CDB1.*CD1 + CDB2.*CD2;
% 
% enh(:,:,1) = idwt2(CAR,CHR,CVR,CDR,'db4');
% enh(:,:,2) = idwt2(CAG,CHG,CVG,CDG,'db4');
% enh(:,:,3) = idwt2(CAB,CHB,CVB,CDB,'db4');
% figure,imshow(uint8(enh)), title('Wavelet');
%Generating Gaussian Pyramid for normalized weight maps
Weight1 = gaussian_pyramid(normaizedWeightmap1,5);
Weight2 = gaussian_pyramid(normaizedWeightmap2,5);
% calculate the laplacian pyramid
level = 5;
% input1
R1 = laplacian_pyramid(firstInput(:, :, 1), level);
G1 = laplacian_pyramid(firstInput(:, :, 2), level);
B1 = laplacian_pyramid(firstInput(:, :, 3), level);
% input2
R2 = laplacian_pyramid(secondInput(:, :, 1), level);
G2 = laplacian_pyramid(secondInput(:, :, 2), level);
B2 = laplacian_pyramid(secondInput(:, :, 3), level);

% fusion
for i = 1 : level
    R_r{i} = Weight1{i} .* R1{i} + Weight2{i} .* R2{i};
    R_g{i} = Weight1{i} .* G1{i} + Weight2{i} .* G2{i};
    R_b{i} = Weight1{i} .* B1{i} + Weight2{i} .* B2{i};
end
% reconstruct & output
R = pyramid_reconstruct(R_r);
G = pyramid_reconstruct(R_g);
B = pyramid_reconstruct(R_b);
fusedImage = cat(3, uint8(R), uint8(G), uint8(B));
toc;
figure, imshow([im,uint8(fusedImage)]);
% enhancedImage = dehaze(double(fusedImage));
% figure, imshow([im,uint8(fusedImage)]);
title('Dehazed Image');
% cd 'F:\manuscripts\paper3\images'
% imwrite(uint8(fusedImage),'FUIER_UW3(NN).jpg','jpg');
% cd 'C:\users\rajnigsethi\documents\matlab\prior based\idea 2';
% 