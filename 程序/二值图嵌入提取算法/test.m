% m=zeros(100,100)
% m(:,50)=1;
% % m(20,:)=1;
% % m(30,:)=1; 
% z=abs(fftshift((fft2(m))))
% imshow(z);


m2=zeros(100,100)
m2(50,:)=1;
% m(20,:)=1;
% m(30,:)=1; 
z2=idct(m2)
aaa=im2uint8(z2)
imshow(aaa);


A1=imread('2.png'); %����ͼƬ
A1=255-rgb2gray(A1)
thresh1 = graythresh(A1);     %�Զ�ȷ����ֵ����ֵ
I21 = im2bw(A1,thresh1);       %��ͼ���ֵ��
B1=fftshift((dct2(I21))); % ���и���Ҷ�任
figure(1)
imshow(B1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A=imread('1.png'); %����ͼƬ
A=rgb2gray(A)
thresh = graythresh(A);     %�Զ�ȷ����ֵ����ֵ
I2 = ~im2bw(A,thresh);       %��ͼ���ֵ��
z2=idct(double(I2))
lll=im2uint8(z2)
figure(2)
imshow(lll);


pic=A1+lll;
result=fftshift((dct2(pic))); % ���и���Ҷ�任
figure(3)
imshow(result);



get=m2.*result
figure(4)
imshow(get)
figure(5)
imshow(m2)
% figure(4)
% B4=B+B1
% imshow(B4)


[r,p] = corrcoef(I2,get) %Compute sample correlation and p-values.
d=det(r)
