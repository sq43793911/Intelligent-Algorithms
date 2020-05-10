function result=InitAntigen(A,B)
[m,n]=size(A);
Index=1:n;
result=[B];
tmp=B;
Index(:,B)=[];
for col=2:n
    [p,q]=size(Index);
    templen=D(tmp,Index(1,1));
    tmpID=1;
    for as=1:q
        if D(tmp,Index(1:ss))<tmplen
            tmpID=ss;
            templen=D(tmp,Index(1,ss));
        end
    end
    tmp=Index(1,tmpID);
    result=[result tmp];
    Index(:,tmpID)=[]
end