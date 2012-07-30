function out=ysorno(I1,I2,rowcordi,colcordi)
out=0;
cnt=0;
for i=rowcordi(1):rowcordi(9)
    for j=colcordi(1):colcordi(9)
        if(abs(I1(i,j) - I2(i,j)) > 40)
            cnt=cnt+1;
        end
    end
end
if(cnt > 300)
    out=1;
end
