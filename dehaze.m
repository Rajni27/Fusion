function I_enhanced = dehaze(I)
p = I;

r = 16;
eps = 0.1^2;

q = zeros(size(I));

q(:, :, 1) = guidedfilter_color(I, p(:, :, 1), r, eps);
q(:, :, 2) = guidedfilter_color(I, p(:, :, 2), r, eps);
q(:, :, 3) = guidedfilter_color(I, p(:, :, 3), r, eps);

I_enhanced = (I - q) * 5 + q;
end