clc; clear; close all;

% Step 1: Read and preprocess image
I = imread('cameraman.tif');   % You can replace with any image
I_gray = im2double(I);

% Step 2: Perform 2D Fourier Transform
F = fft2(I_gray);
F_shift = fftshift(F);         % Shift zero frequency to center

% Step 3: Design a Low-Pass Filter (remove high frequencies)
[M, N] = size(I_gray);
D0 = 50;                       % Cutoff frequency (adjust for sharpness)
[u, v] = meshgrid(-N/2:N/2-1, -M/2:M/2-1);
D = sqrt(u.^2 + v.^2);

% Ideal Low-Pass Filter
H = double(D <= D0);           % 1 for low frequencies, 0 for high

% Step 4: Apply filter in frequency domain
F_filtered = F_shift .* H;

% Step 5: Perform Inverse Fourier Transform
F_ishift = ifftshift(F_filtered);
I_filtered = real(ifft2(F_ishift));

% Step 6: Display results
figure('Name','High-Frequency Elimination (Low-Pass Filtering)');

subplot(2,3,1), imshow(I_gray, []), title('Original Image');
subplot(2,3,2), imshow(log(1+abs(F_shift)), []), title('Original Spectrum');
subplot(2,3,3), imshow(H, []), title('Low-Pass Filter Mask');
subplot(2,3,4), imshow(log(1+abs(F_filtered)), []), title('Filtered Spectrum');
subplot(2,3,5), imshow(I_filtered, []), title('Reconstructed (Low-Freq) Image');
subplot(2,3,6), imshow(I_gray - I_filtered, []), title('Removed High-Freq Components');
