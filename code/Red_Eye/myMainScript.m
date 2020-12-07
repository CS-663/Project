
tic;
%% CODE

ambient = im2double(imread('../../data/Red_Eye/01_01_stranger_no_flash.jpg'));
flash = im2double(imread('../../data/Red_Eye/01_02_stranger_flash.jpg'));

ambient_convert = rgb2ycbcr(ambient);
flash_convert = rgb2ycbcr(flash);

a_y = ambient_convert(:,:,1);
a_cb = ambient_convert(:,:,2);
a_cr = ambient_convert(:,:,3);
% figure;
% imshow(a_cr);

f_y = flash_convert(:,:,1);
f_cb = flash_convert(:,:,2);
f_cr = flash_convert(:,:,3);
% figure;
% imshow(f_cr);

A = (f_cr - a_cr);

% https://in.mathworks.com/matlabcentral/answers/86410-changing-values-of-pixels-in-an-image-pixel-by-pixel-thresholding
R = A;
[height, width] = size(A);
R(A<=0.05) = 0.0;
R = reshape(R, [height, width]);

minimum = min(R, [], 'all');
maximum = max(R, [], 'all');
fprintf("Minimum: %f\n", minimum);
fprintf("Maximum: %f\n", maximum);

figure;
imshow(R);
impixelinfo;

final_bin = find_seed(R);

figure;
imshow(final_bin);

toc;
