%% ��ʼ����Ⱥ
%���룺
% NIND����Ⱥ��С
% N��   ����Ⱦɫ�峤��  
%�����
%��ʼ��Ⱥ
function Chrom=InitPop(NIND,N)
Chrom=zeros(NIND,N);%���ڴ洢��Ⱥ
%=[5 7 10 15 20 30];
for i=1:N
    Chrom(:,i)=randi([1,255],NIND,1);%������ɳ�ʼ��Ⱥ
end