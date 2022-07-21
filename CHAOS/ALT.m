function W = ALT(A,m)
n=size(A,2);
x=-1*ones(1,n);
if length(m)==1
    x(1:m)=1;
else
    x(m)=1;
end
M=x'*x;
W=SRW(A).*M;
end