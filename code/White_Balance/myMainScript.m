%% MyMainScript

tic;
%% Your code here

flash = im2double(imread('../../data/White_Balance/potsWB_00_flash.jpg'));
ambient = im2double(imread('../../data/White_Balance/potsWB_01_noflash.jpg'));
% figure;
% imshow(flash);
figure;
imshow(ambient);
title('Original No-Flash Image');
impixelinfo;

flash_lin = my_linearization(flash);
ambient_lin = my_linearization(ambient);

delta = flash_lin - ambient_lin;

C_p = zeros(size(ambient));

C_p(:,:,1) = imdivide(ambient(:,:,1), delta);
C_p(:,:,2) = imdivide(ambient(:,:,2), delta);
C_p(:,:,3) = imdivide(ambient(:,:,3), delta);


% ambient_sum = ambient(:,:,1) + ambient(:,:,2) + ambient(:,:,3);
t1_r = 0.02*range(ambient(:,:,1), 'all');
t1_g = 0.02*range(ambient(:,:,2), 'all');
t1_b = 0.02*range(ambient(:,:,3), 'all');
t2 = 0.02*range(delta, 'all');

[h, w] = size(delta);

figure;
imshow(C_p);
impixelinfo;

for i = 1:w
    for j = 1:h
    if ambient(j,i,1)<t1_r || ambient(j,i,2)<t1_g || ambient(j,i,3)<t1_b ...
            || delta(j,i)<t2
        C_p(j,i,:)= 0.0;
    end
    end
end

% C_p = contrast_streching(C_p);

disp(max(C_p,[],'all'));
disp(min(C_p,[],'all'));

c_r = mean(C_p(:,:,1), 'all');
c_g = mean(C_p(:,:,2), 'all');
c_b = mean(C_p(:,:,3), 'all');

ambient_wb = zeros(size(ambient));

ambient_wb(:,:,1) = (imdivide(ambient(:,:,1), c_r));
ambient_wb(:,:,2) = (imdivide(ambient(:,:,2), c_g));
ambient_wb(:,:,3) = (imdivide(ambient(:,:,3), c_b));

patch = ones(80);
figure;
imshow(cat(3,patch*c_r,patch*c_g,patch*c_b));
title('Estimated ambient illumination');


figure;
imshow(ambient_wb);
title('White-Balanced Image');
impixelinfo;

toc;
