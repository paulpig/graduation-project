%清空变量，读取图像
clear;close all
src= imread('15.bmp');

% gray=rgb2gray(src);  
gray=src;
gray = im2double(gray);
%缩放图像，减少运算时间
% gray = imresize(gray, 0.4);

%用matlab自带的edge函数提取Harris角点，对比效果
C = corner(gray);
imshow(gray),title('matlab-conner'),
% hold on
% plot(C(:,1), C(:,2), 'r*');

wname = 'sym4';
[CA,CH,CV,CD] = dwt2(gray,wname,'mode','per');
figure(1)
imagesc(CV); title('Vertical Detail Image');
figure(2)
imagesc(CA); title('Lowpass Approximation');

hold off