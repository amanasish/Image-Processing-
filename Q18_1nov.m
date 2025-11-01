clc; clear; close all;

% Step 1: Read and preprocess image
I = imread('cameraman.tif');   % Replace with your own image
I_gray = im2double(I);         % Convert to double precision
[m, n] = size(I_gray);

% Step 2: Reshape image into vectors (each column = pixel feature)
X = reshape(I_gray, m*n, 1);   % Flatten image into a column vector

% Step 3: Subtract the mean (zero-mean data)
mean_X = mean(X);
X_zero_mean = X - mean_X;

% Step 4: Compute covariance matrix
C = cov(X_zero_mean);

% Step 5: Eigen decomposition of covariance matrix
% (For grayscale, covariance is scalar, so for color use this form)
% If color image, uncomment below:
% I_color = imread('peppers.png');
% I_color = im2double(I_color);
% X = reshape(I_color, [], 3);
% mean_X = mean(X);
% X_zero_mean = X - mean_X;
% C = cov(X_zero_mean);
% [V, D] = eig(C);

[V, D] = eig(C);

% Step 6: Compute K–L Transform coefficients
Y = X_zero_mean * V;

% Step 7: Reconstruct the image (Inverse K–L Transform)
X_reconstructed = Y * V' + mean_X;
I_reconstructed = reshape(X_reconstructed, m, n);

% Step 8: Display results
figure('Name','Karhunen–Loève Transform (KLT)');
subplot(1,3,1), imshow(I_gray, []), title('Original Image');
subplot(1,3,2), imshow(I_reconstructed, []), title('Reconstructed Image');
subplot(1,3,3), imshow(abs(I_gray - I_reconstructed), []), title('Difference Image');
