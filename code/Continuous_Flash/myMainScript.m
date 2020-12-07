
tic;
%% CODE

ambient = imread('../../data/Continuous_Flash/helmet.02.fadjust0.0.jpg');
flash = imread('../../data/Continuous_Flash/helmet.06.f1.jpg');

ambient_convert = rgb2ycbcr(ambient);
flash_convert = rgb2ycbcr(flash);

% Value to be manipulated for interpolating between
% Ambiet and Flash images

alpha = 1.5;
if (alpha >= 0.0) && (alpha <= 1.0)
    Y_alpha = (1-alpha)*ambient_convert(:,:,1) + (alpha)*flash_convert(:,:,1);
    Cb_alpha = (1-alpha)*ambient_convert(:,:,2) + (alpha)*flash_convert(:,:,2);
    Cr_alpha = (1-alpha)*ambient_convert(:,:,3) + (alpha)*flash_convert(:,:,3);
elseif alpha > 1.0
    disp("here");
    Y_alpha = abs(1-alpha)*ambient_convert(:,:,1) + (alpha)*flash_convert(:,:,1);
    Cb_alpha = (0.0)*ambient_convert(:,:,2) + (1.0)*flash_convert(:,:,2);
    Cr_alpha = (0.0)*ambient_convert(:,:,3) + (1.0)*flash_convert(:,:,3);
else
    Y_alpha = (1-alpha)*ambient_convert(:,:,1) + abs(alpha)*flash_convert(:,:,1);
    Cb_alpha = (1.0)*ambient_convert(:,:,2) + (0.0)*flash_convert(:,:,2);
    Cr_alpha = (1.0)*ambient_convert(:,:,3) + (0.0)*flash_convert(:,:,3);
end

ycbcr_combined = cat(3, Y_alpha, Cb_alpha, Cr_alpha);

rgb_combined = ycbcr2rgb(ycbcr_combined);
minimum = min(rgb_combined, [], 'all');
maximum = max(rgb_combined, [], 'all');
fprintf("Minimum: %f\n", minimum);
fprintf("Maximum: %f\n", maximum);
imshow(rgb_combined);

toc;
