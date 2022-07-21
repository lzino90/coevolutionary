function [A] = WS(N,K,p)
%WS(N,K,p) generates Watts-Strogatz random graph with N nodes, average
%degree K (must be even) and replacing probability p. Realized by Zino.
v=zeros(1,N);
for i=1:K/2
    v(1+i)=1;
    v(N+1-i)=1;
end
A=circ(v);
for i=2:N
    for j=1:i
        if A(i,j)==1 && rand<=p
            flag=0;
            while flag==0
                k=randi(N);
                if A(i,k)==0 && i~=k
                    A(i,k)=1;
                    A(k,i)=1;
                    A(i,j)=0;
                    A(j,i)=0;
                    flag=1;
                end
            end
        end
    end
end
end

