function [u, k, f, Xc, Xv] = imblur_crop(u0, a, w)
% inputs:
% u0 -- original 95-dim barcode signal
% a -- reference width
% w -- standard deviation factor, ie. sigma = w*a
% outputs: 
% u -- zero padded stretched signal 
% k -- gaussian kernel
% f -- blurred signal (no noise yet) f = k*u
% Xv -- cropping matrix for valid part of convolution
% Xc -- centered cropping matrix

sigma = a*w;
cutoff = ceil(2*sigma);

%% construct the Gaussian kernel with sigma the standard deviation and
%length 2*cutoff+1
x = -cutoff:cutoff; 
k =exp(-x.^2/2/sigma^2); 
k = k/sum(k);   % normalize to sum 1

%% u is the stretched version of u0 
%%u = imresize(u0',[95*a 1], 'nearest'); %replace with stretching matrix
repeat = a/length(u0);
Eindex = 1;
for Sindex = 1:length(u0)
    for Rindex = 0:repeat-1
        u(Eindex) = u0(Sindex);
        Eindex = Eindex + 1;
    end
end
n = length(u);

%% cropping matrices (their transposes are padding matrices)
nc = n-2*cutoff;
Xv = sparse(1:nc,1+2*cutoff:n,ones(nc,1),nc,n);
Xc = sparse(1:nc,1+cutoff:n-cutoff,ones(nc,1),nc,n);

%% convolution 
kpad = zeros(n,1);
kpad(1:2*cutoff+1) = k;
f = real(ifft(fft(kpad).*fft(u)));

%%option to visualize stretched and blurred data
figure(21)
clf
plot(u)
hold on
plot(Xc'*Xv*f,'r');
ylim([-.1 1.2]);
legend('clean signal','cropped blurry signal');

