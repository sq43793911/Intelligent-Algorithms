%% 第22章 蚁群算法的优化计算——旅行商问题(TSP)优化
% <html>
% <table border="0" width="600px" id="table1">	<tr>		<td><b><font size="2">该案例作者申明：</font></b></td>	</tr>	<tr><td><span class="comment"><font size="2">1：本人长期驻扎在此<a target="_blank" href="http://www.matlabsky.com/forum-78-1.html"><font color="#0000FF">板块</font></a>里，对该案例提问，做到有问必答。</font></span></td></tr><tr>	<td><span class="comment"><font size="2">2</font><font size="2">：此案例有配套的教学视频，视频下载请点击<a href="http://www.matlabsky.com/forum-91-1.html">http://www.matlabsky.com/forum-91-1.html</a></font><font size="2">。 </font></span></td>	</tr>			<tr>		<td><span class="comment"><font size="2">		3：此案例为原创案例，转载请注明出处（《MATLAB智能算法30个案例分析》）。</font></span></td>	</tr>		<tr>		<td><span class="comment"><font size="2">		4：若此案例碰巧与您的研究有关联，我们欢迎您提意见，要求等，我们考虑后可以加在案例里。</font></span></td>	</tr>	<tr>		<td><span class="comment"><font size="2">		5：以下内容为初稿，与实际发行的书籍内容略有出入，请以书籍中的内容为准。</font></span></td>	</tr>	</table>
% </html>

%% 清空环境变量
clear all
clc

%% 导入数据
load CityPosition3.mat


%% 初始化参数
m = 40;                              % 蚂蚁数量
alpha = 1;                           % 信息素重要程度因子
beta = 5;                            % 启发函数重要程度因子
rho = 0.1;                           % 信息素挥发因子
Q = 1;                               % 常系数

iter_max = 200;                      % 最大迭代次数 


b = 50; %总循环次数
c=zeros(b,1); %到达最短的迭代次数集合
%BSF=zeros(b,N);
%mRandM=zeros(b,N);%最优路径
bsf_result = zeros(b,1); %最短路径集合
t=zeros(b,1); %运行时间集合

%% 迭代寻找最佳路径
for a = 1:b
    tic;
    xx=[];
    
    %% 计算城市间相互距离
n = size(citys,1);%size(A,1)该语句返回的时矩阵A的行数， c=size(A,2) 该语句%返回的时矩阵A的列数
D = zeros(n,n);
for i = 1:n
    for j = 1:n
        if i ~= j
            D(i,j) = sqrt(sum((citys(i,:) - citys(j,:)).^2));% (x1-x2)^2+(y1-y2）^2
        else
            D(i,j) = 1e-4; %也可为0     
        end
    end    
end

Tau = ones(n,n);                     % 信息素矩阵
Table = zeros(m,n);                  % 路径记录表
Eta = 1./D;                          % 启发函数
Route_best = zeros(iter_max,n);      % 各代最佳路径       
Length_best = zeros(iter_max,1);     % 各代最佳路径的长度  
Length_ave = zeros(iter_max,1);      % 各代路径的平均长度  
iter = 1;                            % 迭代次数初值

while iter <= iter_max
    % 随机产生各个蚂蚁的起点城市
      start = zeros(m,1);
      for i = 1:m
          temp = randperm(n);%随机排序
          start(i) = temp(1);%排序中的第一个
      end
      Table(:,1) = start; 
      % 构建解空间
      citys_index = 1:n;
      % 逐个蚂蚁路径选择
      for i = 1:m
          % 逐个城市路径选择
         for j = 2:n
             tabu = Table(i,1:(j - 1));           % 已访问的城市集合(禁忌表)
             allow_index = ~ismember(citys_index,tabu);%不在禁忌表中为真
             allow = citys_index(allow_index);  % 待访问的城市集合
             P = allow;
             % 计算城市间转移概率
             for k = 1:length(allow)
                 P(k) = Tau(tabu(end),allow(k))^alpha * Eta(tabu(end),allow(k))^beta;%转移概率的分子
             end
             P = P/sum(P);%转移概率的分母
             % 轮盘赌法选择下一个访问城市
             Pc = cumsum(P); %累积和    
            target_index = find(Pc >= rand); %返回Pc中满足条件
            target = allow(target_index(1));%第一个满足条件的
            Table(i,j) = target;
         end
      end
      % 计算各个蚂蚁的路径距离
      Length = zeros(m,1);
      for i = 1:m
          Route = Table(i,:);
          for j = 1:(n - 1)
              Length(i) = Length(i) + D(Route(j),Route(j + 1));
          end
          Length(i) = Length(i) + D(Route(n),Route(1));
      end
      % 计算最短路径距离及平均距离
      if iter == 1
          [min_Length,min_index] = min(Length);
          Length_best(iter) = min_Length;  
          Length_ave(iter) = mean(Length);
          Route_best(iter,:) = Table(min_index,:);
      else
          [min_Length,min_index] = min(Length);%取最小值及其位置
          Length_best(iter) = min(Length_best(iter - 1),min_Length);
          Length_ave(iter) = mean(Length);
          if Length_best(iter) == min_Length%更新截止目前的最优解
              Route_best(iter,:) = Table(min_index,:);
          else%不更新
              Route_best(iter,:) = Route_best((iter-1),:);
          end
      end
      % 更新信息素
      Delta_Tau = zeros(n,n);
      % 逐个蚂蚁计算
      for i = 1:m
          % 逐个城市计算
          for j = 1:(n - 1)
              Delta_Tau(Table(i,j),Table(i,j+1)) = Delta_Tau(Table(i,j),Table(i,j+1)) + Q/Length(i);
          end
          Delta_Tau(Table(i,n),Table(i,1)) = Delta_Tau(Table(i,n),Table(i,1)) + Q/Length(i);
      end
      Tau = (1-rho) * Tau + Delta_Tau;
    % 迭代次数加1，清空路径记录表
    iter = iter + 1;
    Table = zeros(m,n);
end

%% 结果显示
[Shortest_Length,c(a,:)] = min(Length_best);
Shortest_Route = Route_best(c(a,:),:);
bsf_result(a,:) = Shortest_Length;

t(a,:)=toc;
end
% disp(['最短距离:' num2str(Shortest_Length)]);
% disp(['最短路径:' num2str([Shortest_Route Shortest_Route(1)])]);%在命令窗口输出 

%% 绘图
% figure(1)
% plot([citys(Shortest_Route,1);citys(Shortest_Route(1),1)],...
%      [citys(Shortest_Route,2);citys(Shortest_Route(1),2)],'o-');%...换行，plot(x,y,'o-'），途径x坐标+起始x坐标，途径y坐标+起始y坐标
% grid on
% for i = 1:size(citys,1)
%     text(citys(i,1),citys(i,2),['   ' num2str(i)]);%输出城市编号，输出的位置是城市的x,y坐标，'  '编号左边空出位置
% end
% text(citys(Shortest_Route(1),1),citys(Shortest_Route(1),2),'       起点');
% text(citys(Shortest_Route(end),1),citys(Shortest_Route(end),2),'       终点');
% xlabel('城市位置横坐标')
% ylabel('城市位置纵坐标')
% title(['蚁群算法优化路径(最短距离:' num2str(Shortest_Length) ')'])

% DrawPath(Shortest_Route, citys);
% 
% figure
% plot(1:iter_max,Length_best,'b',1:iter_max,Length_ave,'r:')
% legend('最短距离','平均距离')
% xlabel('迭代次数')
% ylabel('距离')
% title('各代最短距离与平均距离对比')

%%
% <html>
% <table width="656" align="left" >	<tr><td align="center"><p align="left"><font size="2">相关论坛：</font></p><p align="left"><font size="2">Matlab技术论坛：<a href="http://www.matlabsky.com">www.matlabsky.com</a></font></p><p align="left"><font size="2">M</font><font size="2">atlab函数百科：<a href="http://www.mfun.la">www.mfun.la</a></font></p></td>	</tr></table>
% </html>