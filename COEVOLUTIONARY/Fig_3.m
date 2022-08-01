clc
clear
close all

%% Initialization

np=10;
nn=10;
n=np+nn;


condHold=true;
condSelfLoop=false;

alpha=0;
tf=150;
I=eye(n,n);

gam=0*ones(n,1);
beta=.5*ones(n,1);
lam=0.6*ones(n,1);

CondY=((1-2*lam)./(1-lam));

P=2*lam(1)*beta(1)*(1-lam(1))*(1-gam(1));
Q=2*lam(1)*(1-beta(1));

CondDelta=0.5*(1+(P/(P+Q)));


eta=(lam(1)*(1-beta(1)))/(4*beta(1)*(1-lam(1))*(1-gam(1)));

u=0*unifrnd(-1,1,n,1);
mu=0.4;


load('i_exam')
load('Wpol2')
dp=sum(W(1:np,1:np),2);
dn=sum(W(np+1:end,np+1:end),2);
    
    if all((dp>CondDelta))==1 && all(dn>CondDelta)==1
        disp('condition OK')
    end
A=W;
plot(digraph(W))


xp=ones(np,1);
xp(end-5)=-1;
xn=-ones(nn,1);
xn(end-5)=1;
x=[xp;xn];

yp=0.05*(1:10)';

yp(1)=-0.1;
yn=-0.04*(11:20)';
yn(1)=0.1;


y=[yp;yn];


%% Fig 3a

xP_indx0=find(x==1);
xN_indx0=find(x==-1);

yP_indx0=find(y>0);
yN_indx0=find(y<0);

differentxy=find((sign(y)-x)~=0);

gr0=digraph(W);
gp0=plot(gr0,'Layout','circle','markersize',12,'linewidth',1);
gp0.EdgeAlpha=0.85;
gp0.NodeFontSize=12;

set(gca,'XColor', 'none','YColor','none')
axis tight
highlight(gp0,yP_indx0,'NodeColor',[0.13 0.64 0.21])
highlight(gp0,yN_indx0,'NodeColor',[0.9 0.33 0.10])
highlight(gp0,differentxy,'NodeColor',[0.93 0.7 0.10])

%% Dynamics
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
        y(i(t),t+1)=(1-lam(i(t)))*((1-gam(i(t)))*W(i(t),:)*y(:,t)+gam(i(t))*u(i(t)))+lam(i(t))*x(:,t);
        x(:,t+1)=x(:,t);
    else
        y(i(t),t+1)=(1-lam(i(t)))*((1-gam(i(t)))*W(i(t),:)*y(:,t)+gam(i(t))*u(i(t)))+lam(i(t))*sign(deltaF(t));
        
        x(i(t),t+1)=sign(deltaF(t));
    end
    
    phi(t)=Phi(y(:,t),x(:,t),u,W,alpha,beta,lam,gam,A);
    phiN(t)=PhiN(y(:,t),x(:,t),u,W,alpha,beta,lam,gam,A);
    
    

    
    phiT  = Phi(y(:,t)  ,x(:,t)  ,u,W,alpha,beta,lam,gam,A);
    phiTp1= Phi(y(:,t+1),x(:,t+1),u,W,alpha,beta,lam,gam,A);   
    
    p(t)=phiDif2(y(i(t),t+1),y(i(t),t),x(i(t),t+1),x(:,t),gam(i(t)),lam(i(t)),beta(i(t)),alpha,i(t),W,n,A);
   
end


ys=y(:,end);
xs=x(:,end);

xP_indx=find(xs==1);
xN_indx=find(xs==-1);

yP_indx=find(ys>0);
yN_indx=find(ys<0);


%% Fig 3b

figure
gr=digraph(W);
gp=plot(gr,'Layout','circle','markersize',12,'linewidth',1);
gp.EdgeAlpha=0.85;
gp.NodeFontSize=12;
highlight(gp,yP_indx,'NodeColor',[0.13 0.64 0.21])
highlight(gp,yN_indx,'NodeColor',[0.9 0.33 0.10])
set(gca,'XColor', 'none','YColor','none')
axis tight


%% Fig 3c

figure
plot(0:tf,y,'linewidth',1.2)
ylim([-1.1 1.1])
xlabel('Time')
ylabel('x(t)')