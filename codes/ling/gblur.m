function [A, fc, cutoff, f, k] = gblur (u0, a, w, nsig, varargin)

sigma = a*w;
cutoff = ceil(2*sigma);
cutlength =  2*cutoff;

%% construct the Gaussian kernel with sigma the standard deviation and

x = -cutoff:cutoff; 
k =exp(-x.^2/2/sigma^2); 
k = k/sum(k);   % normalize to sum 1
display(size(k))

%% stretchedu is the stretched version of u0 
%%u = imresize(u0',[95*a 1], 'nearest'); %replace with stretching matrix
S = kron(eye(95),ones(a,1)); %stretching matrix
u = S*u0';
n = length(u);

%Prepare values for convolution
kpad = zeros(n,1);
kpad(1:cutoff*2+1) = k;
%kpad = circshift(kpad,floor((n/2-size(k,2)/2)));
f = real(ifft(fft(kpad).*fft(u))); %blurry signal
%f = circshift(f,-cutoff); %shift to line up with u
f = f + nsig*randn(size(f)); %add noise

if(size(varargin,2) == 0)
    fc = f(cutoff+1:end-cutoff);
    bigU = convmtx(u,2*cutlength+1);
    A = bigU(1.5*cutlength+1:end-1.5*cutlength,:);
elseif(size(varargin,2)== 2)
    display(varargin);
    display(varargin{1});
    display(varargin{2});
    fc = f(varargin{1}+cutoff:varargin{2}-cutoff);
    bigU = convmtx(u(varargin{1}:varargin{2},1),2*cutlength+1);
    A = bigU(1.5*cutlength+1:end-1.5*cutlength,:); %cropping to the valid equations
end
end

