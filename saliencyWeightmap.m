function [ W2] = saliencyWeightmap( img )
hsvimg = rgb2hsv(img);
W2 = entropyfilt(uint8(hsvimg(:,:,3)));
W2 = W2./max(max(W2));
end