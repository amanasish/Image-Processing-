% DATE : 25 August
img = imread('Camera.jpg');

% WAP to find negative , gama , log , contrast stretching and thresholding
% Q2

% spatial resolution
[rows, cols] = size(img);
fprintf('Spatial Resolution:\n');
fprintf(' - Width  = %d pixels\n', cols);
fprintf(' - Height = %d pixels\n', rows);

figure;
imshow(img);
title('Grayscale Image');

% -------- Intensity Resolution Analysis --------
% Determine bit depth
unique_vals = unique(img);
num_levels = length(unique_vals);
bit_depth = ceil(log2(num_levels));

fprintf('\nIntensity Resolution:\n');
fprintf(' - Number of intensity levels = %d\n', num_levels);
fprintf(' - Estimated bit depth = %d bits\n', bit_depth);

% Histogram
figure;
imhist(img);
title('Histogram of Intensity Levels');
xlabel('Intensity Value');
ylabel('Pixel Count');


% -------- Negative Transformation --------
negative_img = 255 - img;

figure;
imshow(negative_img);
title('Negative Image');

% -------- Gamma Correction --------
gamma = 0.5; % You can change this value (e.g., <1 brightens, >1 darkens)
img_normalized = im2double(img); % Normalize to [0,1]
gamma_corrected = imadjust(img_normalized, [], [], gamma);
figure;
imshow(gamma_corrected);
title(['Gamma Correction (Gamma = ', num2str(gamma), ')']);

% -------- Log Transformation --------
% Formula: s = c * log(1 + r)
c = 255 / log(1 + double(max(img(:))));
log_transformed = c * log(1 + double(img));
log_transformed = uint8(log_transformed); % Convert back to uint8


% -------- 4. Contrast Stretching --------
% Formula: s = (r - rmin)*(255/(rmax - rmin))
rmin = double(min(img(:)));
rmax = double(max(img(:)));
contrast_stretched = uint8((double(img) - rmin) * (255 / (rmax - rmin)));
figure;
imshow(contrast_stretched);
title('Contrast Stretching');

% -------- 5. Thresholding --------
threshold = 100; % You can change this value
binary_img = img > threshold; % Simple binary thresholding
figure;
imshow(binary_img);
title(['Thresholding (Threshold = ', num2str(threshold), ')']);