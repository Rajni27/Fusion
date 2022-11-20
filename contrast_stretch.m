function out = contrast_stretch(im)
    im = im2double(im);
% im = rgb2hsv(im);
%      [~,in] = min(mean(mean(im)));
    for in = 1:3
        minI = min(min(im(:,:,in)));
        maxI = max(max(im(:,:,in)));
        
        temp = (im(:,:,in)-minI)/(maxI-minI);
%         alpha = 0.4;
%         out(:,:,in) = (temp/sqrt(2*alpha^2)) .* exp(-(temp.^2)/(2*alpha^2));
        out(:,:,in) = temp;
    end
%     out = hsv2rgb(out);
    out = dehaze(out);
    out = im2uint8(out);
%     figure,imshow(out);
end