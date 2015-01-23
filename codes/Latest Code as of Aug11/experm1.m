clear; close all

  u0=upc2signal('123456789012');
%  num = randi(1000000000000);
%  u0=upc2signal(num2str(num, '%12i'));
 a = 10;
 w =1; 
% lambda =0.001; 
% dt = 0.001; 
% threshold =0.00002;
% 
% [fc,nextu,stretchedu] = test2(u0,a,w,lambda, dt, threshold);
% 
% 
% uth = (nextu>0.5);
% figure;  plot(uth, 'k'); hold on; plot(fc, 'r'); %hold on; plot(stretchedu, 'b')
% xlim([1, length(nextu)])
% ylim([-0.1 1.1])
[A, fc, cutoff, f, k_ori] = gblur (u0, a, w, 0.01);
%[k_es] = kfind('12',10,f);
%figure; plot(k_es); hold on; plot(k,'r')
[k_es,u_es,err,idx] = kernelforl(f,a);
figure; plot(k_es); hold on; plot(k_ori,'r')
title('Estimated K');
frame = getframe(1);
im = frame2im(frame);
[imind,cm] = rgb2ind(im,256);
imwrite(imind,cm,'estimatedk.gif','gif', 'Loopcount',0);
close;

% i1 = 1;
% i2 = 17;
% [nextk] = shortblur2(uth,a,i1,i2,threshold);
% figure; plot(nextk); hold on; plot(k,'r')
% xlim([1, length(nextk)])
% ylim([-0.1 1.1])