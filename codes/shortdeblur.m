function [nextk] = shortdeblur(u0,a,i1,i2,threshold)

%Deblur the data
thisk = 0;
nextk = min(1, max(0, thisk + dt(-A'*(A*thisk-fc)-(lamda*thisu))));
while norm(nextk - thisk)/norm(thisk) > threshold
    thisk = nextk;
    nextk = min(1, max(0, thisk + dt(-A'*(A*thisk-fc)-(lamda*thisu))));
end
end