function K = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BsP) %�ɱ����㣬ga�е���Ӧ�Ժ���
%% ����˼·
%���������ڹ̶���һ�ζ�������һ�����ڵ�������Ҫ��
%һ������255��
%HΪÿ��Ķ����������ݹ������ڽ��з��࣬��7��
%ÿ�տ���Ǹ���ÿ��������Ӧ���ٵģ����仯��w*H*2+w*(H-1)*...w*1
%ÿ������ɱ�Ϊ����������ÿ�εĳɱ���Ȼ��7�����

%% �ɱ�����
[NIND, N]= size(BsP);
K = zeros(NIND,1);
minBT = [5 7 10 15 20 30];    %ÿ�����Ͷ������ڣ������������������ȱ��
MB = [1000 2000 3000 4000 5000 6000];
%% ÿ�����Ͷ�����
% minimium = zeros(N,1);
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
    %Tag = zeros(N,1);
    MG = zeros(N,1);
    TMG = 0;
    %% ������ɱ�
    for f = 1:N  
        e(f) = 255/BsP(i,f);    %ÿ��Ķ�������
        %Tag(f) = BsP(i,f)/BtAF(f);
        if BsP(i,f) >=  minBT(f)      %�����ȱ��
            c(f) = BsP(i,f)-minBT(f);
                for g = 1:BsP(i,f)
                    b(f) = LB(f)*((BsP(i,f)+c(f))*BtAF(f)-g*BtAF(f))+b(f);
                end
        else                    %���ȱ��
            c(f) = minBT(f)-BsP(i,f);
            d(f) = 70*8*c(f)*(e(f)-1);      %����Ӱ�������ɱ�
            MG(f) = c(f)*MB(f);
            TMG = MG(f)+TMG;
            %d(f) = 0.1*TL;
            MK = d(f)+MK;                 %�ܼӰ�ɱ�
                for h = 1:BsP(i,f)
                    b(f) = LB(f)*(BtAF(f)*BsP(i,f)-h*BtAF(f))+b(f);
                end
        end
        TLK = b(f)*e(f)+TLK;        %�ܿ��ɱ�
    %% �����ɱ����㣬tΪ���������ɱ���cΪ����Сʱ���ʣ��������һ�ζ�����Ҫ2�ˣ�һСʱ��
    
        TTK = e(f)*(TB(f)+2*L) + TTK;   %�����ɱ��Ӻ�

     end 
    K(i,1) = AG + TTK + TL + TFK + TLK + MK + TMG;    %�ܳɱ��Ӻ�
end