% Question 1 : WAP to read and display an digital image , split and display
% the image into four (4) quandrants

img = imread('img2.jpg');

imshow(img);
title('Full Image');
[r,c,~]=size(img);
mid_r = floor(r/2);
mid_c = floor(c/2);

%horizzontal cross
top_hf = img(1:mid_r,:,:);
bottom_hf = img(mid_r+1:end,:,:);

%vertical cross
left_hf = img(:,1:mid_c,:);
right_hf = img(:,mid_c+1:end,:);

figure;
imshow(top_hf);
title('Top (Upper) ');

figure;
imshow(bottom_hf);
title('Bottom (Lower) ');

figure;
imshow(left_hf);
title('Left (first) ');

figure;
imshow(right_hf);
title('Right (Second) ');