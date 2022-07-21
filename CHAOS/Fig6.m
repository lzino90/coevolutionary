clc
clear all
n=200;
alpha=.5;
R=100;
lambda=0:0.01:1;
for i=1:length(lambda)
    for j=1:R
        res(i,j)=CAOf(RRG(n,16),SRW(RRG(n,4)),alpha,lambda(i),0,20,[1 -ones(1,n-1)],[1 -ones(1,n-1)],4*n^2,1);
    end
    display(strcat('Progress: ',num2str(round(25*i/length(lambda))),'%'))
end
figure
plot(lambda,var((.5+.5*res')))


clc
clear all
n=200;
alpha=.5;
R=100;
lambda=0:0.01:1;
for i=1:length(lambda)
    for j=1:R
        res(i,j)=CAOf(ER(n,16/(n-1)),SRW(ER(n,4/(n-1))),alpha,lambda(i),0,20,[1 -ones(1,n-1)],[1 -ones(1,n-1)],4*n^2,1);
    end
    display(strcat('Progress: ',num2str(round(25+25*i/length(lambda))),'%'))
end
figure
plot(lambda,var((.5+.5*res')))


clc
clear all
n=200;
alpha=.5;
R=100;
lambda=0:0.01:1;
for i=1:length(lambda)
    for j=1:R
        res(i,j)=CAOf(WS(n,16,.2),SRW(WS(n,4,.2)),alpha,lambda(i),0,20,[1 -ones(1,n-1)],[1 -ones(1,n-1)],4*n^2,1);
    end
    display(strcat('Progress: ',num2str(round(50+25*i/length(lambda))),'%'))
end
figure
plot(lambda,var((.5+.5*res')))

clc
clear all
n=200;
alpha=.5;
R=100;
lambda=0:0.01:1;
for i=1:length(lambda)
    for j=1:R
        res(i,j)=CAOf(AB(n,16/2),SRW(AB(n,4/2)),alpha,lambda(i),0,20,[1 -ones(1,n-1)],[1 -ones(1,n-1)],4*n^2,1);
    end
    display(strcat('Progress: ',num2str(round(75+25*i/length(lambda))),'%'))
end
figure
plot(lambda,var((.5+.5*res')))