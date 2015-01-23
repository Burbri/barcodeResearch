function [ output_args ] = Untitled( input_args )
sigma = a*w;

if nargin<4
    cutoff = ceil(4*sigma);
end

%% construct the Gaussian kernel with sigma be the standard deviation and
cutlength= be 2*cutoff+1
x = -cutoff:cutoff; 
k =exp(-x.^2/2/sigma^2); 
k = k/sum(k);   % normalize to sum 1

%% u is the stretched version of u0 
u = imresize(u0,[1, 95*a], 'nearest'); %replace with stretching matrix
n = length(u);


end

size()