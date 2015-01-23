function [ u ] = deconvolute( k, f, r )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%f = kpad*u;
%f = real(ifft(fft(kpad).*fft(u)));
kpad = zeros(size(f,1),1);
kpad(1:size(k,1)) = k;
% ki = 1./fft(kpad);
% kr = (abs(fft(kpad).^2)) ./ (abs(fft(kpad).^2)+r);
% ff = fft(f);
% u = real(ifft(ki .* kr .* ff));
u = real(ifft((1./fft(kpad)) .* ((abs(fft(kpad)).^2)./(abs(fft(kpad)).^2 + r)) .* fft(f)));

end