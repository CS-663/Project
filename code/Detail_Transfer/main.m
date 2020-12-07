% Hyper parameters for compressed images
% bilateral_filter(input, 8, 0.07, 33);
% joint_bilateral_filter(input, flash_input, 8, 0.001, 33);

% Hyper parameters for original images
% bilateral_filter(input, 25, 0.07, 101);
% joint_bilateral_filter(input, flash_input, 25, 0.001, 101);

%% Import images
ambient_input = im2double(imread('../../data/Compressed_Detail_Transfer/carpet_01_noflash.png'));
flash_input = im2double(imread('../../data/Compressed_Detail_Transfer/carpet_00_flash.png'));
imshow(ambient_input);
title('Input Ambient Image');
figure;
imshow(flash_input);
title('Input Flash Image');

%% Denoising using bilateral and joint bilateral filter
A_base = bilateral_filter(ambient_input, 8, 0.07, 33);
figure;
imshow(A_base);
title('Bilateral Filter');
imwrite(A_base,'../../output_images/compressed/carpet_noflash_bilateral.png');
A_nr = joint_bilateral_filter(ambient_input, flash_input, 8, 0.001, 33);
figure;
imshow(A_nr);
title('Joint Bilateral Filter');
imwrite(A_base,'../../output_images/compressed/carpet_noflash_joint_bilateral.png');

%% Detail transfer
