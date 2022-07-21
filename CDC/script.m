n=16;
A=RRG(16,4);

e=0;
for i=1:length(A)
    for j=1:length(A)
        if A(i,j)==1
            if e==0
                s=strcat('\foreach \s/\t in {',num2str(i),'/',num2str(j));
                e=1;
            else
                s=strcat(s,',',num2str(i),'/',num2str(j));
            end
        end
    end
end
display(strcat(s,'}'));


x0=[-ones(6,1); 2*round(rand(10,1))-1];
y0=2*rand(n,1)-1;
u=2*rand(n,1)-1;
[x,y]=CAOcdc(SRW(A),.1,.2,.2,.6,u,x0,y0,500);

vettore_colore=.5*x0+.5;
for i=1:length(vettore_colore)
    col=RB(vettore_colore(i));
    display(strcat('\definecolor{mycolora',num2str(i),'}{rgb}{',num2str(col(1)),',',num2str(col(2)),',',num2str(col(3)),'}%'))
end

vettore_colore=.5*y0+.5;
for i=1:length(vettore_colore)
    col=RB(vettore_colore(i));
    display(strcat('\definecolor{mycoloro',num2str(i),'}{rgb}{',num2str(col(1)),',',num2str(col(2)),',',num2str(col(3)),'}%'))
end

vettore_colore=.5*x+.5;
for i=1:length(vettore_colore)
    col=RB(vettore_colore(i));
    display(strcat('\definecolor{mycolora',num2str(i),'}{rgb}{',num2str(col(1)),',',num2str(col(2)),',',num2str(col(3)),'}%'))
end

vettore_colore=.5*y+.5;
for i=1:length(vettore_colore)
    col=RB(vettore_colore(i));
    display(strcat('\definecolor{mycoloro',num2str(i),'}{rgb}{',num2str(col(1)),',',num2str(col(2)),',',num2str(col(3)),'}%'))
end
