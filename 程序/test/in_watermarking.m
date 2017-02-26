%Ƕ��ˮӡ���㷨
function picture_rgb=in_watermarking(picture,code)

%��ȡy����,����ǹؼ����������ȱ��������ģ�8��ȵ�ͼƬû�����ȵġ�����ʹ�ô˷�����
% ycbcr=rgb2ycbcr(picture);
% y=ycbcr(:,:,1);
% picture_gary=double(y);

picture_gary=double(picture);
%Ԥ����80%ѡ��ά���˲���20ѡ��ԭͼ��,�ƻ�ԭͼ�д��ڵ�������
picture_wiener=wiener2(picture_gary);
[width,height]=size(picture_gary);
temp_picture=picture_gary-picture_wiener;
a=ones(width,round(height*0.8));
b=zeros(width,round(height*0.2));
c=[a b];
idx = randperm(numel(c) );
mask = reshape(c(idx),size(c)) ;
suoyin=logical((temp_picture>0).*(mask==1));
picture_gary(suoyin)=picture_wiener(suoyin);

% imshow(uint8(picture_gary));
%����28*7��������С
A=-1;B=1;
random_mat=A+(B-A)*rand(28,7);
watermarking_double=repmat(random_mat,228,460);

%��תˮӡ��Ϣ
code_int=code(1,1)*8+code(1,2)*4+code(1,3)*2+code(1,4);
if(code_int==0)
    rotation=180.0;
else
    rotation=180.0/16*code_int;
end;
watermarking_double = imrotate(watermarking_double,rotation,'bilinear','crop');
[w,h]=size(watermarking_double);
watermarking=watermarking_double(w/2-width/2:width/2+w/2-1,h/2-height/2:height/2+h/2-1);


fid=fopen('rotation.txt','a');
fprintf(fid,'%d  ',rotation);
fclose(fid);
    
    
%JND�ļ���
%1.����ͼ��ļ���
B=[1,1,1,1,1;1,2,2,2,1;1,2,0,2,1;1,2,2,2,1;3,1,1,1,1]/32;
picture_bg=conv2(picture_gary,B,'same');
imshow(uint8(picture_bg));

%2.�������ȵ�����Ȩƽ��picture_mg
G1=[0,0,0,0,0;1,3,8,3,1;0,0,0,0,0;-1,-3,-8,-3,-1;0,0,0,0,0]/16;
G2=[0,0,1,0,0;0,8,3,0,0;1,3,0,-3,-1;0,0,-3,-8,0;0,0,-1,0,0]/16;
G3=[0,0,1,0,0;0,0,3,8,0;-1,-3,0,3,1;0,-8,-3,0,0;0,0,-1,0,0]/16;
%G3=G2;
G4=[0,1,0,-1,0;0,3,0,-3,0;0,8,0,-8,0;0,3,0,-3,0;0,1,0,-1,0]/16;

grad1=conv2(picture_gary,G1,'same');
grad2=conv2(picture_gary,G2,'same');
grad3=conv2(picture_gary,G3,'same');
grad4=conv2(picture_gary,G4,'same');

picture_mg=max(max(max(abs(grad1),abs(grad2)),abs(grad3)),abs(grad4));

imshow(uint8(picture_mg));


%3.����jnd
To=17;
v=3/128;
m=1/2;
p1=2.0;
p2=3.0;

f2=picture_bg;
f2(picture_bg<=127)=To*(1-sqrt(picture_bg(picture_bg<=127)/127.0))+3.0;
f2(picture_bg>127)=v*(picture_bg(picture_bg>127)-127.0)+3.0;


X=picture_bg*0.0001+0.115;
B=m-picture_bg*0.01;

f1=picture_mg.*X+B;

JND=p1*(f1+p2)+f2;


JND=mapminmax(JND,0,1);

imshow(uint8(JND));


%Ƕ��ˮӡ
x1=150;
x2=15;
Y=picture_gary+x1*JND.*watermarking+x2*(1-JND).*watermarking;

imshow(uint8(Y));


%��ycbcrת��ΪRGB
ycbcr(:,:,1)=uint8(Y);
% picture_rgb=ycbcr2rgb(ycbcr);
picture_rgb=Y
imshow(uint8(Y));

% imwrite(picture_rgb,'inWatermarking.bmp');
