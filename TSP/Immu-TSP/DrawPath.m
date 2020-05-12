%% ��·������
%����
% Chrom  ����·��   
% X      ����������λ��
function DrawPath(Chrom,X) 
R=[Chrom(1,:) Chrom(1,1)]; %һ�������(����)
figure;
hold on;
plot(X(:,1),X(:,2),'o','color',[0.5,0.5,0.5])%������һ��Ϊ�����ꡢ�ڶ���Ϊ������
plot(X(Chrom(1,1),1),X(Chrom(1,1),2),'rv','MarkerSize',20) %Chrom�ĵ�һ�С���һ�� 
for i=1:size(X,1)%X��ÿ��
    text(X(i,1)+0.05,X(i,2)+0.05,num2str(i),'color',[1,0,0]);
end
A=X(R,:);
row=size(A,1);
for i=2:row
    [arrowx,arrowy] = dsxy2figxy(gca,A(i-1:i,1),A(i-1:i,2));%����ת��
    annotation('textarrow',arrowx,arrowy,'HeadWidth',8,'color',[0,0,1]);
end
hold off
text(X(Chrom(1),1),X(Chrom(1),2),'  ���');
text(X(Chrom(end),1),X(Chrom(end),2),'  �յ�');
xlabel('������')
ylabel('������')
title('�켣ͼ')
box on