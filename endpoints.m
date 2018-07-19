function g = endpoints(f)

g=zeros(size(f));
for i=2:size(g,1)-1
    for j=2:size(g,2)-1
        nhood=f(i-1:i+1,j-1:j+1);
        if nhood(2,2)==1 && sum(nhood(:))==2
            g(i,j)=1;
        end
    end
end
        
