function K = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BOMA,BsM) %�ɱ����㣬ga�е���Ӧ�Ժ���
%% ����˼·
%���������ڹ̶���һ�ζ�������һ�����ڵ�������Ҫ��
%һ������255��
%HΪÿ��Ķ����������ݹ������ڽ��з��࣬��7��
%ÿ�տ���Ǹ���ÿ��������Ӧ���ٵģ����仯��w*H*2+w*(H-1)*...w*1
%ÿ������ɱ�Ϊ����������ÿ�εĳɱ���Ȼ��7�����

%% �ɱ�����
[NIND, N]= size(BsM);
K = zeros(NIND,1);
minBT = [30 45 60 120 160];    %ÿ�����Ͷ������ڣ������������������ȱ��
MB = [10000 30000 50000 80000 100000];
%% ÿ�����Ͷ�����
minimium = zeros(5,1);
% for a = 1:N
%     minimium(a) = minBT(a)*BtAF(a);
% end
%% ��Ⱥ��ѭ��
for i = 1:NIND
    %% ��������ʼ��
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
    %% ������ɱ�
    for f = 1:N  
        e(f) = TA(f)/BsM(i,f);    %ÿ��Ķ�������
        Tag(f) = BsM(i,f)/BtAF(f);
        %% 30
        if BOMA(f,9)==30
            minimium(1) = minBT(1)*BtAF(f);
            if BsM(i,f) >=  minimium(1)      %�����ȱ��
                for g = 1:Tag(f)
                    b(f) = LB(1)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %���ȱ��
                c(f) = minimium(1)-BsM(i,f);
                d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %����Ӱ�������ɱ�
                MG(f) = (c(f)/BtAF(f))*MB(1);
                TMG = MG(f)+TMG;
                %d(f) = 0.1*TL;
                MK = d(f)+MK;                 %�ܼӰ�ɱ�
                    for h = 1:Tag(f)
                        b(f) = LB(1)*(BsM(i,f)-h*BtAF(f))+b(f);
                    end
            end
            TLK = b(f)*e(f)+TLK;        %�ܿ��ɱ�
        %% �����ɱ����㣬tΪ���������ɱ���cΪ����Сʱ���ʣ��������һ�ζ�����Ҫ2�ˣ�һСʱ��
    
            TTK = e(f)*(TB(1)+2*L) + TTK;   %�����ɱ��Ӻ�

      
        %% 45
        elseif BOMA(f,9)==45
            minimium(2) = minBT(2)*BtAF(f);
            if BsM(i,f) >=  minimium(2)      %�����ȱ��
                for g = 1:Tag(f)
                    b(f) = LB(2)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %���ȱ��
                c(f) = minimium(2)-BsM(i,f);
                d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %����Ӱ�������ɱ�
                MG(f) = (c(f)/BtAF(f))*MB(2);
                TMG = MG(f)+TMG;
                %d(f) = 0.1*TL;
                MK = d(f)+MK;                 %�ܼӰ�ɱ�
                    for h = 1:Tag(f)
                        b(f) = LB(2)*(BsM(i,f)-h*BtAF(f))+b(f);
                    end
            end
            TLK = b(f)*e(f)+TLK;        %�ܿ��ɱ�
        %% �����ɱ����㣬tΪ���������ɱ���cΪ����Сʱ���ʣ��������һ�ζ�����Ҫ2�ˣ�һСʱ��
    
            TTK = e(f)*(TB(2)+2*L) + TTK;   %�����ɱ��Ӻ�
        
        elseif BOMA(f,9)==60
            minimium(3) = minBT(3)*BtAF(f);
            if BsM(i,f) >=  minimium(3)      %�����ȱ��
                for g = 1:Tag(f)
                    b(f) = LB(3)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %���ȱ��
            c(f) = minimium(3)-BsM(i,f);
            d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %����Ӱ�������ɱ�
            MG(f) = (c(f)/BtAF(f))*MB(3);
            TMG = MG(f)+TMG;
            %d(f) = 0.1*TL;
            MK = d(f)+MK;                 %�ܼӰ�ɱ�
                for h = 1:Tag(f)
                    b(f) = LB(3)*(BsM(i,f)-h*BtAF(f))+b(f);
                end
            end
            TLK = b(f)*e(f)+TLK;        %�ܿ��ɱ�
    %% �����ɱ����㣬tΪ���������ɱ���cΪ����Сʱ���ʣ��������һ�ζ�����Ҫ2�ˣ�һСʱ��
    
            TTK = e(f)*(TB(3)+2*L) + TTK;   %�����ɱ��Ӻ�

        elseif BOMA(f,9)==120
            minimium(4) = minBT(4)*BtAF(f);
            if BsM(i,f) >=  minimium(4)      %�����ȱ��
                for g = 1:Tag(f)
                    b(f) = LB(4)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %���ȱ��
            c(f) = minimium(4)-BsM(i,f);
            d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %����Ӱ�������ɱ�
            MG(f) = (c(f)/BtAF(f))*MB(4);
            TMG = MG(f)+TMG;
            %d(f) = 0.1*TL;
            MK = d(f)+MK;                 %�ܼӰ�ɱ�
                for h = 1:Tag(f)
                    b(f) = LB(4)*(BsM(i,f)-h*BtAF(f))+b(f);
                end
            end
            TLK = b(f)*e(f)+TLK;        %�ܿ��ɱ�
    %% �����ɱ����㣬tΪ���������ɱ���cΪ����Сʱ���ʣ��������һ�ζ�����Ҫ2�ˣ�һСʱ��
    
        TTK = e(f)*(TB(4)+2*L) + TTK;   %�����ɱ��Ӻ�

        elseif BOMA(f,9)==160
            minimium(5) = minBT(5)*BtAF(f);
            if BsM(i,f) >=  minimium(5)      %�����ȱ��
                for g = 1:Tag(f)
                    b(f) = LB(5)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
            else                    %���ȱ��
            c(f) = minimium(5)-BsM(i,f);
            d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %����Ӱ�������ɱ�
            MG(f) = (c(f)/BtAF(f))*MB(5);
            TMG = MG(f)+TMG;
            %d(f) = 0.1*TL;
            MK = d(f)+MK;                 %�ܼӰ�ɱ�
                for h = 1:Tag(f)
                    b(f) = LB(5)*(BsM(i,f)-h*BtAF(f))+b(f);
                end
            end
            TLK = b(f)*e(f)+TLK;        %�ܿ��ɱ�
    %% �����ɱ����㣬tΪ���������ɱ���cΪ����Сʱ���ʣ��������һ�ζ�����Ҫ2�ˣ�һСʱ��
    
            TTK = e(f)*(TB(5)+2*L) + TTK;   %�����ɱ��Ӻ�
        end
        
     end 
    K(i,1) = AG + TTK + TL + TFK + TLK + MK + TMG;    %�ܳɱ��Ӻ�
end