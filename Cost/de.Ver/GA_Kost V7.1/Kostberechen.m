function K = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BsM) %�ɱ����㣬ga�е���Ӧ�Ժ���
%% ����˼·
%���������ڹ̶���һ�ζ�������һ�����ڵ�������Ҫ��
%һ������255��
%HΪÿ��Ķ����������ݹ������ڽ��з��࣬��7��
%ÿ�տ���Ǹ���ÿ��������Ӧ���ٵģ����仯��w*H*2+w*(H-1)*...w*1
%ÿ������ɱ�Ϊ����������ÿ�εĳɱ���Ȼ��7�����

%% �ɱ�����
[NIND, N]= size(BsM);
K = zeros(NIND,1);
minBT = [7 15 30 45 60 120 160];    %ÿ�����Ͷ������ڣ������������������ȱ��
%% ÿ�����Ͷ�����
minimium = zeros(N,1);
for a = 1:N
    minimium(a) = minBT(a)*BtAF(a);
end
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
    %% ������ɱ�
    for f = 1:N  
        e(f) = TA(f)/BsM(i,f);    %ÿ��Ķ�������
        Tag(f) = BsM(i,f)/BtAF(f);
        if BsM(i,f) >=  minimium(f)      %�����ȱ��
                for g = 1:Tag(f)
                    b(f) = LB(f)*(BsM(i,f)+S(f)-g*BtAF(f))+b(f);
                end
        else                    %���ȱ��
            c(f) = minimium(f)-BsM(i,f);
            d(f) = 70*8*(c(f)/BtAF(f))*(e(f)-1);      %����Ӱ�������ɱ�
            MK = d(f)+MK;                 %�ܼӰ�ɱ�
                for h = 1:Tag(f)
                    b(f) = LB(f)*(BsM(i,f)-h*BtAF(f))+b(f);
                end
        end
        TLK = b(f)*e(f)+TLK;        %�ܿ��ɱ�
    %% �����ɱ����㣬tΪ���������ɱ���cΪ����Сʱ���ʣ��������һ�ζ�����Ҫ2�ˣ�һСʱ��
    
        TTK = e(f)*(TB(f)+2*L) + TTK;   %�����ɱ��Ӻ�

     end 
    K(i,1) = AG + TTK + TL + TFK + TLK + MK;    %�ܳɱ��Ӻ�
end