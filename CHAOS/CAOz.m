function [zx,zy] = CAOz(A,W,alpha,lambda,mu,beta,x0,y0,T,s)
% A is the adjacency matrix of the influence network, W the weighted
% adjacency matrix of the communication network, alpha the evolutionary
% advantage, lambda the weight of opinion in the decision-making process,
% mu the weight of actions in the opinion dynamics, beta the noise in the loglinear learning, x0 and y0 the initial
% conditions for actions and opinion, respectively, and T the time horizon
% of the simulation
if nargin==9
    
n=size(A,2);
d=sum(A,2);

if size(x0,1)==1
    x0=x0';
end

if size(y0,1)==1
    y0=y0';
end

x=x0;
y=y0;
zx=-ones(1,T+1);
zy=-ones(1,T+1);
zx(1)=sum(x)/n;
zy(1)=sum(y)/n;

for t=1:T
    i=randi(n);
     if rand <exp(beta*(lambda*y(i)/2+(1-lambda)*A(i,:)*(1+x(:,end))*(1+alpha)/d(i)))/(exp(beta*(lambda*y(i)/2+(1-lambda)*A(i,:)*(1+x(:,end))*(1+alpha)/d(i)))+exp(beta*(-lambda*y(i)+(1-lambda)*A(i,:)*(1-x(:,end))/d(i))))
         temp=1;
     else
         temp=-1;
     end
     y(i)=(1-mu)*W(i,:)*y+mu*A(i,:)*x/d(i);
     x(i)=temp;
     zx(t+1)=sum(x)/n;
     zy(t+1)=sum(y)/n;
end
else
 
n=size(A,2);
r=n-s;
d=sum(A,2);

if size(x0,1)==1
    x0=x0';
end

if size(y0,1)==1
    y0=y0';
end

x=x0;
y=y0;
x(1:s)=1;
y(1:s)=1;
zx=-ones(1,T+1);
zy=-ones(1,T+1);
zx(1)=sum(x)/n;
zy(1)=sum(y)/n;

for t=1:T
    i=s+randi(r);
     if rand <exp(beta*(lambda*y(i)/2+.25*(1-lambda)*A(i,:)*(1+x(:,end))*(1+alpha)/d(i)))/(exp(beta*(lambda*y(i)/2+.25*(1-lambda)*A(i,:)*(1+x(:,end))*(1+alpha)/d(i)))+exp(beta*(-lambda*y(i)/2+.25*(1-lambda)*A(i,:)*(1-x(:,end))/d(i))))
         temp=1;
     else
         temp=-1;
     end
     y(i)=(1-mu)*W(i,:)*y+mu*A(i,:)*x/d(i);
     x(i)=temp;
     zx(t+1)=sum(x)/n;
     zy(t+1)=sum(y)/n;
end  
end
figure
[x,t]=reducev2(zx,[0:T],400);
[y,t]=reducev2(zy,[0:T],400);
plot(t,x)
hold on
plot(t,y)
axis([0 T -1 1])
end