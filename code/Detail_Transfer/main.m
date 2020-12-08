% Hyper parameters for compressed images
% bilateral_filter(input, 8, 0.07, 33);
% joint_bilateral_filter(input, flash_input, 8, 0.001, 33);

% Hyper parameters for original images
% bilateral_filter(input, 25, 0.07, 101);
% joint_bilateral_filter(input, flash_input, 25, 0.001, 101);

% DONT DELETE COMMENTED PART
% CHANGE THE FILE NAME TO GET DETAIL IMAGES FOR OTHERS AND TWEAK HYPER
% PARAMETERS, THATS IT ONE HAS TO DO AND NOTHING ELSE
%% Import images
% For carpet 
ambient_input = im2double(imread('../../data/Detail_Transfer/carpet_01_noflash.tif'));
flash_input = im2double(imread('../../data/Detail_Transfer/carpet_00_flash.tif'));
imshow(ambient_input);
title('Input Ambient Image');
figure;
imshow(flash_input);
title('Input Flash Image');

% For pot
% A = im2double(imread('../../data/Compressed_Detail_Transfer/lamp_01_noflash.png'));
% F = im2double(imread('../../data/Compressed_Detail_Transfer/lamp_00_flash.png'));
% imshow(A);
% title('Input Ambient Image');
% figure;
% imshow(F);
% title('Input Flash Image');

%% Denoising using bilateral and joint bilateral filter
% For carpet
% A_base = bilateral_filter(ambient_input, 25, 0.07, 101);
% figure;
% imshow(A_base);
% title('Bilateral Filter');
% imwrite(A_base,'../../output_images/carpet_noflash_bilateral.tif');
A_nr = joint_bilateral_filter(ambient_input, flash_input, 25, 0.001, 101);
figure;
imshow(A_nr);
title('Joint Bilateral Filter');
imwrite(A_nr,'../../output_images/carpet_noflash_joint_bilateral.tif');

% For pot
% A_base = bilateral_filter(A, 8, 0.07, 33);
% figure;
% imshow(A_base);
% title('Bilateral Filter');
% A_nr = joint_bilateral_filter(A, F, 8, 0.001, 33);
% figure;
% imshow(A_nr);
% title('Joint Bilateral Filter');

%% Finding difference between Joint and Base bilateral filtering
% For carpet
% difference = rgb2gray(A_nr - A_base);
% difference = 1 - difference;
% difference = (difference - min(min(difference))) / (max(max(difference))- min(min(difference)));
% figure;
% imshow(difference);
% title("Difference between Joint bilateral and Bilateral");
% imwrite(difference, '../../output_images/carpet_difference.tif');

%% Detail transfer
F_detail = flash_detail(F, 8, 0.07, 33);
% For carpet
% figure;
% imshow(F_detail);
% title("Detail Layer");
% imwrite(F_detail, '../../output_images/carpet_detail.tif');

A_final = A_nr .* F_detail;
figure;
imshow(A_final);
title("Detail transfer without mask");
imwrite(A_final, '../../output_images/compressed/lamp_detail_transfer_nomask.png');

%% Mask for shadow and specularity detection
F_lin = my_linearization(F);
A_lin = my_linearization(A);
M = flash_mask(F_lin, A_lin, 0.03, 4);
figure;
imshow(M);
title('Mask');
imwrite(M, '../../output_images/compressed/lamp_mask.png');
A_final = my_denoising(A_base, A_nr, F_detail, M);
figure;
imshow(A_final);
title("Detail transfer");
imwrite(A_final, '../../output_images/compressed/lamp_transfer.png');





