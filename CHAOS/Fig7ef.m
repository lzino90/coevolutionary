x=linspace(0,1,51);
f=NaN*ones(1,51);
j=1;
    i=1;
for j=1:1326
    if a(j,1)==x(i) && a(j,3)<=0 && isnan(f(i))
        f(i)=a(j,2);
        i=i+1;
    end
    if i>51
        break
    end
end