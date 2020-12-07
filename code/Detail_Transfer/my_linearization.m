% Linearization of image is equivalent to percieved luminance of image

function linearized_image = my_linearization(image)
    if ndims(image) > 2
        linearized_image = 0.2989*image(:,:,1) + 0.5870.*image(:,:,2) ...
            + 0.1140*image(:,:,3);
    else
        linearized_image = image;
    end
end