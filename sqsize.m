 function [cordi sqdim]=sqsize(k,in1,in2)
a=size(k);
g=k;
if (numel(a)==3)
    g=rgb2gray(k);
end
m=a(1);n=a(2);
pic_x=fix((m+in1)/2);
pic_y=fix((n+in2)/2);
gxy=g(pic_x,pic_y);
flag=0;
i=0;
while(flag == 0)
   i=i+1;  
   if(abs(g(pic_x,pic_y)-g(pic_x,pic_y-i)) > 30)
       col1=pic_y-i;
       flag=1;
   end
end
flag=0;
i=0;
while(flag == 0)
   i=i+1;  
   if(abs(g(pic_x,pic_y)-g(pic_x,pic_y+i)) > 30)
       col2=pic_y+i;
       flag=1;
   end
end
flag=0;
i=0;
while(flag == 0)
   i=i+1;  
   if(abs(g(pic_x,pic_y)-g(pic_x-i,pic_y)) > 10)
       row1=pic_x-i;
       flag=1;
   end
end        
flag=0;
i=0;
while(flag == 0)
   i=i+1;  
   if(abs(g(pic_x,pic_y)-g(pic_x+i,pic_y)) >= 10)
       row2=pic_x+i;
       flag=1;
   end
end
a=row1;row=row1;
b=col1;col=col1;
c=row2;
d=col2;
sq1=c-a;sq2=d-b;
% sd1=c-a;
% sd2=d-b;
% sd1=a+(4*t1);
% sd2=b+(4*t2);
% st1=a-(4*t1);
% st2=b-(4*t2);
cordi=[row col];sqdim=[ sq1 sq2];