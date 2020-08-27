function K = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BsM) %成本计算，ga中的适应性函数
%% 基本思路
%订货的周期固定，一次订货满足一个周期的生产需要。
%一共生产255天
%H为每类的订货量，根据供货周期进行分类，共7类
%每日库存是根据每日消耗相应减少的，库存变化：w*H*2+w*(H-1)*...w*1
%每类运输成本为订货次数乘每次的成本，然后7类相加

%% 成本计算
[NIND, N]= size(BsM);
K = zeros(NIND,1);
minBT = [7 15 30 45 60 120 160];    %每类的最低订货周期，低于这个周期则会产生缺货
%% 每类的最低订货量
minimium = zeros(N,1);
for a = 1:N
    minimium(a) = minBT(a)*BtAF(a);
end
%% 种群内循环
for i = 1:NIND
    %% 各参数初始化
    MK = 0;
    b = zeros(1,N);
    TLK = 0;
    c = zeros(1,N);
    d = zeros(1,N);
    e = zeros(N,1);
    TTK = 0;
    Tag = zeros(N,1);
    %% 计算库存成本
    for f = 1:N  
        e(f) = TA(f)/BsM(i,f);    %每类的订货次数
        Tag(f) = BsM(i,f)/BtAF(f);
        if BsM(i,f) >=  minimium(f)      %如果不缺货
                for g = 1:Tag(f)
                    b(f) = LB(f)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
        else                    %如果缺货
            c(f) = minimium(f)-BsM(i,f);
            d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %各类加班的人力成本
            MK = d(f)+MK;                 %总加班成本
                for h = 1:Tag(f)
                    b(f) = LB(f)*(BsM(i,f)-h*BtAF(f))+b(f);
                end
        end
        TLK = b(f)*e(f)+TLK;        %总库存成本
    %% 订单成本计算，t为各类的运输成本；c为工人小时工资，这里假设一次订货需要2人，一小时。
    
        TTK = e(f)*(TB(f)+2*L) + TTK;   %订货成本加和

     end 
    K(i,1) = AG + TTK + TL + TFK + TLK + MK;    %总成本加和
end