function out=ischessboard(I)
% I=imread('2.jpg');
a=size(I);
if (numel(a)==3)
    I=rgb2gray(I);
end
% imtool(I)
a=size(I);
%imtool(I)
edge_I=edge(I,'canny');
%  imtool(edge_I)
sum_edge=sum(edge_I);

max_sum_edge=max(sum_edge);
count=0;
for i=1:a(2)
    if(sum_edge(i)>.5*max_sum_edge)
        count=count+1;
    end
end
% plot(sum_edge,'r')
% hold on
% grid on
sum_edge=sum(edge_I');
max_sum_edge=max(sum_edge);
count2=0;
for i=1:a(1)
    if(sum_edge(i)>.5*max_sum_edge)
        count2=count2+1;
    end
end
%  plot(sum_edge)
diff=abs(count-count2);
flag=0;
if(diff < 8 && (count+count2)<25&&count>6&&count2>6)
    flag=1;
end
% count
% count2


out=flag;