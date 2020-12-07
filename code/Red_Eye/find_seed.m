function final_bin = find_seed(R)
    mean_R = mean(R, 'all');
    std_R = std(R, 0, 'all');

    R_thresh = max([0.6 mean_R+3*std_R]);

    R_bin = imbinarize(R, R_thresh);
    A_Y = imbinarize(R, 0.6);

    final_bin = bitand(R_bin, A_Y);

    minimum = min(final_bin, [], 'all');
    maximum = max(final_bin, [], 'all');
    fprintf("Minimum: %f\n", minimum);
    fprintf("Maximum: %f\n", maximum);
end