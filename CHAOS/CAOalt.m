function [zx1,zx2,zy1,zy2] = CAOalt(A,W,alpha,lambda,mu,beta,x0,y0,T,M)
% A is the adjacency matrix of the influence network, W the weighted
% adjacency matrix of the communication network, alpha the evolutionary
% advantage, lambda the weight of opinion in the decision-making process,
% mu the weight of actions in the opinion dynamics, beta the noise in the loglinear learning, x0 and y0 the initial
% conditions for actions and opinion, respectively, and T the time horizon
% of the simulation
    
n=size(A,2);
d=sum(A,2);
W=ALT(W,M);

if size(x0,1)==1
    x0=x0';
end

if size(y0,1)==1
    y0=y0';
end

x=x0;
y=y0;
zx1=zeros(1,T+1);
zy1=zeros(1,T+1);
zx2=zeros(1,T+1);
zy2=zeros(1,T+1);
zx1(1)=sum(x(1:M))/M;
zx2(1)=sum(x(M+1:n))/(n-M);
zy1(1)=sum(y(1:M))/M;
zy2(1)=sum(y(M+1:n))/(n-M);

for t=1:T
    i=randi(n);
     if rand <exp(beta*(lambda*y(i)/2+(1-lambda)*A(i,:)*(1+x(:,end))*(1+alpha)/d(i)))/(exp(beta*(lambda*y(i)/2+(1-lambda)*A(i,:)*(1+x(:,end))*(1+alpha)/d(i)))+exp(beta*(-lambda*y(i)+(1-lambda)*A(i,:)*(1-x(:,end))/d(i))))
         temp=1;
     else
         temp=-1;
     end
     y(i)=(1-mu)*W(i,:)*y+mu*A(i,:)*x/d(i);
     x(i)=temp;
zx1(t+1)=sum(x(1:M))/M;
zx2(t+1)=sum(x(M+1:n))/(n-M);
zy1(t+1)=sum(y(1:M))/M;
zy2(t+1)=sum(y(M+1:n))/(n-M);
end
figure
[x1,t]=reducev2(zx1,[0:T],400);
[x2,t]=reducev2(zx2,[0:T],400);
[y1,t]=reducev2(zy1,[0:T],400);
[y2,t]=reducev2(zy2,[0:T],400);
plot(t,x1,'r')
hold on
plot(t,y1,'r--')
plot(t,x2,'b')
plot(t,y2,'b--')
axis([0 T -1 1])
end