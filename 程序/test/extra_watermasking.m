function code_bin=extra_watermasking(picture,index)

GRAY=rgb2gray(picture);  

%图像缩放
RGB = imresize(GRAY, [512 512]);


%RGB=imadjust(RGB, [75/255, 160/255], [0, 1]);
RGB=imadjust(RGB,[0.3 0.7],[]);
%GRAY=picture
%图形加上旋转
%GRAY = imrotate(GRAY,45,'bilinear','crop'); % 旋转45度，保持原图片大小
imwrite(RGB,'44.bmp');
imshow(RGB);

WIDTH=size(RGB,2);  
HEIGHT=size(RGB,1);  

%去除像素低的点

%wiener滤波
%W_picture=GRAY-wiener2(GRAY,[3,3]);
W_picture=RGB;
%图像的自相关矩阵
frame2=W_picture-mean(mean(W_picture));%减掉均值  
dd=xcorr2(frame2);
mesh(dd);

%高斯滤波
sigma = 1;
gausFilter = fspecial('gaussian', [5,5], sigma);
gaus= imfilter(dd, gausFilter, 'replicate');

%和掩膜卷积
%C = conv2(W_picture,gaus);
%[h,w]=size(C);

mesh(gaus);

%寻找图像中的极大值和极小值
result_high=imregionalmax(gaus);
result_low=imregionalmin(gaus);

result=result_high;
%result=result_temp(10:WIDTH*2-10,10:HEIGHT*2-10);
imshow(result);
 

%得到霍夫空间、求极值点、得到线段信息


[H1,T1,R1] = hough(result);
Peaks=houghpeaks(H1,10);
lines=houghlines(result,T1,R1,Peaks);
% theta=mode(lines.theta);
[qq,k]=size(lines);
for i=1:k
    theta(i)=lines(i).theta;
end;
theta_main=mode(theta);
%最后的结果
result_thero=mod(90-theta_main,180);

code_int=round(result_thero*16/180);
code_bin=dec2bin(code_int,4);


