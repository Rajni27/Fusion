function [ entropy ] = Entropy( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m,n,o]=size(img);
Y = zeros(m,n);
Y = (0.299 * img(:,:,1))+(0.587 * img(:,:,1))+(0.114 * img(:,:,3));

entropy = 0;
for i = 1:255
    j = find(Y == i);
    s = size(j);
    if s(1) == 0
        continue;
    end
    p = s(1)/(m*n);
    entropy = entropy + (p* log2(p));
end
entropy = -1*entropy;
end

