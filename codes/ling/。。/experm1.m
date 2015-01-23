clear; close all

 u0=upc2signal('1234567890123'); 
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
[A, fc, cutoff, f, k_ori] = gblur (u0, a, w, 0.005);
%[k_es] = kfind('12',10,f);
%figure; plot(k_es); hold on; plot(k,'r')
[k_es,u_es,err,idx] = kernelforl(f,a);
figure; plot(k_es); hold on; plot(k_ori,'r')

% i1 = 1;
% i2 = 17;
% [nextk] = shortblur2(uth,a,i1,i2,threshold);
% figure; plot(nextk); hold on; plot(k,'r')
% xlim([1, length(nextk)])
% ylim([-0.1 1.1])