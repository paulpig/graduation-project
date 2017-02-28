%function:
%       Harris角点检测
%注意：
%       matlab自带的corner函数即可实现harris角点检测。但考虑到harris角点的经典性，本程序将其实现，纯粹出于学习目的，了解特征点检测的方法。
%       其中所有参数均与matlab默认保持一致
%referrence：
%      Chris Harris & Mike Stephens，A COMBINED CORNER AND EDGE DETECTOR
%date:2015-1-11
%author:chenyanan
%转载请注明出处：http://blog.csdn.net/u010278305

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