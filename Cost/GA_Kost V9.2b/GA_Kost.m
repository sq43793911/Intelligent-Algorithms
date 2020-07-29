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

%% �汾 V9.2b
% ÿ�����ﵥ�����㣬�޶��ɱ������߼����޶��ɱ�����
%������ʷ��
%V8.2a ��������ɱ���ȱ���ɱ�
%V8.0a ����ABC���෨���·��࣬�˳������B�࣬ʹ�ö�����Ϊ����
%V7.1 �޸ı�����
%V7.0 �������������Ϊ�������������ɱ�����ģ�ͣ��������������
%V6.3 ���µ�ԭʼ�Ķ������ڣ��ĳ�3�ࡣ
%V6.2 �����˳ɱ������е�һ��С����  11.11
%V6.11-V6.12 ������ԭ���Ķ������ڣ�ʹ�����һ��Ĵֿ�ʽ����ʽ��ע�����ơ�  11.11
%V6.0 �°汾�޸��˼Ӱ�ɱ��ļ��㷽ʽ��ʹģ�͸��Ӻ���    11.11
%V5.2 ������ԭ���Ķ������ڣ������ԭ���ɱ��Թ��Աȣ�����ͼ������ʾ  11.11
%V5.1 �����˸�������ɱ���ʹ�������ʵ�����     10.11
%V4.1-V5.0 �Ż��Ŵ�������ʹ����ֵ�����Ž⾡���ܺ������������־ֲ����Ž�    10.11
%V4.0 �ɱ�������������ȱ���ɱ����㣬�������Ż�����ͼ     09.11
%V3.0 �ɱ������н��̶����ɱ��ĳ��˱���ĳɱ�����     08.11
%V2.0 �������ݣ�������ݣ�����ṹ����      07.11
%V1.0 ��ʼ�汾��Ϊ�㶨���ɱ����㶨�����ɱ����㶨�����ɱ����㶨����ɱ����䶩���ɱ����ܳɱ�����     05.11

clear
clc
close all

%% ��������
% format long
BOM = xlsread('QYC120-BOM�嵥�ϲ���.xls'); %��ȡ�������

L = 50;          %���˵�Сʱ����
TL = 12*17*15*8*L;   %CΪ�����ֵ������ɱ������費ȱ�������Ӱ�
FK = 10000;       %����һ�����ε������ɱ�
TFK = 17*FK;        %DΪ���������е������ɱ�
LB = [0.05 0.10 0.15 0.25 0.50 0.75 1.5 5 10];   %�洢�ɱ�,ÿ���ÿ��洢�ѣ�Ԫ/��
N = 48;             %NΪ��������
TB = [500 700 1000 1500 3000 4000 5000 7000 10000];  %����ɱ�
VST = 5;        %��ȫ��ǰ�ڣ�����ò���������������Ҫ
minni = [7 10 15 20 30 45 60 90 160];    %ÿ�����Ͷ������ڣ������������������ȱ��

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
        BOMB = [BOMB;BOM(e,:)];
    else
        BOMC = [BOMC;BOM(e,:)];
    end
end
%% ����������
%����A��ÿ����ÿ����������
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

%����ÿ�����󣨾�ֵ��;����ÿ�����������;����ÿ�ඩ����
TA = zeros(N,1);
BtAF = zeros(N,1);
S = zeros(N,1);
BsP = zeros(1,N);
for x = 1:N
    BtAF(x) = (BOMB(x,6)*6)/15;    %ÿ���ÿ������
    TA(x)=BOMB(x,6)*6*102;       %����ÿ���������
    S(x)=VST*BtAF(x);       %ÿ��İ�ȫ�����
    if BOMB(x,9)==7
        BsP(x) = minni(1)*BtAF(x)+S(x);   % ÿ��Ķ�����
    elseif BOMB(x,9)==10
        BsP(x) = minni(2)*BtAF(x)+S(x);   % ÿ��Ķ�����
    elseif BOMB(x,9)==15
        BsP(x) = minni(3)*BtAF(x)+S(x);   % ÿ��Ķ�����
    elseif BOMB(x,9)==20
        BsP(x) = minni(4)*BtAF(x)+S(x);   % ÿ��Ķ�����
    elseif BOMB(x,9)==30
        BsP(x) = minni(5)*BtAF(x)+S(x);   % ÿ��Ķ�����
    elseif BOMB(x,9)==45
        BsP(x) = minni(5)*BtAF(x)+S(x);   % ÿ��Ķ�����
    elseif BOMB(x,9)==60
        BsP(x) = minni(5)*BtAF(x)+S(x);   % ÿ��Ķ�����
    elseif BOMB(x,9)==90
        BsP(x) = minni(5)*BtAF(x)+S(x);   % ÿ��Ķ�����
    else
        BsP(x) = minni(9)*BtAF(x)+S(x);   % ÿ��Ķ�����
    end
    %BsP(x) = minni(1)*BtAF(x)+S(x);   % ÿ��Ķ�����
end
%% �Ŵ�����
NIND=500;       %��Ⱥ��С
MAXGEN=200;     %����Ŵ�����
Pc=0.9;         %�������
Pm=0.3;        %�������
GGAP=0.8;       %����
xx=[];
yy=[];
%% ��ʼ����Ⱥ
Chrom=InitPop(NIND,N,TA,BsP);
%% �Ż�
gen=0;
ObjV = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BOMB,Chrom);   %����ɱ�
preObjV=min(ObjV);
for gen=1:MAXGEN
    %% ������Ӧ��
    ObjV = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BOMB,Chrom);  %����ɱ�
    preObjV=min(ObjV);
    FitnV=Fitness(ObjV);
    %% ѡ��
    SelCh=Select(Chrom,FitnV,GGAP);
    %% �������
    SelCh=Recombin(SelCh,Pc);
    %% ����
    SelCh=Mutate(SelCh,Pm);
    %% ��ת����
    SelCh=Reverse(SelCh,TFK,AG,TL,S,TB,L,LB,BtAF,TA,BOMB);
    %% �ز����Ӵ�������Ⱥ
    Chrom=Reins(Chrom,SelCh,ObjV);
    %% ���³ɱ�
    xx=[xx;preObjV];
    yy=[yy;mean(ObjV)];
end

ObjV = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BOMB,Chrom);  %����ɱ�
[minObjV,minInd]=min(ObjV);  %minObjV-��ͳɱ�;minInd-������
Best = Chrom(minInd,:);      %���Ž�
save('���Ŷ�����.mat','Best');
save('���ųɱ�.mat','minObjV');
% H = [20000 100 100 300 500];      %ԭ���Ķ�����

% K = Kostberechen(AG,TL,TFK,S,TB,L,LB,BtAF,TA,BOMA,H); %ԭ���ĳɱ�
%% ��ͼ
figure
X = 1:MAXGEN;
XX = 1:MAXGEN;
% XXX = 150;
p=plot(X,xx,'g',XX,yy,'b');   %,XXX,K,'r*');
xlabel('��������')
ylabel('�ɱ�')
title('�Ż�����')
%p(1).Marker = 'o';
p(2).Marker = 'v';

