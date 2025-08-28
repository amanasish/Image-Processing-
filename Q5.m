% WAP to perform image sampling and quantization of an image.

% Read the input image
img = imread('Camera.jpg');    % Load image

% If the image is RGB, convert it to grayscale
if size(img,3) == 3
    img = rgb2gray(img);       % Convert to grayscale
end

% Show histogram of original image
figure;
imhist(img);
title('Histogram of Original Image');

% ----------------- Image Sampling ------------------
n = 50;                % Sampling factor
[h, w] = size(img);    % Get image height and width
im = zeros(h, w);      % Initialize output image

% Perform sampling
for i = 1:n:h
    for j = 1:n:w
        % Fill each n×n block with the top-left pixel value
        for k = 0:n-1
            for l = 0:n-1
                if (i+k <= h) && (j+l <= w)   % Boundary check
                    im(i+k, j+l) = img(i, j);
                end
            end
        end
    end
end

% ----------------- Image Quantization ------------------
% Reduce gray levels (example: to 16 levels)
quant_levels = 16;
q_img = floor(double(img) / (256/quant_levels)) * (256/quant_levels);

% ----------------- Display Results ------------------
figure;
subplot(2,2,1);
imshow(uint8(img));
title('Original Image');

subplot(2,2,2);
imshow(uint8(im));
title('Sampled Image');

subplot(2,2,3);
imshow(uint8(q_img));
title(['Quantized Image (', num2str(quant_levels), ' levels)']);
