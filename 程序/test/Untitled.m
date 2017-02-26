% a=[1,2,3;4,5,6;7,8,9];
% 
% r=randperm( size(a,1) );   %生成关于行数的随机排列行数序列
% B=a(r, :); %根据这个序列对A进行重新排序 
% 
% 
% rb=randperm( size(B,2) );   %生成关于列数的随机排列列数序列
% C=B(:, rb);                              %根据这个序列对A进行重新排序

% 
% a=[1,1,1,1;1,1,1,1];
% [h,w]=size(a);

% n = 15;                % Code length
% k = 11;                % Message length
% data = randi([0 1],k,1);
% encData = encode(data,n,k,'hamming/binary');
% encData(4) = ~encData(4);
% decData = decode(encData,n,k,'hamming/binary');

% N=31;
% K=26;
% temp1=[1,0,0,1, 1,0,1,0,    1,0,1,1,   0,1,0,1,   1,0,1,1,   1,0,1,0  ,0,1,1,1 ,0,1,0];
% temp2=[1,0,0,1, 1,0,1,0,    1,0,1,1,   0,1,0,1,   1,0,1,1,   1,0,0,0  ,0,1,1,1 ,0,0,0];
% temp_input1=temp1;
% temp_input2=temp2;
% [msg1]=decode(temp1, N,K);
% [msg2,err,ccode]=decode(temp2, N,K);
% 
% numerr = biterr(msg1,msg2);
% 
% aa=4;

% picture=imread('lena标准测试图像.bmp');
% ycbcr=rgb2ycbcr(picture);
% y=ycbcr(:,:,1);
% picture_gary=double(y);
% %JND的计算
% %1.背景图像的计算
% B=[1,1,1,1,1;1,2,2,2,1;1,2,0,2,1;1,2,2,2,1;3,1,1,1,1]/32;
% picture_bg=conv2(picture_gary,B,'same');
% imshow(uint8(picture_bg));
% 
% %2.计算亮度的最大加权平均picture_mg
% G1=[0,0,0,0,0;1,3,8,3,1;0,0,0,0,0;-1,-3,-8,-3,-1;0,0,0,0,0]/16;
% G2=[0,0,1,0,0;0,8,3,0,0;1,3,0,-3,-1;0,0,-3,-8,0;0,0,-1,0,0]/16;
% G3=[0,0,1,0,0;0,0,3,8,0;-1,-3,0,3,1;0,-8,-3,0,0;0,0,-1,0,0]/16;
% %G3=G2;
% G4=[0,1,0,-1,0;0,3,0,-3,0;0,8,0,-8,0;0,3,0,-3,0;0,1,0,-1,0]/16;
% 
% grad1=conv2(picture_gary,G1,'same');
% grad2=conv2(picture_gary,G2,'same');
% grad3=conv2(picture_gary,G3,'same');
% grad4=conv2(picture_gary,G4,'same');
% 
% picture_mg=max(max(max(abs(grad1),abs(grad2)),abs(grad3)),abs(grad4));
% 
% imshow(uint8(picture_mg));
% 
% 
% %3.计算jnd
% To=17;
% v=3/128;
% m=1/2;
% p1=2.0;
% p2=3.0;
% 
% f2=picture_bg;
% f2(picture_bg<=127)=To*(1-sqrt(picture_bg(picture_bg<=127)/127.0))+3.0;
% f2(picture_bg>127)=v*(picture_bg(picture_bg>127)-127.0)+3.0;
% 
% 
% X=picture_bg*0.0001+0.115;
% B=m-picture_bg*0.01;
% 
% f1=picture_mg.*X+B;
% 
% JND=p1*(f1+p2)+f2;
% 
% 
% JND=mapminmax(JND,0,255);
% 
% imshow(uint8(JND));



%产生28*7的随机块大小
A=0;B=255;
random_mat=A+(B-A)*rand(28,7);
watermarking_double=repmat(random_mat,228,460);

%旋转水印信息
code_int=0;
if(code_int==0)
    rotation=180.0;
else
    rotation=180.0/16*code_int;
end;
watermarking_double = imrotate(watermarking_double,rotation,'bilinear','crop');
[w,h]=size(watermarking_double);
watermarking=watermarking_double(1:512,1:512);
imshow(uint8(watermarking));