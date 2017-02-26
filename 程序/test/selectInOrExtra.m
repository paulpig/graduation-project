function selectInOrExtra(select,path)
%�ֽ�ͼ��ָ�ɾſ�
picture=imread(path);
[WIDTH,HEIGH,channel]=size(picture)
N=31;
K=26;
code_extra=[];

if(select==0)
    %��������룬������0
    code=randint(1,26);
    hamming_code=uint8([encode(code,N,K),0]);

    %д���ļ���Ϊ��֮����֤
    fid=fopen('in_information.txt','w');
    fprintf(fid,'%d',hamming_code);
    fclose(fid);
end

if(select==0)
    delete('rotation.txt');
end;

for i=1:3
    for j=1:3
        %ѡ��Ƕ�뻹����ȡˮӡ
        if(select ==0 )
            %Ƕ��ˮӡ,Ƕ�����ÿ����Ϣ�����һ��Ϊ���ÿ�,����Ϊ0000
            if(i==3 && j==3)
                picture_rgb=in_watermarking(picture(fix((i-1)*WIDTH/3)+1:fix((i)*WIDTH/3),fix((j-1)*HEIGH/3)+1:fix(j*HEIGH/3),:),[0,0,0,0]);
                [h,w,c]=size(picture_rgb);
                padding=10;
                picture(fix((i-1)*WIDTH/3)+1+padding:fix((i)*WIDTH/3)-padding,fix((j-1)*HEIGH/3)+1+padding:fix(j*HEIGH/3)-padding,:)=picture_rgb(padding+1:h-padding,padding+1:w-padding,:);
                continue;
            else
                %imshow(picture(fix((i-1)*WIDTH/3)+1:fix(i*WIDTH/3),fix((j-1)*HEIGH/3)+1:fix(j*HEIGH/3),:));
                picture_rgb=in_watermarking(picture(fix((i-1)*WIDTH/3)+1:fix((i)*WIDTH/3),fix((j-1)*HEIGH/3)+1:fix(j*HEIGH/3),:),hamming_code(12*i+4*j-15:12*i+4*j-12));
                [h,w,c]=size(picture_rgb);
                padding=10;
                picture(fix((i-1)*WIDTH/3)+1+padding:fix((i)*WIDTH/3)-padding,fix((j-1)*HEIGH/3)+1+padding:fix(j*HEIGH/3)-padding,:)=picture_rgb(padding+1:h-padding,padding+1:w-padding,:);
               
            end
        else
            %��ȡˮӡ
             code_bin=extra_watermasking(picture(fix((i-1)*WIDTH/3)+1:fix((i)*WIDTH/3),fix((j-1)*HEIGH/3)+1:fix(j*HEIGH/3),:),3*i-3+j);
             code_extra=[code_extra code_bin];
        end;
    end
end

if(select==0)
    imwrite(picture,'inWatermarking.bmp');
else
    temp=[];
    for i=1:31
        temp=[temp,str2num(code_extra(i))];
    end;
    input_temp=double(temp');
    [msg]=decode(input_temp, N,K);
    %a=2;
end;

