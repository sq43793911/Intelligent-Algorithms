%% 初始化种群
%输入：
% NIND：种群大小
% N：   个体染色体长度  
%输出：
%初始种群
function Chrom=InitPop(NIND,N)
Chrom=zeros(NIND,N);%用于存储种群
%=[5 7 10 15 20 30];
for i=1:N
    Chrom(:,i)=randi([1,255],NIND,1);%随机生成初始种群
end