%��ձ�������ȡͼ��
clear;close all
src= imread('15.bmp');

% gray=rgb2gray(src);  
gray=src;
gray = im2double(gray);
%����ͼ�񣬼�������ʱ��
% gray = imresize(gray, 0.4);

%��matlab�Դ���edge������ȡHarris�ǵ㣬�Ա�Ч��
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