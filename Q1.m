% Displaying read image
img = imread('Lena.png');

subplot(3,3,1);
imshow(img);
title('Org Img');
disp(img);  

% Adding number to each pixel
% img2 = imread('1.jpg');
num=400;
for i=1:size(img,1)
    for j=1:size(img,2)
        img(i,j)=img(i,j)+num;
    end
end

subplot(3,3,2);
imshow(img);
title('Img with Added Num to Each Pixel Value');

% Split and Dislay in 4 quadrants

% copying Size of Row and Col 

[rw,col,~] = size(img);

mid_rw = floor(rw/2);
mid_col = floor(col/2);

quad1 = img(1:mid_rw,1:mid_col,:);
quad3 = img(mid_rw+1:end,1:mid_col,:);

quad4 = img(mid_rw+1:end,1:mid_col,:);
quad2 = img(1:mid_rw,mid_col+1:end,:);

% Displaying

subplot(3,3,5);
imshow(quad1);
title('Quad 1');


subplot(3,3,8);
imshow(quad3);
title('quad3');



subplot(3,3,9);
imshow(quad4);
title('quad4');



subplot(3,3,6);
imshow(quad2);
title('quad2');

