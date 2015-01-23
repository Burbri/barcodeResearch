function [k_es,u_es,err,idx] = kernelforl(fc,a)
%UNTITLED Summary of this function goes here
%   fc = blurred barcode
%   a = stretching factor
%
%   k_es = estimated k (blurring kernel)
%   u_es = estimated u
%   err = 
figure
err = 1/0;
for i = 0:99
    k = kfind( num2str(i, '%02i'), a, fc );
    k = k(1:4*a+1);
    u = deconvwnr(fc, k, 0.05);
%     U = convmtx(u,size(k,1));
    
%    kpad = zeros(size(u,1),1);
%     kpad(size(kpad,1)/2 - size(k,1)/2:size(kpad,1)/2 + size(k,1)/2);
    conre = conv(u,k);
    conre = conre(2*a+1:end-2*a);
    %figure
    plot(conre)
    hold on
    plot(fc,'r')
    e = norm( fc - conre);
    
    if(e < err)
        k_es = k;
        u_es = u;
        err = e;
        idx = i;
    end
   
end
figure
conre = conv(u_es,k_es);
conre = conre(2*a+1:end-2*a);
plot(conre)
hold on
plot(fc,'r')
end

