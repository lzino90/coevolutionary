function [A] = AB(N,m)
%AB(N,m) generates an Albert-Barabasi random graph with size N and average degree m. Realized by Zino.
A=zeros(N);
A(1:m+1,1:m+1)=ones(m+1)-eye(m+1);
d=sum(A,2);
s0=m+1;
for i=(s0+1):N
    h=0;
    while h<m
    j=randvett(sommacumulativa(d(1:(i-1))/sum(d(1:(i-1)))));
    if A(i,j)==0
        d(i)=d(i)+1;
        d(j)=d(j)+1;
        A(i,j)=1;
        A(j,i)=1;
        h=h+1;
    end
    end
end
end

