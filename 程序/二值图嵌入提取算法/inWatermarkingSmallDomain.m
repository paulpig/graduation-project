%基于特征点周围区域的小波中嵌入水印信息
img=imread('15.bmp');
[width,height]=size(img);
mark=zeros(width,height);
inWaterLength=20;
mark_judge=zeros(inWaterLength);
mark_one=ones(inWaterLength);

gray = im2double(img);
wname = 'sym4';
temp=0;
point_get=0;    
point_get2=0;
%产生28*7的随机块大小
A=-1;B=1;
random_mat=A+(B-A)*rand(28,7);
watermarking_double=repmat(random_mat,228,460);
[w,h]=size(watermarking_double);
% watermarking=watermarking_double(w/2-width/2:width/2+w/2-1,h/2-height/2:height/2+h/2-1);
% half_watermarking=watermarking(1:inWaterLength/2,1:inWaterLength/2);
% imwrite(uint8(half_watermarking),'rightWatermarking.bmp');

%正确水印信息
watermarking_double_rotate = imrotate(watermarking_double,30,'bilinear','crop');
[w,h]=size(watermarking_double_rotate);
watermarking_rotate=watermarking_double_rotate(w/2-width/2:width/2+w/2-1,h/2-height/2:height/2+h/2-1);
half_watermarking=watermarking_rotate(1:inWaterLength/2,1:inWaterLength/2);
%imwrite(uint8(half_watermarking),'rightWaterMarking.bmp');

%旋转过的错误的水印
for i=1:18
    watermarking_double_rotate_wrong = imrotate(watermarking_double,i*10,'bilinear','crop');
    [w,h]=size(watermarking_double_rotate_wrong);
    watermarking_rotate_wrong=watermarking_double_rotate_wrong(w/2-width/2:width/2+w/2-1,h/2-height/2:height/2+h/2-1);
    wrong_watermarking=watermarking_rotate_wrong(1:inWaterLength/2,1:inWaterLength/2);
    %imwrite(uint8(wrong_watermarking),[['wrongWaterMarking',num2str(i)],'.bmp']);
end

%寻找harris角
C = corner(gray);
[m,n]=size(C);
%构造点周围的的5*5的矩阵,此处还未考虑边界问题,边界问题只是简单的去除
for i=1:m
    x_point=C(i,1);
    y_point=C(i,2);
    
    if(x_point-inWaterLength/2<0 || x_point+inWaterLength/2-1>width || y_point-inWaterLength/2<0 || y_point+inWaterLength/2-1>height)
        continue;
    end;
    judge=mark(x_point-inWaterLength/2:x_point+inWaterLength/2-1,y_point-inWaterLength/2:y_point+inWaterLength/2-1);
    
    if(~isequal(judge,mark_judge))
        continue;
    end
    
    matric=gray(x_point-inWaterLength/2:x_point+inWaterLength/2-1,y_point-inWaterLength/2:y_point+inWaterLength/2-1);
    [CA,CH,CV,CD] = dwt2(matric,wname,'mode','per');
    X = idwt2(CD+10*double(uint8(half_watermarking)),CH,CV,CD,wname,'mode','per');
    gray(x_point-inWaterLength/2:x_point+inWaterLength/2-1,y_point-inWaterLength/2:y_point+inWaterLength/2-1)=X;
    mark(x_point-inWaterLength/2:x_point+inWaterLength/2-1,y_point-inWaterLength/2:y_point+inWaterLength/2-1)=mark_one;
    point_get=[point_get,x_point];
    point_get2=[point_get2,y_point];
end

subplot(1,2,1),imshow(gray),title('matlab-conner'),  
hold on  
plot(point_get, point_get2, 'r*');  

imwrite(gray,'inWatermarking.bmp');
%imshow(gray);