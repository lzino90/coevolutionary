function [x,y] = CAO(A,W,alpha,lambda,mu,beta,x0,y0,T,s)
% A is the adjacency matrix of the influence network, W the weighted
% adjacency matrix of the communication network, alpha the evolutionary
% advantage, lambda the weight of opinion in the decision-making process,
% mu the weight of actions in the opinion dynamics, beta the noise in the loglinear learning, x0 and y0 the initial
% conditions for actions and opinion, respectively, and T the time horizon
% of the simulation. s the number of stubborn noes

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

for t=1:T
    y=[y y(:,end)];
    x=[x x(:,end)];
    i=randi(n);
     if rand <exp(beta*(lambda*y(i)+(1-lambda)*A(i,:)*x(:,end)*(1+alpha)/d(i)))/(exp(beta*(lambda*y(i)+(1-lambda)*A(i,:)*x(:,end)*(1+alpha)/d(i)))+exp(beta*(lambda*(1-y(i))+(1-lambda)*A(i,:)*(1-x(:,end))/d(i))))
         x(i,end)=1;
     else
         x(i,end)=0;
     end
     y(i,end)=(1-mu)*W(i,:)*y(:,end)+mu*A(i,:)*x(:,end-1)/d(i);
end
end