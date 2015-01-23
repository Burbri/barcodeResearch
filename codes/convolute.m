function [ f ] = convolute( k, u )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

kpad = zeros(size(u,1),1);
kpad(1:size(k,1)) = k;

f = real(ifft(fft(kpad).*fft(u)));


end

