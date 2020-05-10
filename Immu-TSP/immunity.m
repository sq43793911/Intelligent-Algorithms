clear all;
clc;

load CityPosition3.mat
N=size(citys,1);%城市个数
M=40;
%种群个数
pos=citys;            %randn(N,2);


    
%生成城市坐标
global D;
%城市距离数据
 
D=zeros(N,N);
for i=1:N
    for j=i+1:N
        dis=(pos(i,1)-pos(j,1)).^2+(pos(i,2)-pos(j,2)).^2;
        D(i,j)=dis^(0.5);
        D(j,i)=D(i,j);
    end
end

%中间结果保存
global TmpResult;
TmpResult=[];
global TmpResult1;
TmpResult1=[];


%参数设定
%[M,N]=size(D);%群体规模
pCharChange=1;%字符换位概率
pStrChange=0.4;%字符串移位概率
pStrReverse=0.4;%字符串逆转概率
pCharReCompose=0.4;%字符重组概率
MaxIterateNum=200;%最大迭代次数
b = 50; %总循环次数
c=zeros(b,1); %到达最短的迭代次数集合
BSF=zeros(b,N);
mRandM=zeros(b,N);%最优路径
bsf_result = zeros(b,1); %最短路径集合
t=zeros(b,1); %运行时间集合

for a=1:b  %下一步使用palfor
tic
xx=[];
%数据初始化
mPopulation=zeros(M,N);

for rol=1:M;
    mPopulation(rol,:)=randperm(N);%产生初始抗体
    mPopulation(rol,:)=DisplaceInit(mPopulation(rol,:));%预处理
end

%迭代
count=0;

while count<MaxIterateNum
    %产生新抗体
    B=Mutation(mPopulation,[pCharChange pStrChange pStrReverse pCharReCompose]);
    %计算所有抗体的亲和力、所有抗体和最优抗体的排斥力
    [mPopulation,xx]=SelectAntigen(mPopulation,B,xx);
    %hold on
    %plot(count,TmpResult(end),'.');
    %drawnow
%     display(TmpResult(end));
%         display(TmpResult1(end));
    count=count+1;
    mRandM(a,:) = mPopulation(end,:);
end

[bsf,c(a,:)] = min(xx);

% figure;
% 
% hold on
% plot(bsf,'-r');
% title('最佳适应度变化趋势')
% xlabel('迭代数')
% ylabel('最佳适应度')

bsf_result(a,:) = bsf;

%MaxIterateNum = MaxIterateNum + a;

BSF(a,:) = mRandM(a,:);
%DrawPath(BSF(a,:),citys);
t(a,:)=toc;
end

bsf_best = min(bsf_result);
