function P = SRW(A,s)
%SRW(A,s) generates a simple random walk consensus matrix adapted to a graph given its dajacency matrix A and the set of stubborn nodes s. Realized by Zino.
n=size(A,1);
d=sum(A,2);
for i=1:n
    if d(i)==0
        A(i,i)=1;
        d(i)=1;
    end
end
P=diag(d.^(-1))*A;
if nargin==2
    for i=1:length(s)
        P(s(i),1:n)=(s(i)==1:n);
    end
end
end

