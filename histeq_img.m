function out = histeq_img(input)
%     avg = mean(mean(input));
%     [~,in] = max(avg);
    for in = 1:3
        out(:,:,in) = histeq(input(:,:,in));
    end
end