function flag=reg_check(A)
%graph_check(A) checks if A is a regular graph. The function returns 0 if it
%is, 1 otherwise.
flag=0;
d=sum(A);
if min(d)<d(1) || max(d)>d(1)
    flag=1;
end
end