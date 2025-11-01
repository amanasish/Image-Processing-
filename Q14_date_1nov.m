% Step 1: Read and preprocess the image
I = imread('Lena.png');   % You can replace with any image
I_gray = rgb2gray(I);         % Convert to double precision for processing
% Step 2: Perform 2D Discrete Fourier Transform (DFT)
F = fft2(I_gray);              % Compute 2D FFT
F_shift = fftshift(F);         % Shift zero frequency to the center

% Step 3: Compute magnitude spectrum (for visualization)
magnitude_spectrum = log(1 + abs(F_shift));  % Log scaling for visibility

% Step 4: Perform Inverse Fourier Transform to reconstruct image
F_ishift = ifftshift(F_shift); % Shift back before inverse
I_reconstructed = ifft2(F_ishift);  % Inverse FFT
I_reconstructed = real(I_reconstructed); % Remove small imaginary parts

% Step 5: Display results
figure('Name','Fourier Transform and Reconstruction');

subplot(2,2,1), imshow(I_gray, []), title('Original Image');
subplot(2,2,2), imshow(magnitude_spectrum, []), title('Magnitude Spectrum (DFT)');
subplot(2,2,3), imshow(log(1+abs(ifftshift(F))), []), title('Unshifted Spectrum');
subplot(2,2,4), imshow(I_reconstructed, []), title('Reconstructed Image (Inverse DFT)');

