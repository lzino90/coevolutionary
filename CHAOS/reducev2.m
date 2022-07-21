function [ar,tr] = reducev2(a,t,m)
%reducev(a,t,n) reduces the length of vectors a and t to m using
%evenly-spaced points.
n=length(a);
tr=linspace(t(1),t(end),m);
ar=zeros(1,m);
ar(1)=a(1);
j=1;
for i=2:m
   while t(j)<tr(i)
       j=j+1;
   end
    ar(i)=a(j);
end
end

