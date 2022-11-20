function [ W1 ] = luminanceWeightmap( img )
 hsv = rgb2hsv(img);
s = (hsv(:,:,2));
filterWinSize = 8;
mLocalSumFilter = ones(filterWinSize, filterWinSize);
vGradXFilter = [-0.5, 0, 0.5];
vGradYFilter = [-0.5; 0; 0.5];
mInputImageGradX = imfilter(s, vGradXFilter, 'replicate', 'same', 'corr');
mInputImageGradY = imfilter(s, vGradYFilter, 'replicate', 'same', 'corr');

mInputImageGradX1=im2double(mInputImageGradX);
mInputImageGradY1=im2double(mInputImageGradY);
mInputImageGradNorm = sqrt((mInputImageGradX1 .^ 2.0) + (mInputImageGradY1 .^ 2.0));
mInputImageGradNorm = imfilter(mInputImageGradNorm, mLocalSumFilter, 0, 'same', 'corr') ;
W1_1 = mInputImageGradNorm;
W1 = W1_1./max(max(W1_1));
figure; imshow(W1);
end
