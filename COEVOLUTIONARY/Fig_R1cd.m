clc
clear
close all
rr=0.1; %noise
nm=25;
nf=25;
n=nm+nf;

alpha=0;
tf=350;
I=eye(n,n);

gamF=max(min(0.7*ones(nf,1)+rr*randn(nf,1),0.99),0.01);
gamM=max(min(0.2*ones(nm,1)+rr*randn(nm,1),0.99),0.01);
gam=[gamF;gamM];

betaF=max(min(.4*ones(nf,1)+rr*randn(nf,1),0.99),0.01);
betaM=max(min(.4*ones(nm,1)+rr*randn(nm,1),0.99),0.01);
beta=[betaF;betaM];

lamF=max(min(.2*ones(nf,1)+rr*randn(nf,1),0.99),0.01);
lamM=max(min(.7*ones(nm,1)+rr*randn(nm,1),0.99),0.01);
lam=[lamF;lamM];


% lam([2,3,28,40])=1;
% beta([2,3,28,40])=1;

%%
eta=(lam(1)*(1-beta(1)))/(4*beta(1)*(1-lam(1))*(1-gam(1)));
ubound=-(1-gam(1))*(1+2*eta/lam(1))/gam(1);

%%
load('sWA') % sparse A and W

W=(diag(1./sum(W,2)))*W;
A=(diag(1./sum(A,2)))*A;

%%
i=load('i');i=i.i; % agents used in the example

%% data from the paper
load('plig')



yW=rescale(yWsep1,-1,1);
yM=rescale(yMsep1,-1,1);
yM(12)=0.323;yM(13)=0.456;yM(23)=0.123;
yW(4)=0.159;
xW=rescale(xWsep1,-1,1);
xM=rescale(xMsep1,-1,1);

xMBin=(-(xM<0)+(xM>0));
xWBin=(-(xW<0)+(xW>0));

y=[yW;yM];
x=[xWBin;xMBin];
[mean(yW) mean(yM) mean(x)]

u=y;

%%


for t=1:tf
    
%     i(t)=randi(n);
    
    s= (1-lam(i(t)))*((1-gam(i(t)))*(W(i(t),:)*y(:,t))+gam(i(t))*u(i(t)))+lam(i(t));
    sp=(1-lam(i(t)))*((1-gam(i(t)))*(W(i(t),:)*y(:,t))+gam(i(t))*u(i(t)))-lam(i(t));
        
    f1= fi(y(:,t),s,x(:,t),1,u,W,gam,lam,alpha,beta,A);
    fN1=fi(y(:,t),sp,x(:,t),-1,u,W,gam,lam,alpha,beta,A);
    
    deltaF(t)=f1(i(t))-fN1(i(t));
    
    
    y(:,t+1)=y(:,t);
    x(:,t+1)=x(:,t);
    
    if abs(deltaF(t))<=0.000001
        y(i(t),t+1)=(1-lam(i(t)))*((1-gam(i(t)))*W(i(t),:)*y(:,t)+gam(i(t))*u(i(t)))+lam(i(t))*x(i(t),t);
        x(:,t+1)=x(:,t);
    else
        y(i(t),t+1)=(1-lam(i(t)))*((1-gam(i(t)))*W(i(t),:)*y(:,t)+gam(i(t))*u(i(t)))+lam(i(t))*sign(deltaF(t));
        x(i(t),t+1)=sign(deltaF(t));
    end
    
    phi(t)=Phi(y(:,t),x(:,t),u,W,alpha,beta,lam,gam,A);
    phiN(t)=PhiN(y(:,t),x(:,t),u,W,alpha,beta,lam,gam,A);
    
    p(t)=phiDif2(y(i(t),t+1),y(i(t),t),x(i(t),t+1),x(:,t),gam(i(t)),lam(i(t)),beta(i(t)),alpha,i(t),W,n,A);
    
end

%% Polarization analysis

ys=y(:,end);
xs=x(:,end);

xP_indx=find(xs==1);
xN_indx=find(xs==-1);

yP_indx=find(ys>0);
yN_indx=find(ys<0);

Wp=W;
Wp(:,yN_indx)=0;
dP=Wp*ones(n,1);

condP=lam+((1-beta)./beta).*(0.5-dP);
% all(find(ys>=condP)==yP_indx)




dN=1-dP;
condN=-(lam+((1-beta)./beta).*(dN-0.5));


%%figure

figure
ymeanF=mean(y(1:nf,:));
ymeanM=mean(y(nf+1:end,:));
xmeanF=mean(x(1:nf,:));
xmeanM=mean(x(nf+1:end,:));
xmean=mean(x);

plot(0:tf,ymeanF,'r','linewidth',1.3)
hold on
plot(0:tf,ymeanM,'b','linewidth',1.3)
hold on
plot(0:tf,xmeanF,'r-.','linewidth',1.3)
hold on
plot(0:tf,xmeanM,'b-.','linewidth',1.3)
hold on
plot(0:tf,xmean,'k--','linewidth',1.3)
xlabel('Time')
ylim([-0.5 1.1])
legend('$\bar{y}_f$','$\bar y_m$','$\bar x_f$','$\bar x_m$','$\bar x$','interpreter','latex','Orientation','horizontal')