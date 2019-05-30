function bestlinefusion(A, B, rowBegin, rowEnd, colBegin, colEnd, isPano)
%��ͼ��ƴ�ӵĸĽ��㷨����ѷ�����㷨 ͼ���ں�
%�ȸ���֮ǰ�õ���H��������ص�����Rect
% A = imread(A);
% B = imread(B);
% figure(1);
% subplot(121);
% imshow(A);
% subplot(122);
% imshow(B);
[H,W,~]=size(A);
[HB, WB, ~]=size(B);
L=colBegin;
R=colEnd;
margin= R - L + 1;
%sprintf('L=%d, R=%d, margin=%d', L, R, margin)
% ����õ��ص�����Ĳ�ֵͼ�� ?��ʵ�Ҳ��������ֵͼ����� ?ֻҪ�����ص�����Ĵ�С�ͺ��� Ϊʲô��Ҫ�����ֵͼ ������û�õ�
% Rect=zeros(H, margin);
% for i=rowBegin:rowEnd-1
%     for j=L:R
%         row = i-rowBegin+1;
%         col = j-L+1;
% %         sprintf('row=%d, col=%d, L=%d, R=%d', row, col, L, R)
%         tempA = A(i,j);
%         tempB = B(row,col);
%         Rect(i,col)=tempA-tempB;
%     end
% end
% Rect=uint8(Rect);%���Ҫ��Ҫ�أ�
% figure(2);
% imshow(Rect);
% �����ں�ͼ�Ĵ�С
if isPano == 1
    newW = W;
   
else
    newW = 2*W - margin + 1;
end
%sprintf('newW=%d', newW)
result = zeros(H, newW);
%��·���ľ���
path=zeros(H, margin);
%��ǿ��ֵ ÿ��·����ǿ��ֵstrength=color^2+geometry
color=zeros(1,margin);
geometry=zeros(1,margin);
strength1=zeros(1,margin);
strength2=zeros(1,margin);
%�����һ�м���ʼ����ǿ��ֵ
for j=L:R
    y=j-L+1;
    color(y)=A(rowBegin,j)-B(1,y);
    if(y==1)
        Bxdao=B(1,y+1)+2*B(2,y+1);
        Bydao=B(2,y)+2*B(2,y+1);
        Aydao=2*A(rowBegin + 1,j-1)+A(rowBegin + 1,j)+2*A(rowBegin + 1,j+1);
        Axdao=A(rowBegin,j+1)+2*A(rowBegin + 1,j+1)-A(rowBegin,j-1)-2*A(rowBegin + 1,j-1);
        geometry(y)=(Axdao-Bxdao)*(Aydao-Bydao);
        strength1(y)=color(y)^2+geometry(y);
        path(rowBegin,y)=y;
        continue;
    end
    if(j==R)
        Axdao=A(rowBegin,j-1)-2*A(rowBegin+1,j-1);
        Aydao=2*A(rowBegin+1,j-1)+A(rowBegin+1,j);
        Bxdao=B(1,y+1)+2*B(2,y+1)-B(1,y-1)-2*B(2,y-1);
        Bydao=2*B(2,y-1)+B(2,y)+2*B(2,y+1);
        geometry(y)=(Axdao-Bxdao)*(Aydao-Bydao);
        strength1(y)=color(y)^2+geometry(y);
        path(rowBegin,y)=y;
        continue;
    end
    Axdao=A(rowBegin,j+1)+2*A(rowBegin+1,j+1)-A(rowBegin,j-1)-2*A(rowBegin+1,j-1);
    Bxdao=B(1,y+1)+2*B(2,y+1)-B(1,y-1)-2*B(2,y-1);
    Aydao=2*A(rowBegin+1,j-1)+A(rowBegin+1,j)+2*A(rowBegin+1,j+1);
    Bydao=2*B(2,y-1)+B(2,y)+2*B(2,y+1);
    geometry(y)=(Axdao-Bxdao)*(Aydao-Bydao);
    strength1(y)=color(y)^2+geometry(y);
    path(rowBegin,y)=y;
end
color=zeros(1,margin);
geometry=zeros(1,margin);
small=0;

%��ʼ��չ ����һ�� �ӵڶ��е������ڶ��� ���һ�е����ó��� ���һ��һ�� ��Ϊ���Ľṹ��ֵgeometry������
for i=rowBegin + 1:rowEnd - 1
    %�Ȱ���һ�е�ǿ��ֵȫ��������� ��ʱ����Ҫ�Ƚ����������ó�������
    for j=L:R
        x=i-rowBegin+1;
        y=j-L+1;
%         sprintf('(i=%d, j=%d), (x=%d, y=%d)', i, j, x, y)
        color(y)=A(i,j)-B(x,y);
        if(y==1)
            Axdao=2*A(i-1,j+1)+A(i,j+1)+2*A(i+1,j+1)-2*A(i-1,j-1)-A(i,j-1)-2*A(i+1,j-1);
            Bxdao=2*B(x-1,y+1)+B(x,y+1)+2*B(x+1,y+1);
            Aydao=-2*A(i-1,j-1)-A(i-1,j)-2*A(i-1,j+1)+2*A(i+1,j-1)+A(i+1,j)+2*A(i+1,j+1);
            Bydao=-B(x-1,y)-2*B(x-1,y+1)+B(x+1,y)+2*B(x+1,y+1);
            geometry(y)=(Axdao-Bxdao)*(Aydao-Bydao);
            strength2(y)=color(y)^2+geometry(y);
            continue;
        end
        if(j==R)
            Axdao=-2*A(i-1,j-1)-A(i,j-1)-2*A(i+1,j-1);
            Bxdao=2*B(x-1,y+1)+B(x,y+1)+2*B(x+1,y+1)-2*B(x-1,y-1)-B(x,y-1)-2*B(x+1,y-1);
            Aydao=-2*A(i-1,j-1)-A(i-1,j)+2*A(i+1,j-1)+A(i+1,j);
            Bydao=-2*B(x-1,y-1)-B(x-1,y)-2*B(x-1,y+1)+2*B(x+1,y-1)+B(x+1,y)+2*B(x+1,y+1);
            geometry(y)=(Axdao-Bxdao)*(Aydao-Bydao);
            strength2(y)=color(y)^2+geometry(y);
            continue;
        end
        Axdao=2*A(i-1,j+1)+A(i,j+1)+2*A(i+1,j+1)-2*A(i-1,j-1)-A(i,j-1)-2*A(i+1,j-1);
        Bxdao=2*B(x-1,y+1)+B(x,y+1)+2*B(x+1,y+1)-2*B(x-1,y-1)-B(x,y-1)-2*B(x+1,y-1);
        Aydao=-2*A(i-1,j-1)-A(i-1,j)-2*A(i-1,j+1)+2*A(i+1,j-1)+A(i+1,j)+2*A(i+1,j+1);
        Bydao=-2*B(x-1,y-1)-B(x-1,y)-2*B(x-1,y+1)+2*B(x+1,y-1)+B(x+1,y)+2*B(x+1,y+1);
        geometry(y)=(Axdao-Bxdao)*(Aydao-Bydao);
        strength2(y)=color(y)^2+geometry(y);
    end
    for j=1:margin
        if(path(i-1,j)==1)
            if(strength2(1)<strength2(2))
                strength1(j)=strength1(j)+strength2(1);
                path(i,j)=1;
            else
                strength1(j)=strength1(j)+strength2(2);
                path(i,j)=2;
            end
        else
            if(path(i-1,j)==margin)
                if(strength2(margin-1)<strength2(margin))
                    strength1(j)=strength1(j)+strength2(margin-1);
                    path(i,j)=margin-1;
                else
                    strength1(j)=strength1(j)+strength2(margin);
                    path(i,j)=margin;
                end
            else
                if(strength2(path(i-1,j)-1)<strength2(path(i-1,j)))
                    if(strength2(path(i-1,j)-1)<strength2(path(i-1,j)+1))
                        small=strength2(path(i-1,j)-1);
                        path(i,j)=path(i-1,j)-1;
                    else
                        small=strength2(path(i-1,j)+1);
                        path(i,j)=path(i-1,j)+1;
                    end
                else
                    if(strength2(path(i-1,j))<strength2(path(i-1,j)+1))
                        small=strength2(path(i-1,j));
                        path(i,j)=path(i-1,j);
                    else
                        small=strength2(path(i-1,j)+1);
                        path(i,j)=path(i-1,j)+1;
                    end
                end
                strength1(j)=strength1(j)+small;
            end
        end
        small=0;
    end
    strength2=zeros(1,margin);
    color=zeros(1,margin);
    geometry=zeros(1,margin);
end
%�����������һ��
i=rowEnd;
x=i-rowBegin+1;  % ��֤��1��ʼ
for j=L:R
    y=j-L+1;
    color(y)=A(i,j)-B(x,y);
    if(y==1)
        Axdao=2*A(i-1,j+1)+A(i,j+1)-2*A(i-1,j-1)-A(i,j-1);
        Aydao=-2*A(i-1,j-1)-A(i-1,j)-2*A(i-1,j+1);
        Bxdao=2*B(x-1,y+1)+B(x,y+1);
        Bydao=-B(x-1,y)-2*B(x-1,y+1);
        continue;
    end
    if(j==R)
        Bxdao=2*B(x-1,y+1)+B(x,y+1)-2*B(x-1,y-1)-B(x,y-1);
        Bydao=-2*B(x-1,y-1)-B(x-1,y)-2*B(x-1,y+1);
        Axdao=-2*A(i-1,j-1)-A(i,j-1);
        Aydao=-2*A(i-1,j-1)-A(i-1,j);
        continue;
    end
    Axdao=2*A(i-1,j+1)+A(i,j+1)-2*A(i-1,j-1)-A(i,j-1);
    Bxdao=2*B(x-1,y+1)+B(x,y+1)-2*B(x-1,y-1)-B(x,y-1);
    Aydao=-2*A(i-1,j-1)-A(i-1,j)-2*A(i-1,j+1);
    Bydao=-2*B(x-1,y-1)-B(x-1,y)-2*B(x-1,y+1);
    geometry(y)=(Axdao-Bxdao)*(Aydao-Bydao);
    strength2(y)=color(y)^2+geometry(y);
end
for j=1:margin
    if(path(i-1,j)==1)
        if(strength2(1)<strength2(2))
            strength1(j)=strength1(j)+strength2(1);
            path(i,j)=1;
        else
            strength1(j)=strength1(j)+strength2(2);
            path(i,j)=2;
        end
    else
        if(path(i-1,j)==margin)
            if(strength2(margin-1)<strength2(margin))
                strength1(j)=strength1(j)+strength2(margin-1);
                path(i,j)=margin-1;
            else
                strength1(j)=strength1(j)+strength2(margin);
                path(i,j)=margin;
            end
        else
            if(strength2(path(i-1,j)-1)<strength2(path(i-1,j)))
                if(strength2(path(i-1,j)-1)<strength2(path(i-1,j)+1))
                    small=strength2(path(i-1,j)-1);
                    path(i,j)=path(i-1,j)-1;
                else
                    small=strength2(path(i-1,j)+1);
                    path(i,j)=path(i-1,j)+1;
                end
            else
                if(strength2(path(i-1,j))<strength2(path(i-1,j)+1))
                    small=strength2(path(i-1,j));
                    path(i,j)=path(i-1,j);
                else
                    small=strength2(path(i-1,j)+1);
                    path(i,j)=path(i-1,j)+1;
                end
            end
            strength1(j)=strength1(j)+small;
        end
    end
    small=0;
end
% �Ƚ�strength1��ŵ�ÿ��·����ǿ��ֵ���ܺ� ˭��С ��ѡpath�ж�Ӧ����һ�е�·��

[minzhi,minth]=min(strength1);
mypath=path(:,minth);
% mypath�ŵľ�����ѷ����ѡ����·�� ����·�������ǲο�ͼA �ұ���Ŀ��ͼB
for i=1:H
    % copy A
    for j=1:mypath(i)+L-1
        result(i,j,1)=A(i,j,1);
        result(i,j,2)=A(i,j,2);
        result(i,j,3)=A(i,j,3);
    end
    % copy B
    for j=mypath(i)+L-1:newW-1
        x=i;
        if x > HB
            %sprintf('x=%d, HB=%d', x, HB)
            continue;
        end
        y=j-L+1;
        if y > WB
            %sprintf('y=%d, HW=%d', y, WB)
            continue;
        end
%         sprintf('x=%d, y=%d', x, y)
        temp1 = B(x,y,1);
        temp2 = B(x,y,2);
        temp3 = B(x,y,3);
        result(i,j,1)=temp1;
        result(i,j,2)=temp2;
        result(i,j,3)=temp3;
%         if isPano == 1
%             result(i+rowBegin,j,1)=temp1;
%             result(i+rowBegin,j,2)=temp2;
%             result(i+rowBegin,j,3)=temp3;
%         else
%             result(i,j,1)=temp1;
%             result(i,j,2)=temp2;
%             result(i,j,3)=temp3;
%         end
    end
end

result=uint8(result);
figure('Name', '��ѷ�����ںϽ��');
imshow(result);
imwrite(result, 'result.jpg');
title('��ѷ�����ںϽ��');
size_A = size(A);
size_B = size(B);
size_result = size(result);
%sprintf('A.shape=(%d, %d), B.shape=(%d, %d), result.shape=(%d, %d)',size_A(1), size_A(2), size_B(1), size_B(2), size_result(1),size_result(2))
for i=rowBegin:rowEnd-1
    x = i-rowBegin+1;
    result(i,L+mypath(x),1)=0;
    result(i,L+mypath(x),2)=255;
    result(i,L+mypath(x),3)=0;
end
figure('Name', '��ѷ����');
imshow(result);
imwrite(result, 'bestfusion_result_1.jpg');
title('��ѷ����');