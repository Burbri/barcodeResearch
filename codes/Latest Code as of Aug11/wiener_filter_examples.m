%wiener filter tests
clear all

upc = '123456789123';
u0 = upc2signal(upc);
a = 12;
w = 1;
nsig = .05;

[u, k, f, Xc, Xv] = imblur_crop(u0, a, w);
f = f + nsig*randn(size(f)); %add noise
N = length(u);
kpad = zeros(N,1);
klen = length(k);
kpad(1:klen) = k;

%wiener-type filter in Fourier domain
r = .005;
KPAD = fft(kpad);
uw = real(ifft( (conj(KPAD).*fft(f))./(abs(KPAD).^2 + r) ));
%uw = real(ifft( (conj(KPAD).*fft(f)+r)./(abs(KPAD).^2 + r) )); %prefer u=1
figure(22)
clf
plot(u)
hold on
plot(circshift(f,-round((klen-1)/2)),'r');
plot(uw,'g');
ylim([-.1 1.4]);
legend('clean signal','blurry signal','wiener filtered');

%direct wiener-type filter using cropping
r = .005;
K = real(ifft(diag(KPAD)*fft(eye(N))));
uwx = (r*eye(N) + K'*Xv'*Xv*K)\(K'*Xv'*Xv*f);
%uwx = (r*eye(N) + K'*Xv'*Xv*K)\(K'*Xv'*Xv*f + r); %prefer u=1
figure(23)
clf
plot(u)
hold on
plot(circshift(f,-round((klen-1)/2)),'r');
plot(uwx,'g');
ylim([-.1 1.4]);
legend('clean signal','blurry signal','wiener filtered (cropped model)');



