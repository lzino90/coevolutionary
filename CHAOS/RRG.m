function A = RRG(n,d)
% RRG(n,d) creates a random d-regular undirected graph with n nodes.
% Important: n*d must be even! Created by Zino.

maxIter = 10;

A=zeros(n);

%a list of open half-edges
U = repmat(1:n,1,d);

%graph creation
j=0; 
i=1;
while ~isempty(U) && i < maxIter
    %chose at random 2 half edges
    j=j+1;
    i1 = ceil(rand*length(U));
    i2 = ceil(rand*length(U));
    v1 = U(i1);
    v2 = U(i2);

    %check that the selected edge is non a loop neither a parallel edge
    if (v1 == v2) || (A(v1,v2) == 1)
        %restart process if edges are finished without havin a graph
        if j == n*d          
            i=i+1;            
            j = 0;
            U = repmat(1:n,1,d);
            A=zeros(n);
        end
    else
        %add edge to graph and remove half-edges from U
        A(v1, v2)=1;
        A(v2, v1)=1;
        v = sort([i1,i2]);
        U = [U(1:v(1)-1), U(v(1)+1:v(2)-1), U(v(2)+1:end)];
    end
end
%check if A is a simple regular graph
if graph_check(A)+reg_check(A)>0   
    A='error: try again with more iterations';
end
end