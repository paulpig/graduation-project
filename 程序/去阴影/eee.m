I = imread('temp.jpg');  
I = rgb2gray(I);  
%colfilt(I,[31 31],'sliding',@bk)  
% 功能：以列方法进行邻域处理，也可执行常规非线性滤波。  
% 用法：B = colfilt(A,[m n],block_type,fun)  
% 该函数生成了一幅图像Ａ，在Ａ中，每一列对应于其中心位于图像内某个位置的邻域所包围的像素。然后将函数应用于该矩阵中。  
% [m n]表示大小为m行n列的邻域。block_type表示了一个字符串，包括'distinct','sliding'两种，  
% 其中'sliding'是在输入图像中逐个像素地滑动该m乘n的区域。fun表示引用了一个函数进行处理，  
% 函数返回值的大小必须和原图像大小相同。  

%获取背景图像，块中最亮的五个点的亮度平均值作为背景。
I2 = uint8(colfilt(I,[31 31],'sliding',@bk));  
imwrite(I2,'1.png');
figure(1),imshow(I2);


%原图减去背景图，从而是得光照均匀，对比背景图和原图，增强原图的对比度
I3 = minusBk(I,I2);  
figure(2),imshow(I3);
imwrite(I3,'2.png');

%阈值均匀化，threashold的值需要通过OTsu方法来获得
[m,n]=size(I4);
ImOut_pic = uint8(zeros(m,n));
for i=1:m
    for j=1:n
        if(I3(i,j)<threshold)
            ImOut_pic(i,j)=0;
        else
            ImOut_pic(i,j)=255;
        end;
    end;
end;
imshow(ImOut_pic);
imwrite(ImOut_pic,'3.png');