clc; clear; close all;

% Step 1: Read and preprocess the image
I = imread('cameraman.tif');   % Replace with your image
I_gray = im2double(I);         % Convert to double precision

% Step 2: Perform 2D Discrete Cosine Transform (DCT)
DCT_image = dct2(I_gray);      % Compute 2D DCT

% Step 3: Display DCT (log scaled for visibility)
DCT_display = log(1 + abs(DCT_image));

% Step 4: Perform Inverse DCT to reconstruct the image
IDCT_image = idct2(DCT_image); % Reconstruct original image

% Step 5: Display results
figure('Name','Discrete Cosine Transform (DCT)');

subplot(2,2,1), imshow(I_gray, []), title('Original Image');
subplot(2,2,2), imshow(DCT_display, []), title('DCT Coefficients (Log Scaled)');
subplot(2,2,3), imshow(IDCT_image, []), title('Reconstructed Image (IDCT)');
subplot(2,2,4), imshow(abs(I_gray - IDCT_image), []), title('Difference Image');
