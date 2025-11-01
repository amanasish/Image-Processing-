clc; clear; close all;

%% Step 1: Read and preprocess image
I = imread('cameraman.tif');  % Grayscale image
I = im2double(I);
figure('Name','Original Image');
imshow(I), title('Original Image');

%% ==========================================================
% ? Step 2: Differential Edge Detection (Sobel / Prewitt)
% ==========================================================
% Sobel Operator
edges_sobel = edge(I, 'sobel');

% Prewitt Operator
edges_prewitt = edge(I, 'prewitt');

figure('Name','Differential Edge Detection');
subplot(1,2,1), imshow(edges_sobel), title('Sobel Edge Detection');
subplot(1,2,2), imshow(edges_prewitt), title('Prewitt Edge Detection');

%% ==========================================================
% ? Step 3: Point Detection (Laplacian of Gaussian)
% ==========================================================
% Laplacian of Gaussian (LoG) for point/spot detection
hsize = 7;      % Filter size
sigma = 1.0;    % Standard deviation
LoG_filter = fspecial('log', hsize, sigma);
edges_log = imfilter(I, LoG_filter, 'replicate');
edges_log = edge(I, 'log');  % Using MATLAB built-in for zero-crossing

figure('Name','Point Detection (LoG)');
imshow(edges_log), title('Laplacian of Gaussian (LoG) Edge Detection');

%% ==========================================================
% ?? Step 4: Canny Edge Detection
% ==========================================================
edges_canny = edge(I, 'canny');

figure('Name','Canny Edge Detection');
imshow(edges_canny), title('Canny Edge Detection');

%% ==========================================================
% Step 5: Combined Segmentation (Optional)
% ==========================================================
% Combine all edges to get a segmented map
combined_edges = edges_sobel | edges_prewitt | edges_log | edges_canny;

figure('Name','Combined Edge Segmentation');
imshow(combined_edges), title('Combined Segmentation Using Edges');
