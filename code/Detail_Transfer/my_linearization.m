function linearized_image = my_linearization(image)
    if ndims(image) > 2
        linearized_image = rgb2gray(image);
    else
        linearized_image = image;
    end
end