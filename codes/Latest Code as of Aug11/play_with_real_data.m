clear;% close all

img = imread('r_small.jpg');

img = rgb2gray(img); 

img = double(img)/255;

data = mean(img(500:850,10:end-10)); data = data';

%% finding stretch factor
fprintf('Pre-processing of the data\n');
smoothf = imfilter(data,fspecial('gaussian',5,1), 'same');%smoothing data
upordown = sign(diff(smoothf));%determine whether derivatives is positive or negative
minflags = [upordown(1)>0; diff(upordown)>0;upordown(end)>0].*(data<0.15);%less than 0.7 because don't want the first and last end of the barcode. 0,7 can be adjusted
minima   = find(minflags);

f = data;
% figure; plot(f); hold on; plot(minima, f(minima), 'r.')



strfactor =round((minima(end)-minima(1))/94); % stretch factor
% stretch matrix S
bdryfactor = 6; %adding 0 each side
bdrysize = strfactor*bdryfactor; % boundary size
S = kron(eye(95+2*bdryfactor), ones(strfactor,1)); %kron generate 11,11,11.. matri see the notes. 
M = size(S,1);
%% check the upc digit- add the upc to signal code 
% u0 = upc2signal('33115835891') 12 digit from image
%u =  padarray(u0,bdryfactor,0); % add 0
% u=S*u0; % to stretch



%% put data in the center
middlepoint = (minima(end)-minima(1))/2+minima(1); startpoint = round( middlepoint-M/2);
fcut = 1-data(startpoint:startpoint+M-1);
% 
% plot(fcut)
% 


%% fit intensity
nbin = 100;
[num, ctr] = hist(fcut, nbin);%num vector value. checks how high each bar from the histogram is.

[tmp, idx] = sort(num(1:25), 'descend');%check first 25 numbers and find the max
low = ctr(idx(1));

[tmp, idx] = sort(num(end-24:end), 'descend');
high = ctr(nbin+idx(1)-25);%maximum value

data = (fcut-low)/(high-low);

% figure; plot(data); xlim([1,M])

%% to fit real data to the synthetic ones
u0 = upc2signal('070662138038');%95 dimension vector; 
u0 = u0'; 
u =  padarray(u0,bdryfactor,0);%zero padding
upad = S*u; M = length(upad);%stretching matrix with stretching factor

% define a blurring kernel

for s = 1:10140% change increment -> change sigma = s*increment and change s= 1:(20/increment)
sigma = s*(0.001); % you will adjust sigma
kr = ceil(2*sigma);
x = -kr:kr;
k = exp(-x.^2/2/sigma^2);
k = k/sum(k);

syndata = conv(upad, k, 'same');

err(s)=norm(syndata-data);
choiceOFs(s) = sigma;
end

[value, idx] = min(err);
value
idx

sigma = choiceOFs(idx);
kr = ceil(2*sigma);
x = -kr:kr;
k = exp(-x.^2/2/sigma^2);
k = k/sum(k);

syndata = conv(upad, k, 'same');

figure; plot(data); hold on; plot(syndata, 'r')




