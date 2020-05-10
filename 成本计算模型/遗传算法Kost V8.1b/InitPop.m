%% 初始化种群
%输入：
% NIND：种群大小
% N：   个体染色体长度  
%输出：
%初始种群
function Chrom=InitPop(NIND,N,u,BsP)
Chrom=zeros(NIND,N);%用于存储种群
%h=[8 16 31 46 61 91];
for i=1:N
    Chrom(:,i)=randi([round(BsP(i)),u(i)],NIND,1);%随机生成初始种群
end