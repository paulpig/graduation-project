function selectInOrExtra(select,path)
%现将图像分割成九块
picture=imread(path);
[WIDTH,HEIGH,channel]=size(picture)
N=31;
K=26;
code_extra=[];

if(select==0)
    %哈明码编码，最后加上0
    code=randint(1,26);
    hamming_code=uint8([encode(code,N,K),0]);

    %写入文件中为了之后验证
    fid=fopen('in_information.txt','w');
    fprintf(fid,'%d',hamming_code);
    fclose(fid);
end

if(select==0)
    delete('rotation.txt');
end;

for i=1:3
    for j=1:3
        %选择嵌入还是提取水印
        if(select ==0 )
            %嵌入水印,嵌入引用快的信息，最后一块为引用块,编码为0000
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
            %提取水印
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

