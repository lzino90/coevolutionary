function p=phiDif2(yi,yib,xi,x,gam,lam,beta,alpha,i,W,n,A)


eta=(lam*(1-beta))/(4*beta*(1-lam)*(1-gam));


% if xi~=x(i)


tmp=0;

    for j=1:n
        if i~=j
            tmp=tmp+eta*A(i,j)*((1+alpha)*(1+x(j))*(xi-x(i))+(1-x(j))*(x(i)-xi));
        end
    end
    
t1=0.5*(1/((1-lam)*(1-gam)))*(yi-yib)^2;
t2=((lam)/((1-lam)*(1-gam)))*(xi-x(i))*yib;
t3=tmp;
t4=2*eta*A(i,i)*alpha*(xi-x(i));

% t5=W(i,i)*yib;
t5=.5*W(i,i)*(yi-yib)^2;

p=t1+t2+t3+t4+t5;

% elseif xi==x(i)
    
%    p= 0.5*(1/((1-lam)*(1-gam)))*(yi-yib)^2;

% end

end