%% �ɱ������Ż�����
% ���������嵥�����ݹ������ڵĲ�ͬ��������ֳ���7�࣬����7�죬15�죬30�죬45�죬60�죬90��120�죬120�����ϡ�
% �������Ϊ����������λ����������������ΪChrom,����Ӧ�Ⱥ�����ΪH��
% �����������������ڲ���仯
%          ���������е������������ɱ��㶨��
%          ������ÿ��ÿ����������㶨
%          ÿ�������ɱ��Ͳִ��ɱ���ͬ����ÿһ������������������ɱ���ͬ��
%          ��ʱ�����ǰ��Ʒ�Ĳִ��ɱ���
%          ����ȱ������Ҫ�ڹ涨�����ڽ��������˴��ڼӰࡣ
%BOM�嵥�У�����һЩ����û�в�ȫ������ֻӰ���ܳɱ��Ĵ�С������Ӱ���Ż����̣����Կ��Ժ��ԡ�
%% �Ŵ��㷨���
%���룺
%NIND    Ϊ��Ⱥ����
%MAXGEN  Ϊֹͣ�������Ŵ�����MAXGEN��ʱ����ֹͣ,MAXGEN�ľ���ȡֵ������Ĺ�ģ�ͺķѵ�ʱ�����
%m       Ϊ��ֵ��̭����ָ��,���ȡΪ1,2,3,4,����̫��
%Pc      �������
%Pm      �������

%% �汾 V8.3c
% ��������ɱ���ÿ��ȱ���ɱ�
%������ʷ��
%V8.0c ����ABC���෨���·��࣬�˳������C�࣬��������ΪѰ�ű����������޶��ɱ�����ģ�͡� 18.11
%V7.1 �޸ı�����  16.11
%V7.0 �������������Ϊ�������������ɱ�����ģ�ͣ��������������  15.11
%V6.3 ���µ�ԭʼ�Ķ������ڣ��ĳ�3�ࡣ
%V6.2 �����˳ɱ������е�һ��С����  11.11
%V6.11-V6.12 ������ԭ���Ķ������ڣ�ʹ�����һ��Ĵֿ�ʽ������ʽ��ע�����ơ�  11.11
%V6.0 �°汾�޸��˼Ӱ�ɱ��ļ��㷽ʽ��ʹģ�͸��Ӻ���    11.11
%V5.2 ������ԭ���Ķ������ڣ������ԭ���ɱ��Թ��Աȣ�����ͼ������ʾ  11.11
%V5.1 �����˸�������ɱ���ʹ�������ʵ�����     10.11
%V4.1-V5.0 �Ż��Ŵ�������ʹ����ֵ�����Ž⾡���ܺ��������������־ֲ����Ž�    10.11
%V4.0 �ɱ�������������ȱ���ɱ����㣬�������Ż�����ͼ     09.11
%V3.0 �ɱ������н��̶����ɱ��ĳ��˱���ĳɱ�����     08.11
%V2.0 �������ݣ�������ݣ�����ṹ����      07.11
%V1.0 ��ʼ�汾��Ϊ�㶨���ɱ����㶨�����ɱ����㶨�����ɱ����㶨����ɱ����䶩���ɱ����ܳɱ�����     05.11

clear
clc
close all

%% ��������
% format long
BOM = xlsread('QYC120-BOM�嵥�ϲ���.xls'); %��ȡ��������

L = 50;          %���˵�Сʱ����
TL = 12*17*15*8*L;   %CΪ�����ֵ������ɱ������費ȱ�������Ӱ�
FK = 10000;       %����һ�����ε������ɱ�
TFK = 17*FK;        %DΪ���������е������ɱ�
LB = [0.01 0.03 0.06 0.09 1.2 1.5];   %�洢�ɱ�,ÿ���ÿ��洢�ѣ�Ԫ/��
N = 6;             %NΪ��������
TB = [200 300 400 700 1100 1500];  %����ɱ�
VST = 5;        %��ȫ��ǰ�ڣ�����ò���������������Ҫ
minni = [5 7 10 15 20 30];    %ÿ�����Ͷ������ڣ������������������ȱ��

%% ABC ����
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
        BOMB = [BOMA;BOM(e,:)];
    else
        BOMC = [BOMC;BOM(e,:)];
    end
end
%% ������������
%����A��ÿ����ÿ����������
g = size(BOMC,1);
f = zeros(N,1);
AG = 0;
for z = 1:g
    if BOMC(z,9)==5
        f(1) = BOMC(z,6)+f(1);
    elseif BOMC(z,9)==7
        f(2) = BOMC(z,6)+f(2);
    elseif BOMC(z,9)==10
        f(3) = BOMC(z,6)+f(3);
    elseif BOMC(z,9)==15
        f(4) = BOMC(z,6)+f(4);
    elseif BOMC(z,9)==20
        f(5) = BOMC(z,6)+f(5);
    else
        f(6) = BOMC(z,6)+f(6);
    end
    AG = BOMC(z,11)+AG;
end
AG = 100*AG;

%����ÿ�����󣨾�ֵ��;����ÿ�����������;����ÿ�ඩ����
TA = zeros(N,1);
BtAF = zeros(N,1);
S = zeros(N,1);
BsP = zeros(N,1);
for x = 1:N
    BtAF(x) = (f(x)*6)/15;    %ÿ���ÿ������
    TA(x)=f(x)*6*102;       %����ÿ���������
    S(x)=VST*BtAF(x);       %ÿ��İ�ȫ�����
    %BsP(x) = minni(x)*BtAF(x)+S(x);   % ÿ��Ķ�����
end
%% �Ŵ�����
NIND=2000;       %��Ⱥ��С
MAXGEN=200;     %����Ŵ�����
Pc=0.9;         %�������
Pm=0.05;        %�������
GGAP=0.9;       %����
xx=[];
yy=[];
%% ��ʼ����Ⱥ
Chrom=InitPop(NIND,N);
%% �Ż�
gen=0;
ObjV = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,Chrom);   %����ɱ�
preObjV=min(ObjV);
for gen=1:MAXGEN
    %% ������Ӧ��
    ObjV = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,Chrom);  %����ɱ�
    preObjV=min(ObjV);
    FitnV=Fitness(ObjV);
    %% ѡ��
    SelCh=Select(Chrom,FitnV,GGAP);
    %% �������
    SelCh=Recombin(SelCh,Pc);
    %% ����
    SelCh=Mutate(SelCh,Pm);
    %% ��ת����
    SelCh=Reverse(SelCh,TFK,AG,TL,S,TB,L,LB,BtAF,TA);
    %% �ز����Ӵ�������Ⱥ
    Chrom=Reins(Chrom,SelCh,ObjV);
    %% ���³ɱ�
    xx=[xx;preObjV];
    yy=[yy;mean(ObjV)];
end


ObjV = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,Chrom);  %����ɱ�
[minObjV,minInd]=min(ObjV);
Best = Chrom(minInd,:);      %���Ž�
% save('���Ŷ�����.mat','Best');
% save('���ųɱ�.mat','minObjV');
BsM = zeros(1,N);
for i = 1:N
    BsM(i) = Best(i)*BtAF(i);    %ÿ�ඩ����
end
% H = [15 15 20 20 30 30];      %ԭ���Ķ�����

% K = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,H); %ԭ���ĳɱ�
%% ��ͼ
figure
X = 1:MAXGEN;
XX = 1:MAXGEN;
XXX = 150;
p=plot(X,xx,'g',XX,yy,'b',XXX,K,'r*');
xlabel('��������')
ylabel('�ɱ�')
title('�Ż�����')
%p(1).Marker = 'o';
p(2).Marker = 'v';
