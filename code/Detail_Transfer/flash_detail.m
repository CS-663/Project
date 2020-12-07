% F: Flash Image from data
% F_base: Bilateral Filter output of F with spatial_sigma, intensity_sigma,
%         filter_size as required parameters.
% F_detail: Additional detail of Flash image that would be lost in joint
%           bilateral.

function F_detail = flash_detail(F, spatial_sigma, intensity_sigma, filter_size)
    F_base = bilateral_filter(F, spatial_sigma, intensity_sigma, filter_size);
    F_detail = (F + 0.02) ./ (F_base + 0.02);
end