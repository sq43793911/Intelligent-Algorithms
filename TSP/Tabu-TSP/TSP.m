%tabu search to solve the TSP Problem
%by Zhaokai,zkcsu@126.com 
%Information School of Central South University
%2006-06
%revised by LiMing
%2010-02-11

function TSP(City_Coordinates)
Candidate_Num=40;          	%候选解(candidate),取值不大于n*(n-1)/2(全部邻域解个数) 40和100
StopL=1000;          	%最大迭代次数
b = 50; %总循环次数
c=zeros(b,1); %到达最短的迭代次数集合
%BSF=zeros(b,N);
%mRandM=zeros(b,N);%最优路径
bsf_result = zeros(b,1); %最短路径集合
t=zeros(b,1); %运行时间集合

for a = 1:b
    tic;
    xx=[];
m=size(City_Coordinates,1);

%距离矩阵，初始distance_list(i,j)代表城市i和城市j之间的距离
Distance_List=zeros(m);
for i=1:m
    for j=1:m
        Distance_List(i,j)=((City_Coordinates(i,1)-City_Coordinates(j,1))^2+...
        (City_Coordinates(i,2)-City_Coordinates(j,2))^2)^0.5;       
    end
end

CityNum=m;
Tabu_list=zeros(CityNum);   	%禁忌表(tabu list)
Reserved_Solution_Num=10 ; 	%保留Reserved_Solution_Num个最好候选解
bsf=Inf;                   	%设置最优路径的初始值为Inf
tabu_length=ceil(CityNum^0.5); 	%禁忌长度(tabu length)
%save Candidate_Num Candidate_Num;

S0=randperm(CityNum);      	%随机生成初始解序列 
S=S0;
BSF=S0;                    	%设置初始最优路径
%Length_ave = zeros(iter_max,1);      % 各代路径的平均长度 
Si=zeros(Candidate_Num,CityNum);

p=1;

while (p<StopL)
    if Candidate_Num>CityNum*(CityNum)/2
        disp('候选解个数需满足于不大于n*(n-1)/2(全部领域解个数)！');
        break;
    end
    
    ArrS(p)=TotalDistance(Distance_List,S);
    
%该部分程序生成候选解的随机交换位置矩阵，每一行代表一个候选解中
%的两个需要交换的位置的编号
    i=1;
    A=zeros(Candidate_Num,2);
    while i<=Candidate_Num        
        M=CityNum*rand(1,2);  	%随机产生元素值取值范围为[0,10]的2维行向量
        M=ceil(M);
        if M(1)~=M(2)
            m1=max(M(1),M(2));
            m2=min(M(1),M(2));
            A(i,1)=m1;A(i,2)=m2;  	%设置矩阵A在该行元素的第一个值为较大的值，
								%第二个值为较小的值
            if i==1              	%如果是第一次迭代则标记isdel=0
                isdel=0;
            else
                for j=1:i-1 		%逐行进行比较
%发现两行元素相同，即交换的位置完全相同，则标记isdel=1，
%且退出该层循环
                    if A(i,1)==A(j,1)&&A(i,2)==A(j,2)   
                        isdel=1;
                        break;
                    else
                        isdel=0;                        %否则标记isdel=0
                    end
                end
            end
            if ~isdel
                i=i+1;
            else
                i=i;
            end
        else
            i=i;
        end
    end
    
    %该部分为挑选出需要保留的解，即该层搜索中找到的距离最短的
%Reserved_Solution_Num个解
    CL=Inf*ones(Reserved_Solution_Num,4);
    for i=1:Candidate_Num
        Si(i,:)=S;                        %设置候选解的每一行S为初始随机序列
        Si(i,[A(i,1),A(i,2)])=S([A(i,2),A(i,1)]); %交换第i行的两个位置的数据
									  %位置的编号由A产生
%计算第i个候选解的总距离值        
TotalDistance(i)=TotalDistance(Distance_List,Si(i,:));   
        
        %如果候选解的序号小于保留解的总数，则直接记录这些候选解
if i<=Reserved_Solution_Num               
            CL(i,1)=i;                            %第i个候选解
            %记录候选解的总距离值
CL(i,2)=TotalDistance(i);  
%记录交换城市编号值，解序列第A(i,1)个元素的值，即城市编号           
            CL(i,3)=S(A(i,1));      
            %解序列第A(i,2)个元素的值，即城市编号 
            CL(i,4)=S(A(i,2));                    
        else
%如果候选解的序号大于保留解的总数，则将该候选解与已经保留的解的距
%离值进行比较，确定是否保留该候选解而去掉某已经保留的解
            for j=1:Reserved_Solution_Num         
                if TotalDistance(i)<CL(j,2)
                    CL(j,2)=TotalDistance(i);
                    CL(j,1)=i;
                    CL(j,3)=S(A(i,1));
                    CL(j,4)=S(A(i,2));
                    break;
                end
            end
        end
    end
    
    %特赦准则(aspiration criterion)
    %寻找Reserved_Solution_Num个保留解中的最优解
    current_bsf=CL(1,2);
    record_i=1;                  		%最优解的序号为record_i
    for i=2:Reserved_Solution_Num
        if CL(i,2)<current_bsf
            current_bsf=CL(i,2);
            record_i=i;
        end
    end
    
    if CL(record_i,2)<bsf          		%保留解中的最优解小于当前的最短距离bsf
        bsf=CL(record_i,2);
        S=Si(CL(record_i,1),:);        
        BSF=S;                    	%则记录保留解中最优解的路径
        for m=1:CityNum
            for n=1:CityNum
                if Tabu_list(m,n)~=0
                Tabu_list(m,n)=Tabu_list(m,n)-1;
                end
            end
        end
        Tabu_list(CL(record_i,3),CL(record_i,4))=tabu_length; %禁忌表设置
    else  
        for i=1:Reserved_Solution_Num              
            if Tabu_list(CL(i,3),CL(i,4))==0
                S=Si(CL(i,1),:);                
            for m=1:CityNum                 
                for n=1:CityNum
                    if Tabu_list(m,n)~=0
                        Tabu_list(m,n)=Tabu_list(m,n)-1;
                    end
                end
            end        
            Tabu_list(CL(i,3),CL(i,4))=tabu_length;         %禁忌表设置
            break;
            end
        end
    end    
    
    p=p+1;    
    xx=[xx;bsf];
end
%save Arrbsf Arrbsf;
[bsf_result(a,:),c(a,:)] = min(xx);
% BestShortcut=BSF        %搜索到的最优解的城市序列
% TheMinDistance=bsf      %搜索到的最优解的总距离值
% DrawPath(BSF,City_Coordinates);
% 
% figure
% plot(1:StopL,Arrbsf,'b'); 
% xlabel('迭代次数')
% ylabel('距离')
%title('各代最短距离与平均距离对比')

t(a,:)=toc;
end
save bsf_result bsf_result;
save c c;
save t t;

end

%求取一个城市序列的距离值函数，例如[3 1 2]即是3->1->2->3的总距离
function TotalDistance=TotalDistance(Distance_List,s)
DistanV=0;
n=size(s,2);
for i=1:(n-1)
    DistanV=DistanV+Distance_List(s(i),s(i+1));
end
DistanV=DistanV+Distance_List(s(n),s(1));
TotalDistance=DistanV;
end



% % 
% %% 画路径函数
% %输入
% % Chrom  待画路径   
% % X      各城市坐标位置
% function DrawPath(Chrom,X) 
% R=[Chrom(1,:) Chrom(1,1)]; %一个随机解(个体)
% figure;
% hold on;
% plot(X(:,1),X(:,2),'o','color',[0.5,0.5,0.5])%画出第一列为横坐标、第二列为纵坐标
% plot(X(Chrom(1,1),1),X(Chrom(1,1),2),'rv','MarkerSize',20) %Chrom的第一行、第一列 
% for i=1:size(X,1)%X的每行
%     text(X(i,1)+0.05,X(i,2)+0.05,num2str(i),'color',[1,0,0]);
% end
% A=X(R,:);
% row=size(A,1);
% for i=2:row
%     [arrowx,arrowy] = dsxy2figxy(gca,A(i-1:i,1),A(i-1:i,2));%坐标转换
%     annotation('textarrow',arrowx,arrowy,'HeadWidth',8,'color',[0,0,1]);
% end
% hold off
% text(X(Chrom(1),1),X(Chrom(1),2),'  起点');
% text(X(Chrom(end),1),X(Chrom(end),2),'  终点');
% xlabel('城市位置横坐标')
% ylabel('城市位置纵坐标')
% title('轨迹图')
% box on
% end
% 
% function varargout = dsxy2figxy(varargin)
% if length(varargin{1}) == 1 && ishandle(varargin{1}) ...
%                             && strcmp(get(varargin{1},'type'),'axes')   
%     hAx = varargin{1};
%     varargin = varargin(2:end);
% else
%     hAx = gca;
% end;
% if length(varargin) == 1
%     pos = varargin{1};
% else
%     [x,y] = deal(varargin{:});
% end
% axun = get(hAx,'Units');
% set(hAx,'Units','normalized'); 
% axpos = get(hAx,'Position');
% axlim = axis(hAx);
% axwidth = diff(axlim(1:2));
% axheight = diff(axlim(3:4));
% if exist('x','var')
%     varargout{1} = (x - axlim(1)) * axpos(3) / axwidth + axpos(1);
%     varargout{2} = (y - axlim(3)) * axpos(4) / axheight + axpos(2);
% else
%     pos(1) = (pos(1) - axlim(1)) / axwidth * axpos(3) + axpos(1);
%     pos(2) = (pos(2) - axlim(3)) / axheight * axpos(4) + axpos(2);
%     pos(3) = pos(3) * axpos(3) / axwidth;
%     pos(4) = pos(4) * axpos(4 )/ axheight;
%     varargout{1} = pos;
% end
% set(hAx,'Units',axun)
% end