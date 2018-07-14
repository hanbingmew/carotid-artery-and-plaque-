f=imread('53.bmp');
g=f(70:730,206:818);
g_adjust=histeq(g,256);
sum_row=sum(g,2);
[pks,loc]=findpeaks(sum_row);
[sp,ind1]=sort(pks,'descend');
loc1=loc(ind1(1));
loc2=loc(ind1(2));
g1=g_adjust(min(loc1,loc2)-10:max(loc1,loc2)+10,:);
g2=edge(g1,'sobel','horizontal');
g2(1:size(g1,1)/2,:)=0;
g3=imdilate(g2,ones(3,3));
[L,num]=bwlabel(g3);
len=zeros(num,1);
for i=1:num
    ind{i}=find(L==i);
    len(i)=length(ind{i});
end
[sl,ind2]=sort(len,'descend');
g4=zeros(size(g3));
% for i=1:3
%     g4(ind{ind2(i)})=1; 
% end
g4(ind{ind2(1)})=1;
g5=bwmorph(g4,'thin',inf);
g6=zeros(size(g5));
for i=1:size(g5,2)
    m=max(g5(:,i));
    if m==1
        ind3=find(g5(:,i)==1);
        g6(min(ind3),i)=1;
    end
end
g7=zeros(size(g));
g7(min(loc1,loc2)-10:max(loc1,loc2)+10,:)=g6;
[r1,c1]=find(g7==1);
imshow(g);
hold on
plot(c1,r1,'r');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
