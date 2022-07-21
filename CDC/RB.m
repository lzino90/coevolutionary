function c=RB(x)
% RB(x,max,min) gives an rgb color in a red-blue scale, depending on the value x and on max and min

if x>=.5
        c=[2-2*x,2-2*x,1];
else
    c=[1,2*x,2*x];
end
end