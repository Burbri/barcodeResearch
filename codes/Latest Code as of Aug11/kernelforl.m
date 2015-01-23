function [k_es,u_es,err,idx] = kernelforl(fc,a)
%UNTITLED Summary of this function goes here
%   fc = blurred barcode
%   a = stretching factor
%
%   k_es = estimated k (blurring kernel)
%   u_es = estimated u
%   err = 
filename = 'kerneltests.gif';
figure
ylim([0 1]);
err = 1/0;

for i = 0:99
    clf;
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
    title(num2str(i, '%02i'));
    e = norm( fc - conre);
    
    if(e < err)
        k_es = k;
        u_es = u;
        err = e;
        idx = i;
    end
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if i == 0;
        imwrite(imind,cm,filename,'gif', 'Loopcount',0);
    else
        imwrite(imind,cm,filename,'gif','DelayTime',0,'WriteMode','append');
    end
end
close
figure
conre = conv(u_es,k_es);
conre = conre(2*a+1:end-2*a);
plot(conre)
hold on
plot(fc,'r')
title(num2str(idx, '%02i'));
frame = getframe(1);
im = frame2im(frame);
[imind,cm] = rgb2ind(im,256);
imwrite(imind,cm,strcat('final',filename),'gif', 'Loopcount',0);
close
end

