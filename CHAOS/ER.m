function [A] = ER(N,p)
%  ER (N,p) constructs an Erdos-Renyi graph given the number of nodes N. The second entry may be i) the probability p\in[0,1] of having each edge; or ii) the integer number (>=2) of edges. Realized by Zino.
A=zeros(N);
if p<=1
for i=1:N-1
    for j=i+1:N
        if rand<=p
            A(i,j)=1;
            A(j,i)=1;
        end
    end
end
else
    e=0;
    while e<p
        i=randi(N);
        j=randi(N);
        if i~=j && A(i,j)==0
            e=e+1;
            A(i,j)=1;
            A(j,i)=1;
        end
    end
end
end