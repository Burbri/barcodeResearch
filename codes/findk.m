function [ nextk ] = findk( A, fc, cut, lamda, threshold )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%lamda = 1/(0.2-nsig)^2; %%Based on noise variation
dt = 1/norm(A'*A);

%Deblur the data
thisk = zeros(4*cut+1,1);
display(size(fc))
display(size(A))
display(size(thisk))
nextk = min(1, max(0, thisk + dt*(-A'*(A*thisk-fc)-(lamda*thisk))));
D = [eye(size(thisk,1)) zeros(size(thisk,1),1)] - [zeros(size(thisk,1),1) eye(size(thisk,1))];
D = D(1:end-1,1:end-1);
L = D'*D;

rep = 0;
thresh = norm(nextk - thisk)/norm(thisk);
while (thresh > threshold) && (rep < 10^5);
    rep = rep + 1;
    thisk = nextk;
    nextk = min(1, max(0, thisk + dt*(-A'*(A*thisk-fc)-(lamda*L*thisk))));
    thresh = norm(nextk - thisk)/norm(thisk);
    if(mod(rep,10000) == 0)
        disp(rep);
        disp(thresh);
    end
end
display(rep);

end