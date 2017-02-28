img=imread('4.jpg');
[width,height]=size(img);

GRAY=rgb2gray(img);  
%GRAY=img;
image=imresize(GRAY,[512,512]);

imwrite(image,'gray.bmp');

mark=zeros(width,height);
inWaterLength=20;
mark_judge=zeros(inWaterLength);
mark_one=ones(inWaterLength);


point_get=0;    
point_get2=0;

C = corner(image);
[m,n]=size(C);

watermark=imread('rightWaterMarking.bmp');
wrong_watermark=imread('wrongWaterMarking14.bmp');

sum=0;
wname = 'sym4';
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
    
    matric=image(x_point-inWaterLength/2:x_point+inWaterLength/2-1,y_point-inWaterLength/2:y_point+inWaterLength/2-1);
    [CA,CH,CV,CD] = dwt2(matric,wname,'mode','per');
    aa=corr2(watermark,CA);
    sum=sum+aa;
    point_get=[point_get,x_point];
    point_get2=[point_get2,y_point];
end

subplot(1,2,1),imshow(image),title('matlab-conner'),  
hold on  
plot(point_get, point_get2, 'r*');  

a=2;




