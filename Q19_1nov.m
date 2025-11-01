clc; clear; close all;

% Step 1: Read and preprocess image
I = imread('cameraman.tif');
I = im2double(I);

% Step 2: Add Gaussian noise
I_noisy = imnoise(I, 'gaussian', 0, 0.01);

% Step 3: Perform Fourier Transform
F = fft2(I_noisy);
F_shift = fftshift(F);           % Shift low frequency to center
[M, N] = size(I_noisy);
[u, v] = meshgrid(-N/2:N/2-1, -M/2:M/2-1);
D = sqrt(u.^2 + v.^2);           % Distance matrix

% ==========================================================
% Step 4: Design Filters
% ==========================================================

% (a) Gaussian Low-Pass Filter (smooths image)
D0 = 40;  % cutoff frequency
H_gaussian = exp(-(D.^2) / (2*(D0^2)));

% (b) Butterworth Low-Pass Filter
n = 2;  % filter order
H_butterworth = 1 ./ (1 + (D./D0).^(2*n));

% (c) High-Boost / Sharpening Filter
k = 1.5;  % boost factor
H_highpass = 1 - exp(-(D.^2) / (2*(D0^2)));   % Gaussian high-pass
H_sharpen = 1 + k * H_highpass;               % High-boost filter

% ==========================================================
% Step 5: Apply Filters in Frequency Domain
% ==========================================================

% Gaussian Filter
F_gauss = F_shift .* H_gaussian;
I_gauss = real(ifft2(ifftshift(F_gauss)));

% Butterworth Filter
F_butter = F_shift .* H_butterworth;
I_butter = real(ifft2(ifftshift(F_butter)));

% Sharpening Filter
F_sharp = F_shift .* H_sharpen;
I_sharp = real(ifft2(ifftshift(F_sharp)));

% ==========================================================
% Step 6: Display Results
% ==========================================================
figure('Name','Frequency Domain Filters');

subplot(3,3,1), imshow(I, []), title('Original Image');
subplot(3,3,2), imshow(I_noisy, []), title('Noisy Image');
subplot(3,3,3), imshow(log(1+abs(F_shift)), []), title('Magnitude Spectrum');

subplot(3,3,4), imshow(H_gaussian, []), title('Gaussian Low-Pass Filter');
subplot(3,3,5), imshow(H_butterworth, []), title('Butterworth Low-Pass Filter');
subplot(3,3,6), imshow(H_sharpen, []), title('High-Boost (Sharpening) Filter');

subplot(3,3,7), imshow(I_gauss, []), title('After Gaussian LPF');
subplot(3,3,8), imshow(I_butter, []), title('After Butterworth LPF');
subplot(3,3,9), imshow(I_sharp, []), title('After Sharpening Filter');
