 function out =peri(I)
% if (numel(I) == 3)
%     I=rgb2gray(I);
% end
m=0;
% image=0;
% I=sq_t;blk=145;wit=211;
image=uint8(zeros(fix(0.7*size(I,1)),fix(0.7*size(I,2))));
for i=floor(size(I,1)/10):floor(8*size(I,1)/10)
    m=m+1;n=0;
    for j=floor(size(I,2)/10):floor(8*size(I,2)/10)
        n=n+1;
        image(m,n)=I(i,j);
    end
end
% ed=edge(image,'canny');
out=sum(sum(image));
if out < 50
    out=0;
end
