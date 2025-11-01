% Read and preprocess image
I = imread('Lena.png');      
I_gray = rgb2gray(I);           

% Edge detection using various operators
edges_sobel  = edge(I_gray, 'Sobel');
edges_prewitt = edge(I_gray, 'Prewitt');
edges_roberts = edge(I_gray, 'Roberts');
edges_log    = edge(I_gray, 'log');      % Laplacian of Gaussian
edges_canny  = edge(I_gray, 'Canny');

% Display results
figure('Name','Edge Detection Using Various Operators');

subplot(2,3,1), imshow(I_gray), title('Original Grayscale Image');
subplot(2,3,2), imshow(edges_sobel), title('Sobel Operator');
subplot(2,3,3), imshow(edges_prewitt), title('Prewitt Operator');
subplot(2,3,4), imshow(edges_roberts), title('Roberts Operator');
subplot(2,3,5), imshow(edges_log), title('Laplacian of Gaussian (LoG)');
subplot(2,3,6), imshow(edges_canny), title('Canny Operator');
