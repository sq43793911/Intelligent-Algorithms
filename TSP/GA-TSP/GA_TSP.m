%�Ŵ��㷨���TSP����(Ϊѡ�����������ƺ����)
%���룺
%D       �������
%NIND    Ϊ��Ⱥ����
%X       �������й�34�����е�����(��ʼ����)
%MAXGEN  Ϊֹͣ�������Ŵ�����MAXGEN��ʱ����ֹͣ,MAXGEN�ľ���ȡֵ������Ĺ�ģ�ͺķѵ�ʱ�����
%m       Ϊ��ֵ��̭����ָ��,���ȡΪ1,2,3,4,����̫��
%Pc      �������
%Pm      �������
%�����
%R       Ϊ���·��
%Rlength Ϊ·������
clear
clc
close all
%% ��������
load CityPosition2
D=Distanse(X);  %���ɾ������
N=size(D,1);    %���и���
%% �Ŵ�����
NIND=40;       %��Ⱥ��С
MAXGEN=700;     %����Ŵ�����
Pc=0.9;         %�������
Pm=0.05;        %�������
GGAP=0.9;       %����

b = 1; %��ѭ������
c=zeros(b,1); %������̵ĵ�����������
%BSF=zeros(b,N);
%mRandM=zeros(b,N);%����·��
bsf_result = zeros(b,1); %���·������
t=zeros(b,1); %����ʱ�伯��

for a = 1:b;
    tic;
    xx=[];
%% ��ʼ����Ⱥ
Chrom=InitPop(NIND,N);
% %% ����������·��ͼ
% DrawPath(Chrom(1,:),X)
% pause(0.0001)
% %% ���������·�����ܾ���
% disp('��ʼ��Ⱥ�е�һ�����ֵ:')
% OutputPath(Chrom(1,:));
% Rlength=PathLength(D,Chrom(1,:));
% disp(['�ܾ��룺',num2str(Rlength)]);
% disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
%% �Ż�
gen=0;
% figure;
% hold on;%����ͼ��
% box on% �Ƿ���ʾ�߿�
% xlim([0,MAXGEN])% x������������ x limit
% title('�Ż�����')
% xlabel('����')
% ylabel('����ֵ')
ObjV=PathLength(D,Chrom);  %����·������
preObjV=min(ObjV);
while gen<MAXGEN
    %% ������Ӧ��
    [ObjV]=PathLength(D,Chrom);  %����·������
    % fprintf('%d   %1.10f\n',gen,min(ObjV))
    %line([gen-1,gen],[preObjV,min(ObjV)]);pause(0.0001)
    preObjV=min(ObjV);
    FitnV=Fitness(ObjV);
    %% ѡ��
    SelCh=Select(Chrom,FitnV,GGAP);
    %% �������
    SelCh=Recombin(SelCh,Pc);
    %% ����
    SelCh=Mutate(SelCh,Pm);
    %% ��ת����
    SelCh=Reverse(SelCh,D);
    %% �ز����Ӵ�������Ⱥ
    Chrom=Reins(Chrom,SelCh,ObjV);
    %% ���µ�������
    gen=gen+1 ;
    xx = [xx;preObjV];
end
%% �������Ž��·��ͼ
[bsf,c(a,:)] = min(xx);
%ObjV=PathLength(D,Chrom);  %����·������
%[minObjV,minInd]=min(ObjV);
%DrawPath(Chrom(minInd(1),:),X)
%% ������Ž��·�����ܾ���
% disp('���Ž�:')
%p=OutputPath(Chrom(minInd(1),:));
% disp(['�ܾ��룺',num2str(ObjV(minInd(1)))]);
% disp('-------------------------------------------------------------')
bsf_result(a,:) = bsf;
t(a,:)=toc;
end
bsf_best = min(bsf_result);