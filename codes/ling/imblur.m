function [u, k, f] = imblur(u0, a, w, cutoff)
% inputs:
% u0 -- original 95-dim barcode signal
% a -- reference width
% w -- standard deviation factor, ie. sigma = w*a
% cutoff -- to determine the effectiveness of the blurring kernel
% outputs: 
% u -- zero padded stretched signal 
% k -- gaussian kernel
% f -- blurred signal (no noise yet) f = k*u


sigma = a*w;

if nargin<4
    cutoff = ceil(4*sigma);
end

%% construct the Gaussian kernel with sigma be the standard deviation and
%% the length be 2*cutoff+1
x = -cutoff:cutoff; 
k =exp(-x.^2/2/sigma^2); 
k = k/sum(k);   % normalize to sum 1

%% u is the stretched version of u0 
u = imresize(u0,[1, 95*a], 'nearest'); %replace with stretching matrix
n = length(u);

% zero padding of u
tmp = zeros(1, 2*cutoff+n);
tmp(cutoff+1:end-cutoff)=u;
upad = tmp; 

%% convolution 
f = conv(upad, k, 'same');