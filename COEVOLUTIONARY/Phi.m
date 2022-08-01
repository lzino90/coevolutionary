function phi=Phi(y,x,u,W,alpha,beta,lam,gam,A)
n=size(x,1);

a=A;


eta=((lam(1)*(1-beta(1)))/(4*beta(1)*(1-lam(1))*(1-gam(1))));


tempYY=0;
tempXX=0;
tempXi=0;
tempYU=0;
tempYXi=0;

for i=1:n
    for j=1:n
        tempYY=tempYY+0.5*W(i,j)*(y(i)-y(j))^2;
       

        if j~=i
            tempXX=tempXX+eta*0.5*a(i,j)*((1+alpha)*(1+x(j))*(1+x(i))+(1-x(j))*(1-x(i)));
            
        end
        
        
    end
     tempYU=tempYU+(gam(i)/(1-gam(i)))*(y(i)-u(i))^2;
     tempYXi=tempYXi+(lam(i)/((1-lam(i))*(1-gam(i))))*(y(i)-x(i))^2;
     tempXi=tempXi+eta*a(i,i)*((1+alpha)*(1+x(i))^2+(1-x(i))^2);


end
    
    phi=-0.5*(tempYY+tempYU+tempYXi)+tempXX+tempXi;
    
    
    
end
