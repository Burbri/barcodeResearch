function [ nextk ] = kfind(u_2,a,fc)
%this function will help us find all the estimation k for the for two digit
%data we guest.
%fp has to be part of fc for first two digits
u = shortupc2signal(u_2);
%we set threshold and it is changeable
threshold = 0.0001;
%lamda





%% process below is to find stretched matrix A
%cutoff can be changed to fix dimention
cutoff = ceil(2*a);

%construct the Gaussian kernel with sigma the standard deviation and
cutlength =  2*cutoff;
%x = -cutoff:cutoff; 
fp = fc(1+2*cutlength:17*a);

%lamda = lamda_c(fp);
lamda = 1/0.05;

% stretchedu is the stretched version of u0 
%%u = imresize(u0',[95*a 1], 'nearest'); %replace with stretching matrix
su=kron(eye(17),ones(a,1));
stretchedu = su*u';
n = length(stretchedu);

% prepare A and fc for interpretation
%U = convmtx(u, 2*cutlength+1);
%u = conv(u,stretchedu);
%A = U(1.5*cutlength+1: end-1.5*cutlength,:);

%% try
    U = convmtx(stretchedu,2*cutlength+1);
    A = U(2*cutlength+1:end-2*cutlength,:);


%% f
dt = 1/norm(A'*A);


%Deblur the data
thisk = zeros(2*cutlength+1,1);

nextk = min(1, max(0, thisk + dt*(-A'*(A*thisk-fp)-(lamda*thisk))));
D = [eye(size(thisk,1)) zeros(size(thisk,1),1)] - [zeros(size(thisk,1),1) eye(size(thisk,1))];
D = D(1:end-1,1:end-1);
L = D'*D;



rep = 0;
thresh = norm(nextk - thisk)/norm(thisk);
while (thresh > threshold) && (rep < 10^5);
    rep = rep + 1;
    thisk = nextk;
    nextk = min(1, max(0, thisk + dt*(-A'*(A*thisk-fp)-(lamda*L*thisk))));
    thresh = norm(nextk - thisk)/norm(thisk);
    if(mod(rep,10000) == 0)
        disp(thresh);
    end
end
%display(rep);


end

