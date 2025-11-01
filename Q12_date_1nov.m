% Read input image
I = imread('Lena.png');   % You can replace with your own image
I_gray = rgb2gray(I);        % Convert to grayscale

% Apply nonlinear filtering (Median filter)
I_filtered = medfilt2(I_gray, [3 3]);  % 3x3 median filter


% Edge detection (Canny method)
edges_canny = edge(I_filtered, 'Canny');

% Display results
figure;
subplot(2,2,1), imshow(I_gray), title('Original Grayscale Image');
subplot(2,2,2), imshow(I_filtered), title('Nonlinear Filtered Image');
subplot(2,2,3), imshow(edges_canny), title('Edges after Nonlinear Filtering');

% Compare with edge detection without filtering
edges_no_filter = edge(I_gray, 'Canny');
subplot(2,2,4), imshow(edges_no_filter), title('Edges without Filtering');
