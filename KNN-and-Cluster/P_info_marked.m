%% Police_info Classification 

clear all;

%% load data
[p_num, p_txt] = xlsread('Police_Man_without_nomeans_one_weak_morning'); 
% Col5=Time(h:m:s), Col9=deltaTime(s), Col10=Distence(m), Col11=Speed(m/s),
% Col12=Acceleration(m/s*s), Col13=ZTL

[a,b] = size(p_num);


%Main
d = 1;
while d<=a
    p_id  = p_num(d, 2);  %确定警员ID
    p_id_rows = find(p_num(:,2)==p_id); %定位警员ID
    f = size(p_id_rows,1);
    g =1;
    % 对固定ID进行循环
    while g <= f
        x = p_id_rows(1)+1;
        y = p_id_rows(f) +1;
        p_date = p_txt(x : y, 4);
        j = p_date(g);
        k = strcmp(p_date, j);
        p_date_rows = find(k==1);
        m = size(p_date_rows,1);
        q = 1;
        % 对固定天进行循环
        for n = 1:m
            rows = p_date_rows(n);
            t_time = sum(p_num(q:rows,9));
            if t_time > 1200
                p_num(rows-1,16) = prctile(p_num(q:rows-1, 10), 75);
                q = n;
            end
        end
        
                
        
            
        
        
        
%     if p_num(c,9)>=60 && p_num(c,9)<=300
        if sum(p_num(d:c,9))<= 1200
            if p_num(c,10)<=10 && p_num(c,11)<=1.5 && abs(p_num(c,12))<=0.01
                p_num(c,16) = 1;
            else
                p_num(c,16) = 2;
            end
        else
            e = tabulate(p_num(d:c-1,16));
            if e(1,3)>=90
                p_num(d:c,17) = 1;
%             elseif abs(e(1,3)-e(2,3))<=40
%                 p_num(d:c,16) = 2;
            elseif e(2,3)>=70
                p_num(d:c,17) = 3;
            else
                p_num(d:c,17) = 2;
            end
            if p_num(c,10)<=10 && p_num(c,11)<=0.1 && abs(p_num(c,12))<=0.01
                p_num(c,16) = 1;
            else
                p_num(c,16) = 2;
            end
            d = c;
        end
        if c == a
            e = tabulate(p_num(d:c-1,16));
            if e(1,3)>=90
                p_num(d:c,17) = 1;
%             elseif abs(e(1,3)-e(2,3))<=40
%                 p_num(d:c,16) = 2;
            elseif e(2,3)>=70
                p_num(d:c,17) = 3;
            else
                p_num(d:c,17) = 2;
            end
        end
end


