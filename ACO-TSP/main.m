%% ��22�� ��Ⱥ�㷨���Ż����㡪������������(TSP)�Ż�
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">�ð�������������</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1�����˳���פ���ڴ�<a target="_blank" href="http://www.matlabsky.com/forum-78-1.html"><font color="#0000FF">���</font></a>��Ըð������ʣ��������ʱش�</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2</font><font size="2">���˰��������׵Ľ�ѧ��Ƶ����Ƶ��������<a href="http://www.matlabsky.com/forum-91-1.html">http://www.matlabsky.com/forum-91-1.html</a></font><font size="2">�� </font></span></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		3���˰���Ϊԭ��������ת����ע����������MATLAB�����㷨30����������������</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4�����˰��������������о��й��������ǻ�ӭ���������Ҫ��ȣ����ǿ��Ǻ���Լ��ڰ����</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		5����������Ϊ���壬��ʵ�ʷ��е��鼮�������г��룬�����鼮�е�����Ϊ׼��</font></span></td>	</tr>	</table>
% </html>

%% ��ջ�������
clear all
clc

%% ��������
load CityPosition3.mat


%% ��ʼ������
m = 40;                              % ��������
alpha = 1;                           % ��Ϣ����Ҫ�̶�����
beta = 5;                            % ����������Ҫ�̶�����
rho = 0.1;                           % ��Ϣ�ػӷ�����
Q = 1;                               % ��ϵ��

iter_max = 200;                      % ���������� 


b = 50; %��ѭ������
c=zeros(b,1); %������̵ĵ�����������
%BSF=zeros(b,N);
%mRandM=zeros(b,N);%����·��
bsf_result = zeros(b,1); %���·������
t=zeros(b,1); %����ʱ�伯��

%% ����Ѱ�����·��
for a = 1:b
    tic;
    xx=[];
    
    %% ������м��໥����
n = size(citys,1);%size(A,1)����䷵�ص�ʱ����A�������� c=size(A,2) �����%���ص�ʱ����A������
D = zeros(n,n);
for i = 1:n
    for j = 1:n
        if i ~= j
            D(i,j) = sqrt(sum((citys(i,:) - citys(j,:)).^2));% (x1-x2)^2+(y1-y2��^2
        else
            D(i,j) = 1e-4; %Ҳ��Ϊ0     
        end
    end    
end

Tau = ones(n,n);                     % ��Ϣ�ؾ���
Table = zeros(m,n);                  % ·����¼��
Eta = 1./D;                          % ��������
Route_best = zeros(iter_max,n);      % �������·��       
Length_best = zeros(iter_max,1);     % �������·���ĳ���  
Length_ave = zeros(iter_max,1);      % ����·����ƽ������  
iter = 1;                            % ����������ֵ

while iter <= iter_max
    % ��������������ϵ�������
      start = zeros(m,1);
      for i = 1:m
          temp = randperm(n);%�������
          start(i) = temp(1);%�����еĵ�һ��
      end
      Table(:,1) = start; 
      % ������ռ�
      citys_index = 1:n;
      % �������·��ѡ��
      for i = 1:m
          % �������·��ѡ��
         for j = 2:n
             tabu = Table(i,1:(j - 1));           % �ѷ��ʵĳ��м���(���ɱ�)
             allow_index = ~ismember(citys_index,tabu);%���ڽ��ɱ���Ϊ��
             allow = citys_index(allow_index);  % �����ʵĳ��м���
             P = allow;
             % ������м�ת�Ƹ���
             for k = 1:length(allow)
                 P(k) = Tau(tabu(end),allow(k))^alpha * Eta(tabu(end),allow(k))^beta;%ת�Ƹ��ʵķ���
             end
             P = P/sum(P);%ת�Ƹ��ʵķ�ĸ
             % ���̶ķ�ѡ����һ�����ʳ���
             Pc = cumsum(P); %�ۻ���    
            target_index = find(Pc >= rand); %����Pc����������
            target = allow(target_index(1));%��һ������������
            Table(i,j) = target;
         end
      end
      % ����������ϵ�·������
      Length = zeros(m,1);
      for i = 1:m
          Route = Table(i,:);
          for j = 1:(n - 1)
              Length(i) = Length(i) + D(Route(j),Route(j + 1));
          end
          Length(i) = Length(i) + D(Route(n),Route(1));
      end
      % �������·�����뼰ƽ������
      if iter == 1
          [min_Length,min_index] = min(Length);
          Length_best(iter) = min_Length;  
          Length_ave(iter) = mean(Length);
          Route_best(iter,:) = Table(min_index,:);
      else
          [min_Length,min_index] = min(Length);%ȡ��Сֵ����λ��
          Length_best(iter) = min(Length_best(iter - 1),min_Length);
          Length_ave(iter) = mean(Length);
          if Length_best(iter) == min_Length%���½�ֹĿǰ�����Ž�
              Route_best(iter,:) = Table(min_index,:);
          else%������
              Route_best(iter,:) = Route_best((iter-1),:);
          end
      end
      % ������Ϣ��
      Delta_Tau = zeros(n,n);
      % ������ϼ���
      for i = 1:m
          % ������м���
          for j = 1:(n - 1)
              Delta_Tau(Table(i,j),Table(i,j+1)) = Delta_Tau(Table(i,j),Table(i,j+1)) + Q/Length(i);
          end
          Delta_Tau(Table(i,n),Table(i,1)) = Delta_Tau(Table(i,n),Table(i,1)) + Q/Length(i);
      end
      Tau = (1-rho) * Tau + Delta_Tau;
    % ����������1�����·����¼��
    iter = iter + 1;
    Table = zeros(m,n);
end

%% �����ʾ
[Shortest_Length,c(a,:)] = min(Length_best);
Shortest_Route = Route_best(c(a,:),:);
bsf_result(a,:) = Shortest_Length;

t(a,:)=toc;
end
% disp(['��̾���:' num2str(Shortest_Length)]);
% disp(['���·��:' num2str([Shortest_Route Shortest_Route(1)])]);%���������� 

%% ��ͼ
% figure(1)
% plot([citys(Shortest_Route,1);citys(Shortest_Route(1),1)],...
%      [citys(Shortest_Route,2);citys(Shortest_Route(1),2)],'o-');%...���У�plot(x,y,'o-'����;��x����+��ʼx���꣬;��y����+��ʼy����
% grid on
% for i = 1:size(citys,1)
%     text(citys(i,1),citys(i,2),['   ' num2str(i)]);%������б�ţ������λ���ǳ��е�x,y���꣬'  '�����߿ճ�λ��
% end
% text(citys(Shortest_Route(1),1),citys(Shortest_Route(1),2),'       ���');
% text(citys(Shortest_Route(end),1),citys(Shortest_Route(end),2),'       �յ�');
% xlabel('����λ�ú�����')
% ylabel('����λ��������')
% title(['��Ⱥ�㷨�Ż�·��(��̾���:' num2str(Shortest_Length) ')'])

% DrawPath(Shortest_Route, citys);
% 
% figure
% plot(1:iter_max,Length_best,'b',1:iter_max,Length_ave,'r:')
% legend('��̾���','ƽ������')
% xlabel('��������')
% ylabel('����')
% title('������̾�����ƽ������Ա�')

%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p align="left"><font size="2">�����̳��</font></p><p align="left"><font size="2">Matlab������̳��<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab�����ٿƣ�<a href="http://www.mfun.la">www.mfun.la</a></font></p></td>	</tr></table>
% </html>