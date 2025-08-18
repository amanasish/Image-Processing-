img = imread('Lena.png');
figure;
subplot(3,3,1);
imshow(img);
title('Org Img');

% Org ---> Gray
gray_img = rgb2gray(img);
subplot(3,3,2);
imshow(gray_img);
title('Gray Img');

% org ---> Mirror
h = fspecial('gaussian',[21 21],2);
blur_img = imfilter(img,h,'replicate');
subplot(3,3,3);
imshow(blur_img);
title('Blurred Img');

subplot(3,3,4);
imshow(img);
title('Org Img');

% Org ---> Mirror

mir_img = flip(img,2);
subplot(3,3,5);
imshow(mir_img);
title('Mirror Img');

% Org ---> Binary
threshold = 0.5;
binary_normalize = im2double(gray_img);
binary_img_manual = binary_normalize > threshold;
subplot(3,3,6);
imshow(binary_img_manual);
title('Binary Img');