%% Police_info 3D Plot 

clear all;

%% load data
[p_num, p_txt] = xlsread('Police_Man_without_nomeans_one_weak_morning'); 
% Col5=Time(h:m:s), Col9=deltaTime(s), Col10=Distence(m), Col11=Speed(m/s),
% Col12=Acceleration(m/s*s), Col13=ZTL

[a,b] = size(p_num);


%Main
d = 2;
% while d<=a
    p_date = p_txt(d, 4);
    pd = p_date;
    
    f = strcmp(p_txt(:,4), pd);
    p_date_rows = find(f==1);
    pdr = p_date_rows-1;
    
    g = size(pdr,1);
    
    p_date_num = p_num(pdr,:);
    pdn = p_date_num;
    
    h = 1;
    j = 1;
    k = 0;
    m = 0;
    n = 0;
    p= 0;
    r = 0;
    s = 0;
    Linewidth = 1.5;
    Colorstep = 0.05;
    while h <= g
        p_id = pdn(h,2);
        pi = p_id;
        
        p_id_rows = find(pdn(:,2)==pi);
        pir = p_id_rows;
        
        i = size(pir,1);
        p_id_num = pdn(pir,:);
        pin = p_id_num;
            figure(j)
            plot3(pin(:,6),pin(:,7),pin(:,5), 'Color',[k, m, n],'LineWidth',Linewidth);
            title (['Police Man info'; pd]);
            set(gca,'ztick',min(pdn(:,5)):0.01:max(pdn(:,5)));
            zlabel 'Time';
            xlabel 'Longitude';
            ylabel 'Latituede';
            datetick('z', 15,'keepticks');
            set(gca,'Fontsize',24);
            hold on;
            grid on;
            
            k = k+Colorstep;
            p =1;
            if k >= 1
                if p == 1
                    if m <=1 && n<=1
                        k = 1;
                        m = m +Colorstep;
                        if m >= 1
                            m =1;
                            n = n +Colorstep;
                            if n >= 1
                                n = 1;
                                k = 0;
                                m =1;
                                p = 2;
                            end
                        end
                    end
                elseif p == 2
                    k = 1;
                    m =0;
                    n =1;
                    P =1;
                end
                    
            end
                        
                        
            
            h = pir(i)+1;
        
    end

    
    


