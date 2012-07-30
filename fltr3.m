function I=fltr3(Im,B_pi,W_pi,B_sq,W_sq)
I=0;
I=double(Im);
 for i=1:size(I,1)
    for j=1:size(I,2)
        k=0;clr=0;
        k(1)= abs (I(i,j) - B_sq);
        k(2)= abs (I(i,j) - W_sq);
        k(3)= abs (I(i,j) - B_pi);
        k(4)= abs (I(i,j) - W_pi);
        [k ind]=sort(k,'ascend');
        if ind(1) == 1
        I(i,j)=B_sq;
        elseif ind(1) == 2
        I(i,j)=W_sq;
        elseif ind(1) == 3
        I(i,j)=B_pi;
        elseif ind(1) == 4
        I(i,j)=W_pi;
        end
        end
end
 I=uint8(I);