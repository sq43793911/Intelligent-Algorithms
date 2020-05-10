%分类
clc;
clear;

BOM = xlsread('QYC120-BOM清单合并后.xls');
[a,b] = size(BOM);
c = zeros(3,1);
d = zeros(3,1);
for i = 3:a
    if c(1)<=0.85
    c(1) = BOM(i,12)+c(1);
    d(1)=d(1)+1;
    else
        if c(2)<=0.1385
            c(2) = BOM(i,12)+c(2);
            d(2)=d(2)+1;
        else
            c(3) = BOM(i,12)+c(3);
            d(3)=d(3)+1;
        end
    end
end