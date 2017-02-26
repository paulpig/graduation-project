I = imread('temp.jpg');  
I = rgb2gray(I);  
%colfilt(I,[31 31],'sliding',@bk)  
% ���ܣ����з�������������Ҳ��ִ�г���������˲���  
% �÷���B = colfilt(A,[m n],block_type,fun)  
% �ú���������һ��ͼ������ڣ��У�ÿһ�ж�Ӧ��������λ��ͼ����ĳ��λ�õ���������Χ�����ء�Ȼ�󽫺���Ӧ���ڸþ����С�  
% [m n]��ʾ��СΪm��n�е�����block_type��ʾ��һ���ַ���������'distinct','sliding'���֣�  
% ����'sliding'��������ͼ����������صػ�����m��n������fun��ʾ������һ���������д���  
% ��������ֵ�Ĵ�С�����ԭͼ���С��ͬ��  

%��ȡ����ͼ�񣬿�������������������ƽ��ֵ��Ϊ������
I2 = uint8(colfilt(I,[31 31],'sliding',@bk));  
imwrite(I2,'1.png');
figure(1),imshow(I2);


%ԭͼ��ȥ����ͼ���Ӷ��ǵù��վ��ȣ��Աȱ���ͼ��ԭͼ����ǿԭͼ�ĶԱȶ�
I3 = minusBk(I,I2);  
figure(2),imshow(I3);
imwrite(I3,'2.png');

%��ֵ���Ȼ���threashold��ֵ��Ҫͨ��OTsu���������
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