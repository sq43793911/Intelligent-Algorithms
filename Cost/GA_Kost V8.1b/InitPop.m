%% ��ʼ����Ⱥ
%���룺
% NIND����Ⱥ��С
% N��   ����Ⱦɫ�峤��  
%�����
%��ʼ��Ⱥ
function Chrom=InitPop(NIND,N,u,BsP)
Chrom=zeros(NIND,N);%���ڴ洢��Ⱥ
%h=[8 16 31 46 61 91];
for i=1:N
    Chrom(:,i)=randi([round(BsP(i)),u(i)],NIND,1);%������ɳ�ʼ��Ⱥ
end