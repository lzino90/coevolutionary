function f=fi(y,s,x,r,u,W,gam,lam,alpha,beta,A)


n=size(x,1);
I=eye(n,n);
a=A;



for i=1:n
    tempSY=0;
    tempRX=0;
    
    for j=1:n
        
            tempSY=tempSY+W(i,j)*(s-y(j))^2;
            tempRX=tempRX+a(i,j)*( (1+x(j))*(1+alpha)*(1+r)+(1-x(j))*(1-r) );
     
    end
    f(i)=-0.5*(1-lam(i))*beta(i)*(1-gam(i))*tempSY...
        -0.5*(1-lam(i))*beta(i)*gam(i)*(s-u(i))^2 ...
        -0.5*lam(i)*beta(i)*(s-r)^2 ...
        +((lam(i)*(1-beta(i)))/(4))*tempRX;
    
end


end
