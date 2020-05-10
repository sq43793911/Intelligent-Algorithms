function acc_time = time2num(Acc_txt)
%% 时间格式的转换，将文本格式的时间转换为数字时间

[a, b] = size(Acc_txt);

acc_time = zeros(a,3);

for c = 1 : 3
    for d = 2 : a
        acc_time(a,c) = datenum( Acc_txt(a,c+2) );
    end
end