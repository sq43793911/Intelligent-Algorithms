%% 成本的最优化计算
% 根据物料清单，依据供货周期的不同，将货物分成了7类，即：7天，15天，30天，45天，60天，90到120天，120天以上。
% 输入变量为订货量，单位：件。在主程序中为Chrom,在适应度函数中为H。
% 假设条件：订货周期不会变化
%          生产过程中的物力，人力成本恒定。
%          生产中每天每类的需求量恒定
%          每类的运输成本和仓储成本不同，但每一次运输的物力和人力成本相同。
%          暂时不考虑半成品的仓储成本。
%          允许缺货，但要在规定期限内交货，工人存在加班。
%BOM清单中，还有一些单价没有补全，但这只影响总成本的大小，并不影响优化过程，所以可以忽略。
%% 遗传算法求解
%输入：
%NIND    为种群个数
%MAXGEN  为停止代数，遗传到第MAXGEN代时程序停止,MAXGEN的具体取值视问题的规模和耗费的时间而定
%m       为适值淘汰加速指数,最好取为1,2,3,4,不宜太大
%Pc      交叉概率
%Pm      变异概率

%% 版本 V9.2b
% 每个货物单独计算，修订成本计算逻辑，修订成本参数
%更新历史：
%V8.2a 修正运输成本，缺货成本
%V8.0a 按照ABC分类法重新分类，此程序计算B类，使用订货量为变量
%V7.1 修改变量名
%V7.0 将输入变量更改为订货量，修正成本计算模型，修正计算参数。
%V6.3 更新的原始的订货周期，改成3类。
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
BOM = xlsread('QYC120-BOM清单合并后.xls'); %读取表格数据

L = 50;          %工人的小时工资
TL = 12*17*15*8*L;   %C为生产种的人力成本，假设不缺货，不加班
FK = 10000;       %生产一个批次的物力成本
TFK = 17*FK;        %D为生产过程中的物力成本
LB = [0.05 0.10 0.15 0.25 0.50 0.75 1.5 5 10];   %存储成本,每类的每天存储费：元/个
N = 48;             %N为订购分组
TB = [500 700 1000 1500 3000 4000 5000 7000 10000];  %运输成本
VST = 5;        %安全提前期，满足该参数天数生产的需要
minni = [7 10 15 20 30 45 60 90 160];    %每类的最低订货周期，低于这个周期则会产生缺货

%% ABC 分类
[a,b] = size(BOM);
c = zeros(3,1);
d = zeros(3,1);
for i = 3:a
    if c(1)<=0.85
    c(1) = BOM(i,12)+c(1);
    d(1)=d(1)+1;
    else
        if c(2)<=0.1385
            c(2) = BOM(i,12)+c(2);
            d(2)=d(2)+1;
        else
            c(3) = BOM(i,12)+c(3);
            d(3)=d(3)+1;
        end
    end
end
BOMA = [];
BOMB = [];
BOMC = [];
for e = 3:a
    if e<=10
        BOMA = [BOMA;BOM(e,:)];
    elseif e>=11 && e<=58
        BOMB = [BOMB;BOM(e,:)];
    else
        BOMC = [BOMC;BOM(e,:)];
    end
end
%% 处理表格数据
%计算A类每批次每车的需求量
g = size(BOMB,1);
f = zeros(N,1);
AG = 0;
for z = 1:g
    if BOMB(z,9)==7
        f(1) = BOMB(z,6)+f(1);
    elseif BOMB(z,9)==10
        f(2) = BOMB(z,6)+f(2);
    elseif BOMB(z,9)==15
        f(3) = BOMB(z,6)+f(3);
    elseif BOMB(z,9)==20
        f(4) = BOMB(z,6)+f(4);
    elseif BOMB(z,9)==30
        f(5) = BOMB(z,6)+f(5);
    elseif BOMB(z,9)==45
        f(6) = BOMB(z,6)+f(6);
    elseif BOMB(z,9)==60
        f(7) = BOMB(z,6)+f(7);
    elseif BOMB(z,9)==90
        f(8) = BOMB(z,6)+f(8);
    else
        f(9) = BOMB(z,6)+f(9);
    end
    AG = BOMB(z,11)+AG;
end
AG=AG*100;

%计算每天需求（均值）;计算每类的总需求量;计算每类订货点
TA = zeros(N,1);
BtAF = zeros(N,1);
S = zeros(N,1);
BsP = zeros(1,N);
for x = 1:N
    BtAF(x) = (BOMB(x,6)*6)/15;    %每类的每天需求
    TA(x)=BOMB(x,6)*6*102;       %计算每类的总需求
    S(x)=VST*BtAF(x);       %每类的安全库存量
    if BOMB(x,9)==7
        BsP(x) = minni(1)*BtAF(x)+S(x);   % 每类的订货点
    elseif BOMB(x,9)==10
        BsP(x) = minni(2)*BtAF(x)+S(x);   % 每类的订货点
    elseif BOMB(x,9)==15
        BsP(x) = minni(3)*BtAF(x)+S(x);   % 每类的订货点
    elseif BOMB(x,9)==20
        BsP(x) = minni(4)*BtAF(x)+S(x);   % 每类的订货点
    elseif BOMB(x,9)==30
        BsP(x) = minni(5)*BtAF(x)+S(x);   % 每类的订货点
    elseif BOMB(x,9)==45
        BsP(x) = minni(5)*BtAF(x)+S(x);   % 每类的订货点
    elseif BOMB(x,9)==60
        BsP(x) = minni(5)*BtAF(x)+S(x);   % 每类的订货点
    elseif BOMB(x,9)==90
        BsP(x) = minni(5)*BtAF(x)+S(x);   % 每类的订货点
    else
        BsP(x) = minni(9)*BtAF(x)+S(x);   % 每类的订货点
    end
    %BsP(x) = minni(1)*BtAF(x)+S(x);   % 每类的订货点
end
%% 遗传参数
NIND=500;       %种群大小
MAXGEN=200;     %最大遗传代数
Pc=0.9;         %交叉概率
Pm=0.3;        %变异概率
GGAP=0.8;       %代沟
xx=[];
yy=[];
%% 初始化种群
Chrom=InitPop(NIND,N,TA,BsP);
%% 优化
gen=0;
ObjV = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BOMB,Chrom);   %计算成本
preObjV=min(ObjV);
for gen=1:MAXGEN
    %% 计算适应度
    ObjV = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BOMB,Chrom);  %计算成本
    preObjV=min(ObjV);
    FitnV=Fitness(ObjV);
    %% 选择
    SelCh=Select(Chrom,FitnV,GGAP);
    %% 交叉操作
    SelCh=Recombin(SelCh,Pc);
    %% 变异
    SelCh=Mutate(SelCh,Pm);
    %% 逆转操作
    SelCh=Reverse(SelCh,TFK,AG,TL,S,TB,L,LB,BtAF,TA,BOMB);
    %% 重插入子代的新种群
    Chrom=Reins(Chrom,SelCh,ObjV);
    %% 更新成本
    xx=[xx;preObjV];
    yy=[yy;mean(ObjV)];
end

ObjV = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BOMB,Chrom);  %计算成本
[minObjV,minInd]=min(ObjV);  %minObjV-最低成本;minInd-最低序号
Best = Chrom(minInd,:);      %最优解
save('最优订货量.mat','Best');
save('最优成本.mat','minObjV');
% H = [20000 100 100 300 500];      %原来的订货量

% K = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BOMA,H); %原来的成本
%% 画图
figure
X = 1:MAXGEN;
XX = 1:MAXGEN;
% XXX = 150;
p=plot(X,xx,'g',XX,yy,'b');   %,XXX,K,'r*');
xlabel('迭代次数')
ylabel('成本')
title('优化过程')
%p(1).Marker = 'o';
p(2).Marker = 'v';

