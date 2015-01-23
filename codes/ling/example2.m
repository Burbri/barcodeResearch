%clear; close all

u0=upc2signal('1234567890123'); 
a = 10;
w =1; 
lambda =0.001; 
dt = 0.001; 
threshold =0.00002;

[fc,nextu,stretchedu,k] = test2(u0,a,w,lambda, dt, threshold);


uth = (nextu>0.5);
figure;  plot(uth, 'k'); hold on; plot(fc, 'r'); %hold on; plot(stretchedu, 'b')
xlim([1, length(nextu)])
ylim([-0.1 1.1])


% sigma = a*w;
% cutoff = ceil(2*sigma);
% cutlength =  2*cutoff;
% x = -cutoff:cutoff; 
% k =exp(-x.^2/2/sigma^2); 
% k = k/sum(k);   % normalize to sum 1
% 
% su=kron(eye(95),ones(a,1));
% stretchedu = su*u0';
% n = length(stretchedu);
% 
% K = convmtx(k', n);
% % J = convmtx(k,n);
% % display(size(K));
% % display(size(J));
% f = conv(k,stretchedu);
% A = K(cutlength+1: end-cutlength,cutoff+1: end-cutoff)';
% 
% 
% 
% 
% 
% 
% lamda = lamda_c(fc);
% [ nextk ] = findk( A, fc, cutoff, lamda, threshold );
% figure; plot(nextk);hold on; plot(k,'r')