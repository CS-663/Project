% F_lin: Linear Flash Image
% A_lin: Linear ambient Image
% M_shad: Shadow Mask
% T_shad: Threshold of shadow
% M_spec: Specularity Mask
% flash_sigma: Smoothing sigma for combined mask

function combined_mask = flash_mask(F_lin, A_lin, T_shad, flash_sigma)
    M_shad = (F_lin - A_lin) <= T_shad;
    M_spec = F_lin >= 0.95 .* (max(max(F_lin)) - min(min(F_lin)));
    combined_mask = double(M_shad | M_spec);
    combined_mask = imgaussfilt(combined_mask, flash_sigma);
end