function [rowcordi colcordi]=rmborder(I,row,col,sq1,sq2)
k=I;
a=size(k);
if (numel(a)==3)
    k=rgb2gray(k);
end
edge_I=edge(k,'canny');
sum_edge=sum(edge_I);
st2=col;p=0;
for i=1:5
    for j=-15:1:15
        if (st2+j<a(2))
        maxi(j+16)=sum_edge(st2+j);
        end
    end
    for k=-15:1:15
        if st2+k<a(2)
        if (sum_edge(st2+k)==max(maxi));
            colcordi(p+5)=st2+k;
        end
        end
    end
    if p+5==9;
        [di nu]=sort(maxi,'descend');
        if (di(1)-di(2)<80)
            if st2+nu(1)-15-colcordi(p+4)<st2+nu(2)-15-colcordi(p+4)
                colcordi(p+5)=st2+nu(1)-15;
            elseif st2+nu(1)-15-colcordi(p+4)>st2+nu(2)-15-colcordi(p+4)
                colcordi(p+5)=st2+nu(2)-15;
            end
        end
    end
    st2=colcordi(p+5)+sq2;
    p=p+1;
end
st2=col;p=0;
for i=1:5
    for j=-15:1:15
        if (st2+j>0)
        maxi(j+16)=sum_edge(st2+j);
        end
    end
    for k=-15:1:15
        if(st2+k>0)
        if (sum_edge(st2+k)==max(maxi));
            colcordi(p+5)=st2+k;
        end
        end
    end
    if p+5==1;
        [di nu]=sort(maxi,'descend');
        if (di(1)-di(2)<80)
            if abs(st2+nu(1)-15-colcordi(p+6))<abs(st2+nu(2)-15-colcordi(p+6))
                colcordi(p+5)=st2+nu(1)-15;
            elseif abs(st2+nu(1)-15-colcordi(p+6))>abs(st2+nu(2)-15-colcordi(p+6))
                colcordi(p+5)=st2+nu(2)-15;
            end
        end
    end
    st2=colcordi(p+5)-sq2;
    p=p-1;
end
sum_edge=sum(edge_I');
st2=row;p=0;
for i=1:5
    for j=-15:1:15
        if (st2+j<a(1))
        maxi(j+16)=sum_edge(st2+j);
        end
    end
    for k=-15:1:15
        if (st2+k<a(1))
        if (sum_edge(st2+k)==max(maxi));
            rowcordi(p+5)=st2+k;
        end
        end
    end
     if p+5==9;
        [di nu]=sort(maxi,'descend');
        if (di(1)-di(2)<80)
            if st2+nu(1)-15-rowcordi(p+4)<st2+nu(2)-15-rowcordi(p+4)
                rowcordi(p+5)=st2+nu(1)-15;
            elseif st2+nu(1)-15-rowcordi(p+4)>st2+nu(2)-15-rowcordi(p+4)
                rowcordi(p+5)=st2+nu(2)-15;
            end
        end
    end
    st2=rowcordi(p+5)+sq1;
    p=p+1;
end
st2=row;p=0;
for i=1:5
    for j=-15:1:15
        if st2+j>0
        maxi(j+16)=sum_edge(st2+j);
        end
    end
    for k=-15:1:15
        if st2+k>0;
        if (sum_edge(st2+k)==max(maxi));
            rowcordi(p+5)=st2+k;
        end
        end
    end
    if p+5==1;
        [di nu]=sort(maxi,'descend');
        if (di(1)-di(2)<80)
            if abs(st2+nu(1)-15-rowcordi(p+6))<abs(st2+nu(2)-15-rowcordi(p+6))
                rowcordi(p+5)=st2+nu(1)-15;
            elseif abs(st2+nu(1)-15-rowcordi(p+6))>abs(st2+nu(2)-15-rowcordi(p+6))
                rowcordi(p+5)=st2+nu(2)-15;
            end
        end
    end
    st2=rowcordi(p+5)-sq1;
    p=p-1;
end