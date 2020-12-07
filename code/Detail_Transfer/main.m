% Hyper parameters for compressed images
% bilateral_filter(input, 8, 0.07, 33);
% joint_bilateral_filter(input, flash_input, 8, 0.001, 33);

% Hyper parameters for original images
% bilateral_filter(input, 25, 0.07, 101);
% joint_bilateral_filter(input, flash_input, 25, 0.001, 101);

%% Import images
ambient_input = im2double(imread('../../data/Detail_Transfer/carpet_01_noflash.tif'));
flash_input = im2double(imread('../../data/Detail_Transfer/carpet_00_flash.tif'));
imshow(ambient_input);
title('Input Ambient Image');
figure;
imshow(flash_input);
title('Input Flash Image');

%% Denoising using bilateral and joint bilateral filter
A_base = bilateral_filter(ambient_input, 25, 0.07, 101);
figure;
imshow(A_base);
title('Bilateral Filter');
imwrite(A_base,'../../output_images/carpet_noflash_bilateral.tif');
A_nr = joint_bilateral_filter(ambient_input, flash_input, 25, 0.001, 101);
figure;
imshow(A_nr);
title('Joint Bilateral Filter');
imwrite(A_base,'../../output_images/carpet_noflash_joint_bilateral.tif');

%% Detail transfer
difference = rgb2gray(A_nr - A_base);
difference = 1 - difference;
difference = (difference - min(min(difference))) / (max(max(difference))- min(min(difference)));
figure;
imshow(difference);
imwrite(difference, '../../output_images/carpet_difference.tif');
F = flash_input;
F_base = im2double(imread('../../output_images/carpet_flash_bilateral.tif'));
F_detail = (F + 0.02) ./ (F_base + 0.02);






