% spatial_sigma : standard deviation of gaussian for difference of spatial
% location

% intensity-sigma : standard deviation of gaussian for difference of pixel
% intensity

% filter_size : odd value is preferable

function [output_img] = bilateral_filter(input_img, spatial_sigma, intensity_sigma, filter_size)
    [row, col, channel] = size(input_img);
    output_img = zeros(row, col, channel);
    
    % spatial gaussian filter
    spatial_gauss_filter = fspecial('gaussian', filter_size, spatial_sigma);
    
    % padding the image by half of filter_size
    filter_size = floor(filter_size / 2);
    input_img = padarray(input_img, [filter_size filter_size], -1);
    
    for i = (1+filter_size : filter_size+row)
        for j = (1+filter_size : filter_size+col)
            % the 1's in the mask represent pixels of original image
            % the 0's in the mask represent pixels outside the image i.e padded pixels
            mask = input_img(i-filter_size:i+filter_size, j-filter_size:j+filter_size, :);
            mask = logical(mask ~= -1);
            
            % constructing intensity gaussian filter
            intensity_gauss_filter = input_img(i-filter_size:i+filter_size, j-filter_size:j+filter_size, :);
            
            red_component = input_img(i, j, 1);
            green_component = input_img(i, j, 2);
            blue_component = input_img(i, j, 3);
            
            % difference between intensities of current pixel and neighbour pixel
            current_pixel_intensity = padarray(red_component, [filter_size filter_size], red_component);
            current_pixel_intensity(:,:,2) = padarray(green_component, [filter_size filter_size], green_component);
            current_pixel_intensity(:,:,3) = padarray(blue_component, [filter_size filter_size], blue_component);
            
            intensity_gauss_filter = intensity_gauss_filter - current_pixel_intensity;
            intensity_gauss_filter = exp(-(intensity_gauss_filter.^2) / (2 * intensity_sigma^2)) / sqrt(2*pi*intensity_sigma^2);
            
            % masking the filters and combining spatial and intensity gauss filters
            filter = spatial_gauss_filter .* mask;
            filter = filter .* intensity_gauss_filter;
            
            normalize = sum(filter, [1 2]);
            filter(:,:,1) = filter(:,:,1) / normalize(1,1,1);
            filter(:,:,2) = filter(:,:,2) / normalize(1,1,2);
            filter(:,:,3) = filter(:,:,3) / normalize(1,1,3);
            
            output_img(i-filter_size,j-filter_size,:) = sum(filter .* input_img(i-filter_size:i+filter_size, j-filter_size:j+filter_size, :), [1 2]);
        end
    end
end

