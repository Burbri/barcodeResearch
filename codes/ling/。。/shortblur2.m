function [nextk] = shortblur2(u0,a,i1,i2,threshold)
%i1:begining index
%i2:end index
w = 1;
sigma = a*w;
kr = ceil(2*sigma);
lk = 2*kr;
nsig = 0.01;

%construct the Gaussian kernel with sigma the standard deviation
x = -kr:kr;
k = exp(-x.^2/2/sigma^2); %gaussian blur
k = k/sum(k);   %normalize to sum 1

%stretch the initial matrix
S = kron(eye(95),ones(a,1)); %stretching matrix
u = 1-S*u0';
n = length(u);

%Prepare values for convolution
kpad = zeros(n,1);
kpad(1:lk+1) = k;
f = real(ifft(fft(kpad).*fft(u))); %blurry signal
f = circshift(f,-kr); %shift to line up with u
f = f + nsig*randn(size(f)); %add noise

%Convolute the data
bigU = convmtx(u(i1:i2,1),2*lk+1);
A= bigU(1.5*lk+1:end-1.5*lk,:); %cropping to the valid equations
%expect A*k - f(i1+kr:i2-kr) to be small
fc = f(i1+kr:i2-kr);

lamda = 1/(0.2-nsig)^2;
dt = 1/norm(A'*A);

%Deblur the data
thisk = zeros(2*lk+1,1);
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


%% nextk should be of same size as k
%% if so, compute norm(k-nextk)
figure
plot([zeros(1,kr),k,zeros(1,kr)])
hold on
plot(nextk,'r')
display(norm([zeros(1,kr),k,zeros(1,kr)]'-nextk));

end