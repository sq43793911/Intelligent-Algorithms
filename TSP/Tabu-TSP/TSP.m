%tabu search to solve the TSP Problem
%by Zhaokai,zkcsu@126.com 
%Information School of Central South University
%2006-06
%revised by LiMing
%2010-02-11

function TSP(City_Coordinates)
Candidate_Num=40;          	%��ѡ��(candidate),ȡֵ������n*(n-1)/2(ȫ����������) 40��100
StopL=1000;          	%����������
b = 50; %��ѭ������
c=zeros(b,1); %������̵ĵ�����������
%BSF=zeros(b,N);
%mRandM=zeros(b,N);%����·��
bsf_result = zeros(b,1); %���·������
t=zeros(b,1); %����ʱ�伯��

for a = 1:b
    tic;
    xx=[];
m=size(City_Coordinates,1);

%������󣬳�ʼdistance_list(i,j)�������i�ͳ���j֮��ľ���
Distance_List=zeros(m);
for i=1:m
    for j=1:m
        Distance_List(i,j)=((City_Coordinates(i,1)-City_Coordinates(j,1))^2+...
        (City_Coordinates(i,2)-City_Coordinates(j,2))^2)^0.5;       
    end
end

CityNum=m;
Tabu_list=zeros(CityNum);   	%���ɱ�(tabu list)
Reserved_Solution_Num=10 ; 	%����Reserved_Solution_Num����ú�ѡ��
bsf=Inf;                   	%��������·���ĳ�ʼֵΪInf
tabu_length=ceil(CityNum^0.5); 	%���ɳ���(tabu length)
%save Candidate_Num Candidate_Num;

S0=randperm(CityNum);      	%������ɳ�ʼ������ 
S=S0;
BSF=S0;                    	%���ó�ʼ����·��
%Length_ave = zeros(iter_max,1);      % ����·����ƽ������ 
Si=zeros(Candidate_Num,CityNum);

p=1;

while (p<StopL)
    if Candidate_Num>CityNum*(CityNum)/2
        disp('��ѡ������������ڲ�����n*(n-1)/2(ȫ����������)��');
        break;
    end
    
    ArrS(p)=TotalDistance(Distance_List,S);
    
%�ò��ֳ������ɺ�ѡ����������λ�þ���ÿһ�д���һ����ѡ����
%��������Ҫ������λ�õı��
    i=1;
    A=zeros(Candidate_Num,2);
    while i<=Candidate_Num        
        M=CityNum*rand(1,2);  	%�������Ԫ��ֵȡֵ��ΧΪ[0,10]��2ά������
        M=ceil(M);
        if M(1)~=M(2)
            m1=max(M(1),M(2));
            m2=min(M(1),M(2));
            A(i,1)=m1;A(i,2)=m2;  	%���þ���A�ڸ���Ԫ�صĵ�һ��ֵΪ�ϴ��ֵ��
								%�ڶ���ֵΪ��С��ֵ
            if i==1              	%����ǵ�һ�ε�������isdel=0
                isdel=0;
            else
                for j=1:i-1 		%���н��бȽ�
%��������Ԫ����ͬ����������λ����ȫ��ͬ������isdel=1��
%���˳��ò�ѭ��
                    if A(i,1)==A(j,1)&&A(i,2)==A(j,2)   
                        isdel=1;
                        break;
                    else
                        isdel=0;                        %������isdel=0
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
    
    %�ò���Ϊ��ѡ����Ҫ�����Ľ⣬���ò��������ҵ��ľ�����̵�
%Reserved_Solution_Num����
    CL=Inf*ones(Reserved_Solution_Num,4);
    for i=1:Candidate_Num
        Si(i,:)=S;                        %���ú�ѡ���ÿһ��SΪ��ʼ�������
        Si(i,[A(i,1),A(i,2)])=S([A(i,2),A(i,1)]); %������i�е�����λ�õ�����
									  %λ�õı����A����
%�����i����ѡ����ܾ���ֵ        
TotalDistance(i)=TotalDistance(Distance_List,Si(i,:));   
        
        %�����ѡ������С�ڱ��������������ֱ�Ӽ�¼��Щ��ѡ��
if i<=Reserved_Solution_Num               
            CL(i,1)=i;                            %��i����ѡ��
            %��¼��ѡ����ܾ���ֵ
CL(i,2)=TotalDistance(i);  
%��¼�������б��ֵ�������е�A(i,1)��Ԫ�ص�ֵ�������б��           
            CL(i,3)=S(A(i,1));      
            %�����е�A(i,2)��Ԫ�ص�ֵ�������б�� 
            CL(i,4)=S(A(i,2));                    
        else
%�����ѡ�����Ŵ��ڱ�������������򽫸ú�ѡ�����Ѿ������Ľ�ľ�
%��ֵ���бȽϣ�ȷ���Ƿ����ú�ѡ���ȥ��ĳ�Ѿ������Ľ�
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
    
    %����׼��(aspiration criterion)
    %Ѱ��Reserved_Solution_Num���������е����Ž�
    current_bsf=CL(1,2);
    record_i=1;                  		%���Ž�����Ϊrecord_i
    for i=2:Reserved_Solution_Num
        if CL(i,2)<current_bsf
            current_bsf=CL(i,2);
            record_i=i;
        end
    end
    
    if CL(record_i,2)<bsf          		%�������е����Ž�С�ڵ�ǰ����̾���bsf
        bsf=CL(record_i,2);
        S=Si(CL(record_i,1),:);        
        BSF=S;                    	%���¼�����������Ž��·��
        for m=1:CityNum
            for n=1:CityNum
                if Tabu_list(m,n)~=0
                Tabu_list(m,n)=Tabu_list(m,n)-1;
                end
            end
        end
        Tabu_list(CL(record_i,3),CL(record_i,4))=tabu_length; %���ɱ�����
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
            Tabu_list(CL(i,3),CL(i,4))=tabu_length;         %���ɱ�����
            break;
            end
        end
    end    
    
    p=p+1;    
    xx=[xx;bsf];
end
%save Arrbsf Arrbsf;
[bsf_result(a,:),c(a,:)] = min(xx);
% BestShortcut=BSF        %�����������Ž�ĳ�������
% TheMinDistance=bsf      %�����������Ž���ܾ���ֵ
% DrawPath(BSF,City_Coordinates);
% 
% figure
% plot(1:StopL,Arrbsf,'b'); 
% xlabel('��������')
% ylabel('����')
%title('������̾�����ƽ������Ա�')

t(a,:)=toc;
end
save bsf_result bsf_result;
save c c;
save t t;

end

%��ȡһ���������еľ���ֵ����������[3 1 2]����3->1->2->3���ܾ���
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
% %% ��·������
% %����
% % Chrom  ����·��   
% % X      ����������λ��
% function DrawPath(Chrom,X) 
% R=[Chrom(1,:) Chrom(1,1)]; %һ�������(����)
% figure;
% hold on;
% plot(X(:,1),X(:,2),'o','color',[0.5,0.5,0.5])%������һ��Ϊ�����ꡢ�ڶ���Ϊ������
% plot(X(Chrom(1,1),1),X(Chrom(1,1),2),'rv','MarkerSize',20) %Chrom�ĵ�һ�С���һ�� 
% for i=1:size(X,1)%X��ÿ��
%     text(X(i,1)+0.05,X(i,2)+0.05,num2str(i),'color',[1,0,0]);
% end
% A=X(R,:);
% row=size(A,1);
% for i=2:row
%     [arrowx,arrowy] = dsxy2figxy(gca,A(i-1:i,1),A(i-1:i,2));%����ת��
%     annotation('textarrow',arrowx,arrowy,'HeadWidth',8,'color',[0,0,1]);
% end
% hold off
% text(X(Chrom(1),1),X(Chrom(1),2),'  ���');
% text(X(Chrom(end),1),X(Chrom(end),2),'  �յ�');
% xlabel('����λ�ú�����')
% ylabel('����λ��������')
% title('�켣ͼ')
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