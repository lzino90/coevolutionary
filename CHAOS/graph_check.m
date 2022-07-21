function flag=graph_check(A)
%graph_check(A) checks if A is a simple graph. The function returns 0 if it
%is, 1 otherwise.
flag=0;

%check symmetry
if (norm(A-A','fro')>0)
    flag=1;
end

%check parallel edged
if (max(A(:))>1)
    flag=1;
end

%check that g doesn't contain self-loops
if (norm(diag(A))>0)
    flag=1;
end
end