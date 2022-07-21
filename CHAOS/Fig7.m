clc
clear all
n=200;
R=100;
lambda=0:0.02:1;
mu=0:0.0004:0.01;
res=zeros(length(lambda),length(mu));
reso=zeros(length(lambda),length(mu));
for i=1:length(lambda)
    for j=1:length(mu)
        for k=1:R
            [temp1,temp2]=CAOf(RRG(n,8),SRW(RRG(n,4)),.5,lambda(i),mu(j),20,[1 -ones(1,n-1)],[1 -ones(1,n-1)],4*n^2,1);
            res(i,j)=res(i,j)+sign(temp1);
            reso(i,j)=reso(i,j)+temp2;
        end
            display(strcat('Progress: ',num2str(round(50*((i-1)*length(mu)+j)/(length(lambda)*length(mu)))),'%'))
    end
end
figure
surf(lambda,mu, res'/R)
figure
surf(lambda,mu, reso'/R)


clc
clear all
n=200;
R=100;
lambda=0:0.02:1;
mu=0:0.0004:0.01;
res=zeros(length(lambda),length(mu));
reso=zeros(length(lambda),length(mu));
for i=1:length(lambda)
    for j=1:length(mu)
        for k=1:R
            [temp1,temp2]=CAOf(WS(n,8,.2),SRW(WS(n,4,.2)),.5,lambda(i),mu(j),20,[1 -ones(1,n-1)],[1 -ones(1,n-1)],4*n^2,1);
            res(i,j)=res(i,j)+sign(temp1);
            reso(i,j)=reso(i,j)+temp2;
        end
            display(strcat('Progress: ',num2str(round(50+50*((i-1)*length(mu)+j)/(length(lambda)*length(mu)))),'%'))
    end
end
figure
surf(lambda,mu, res'/R)
figure
surf(lambda,mu, reso'/R)