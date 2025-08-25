% DATE : 25 August
% WAP to perform image sampling and quantization of an image.

img = imread('Camera.jpg');


figure;
imhist(img);


n=50;
a=size(img);
w=a(2);
h=a(1);
im=zeros(100);
for i=1:n:h
 for j=1:n:w
     for k=0:n-1
         for l=0:n-1
             im(i+k,j+l)=img(i,j);
 
 end
 end
 end
end
figure;
subplot(2,2,1);
imshow(uint8(img));title('Original Image');
subplot(2,2,2);
imshow(uint8(im));title('Sampled Image');
