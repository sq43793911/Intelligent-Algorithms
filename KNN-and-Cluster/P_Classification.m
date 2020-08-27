%% Police_info Classification 

%clear all;

%% load data
% [p_num, p_txt] = xlsread('Police_Man_without_nomeans_new'); 
% Col5=Time(h:m:s), Col7=deltaTime(s), Col8=Distence(m), Col9=Speed(m/s),
% Col10=Acceleration(m/s*s)

[a,b] = size(p_num);


%Main
min1 = 80;
min2 = 80;
d = 1;
for c = 1 : a
%     if p_num(c,9)>=60 && p_num(c,9)<=300
        if sum(p_num(d:c,4))<= 1200
            if p_num(c,5)<=10 && p_num(c,6)<=0.1 && abs(p_num(c,7))<=0.01
                p_num(c,15) = 1;
            else
                p_num(c,15) = 2;
            end
        else
            e = tabulate(p_num(d:c-1,15));
            if e(1,3)>=min1
                p_num(d:c,16) = 1;
%             elseif abs(e(1,3)-e(2,3))<=40
%                 p_num(d:c,16) = 2;
            elseif e(2,3)>=min2
                p_num(d:c,16) = 3;
            else
                p_num(d:c,16) = 2;
            end
            if p_num(c,5)<=10 && p_num(c,6)<=0.1 && abs(p_num(c,7))<=0.01
                p_num(c,15) = 1;
            else
                p_num(c,15) = 2;
            end
            d = c;
        end
        if c == a
            e = tabulate(p_num(d:c-1,15));
            if e(1,3)>=min1
                p_num(d:c,16) = 1;
%             elseif abs(e(1,3)-e(2,3))<=40
%                 p_num(d:c,16) = 2;
            elseif e(2,3)>=min2
                p_num(d:c,16) = 3;
            else
                p_num(d:c,16) = 2;
            end
        end
end


