tic
%%code to use video named"ch3.avi" in the same directory
% clc
% clear all;
% close all;
% che_vid=mmreader('ch3.avi');
% out=0;
% i=0;
% rate=fix(che_vid.FrameRate);
% while(out == 0)
%     i=i+2*rate;
%     I=read(che_vid,i);
%     out=ischessboard(I);
% end
% ffnum=i;
% F_frame=I;
% [cordi sqdim]=sqsize(F_frame,10,10);
% % siz=size(I);
% % m=siz(1);n=siz(2);
% [rowcordi colcordi]=rmborder(I,cordi(1),cordi(2),sqdim(1),sqdim(2));
% k=1;
% for p=1:8
%     for q=1:8
%         for m=1:rowcordi(p+1)-rowcordi(p)
%             for n=1:colcordi(q+1)-colcordi(q)
%                 a(m,n,1,k)=F_frame(rowcordi(p)+m,colcordi(q)+n,1);
%                 a(m,n,2,k)=F_frame(rowcordi(p)+m,colcordi(q)+n,2);
%                 a(m,n,3,k)=F_frame(rowcordi(p)+m,colcordi(q)+n,3);
%             end
%         end
%         k=k+1;
%     end
% end
% e5=a(:,:,:,29);e51=rgb2gray(e5);
% e4=a(:,:,:,37);e41=rgb2gray(e4);
% a1=a(:,:,:,57);a11=rgb2gray(a1);
% a8=a(:,:,:,1);a81=rgb2gray(a8);
% m=0;n=0;
% for i=floor(3*size(a11,1)/10):floor(6*size(a11,1)/10)
%     m=m+1;n=0;
%     for j=floor(3*size(a11,2)/10):floor(6*size(a11,2)/10)
%         n=n+1;
%         a111(m,n)=a11(i,j);
%     end
% end
% m=0;n=0;
% for i=floor(3*size(a81,1)/10):floor(6*size(a81,1)/10)
%     m=m+1;n=0;
%     for j=floor(3*size(a81,2)/10):floor(6*size(a81,2)/10)
%         n=n+1;
%         a811(m,n)=a81(i,j);
%     end
% end
% [t B_sq]=max(imhist(e51));[t W_sq]=max(imhist(e41));
% [t B_sq]=max(imhist(e51));[t W_sq]=max(imhist(e41));
% [temp1 pos1]=sort(imhist(a811),'descend');[temp2 pos2]=sort(imhist(a111),'descend');
% B_pi=pos1(1); W_pi=pos2(1)-1;
% if B_sq==B_pi||B_pi==W_sq
%     B_pi=pos1(2);
% end
% if W_sq==W_pi||W_pi==B_sq
%     W_pi=pos2(2)-1;
% end
% boardconfiguration='correct';
% if W_pi<B_pi
%     toi=W_pi;
%     W_pi=B_pi-1;
%     B_pi=toi;
%     boardconfiguration='flipped';
% end
% colors=[B_sq W_sq B_pi W_pi];
%  p=1;
%%
 load reqframesgray
 load totalgame
temp=F_frame;
for j=ffnum:4:4480
    I2=read(che_vid,j);
    I3=rgb2gray(I2);
    new=ysorno(temp,I3,rowcordi,colcordi);
    if new == 1
        reqframesgray(:,:,p)=I3;
        frmnum1(p)=j;
        p=p+1;
    end
    temp=I3;
end
for j=1:size(reqframesgray,3)
    k=1;
    for p=1:8
        for q=1:8
            for m=1:rowcordi(p+1)-rowcordi(p)
                for n=1:colcordi(q+1)-colcordi(q)
                    totalgame(m,n,k,j)=double(reqframesgray(rowcordi(p)+m,colcordi(q)+n,j));
                end
            end
            k=k+1;
        end
    end
end
if boardconfiguration=='correct';
    boardconfiguration1=0;
    board='rnbqkbnrppppppppPPPPPPPPRNBQKBNR';
elseif boardconfiguration=='flipped';
    boardconfiguration1=1;
    board='RNBKQBNRPPPPPPPPpppppppprnbkqbnr';
end
strtotalgame(1,64,size(reqframesgray,3))='0';
for i=1:16
    strtotalgame(1,i,1)=board(i);
end
for i=17:32
    strtotalgame(1,i+32,1)=board(i);
end
k=1;
for i=1:8
    for j=1:8
        anytimstr(i,j)=strtotalgame(1,k,size(reqframesgray,3));
        k=k+1;
    end
end
countf=0;
frame=0;
rmoves=ceil((size(reqframesgray,3)-1)/2);
pgnout(1,1)='0';
for i=2:size(reqframesgray,3)    
                ccross=0;
if i < 11
        pgn(1)='0';
        pgn(2)='0';
        pgn(3)=num2str(i-1);
    elseif i >= 11 && i < 101
        gh=num2str(i-1);
        pgn(1)='0';
        pgn(2)=gh(1);
        pgn(3)=gh(2);
    elseif i >= 101
        gh=num2str(i-1);
        pgn(1)=gh(1);
        pgn(2)=gh(2);
        pgn(3)=gh(3);
    end
    pgn(4)='.';
cuse1=pgn;
    strtotalgame(:,:,i)=strtotalgame(:,:,i-1);
    changetr=zeros(1,64);
    cnt=zeros(1,64);
    for j=1:64
        for x1=1:size(totalgame(:,:,j,i),1)
            for x2=1:size(totalgame(:,:,j,i),2)
                if(abs(totalgame(x1,x2,j,i)- totalgame(x1,x2,j,i-1)) > 20)
                    cnt(j)=cnt(j)+1;
                end
            end
        end
        if (cnt(j) > 300)
            changetr(j)=1;
        end
    end
    flag=0;
    qsc=0;
    ksc=0;
    if (sum(changetr) == 4)
        if(changetr(5) == 1)
            flag=1;
            if(changetr(1) == 1)
                if(changetr(2) == 1)
                    strtotalgame(1,2,i)='k';
                    strtotalgame(1,3,i)='r';
                elseif(changetr(4) == 1)
                    strtotalgame(1,3,i)='k';
                    strtotalgame(1,4,i)='r';
                    qsc=1;
                end
            elseif(changetr(8) == 1)
                strtotalgame(1,7,i)='k';
                strtotalgame(1,6,i)='r';
                ksc=1;
            end
        elseif(changetr(61) == 1)
            flag=1;
            if(changetr(57) == 1)
                if(changetr(58) == 1)
                    strtotalgame(1,58,i)='K';
                    strtotalgame(1,59,i)='R';
                elseif(changetr(60) == 1)
                    strtotalgame(1,59,i)='K';
                    strtotalgame(1,60,i)='R';
                    qsc=1;
                end
            elseif(changetr(64) == 1)
                strtotalgame(1,63,i)='K';
                strtotalgame(1,62,i)='R';
            ksc=1;
            end
        end
    elseif(sum(changetr) ~= 4 || flag == 0)
        for p=1:64
            if(changetr(p) == 1)
                g=fltr3(totalgame(:,:,p,i),colors(3),colors(4),colors(1),colors(2));
                can(:,:,p)=edge(g,'canny');
                g1(p)=peri(can(:,:,p));
                if g1(p) == 0
                    tempstr1=strtotalgame(:,p,i-1);
                    strtotalgame(:,p,i)=0;
                    gh=sqname(p);
                    cuse2=[tempstr1 gh];
                end
            end
        end
        for p=1:64
            if(changetr(p) == 1)
                if g1(p) ~= 0
                    tempstr2=strtotalgame(:,p,i-1);
                    strtotalgame(:,p,i)=tempstr2;
                    if(double(tempstr2) ~= 0)
                        ccross=1;
                        tempstr2;
                    end
                    gh=sqname(p);
                    cuse3=[gh];
                end
            end
        end
    end
    setf=0;
      if(qsc == 1)
        setf=1;
        cuse3='000';
   disp1=[cuse3];
    end
    if(ksc == 1)
        setf=1;
        cuse3='0 0';
   disp1=[cuse3];
    end
    if(setf == 0)
        cuse4=cuse2(1);
    end
    if(double(cuse4) > 96)
        cuse4=cuse4-32;
    end
    if(double(tempstr2) > 96)
        tempstr2=tempstr2-32;
    end
    if(((cuse4 == 'p') || (cuse4 == 'P')) && (setf == 0))
        disp1=[cuse3];
        
    elseif(setf == 0)
        disp1=[cuse4 cuse3];
    end
    if((setf == 0) && (ccross == 1))
        disp1=[cuse4 'x' tempstr2];
    end
    countf=countf+1;
   if(countf == 2)
     frame=frame+1;
     strframe=num2str(frame);
       countf=0;
   dispout=[strframe '.' tempdisp ' ' disp1];
   for testi=1:size(dispout,2);
   pgnout(frame,testi)=(dispout(1,testi));
   end
   end
    tempdisp=disp1;
end
dlmwrite('chesspgn.txt',pgnout,'delimiter','')
toc