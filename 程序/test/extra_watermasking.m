function code_bin=extra_watermasking(picture,index)

GRAY=rgb2gray(picture);  

%ͼ������
RGB = imresize(GRAY, [512 512]);


%RGB=imadjust(RGB, [75/255, 160/255], [0, 1]);
RGB=imadjust(RGB,[0.3 0.7],[]);
%GRAY=picture
%ͼ�μ�����ת
%GRAY = imrotate(GRAY,45,'bilinear','crop'); % ��ת45�ȣ�����ԭͼƬ��С
imwrite(RGB,'44.bmp');
imshow(RGB);

WIDTH=size(RGB,2);  
HEIGHT=size(RGB,1);  

%ȥ�����ص͵ĵ�

%wiener�˲�
%W_picture=GRAY-wiener2(GRAY,[3,3]);
W_picture=RGB;
%ͼ�������ؾ���
frame2=W_picture-mean(mean(W_picture));%������ֵ  
dd=xcorr2(frame2);
mesh(dd);

%��˹�˲�
sigma = 1;
gausFilter = fspecial('gaussian', [5,5], sigma);
gaus= imfilter(dd, gausFilter, 'replicate');

%����Ĥ���
%C = conv2(W_picture,gaus);
%[h,w]=size(C);

mesh(gaus);

%Ѱ��ͼ���еļ���ֵ�ͼ�Сֵ
result_high=imregionalmax(gaus);
result_low=imregionalmin(gaus);

result=result_high;
%result=result_temp(10:WIDTH*2-10,10:HEIGHT*2-10);
imshow(result);
 

%�õ�����ռ䡢��ֵ�㡢�õ��߶���Ϣ


[H1,T1,R1] = hough(result);
Peaks=houghpeaks(H1,10);
lines=houghlines(result,T1,R1,Peaks);
% theta=mode(lines.theta);
[qq,k]=size(lines);
for i=1:k
    theta(i)=lines(i).theta;
end;
theta_main=mode(theta);
%���Ľ��
result_thero=mod(90-theta_main,180);

code_int=round(result_thero*16/180);
code_bin=dec2bin(code_int,4);


