%% 计算各个体的路径长度
% 输入：
% D     两两城市之间的距离
% Chrom 个体的轨迹
function len=PathLength(D,Chrom)
[row,col]=size(D);%返回矩阵的行给row，列给col，行和列都是城市个数
NIND=size(Chrom,1);%矩阵Chrom行数，种群个数？
len=zeros(NIND,1);%创建NIND行，1列的0矩阵
for i=1:NIND%为每一个种群计算路径长度
    p=[Chrom(i,:) Chrom(i,1)];%返回第i行，以及第i行第一列；即第i个解+开始城市
    i1=p(1:end-1);%矩阵p的第i个解的记录
    i2=p(2:end);%矩阵p的第i个解的记录中第2个记录+开始城市
    len(i,1)=sum(D((i1-1)*col+i2));%len的第i行的第一个向量是第i个粒子群的路径长度，是矩阵D中N个元素的和，这N个元素所在位置为(i1-1)*col+i2，
end
