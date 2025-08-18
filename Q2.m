img = imread('Lena.png');
figure;
subplot(2,2,1);
imshow(img);
title('Org Img');

% Rotation of Image
rotated_img =  imrotate(img,60);
subplot(2,2,2);
imshow(rotated_img);
title('Rotated Img');

% Scaling of Image
scaled_img = imresize(img,1.5);
subplot(2,2,3);
imshow(scaled_img);
title('Scaled Img');