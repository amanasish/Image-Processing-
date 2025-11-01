clc; clear; close all;

% Step 1: Read and preprocess image
I = imread('cameraman.tif');   % Replace with any grayscale image
I_gray = im2double(I);         % Convert to double

% Step 2: Resize image to power of 2 (required for WHT)
[M, N] = size(I_gray);
m = 2^nextpow2(M);
n = 2^nextpow2(N);
I_resized = imresize(I_gray, [m n]);

% Step 3: Generate Hadamard matrix
H_M = hadamard(m);
H_N = hadamard(n);

% Step 4: Perform 2D Walsh–Hadamard Transform
WHT_image = H_M * I_resized * H_N' / (m*n);

% Step 5: Perform Inverse WHT
I_reconstructed = H_M' * WHT_image * H_N / (m*n);

% Step 6: Display results
figure('Name','Walsh–Hadamard Transform (WHT)');
subplot(2,2,1), imshow(I_gray, []), title('Original Image');
subplot(2,2,2), imshow(log(1 + abs(WHT_image)), []), title('WHT Coefficients (Log Scaled)');
subplot(2,2,3), imshow(I_reconstructed, []), title('Reconstructed Image (Inverse WHT)');
subplot(2,2,4), imshow(abs(I_resized - I_reconstructed), []), title('Difference Image');
