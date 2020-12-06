% A_base: bilateral output of non-flash image
% A_nr: joint bilateral output of non-flash image
% F_detail: detail of Flash image
% Mask: Mask of Flash shadow + specularities

function A_final = my_denoising(A_base, A_nr, F_detail, Mask)
    A_final = (1 - Mask).*A_nr.*F_detail + M.*A_base;
end