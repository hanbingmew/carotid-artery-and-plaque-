f1=imread('23.bmp');
f1=f1(70:730,206:818);
sum_row=sum(f1,2);
[pks,loc]=findpeaks(sum_row);
[sp,ind1]=sort(pks,'descend');
loc1=loc(ind1(1));
loc2=loc(ind1(2));
w=fspecial('average',3);
fa=imfilter(f1,w,'replicate');
fa=fa(min(loc1,loc2)-10:max(loc1,loc2)+10,:);
T=graythresh(fa);
g=im2bw(fa,T);
g1=edge(g,'sobel','horizontal');
g1(size(g1,1)/2:size(g1,1),:)=0;
g2=imdilate(g1,ones(3,3));
[L,num]=bwlabel(g2);
len=zeros(num,1);
for i=1:num
    idx{i}=find(L==i);
    len(i)=length(idx{i});
end
[sl,id1]=sort(len,'descend');
len_av=mean(len);
is_large=sl>=mean(len);
id1_large=id1.*is_large;
g3=zeros(size(g2));
for i=1:length(id1_large)
    if id1_large(i)>0
        g3(idx{id1(i)})=1; 
    end
end
g4=bwmorph(g3,'thin',inf);
g5=zeros(size(g4));
for i=1:size(g4,2)
    col_vec=g4(:,i);
    m=max(col_vec);
    if m==1
        id2=find(col_vec==1);
        g5(max(id2),i)=1;
    end
end
g6=zeros(size(f1));
g6(min(loc1,loc2)-10:max(loc1,loc2)+10,:)=g5;
[r2,c2]=find(g6==1);
imshow(f1);
hold on
plot(c2,r2,'r');