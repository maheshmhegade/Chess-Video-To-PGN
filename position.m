function position1=position(imag,oareaarr1,operiarr1,rowcordi,colcordi,colors,boardconfiguration)
[picepresence a]=trfal(imag,rowcordi,colcordi,colors);
boardconfiguration
for k=1:64
    tt=rgb2gray(a(:,:,:,k));
    mm(:,:,k)=fltr3(tt,colors(3),colors(4),colors(1),colors(2));
end
if boardconfiguration=='correct';
    boardconfiguration1=0;
    board='rnbqkbnrppppppppPPPPPPPPRNBQKBNR';
elseif boardconfiguration=='flipped';
    boardconfiguration1=1;
    board='RNBKQBNRPPPPPPPPpppppppprnbkqbnr';
end
for i=1:64
    positionarr(i)='0';
    if picepresence(i)==1
        m=0;n=0;
        smothimag=picesmothing(rgb2gray(a(:,:,:,i)),colors(4));
        count9=0;
        for l1=1:size(smothimag,1)
            for l2=1:size(smothimag,2)
                if smothimag(l1,l2)==colors(4)
                    count9=count9+1;
                end
            end
        end
        flag=0;
        if count9>300
            flag=1;
        end
        u=colors(2);
        if( rem(i,2) == 0)
            u=colors(1);
        end
        area(i)=measure(mm(:,:,i),u);
        %         area(i)=areaofpic(mm(:,:,i),colors(1),colors(2));
        d2=edge(mm(:,:,i),'canny');
        peri1(i)=peri(d2);
        if (flag==0&&boardconfiguration1==0)
            for j=1:16
                diffarea(j)=abs(area(i)-oareaarr1(j));diffperi(j)=abs(peri1(i)-operiarr1(j));
            end
            [rec put]=min(diffarea+diffperi);
            if rec<100
                positionarr(i)=board(put);
            end
        end
        if (flag==1&&boardconfiguration1==0)
            for j=17:32
                diffarea(j-16)=abs(area(i)-oareaarr1(j));diffperi(j-16)=abs(peri1(i)-operiarr1(j));
            end
            [rec put]=min(diffarea+diffperi);
            if rec<100
                positionarr(i)=board(put+16);
            end
        end
        if (flag==1&&boardconfiguration1==1)
            for j=1:16
                diffarea(j)=abs(area(i)-oareaarr1(j));diffperi(j)=abs(peri1(i)-operiarr1(j));
            end
            [rec put]=min(diffarea+diffperi);
            if rec<100
                positionarr(i)=board(put);
            end
        end
        if (flag==0&&boardconfiguration1==1)
            for j=17:32
                diffarea(j-16)=abs(area(i)-oareaarr1(j));diffperi(j-16)=abs(peri1(i)-operiarr1(j));
            end
            [rec put]=min(diffarea+diffperi);
            if rec<100
                positionarr(i)=board(16+put);
            end
        end
    end
end
k=1;
for i=1:8
    for j=1:8
        position1(i,j)=positionarr(k);
        k=k+1;
    end
end