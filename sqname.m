function out = sqname(k)
num='87654321';
str='abcdefgh';
dig1=floor(k/8);
dig2=rem(k,8);
for i=1:8
    if (i == dig1+1)
        out(2)=num(i);
    end
    if (i == dig2)
        out(1)=str(i);
    end
end
if dig2 == 0;
    out(2)=num(dig1);
    out(1)='h';
end