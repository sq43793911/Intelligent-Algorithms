%% 成本的最优化计算
% 根据物料清单，依据供货周期的不同，将货物分成了7类，即：7天，15天，30天，45天，60天，90到120天，120天以上。
% 输入变量为订货间隔，单位：天。在主程序中为Chrom,在适应度函数中为H。
% 假设条件：在订购过程中，不允许缺货，在下一个生产周期的前一天到货。
%          订货周期不会变化
%          不存在加班
%          生产过程中的物力，人力成本恒定。
%          生产中每天每类的需求量恒定
%BOM清单中，还有一些单价没有补全，但这只影响总成本的大小，并不影响优化过程，所以可以忽略。
%% 遗传算法求解
%输入：
%NIND    为种群个数
%MAXGEN  为停止代数，遗传到第MAXGEN代时程序停止,MAXGEN的具体取值视问题的规模和耗费的时间而定
%m       为适值淘汰加速指数,最好取为1,2,3,4,不宜太大
%Pc      交叉概率
%Pm      变异概率

%% 版本V6.3
% 更新的原始的订货周期，改成3类。
%更新历史：
%V6.2 修正了成本计算中的一个小问题  11.11
%V6.11-V6.12 更改了原来的订货周期，使其符合一般的粗狂式管理方式。注释完善。  11.11
%V6.0 新版本修改了加班成本的计算方式，使模型更加合理    11.11
%V5.2 增加了原来的订货周期，计算出原来成本以供对比，并在图像中显示  11.11
%V5.1 修正了各类运输成本，使其更符合实际情况     10.11
%V4.1-V5.0 优化遗传参数，使最优值和最优解尽可能合理，尽量不出现局部最优解    10.11
%V4.0 成本计算中增加了缺货成本计算，增加了优化过程图     09.11
%V3.0 成本计算中将固定库存成本改成了变库存的成本计算     08.11
%V2.0 输入数据，输出数据，程序结构完善      07.11
%V1.0 初始版本，为恒定库存成本，恒定人力成本，恒定物力成本，恒定购买成本，变订货成本的总成本计算     05.11

clear
clc
close all

%% 加载数据
% format long
s = xlsread('QYC120-BOM清单.xls'); %读取表格数据
A = 17*6*s(1,9);   %A为各类购买成本
c = 50;          %工人的小时工资
C = 100*17*15*8*c;   %C为生产种的人力成本，假设不缺货，不加班
d = 10000;       %生产一个批次的物力成本
D = 17*d;        %D为生产过程中的物力成本
e = [0.01 0.05 0.1 0.5 1 5 10];   %存储成本
N = 7;             %N为订购分类
t = [500 500 1000 2000 3000 6000 8000];  %运输成本

%% 处理表格数据
%计算各类每批次的需求量
y = size(s,1);
a = zeros(N,1);
for z = 3:y
    if s(z,8)<=7
        a(1) = s(z,6)+a(1);
    elseif s(z,8)>7&&s(z,8)<=15
        a(2) = s(z,6)+a(2);
    elseif s(z,8)>15&&s(z,8)<=30
        a(3) = s(z,6)+a(3);
    elseif s(z,8) == 45
        a(4) = s(z,6)+a(4);
    elseif s(z,8) == 60
        a(5) = s(z,6)+a(5);
    elseif s(z,8)>=90&&s(z,8)<=120
        a(6) = s(z,6)+a(6);
    else
        a(7) = s(z,6)+a(7);
    end
end
%计算每天需求（均值）
w = zeros(N,1);
for x = 1:N
    w(x) = (a(x)*6)/15;    %每类的每天需求
end
%% 遗传参数
NIND=3000;       %种群大小
MAXGEN=200;     %最大遗传代数
Pc=0.9;         %交叉概率
Pm=0.2;        %变异概率
GGAP=0.9;       %代沟
xx=[];
yy=[];
%% 初始化种群
Chrom=InitPop(NIND,N);
%% 优化
gen=0;
ObjV = Kostberechen(A,C,D,t,c,e,w,Chrom);   %计算成本
preObjV=min(ObjV);
for gen=1:MAXGEN
    %% 计算适应度
    ObjV = Kostberechen(A,C,D,t,c,e,w,Chrom);  %#ok<*PFTIN> %计算成本
    preObjV=min(ObjV);
    FitnV=Fitness(ObjV);
    %% 选择
    SelCh=Select(Chrom,FitnV,GGAP);
    %% 交叉操作
    SelCh=Recombin(SelCh,Pc);
    %% 变异
    SelCh=Mutate(SelCh,Pm);
    %% 逆转操作
    SelCh=Reverse(SelCh,D,A,C,t,c,e,w);
    %% 重插入子代的新种群
    Chrom=Reins(Chrom,SelCh,ObjV);
    %% 更新成本
    xx=[xx;preObjV];
     if gen >20
        yy=[yy;mean(ObjV)];
     end
end


ObjV = Kostberechen(A,C,D,t,c,e,w,Chrom);  %计算成本
[minObjV,minInd]=min(ObjV);
BsM = zeros(1,7);
for i = 1:N
    BsM(i)=Chrom(1,i)*w(i);
end
H = [60 60 60 90 90 160 160; 30 30 30 60 60 90 160; 15 15 30 60 60 90 160 ];      %原来的订货周期

K = Kostberechen(A,C,D,t,c,e,w,H); %原来的成本
%% 画图
figure
X = 1:MAXGEN;
XX = 21:MAXGEN;
XXX = [50 100 150];
p=plot(X,xx,'g',XX,yy,'b',XXX,K,'r*');
xlabel('迭代次数')
ylabel('成本')
title('优化过程')
%p(1).Marker = 'o';
p(2).Marker = 'v';

