img = imread('Lena.png');
figure;
subplot(2,2,1);
imshow(img);
axis on;

% Detect Face and show
crop_img = img(70:400,110:410,:);
subplot(2,2,2);
imshow(crop_img);