function K = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BOMB,BsM) %成本计算，ga中的适应性函数
%% 基本思路
%订货的周期固定，一次订货满足一个周期的生产需要。
%一共生产255天
%H为每类的订货量，根据供货周期进行分类，共7类
%每日库存是根据每日消耗相应减少的，库存变化：w*H*2+w*(H-1)*...w*1
%每类运输成本为订货次数乘每次的成本，然后7类相加

%% 成本计算
[NIND, N]= size(BsM);
K = zeros(NIND,1);
minBT = [7 10 15 20 30 45 60 90 160];    %每类的最低订货周期，低于这个周期则会产生缺货
MB = [5000 10000 20000 30000 40000 50000 60000 80000 100000];
%% 每类的最低订货量
minimium = zeros(9,1);
% for a = 1:N
%     minimium(a) = minBT(a)*BtAF(a);
% end
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
    MG = zeros(N,1);
    TMG = 0;
    %% 计算库存成本
    for f = 1:N  
        e(f) = TA(f)/BsM(i,f);    %每类的订货次数
        Tag(f) = BsM(i,f)/BtAF(f);
        if BOMB(f,9)==7    % 1
            minimium(1) = minBT(1)*BtAF(f);
            if BsM(i,f) >=  minimium(1)      %如果不缺货
                for g = 1:Tag(f)
                    b(f) = LB(1)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %如果缺货
                c(f) = minimium(1)-BsM(i,f);
                d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %各类加班的人力成本
                MG(f) = (c(f)/BtAF(f))*MB(1);
                TMG = MG(f)+TMG;
                %d(f) = 0.1*TL;
                MK = d(f)+MK;                 %总加班成本
                    for h = 1:Tag(f)
                        b(f) = LB(1)*(BsM(i,f)-h*BtAF(f))+b(f);
                    end
            end
            TLK = b(f)*e(f)+TLK;        %总库存成本
        %% 订单成本计算，t为各类的运输成本；c为工人小时工资，这里假设一次订货需要2人，一小时。
    
            TTK = e(f)*(TB(1)+2*L) + TTK;   %订货成本加和

      
        %% 45
        elseif BOMB(f,9)==10   %2
            minimium(2) = minBT(2)*BtAF(f);
            if BsM(i,f) >=  minimium(2)      %如果不缺货
                for g = 1:Tag(f)
                    b(f) = LB(2)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %如果缺货
                c(f) = minimium(2)-BsM(i,f);
                d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %各类加班的人力成本
                MG(f) = (c(f)/BtAF(f))*MB(2);
                TMG = MG(f)+TMG;
                %d(f) = 0.1*TL;
                MK = d(f)+MK;                 %总加班成本
                    for h = 1:Tag(f)
                        b(f) = LB(2)*(BsM(i,f)-h*BtAF(f))+b(f);
                    end
            end
            TLK = b(f)*e(f)+TLK;        %总库存成本
        %% 订单成本计算，t为各类的运输成本；c为工人小时工资，这里假设一次订货需要2人，一小时。
    
            TTK = e(f)*(TB(2)+2*L) + TTK;   %订货成本加和
        
        elseif BOMB(f,9)==15   %3
            minimium(3) = minBT(3)*BtAF(f);
            if BsM(i,f) >=  minimium(3)      %如果不缺货
                for g = 1:Tag(f)
                    b(f) = LB(3)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %如果缺货
            c(f) = minimium(3)-BsM(i,f);
            d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %各类加班的人力成本
            MG(f) = (c(f)/BtAF(f))*MB(3);
            TMG = MG(f)+TMG;
            %d(f) = 0.1*TL;
            MK = d(f)+MK;                 %总加班成本
                for h = 1:Tag(f)
                    b(f) = LB(3)*(BsM(i,f)-h*BtAF(f))+b(f);
                end
            end
            TLK = b(f)*e(f)+TLK;        %总库存成本
    %% 订单成本计算，t为各类的运输成本；c为工人小时工资，这里假设一次订货需要2人，一小时。
    
            TTK = e(f)*(TB(3)+2*L) + TTK;   %订货成本加和

        elseif BOMB(f,9)==20   %4
            minimium(4) = minBT(4)*BtAF(f);
            if BsM(i,f) >=  minimium(4)      %如果不缺货
                for g = 1:Tag(f)
                    b(f) = LB(4)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %如果缺货
            c(f) = minimium(4)-BsM(i,f);
            d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %各类加班的人力成本
            MG(f) = (c(f)/BtAF(f))*MB(4);
            TMG = MG(f)+TMG;
            %d(f) = 0.1*TL;
            MK = d(f)+MK;                 %总加班成本
                for h = 1:Tag(f)
                    b(f) = LB(4)*(BsM(i,f)-h*BtAF(f))+b(f);
                end
            end
            TLK = b(f)*e(f)+TLK;        %总库存成本
    %% 订单成本计算，t为各类的运输成本；c为工人小时工资，这里假设一次订货需要2人，一小时。
    
        TTK = e(f)*(TB(4)+2*L) + TTK;   %订货成本加和

        elseif BOMB(f,9)==30   %5
            minimium(5) = minBT(5)*BtAF(f);
            if BsM(i,f) >=  minimium(5)      %如果不缺货
                for g = 1:Tag(f)
                    b(f) = LB(5)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %如果缺货
            c(f) = minimium(5)-BsM(i,f);
            d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %各类加班的人力成本
            MG(f) = (c(f)/BtAF(f))*MB(5);
            TMG = MG(f)+TMG;
            %d(f) = 0.1*TL;
            MK = d(f)+MK;                 %总加班成本
                for h = 1:Tag(f)
                    b(f) = LB(5)*(BsM(i,f)-h*BtAF(f))+b(f);
                end
            end
            TLK = b(f)*e(f)+TLK;        %总库存成本
    %% 订单成本计算，t为各类的运输成本；c为工人小时工资，这里假设一次订货需要2人，一小时。
    
            TTK = e(f)*(TB(5)+2*L) + TTK;   %订货成本加和
            
        elseif BOMB(f,9)==45   %6
            minimium(6) = minBT(6)*BtAF(f);
            if BsM(i,f) >=  minimium(6)      %如果不缺货
                for g = 1:Tag(f)
                    b(f) = LB(6)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %如果缺货
            c(f) = minimium(6)-BsM(i,f);
            d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %各类加班的人力成本
            MG(f) = (c(f)/BtAF(f))*MB(6);
            TMG = MG(f)+TMG;
            %d(f) = 0.1*TL;
            MK = d(f)+MK;                 %总加班成本
                for h = 1:Tag(f)
                    b(f) = LB(6)*(BsM(i,f)-h*BtAF(f))+b(f);
                end
            end
            TLK = b(f)*e(f)+TLK;        %总库存成本
    %% 订单成本计算，t为各类的运输成本；c为工人小时工资，这里假设一次订货需要2人，一小时。
    
            TTK = e(f)*(TB(6)+2*L) + TTK;   %订货成本加和

        elseif BOMB(f,9)==60   %7
            minimium(7) = minBT(7)*BtAF(f);
            if BsM(i,f) >=  minimium(7)      %如果不缺货
                for g = 1:Tag(f)
                    b(f) = LB(7)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %如果缺货
            c(f) = minimium(7)-BsM(i,f);
            d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %各类加班的人力成本
            MG(f) = (c(f)/BtAF(f))*MB(7);
            TMG = MG(f)+TMG;
            %d(f) = 0.1*TL;
            MK = d(f)+MK;                 %总加班成本
                for h = 1:Tag(f)
                    b(f) = LB(7)*(BsM(i,f)-h*BtAF(f))+b(f);
                end
            end
            TLK = b(f)*e(f)+TLK;        %总库存成本
    %% 订单成本计算，t为各类的运输成本；c为工人小时工资，这里假设一次订货需要2人，一小时。
    
            TTK = e(f)*(TB(7)+2*L) + TTK;   %订货成本加和
            
        elseif BOMB(f,9)==90   %8
            minimium(8) = minBT(8)*BtAF(f);
            if BsM(i,f) >=  minimium(8)      %如果不缺货
                for g = 1:Tag(f)
                    b(f) = LB(8)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %如果缺货
            c(f) = minimium(8)-BsM(i,f);
            d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %各类加班的人力成本
            MG(f) = (c(f)/BtAF(f))*MB(8);
            TMG = MG(f)+TMG;
            %d(f) = 0.1*TL;
            MK = d(f)+MK;                 %总加班成本
                for h = 1:Tag(f)
                    b(f) = LB(8)*(BsM(i,f)-h*BtAF(f))+b(f);
                end
            end
            TLK = b(f)*e(f)+TLK;        %总库存成本
    %% 订单成本计算，t为各类的运输成本；c为工人小时工资，这里假设一次订货需要2人，一小时。
    
            TTK = e(f)*(TB(8)+2*L) + TTK;   %订货成本加和
        else   %9
            minimium(9) = minBT(9)*BtAF(f);
            if BsM(i,f) >=  minimium(9)      %如果不缺货
                for g = 1:Tag(f)
                    b(f) = LB(9)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %如果缺货
            c(f) = minimium(9)-BsM(i,f);
            d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %各类加班的人力成本
            MG(f) = (c(f)/BtAF(f))*MB(9);
            TMG = MG(f)+TMG;
            %d(f) = 0.1*TL;
            MK = d(f)+MK;                 %总加班成本
                for h = 1:Tag(f)
                    b(f) = LB(9)*(BsM(i,f)-h*BtAF(f))+b(f);
                end
            end
            TLK = b(f)*e(f)+TLK;        %总库存成本
    %% 订单成本计算，t为各类的运输成本；c为工人小时工资，这里假设一次订货需要2人，一小时。
    
            TTK = e(f)*(TB(9)+2*L) + TTK;   %订货成本加和            
        end
        
     end 
    K(i,1) = AG + TTK + TL + TFK + TLK + MK + TMG;    %总成本加和
end