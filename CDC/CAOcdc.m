function [x,y] = CAOcdc(W,alpha,lambda,mu,gamma,u,x0,y0,T)
% A is the adjacency matrix of the influence network, W the weighted
% adjacency matrix of the communication network, alpha the evolutionary
% advantage, lambda the weight of opinion in the decision-making process,
% mu the weight of actions in the opinion dynamics, beta the noise in the loglinear learning, x0 and y0 the initial
% conditions for actions and opinion, respectively, and T the time horizon
% of the simulation



n=size(W,2);

if size(x0,1)==1
    x0=x0';
end

if size(y0,1)==1
    y0=y0';
end

if length(mu)==1
    mu=mu*ones(n,1);
end
if length(lambda)==1
    lambda=lambda*ones(n,1);
end
if length(gamma)==1
    gamma=gamma*ones(n,1);
end

x=x0;
y=y0;
zx=-ones(1,T+1);
zy=-ones(1,T+1);
zx(1)=sum(x)/n;
zy(1)=sum(y)/n;

 
 for t=1:T
    i=randi(n);
    temp=x(i);
     if lambda(i)*y(i)+(1-lambda(i))*W(i,:)*(1+x)*(1+alpha)>(1-lambda(i))*W(i,:)*(1-x)
         temp=1;
     elseif lambda(i)*y(i)+(1-lambda(i))*W(i,:)*(1+x)*(1+alpha)<(1-lambda(i))*W(i,:)*(1-x)
         temp=-1;
     end
     y(i)=W(i,:)*(1-gamma(i))*((1-mu(i))*y+mu(i)*x)+gamma(i)*u(i);
     x(i)=temp;
     zx(t+1)=sum(x)/n;
     zy(t+1)=sum(y)/n;
 end



 
if T>400
[zx,t]=reducev2(zx,[0:T],400);
[zy,t]=reducev2(zy,[0:T],400);
else
    t=0:T;
end
    


figure
plot(t,zx)
hold on
plot(t,zy)
axis([0 T -1 1])



end