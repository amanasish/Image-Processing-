% 3) WAP to enhance the image on the basis of given image ( Histogram
% Matching 


% Read the input image
input_img = imread('Lena.png');

% Convert to grayscale if needed
if size(input_img,3) == 3
    input_gray = rgb2gray(input_img);
else
    input_gray = input_img;
end


% Convert to grayscale if needed
if size(ref_img,3) == 3
    ref_gray = rgb2gray(ref_img);
else
    ref_gray = ref_img;
end


% Read the reference image (for histogram matching)
ref_img = imread('Camera.jpg');


% Histogram Equalization of input image
equalized_img = histeq(input_gray);

% Histogram Matching (Specialization) to match reference image
matched_img = imhistmatch(input_gray, ref_gray);



% Display the images
figure;

subplot(2,2,1);
imshow(input_gray);
title('Original Image');

subplot(2,2,2);
imshow(ref_gray);
title('Reference Image');

subplot(2,2,3);
imshow(equalized_img);
title('Histogram Equalized Image');

subplot(2,2,4);
imshow(matched_img);
title('Histogram Specialized (Matched) Image');
