clear all;
clc;

load CityPosition3.mat
N=size(citys,1);%���и���
M=40;
%��Ⱥ����
pos=citys;            %randn(N,2);


    
%���ɳ�������
global D;
%���о�������
 
D=zeros(N,N);
for i=1:N
    for j=i+1:N
        dis=(pos(i,1)-pos(j,1)).^2+(pos(i,2)-pos(j,2)).^2;
        D(i,j)=dis^(0.5);
        D(j,i)=D(i,j);
    end
end

%�м�������
global TmpResult;
TmpResult=[];
global TmpResult1;
TmpResult1=[];


%�����趨
%[M,N]=size(D);%Ⱥ���ģ
pCharChange=1;%�ַ���λ����
pStrChange=0.4;%�ַ�����λ����
pStrReverse=0.4;%�ַ�����ת����
pCharReCompose=0.4;%�ַ��������
MaxIterateNum=200;%����������
b = 50; %��ѭ������
c=zeros(b,1); %������̵ĵ�����������
BSF=zeros(b,N);
mRandM=zeros(b,N);%����·��
bsf_result = zeros(b,1); %���·������
t=zeros(b,1); %����ʱ�伯��

for a=1:b  %��һ��ʹ��palfor
tic
xx=[];
%���ݳ�ʼ��
mPopulation=zeros(M,N);

for rol=1:M;
    mPopulation(rol,:)=randperm(N);%������ʼ����
    mPopulation(rol,:)=DisplaceInit(mPopulation(rol,:));%Ԥ����
end

%����
count=0;

while count<MaxIterateNum
    %�����¿���
    B=Mutation(mPopulation,[pCharChange pStrChange pStrReverse pCharReCompose]);
    %�������п�����׺��������п�������ſ�����ų���
    [mPopulation,xx]=SelectAntigen(mPopulation,B,xx);
    %hold on
    %plot(count,TmpResult(end),'.');
    %drawnow
%     display(TmpResult(end));
%         display(TmpResult1(end));
    count=count+1;
    mRandM(a,:) = mPopulation(end,:);
end

[bsf,c(a,:)] = min(xx);

% figure;
% 
% hold on
% plot(bsf,'-r');
% title('�����Ӧ�ȱ仯����')
% xlabel('������')
% ylabel('�����Ӧ��')

bsf_result(a,:) = bsf;

%MaxIterateNum = MaxIterateNum + a;

BSF(a,:) = mRandM(a,:);
%DrawPath(BSF(a,:),citys);
t(a,:)=toc;
end

bsf_best = min(bsf_result);
