function [A] = circ(v)
%circ(v) constructs a circulant matrix A from a vector v.
N=length(v);
A=zeros(N);
A(1,:)=v;
S=diag(ones(1,N-1),1);
S(N,1)=1;
for i=2:N
    A(i,:)=A(i-1,:)*S;
end
end

