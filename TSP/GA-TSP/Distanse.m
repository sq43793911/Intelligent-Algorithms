%% ������������֮��ľ���
%���� a  �����е�λ������
%��� D  ��������֮��ľ���
function D=Distanse(a)
row=size(a,1);%���ؾ���a������
D=zeros(row,row);%����0����
for i=1:row%ѭ������i-j�����
    for j=i+1:row
        D(i,j)=((a(i,1)-a(j,1))^2+(a(i,2)-a(j,2))^2)^0.5;
        D(j,i)=D(i,j);
    end
end