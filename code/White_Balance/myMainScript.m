%% MyMainScript

tic;
%% Your code here

flash = im2double(imread('../../data/White_Balance/potsWB_00_flash.jpg'));
ambient = im2double(imread('../../data/White_Balance/potsWB_01_noflash.jpg'));
% figure;
% imshow(flash);
figure;
imshow(ambient);
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

disp(mean(C_p, 'all'));

figure;
imshow(C_p);
impixelinfo;

for i = 1:w
    for j = 1:h
    if ambient(j,i,1)<t1_r && ambient(j,i,2)<t1_g && ambient(j,i,3)<t1_b ...
            || delta(j,i)<t2
        C_p(j,i,:)= 0.0;
    end
    end
end

disp(mean(C_p, 'all'));

c = mean(C_p, 'all');

ambient_wb = (imdivide(ambient, c));

% disp(max(ambient_wb,[],'all'));
% disp(min(ambient_wb,[],'all'));

figure;
imshow(ambient_wb);
impixelinfo;

toc;
