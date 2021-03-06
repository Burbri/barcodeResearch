function [fc,nextu,cuts] = test(u0,a,w,lamda, dt, threshold)

sigma = a*w;
cutoff = ceil(2*sigma);

%% construct the Gaussian kernel with sigma the standard deviation and
cutlength =  2*cutoff;
x = -cutoff:cutoff; 
k =exp(-x.^2/2/sigma^2); 
k = k/sum(k);   % normalize to sum 1

%% stretchedu is the stretched version of u0 
%%u = imresize(u0',[95*a 1], 'nearest'); %replace with stretching matrix
su=kron(eye(95),ones(a,1));
% display(u0);
stretchedu = su*u0';
n = length(stretchedu);

%% prepare A and fc for interpretation
K = convmtx(k', n);
% J = convmtx(k,n);
% display(size(K));
% display(size(J));
f = conv(k,stretchedu);
A = K(cutlength+1: end-cutlength,cutoff+1: end-cutoff)';
fc = f(cutlength+1: end-cutlength);
cuts = stretchedu(cutoff+1:end-cutoff);

%% calculate dt
%solve(norm(-A'*(A*thisu-fc)-(lamda*thisu) - (-A'*(A*thisu-fc)-(lamda*thisu)))

%% apply gradient filter
%%for findex = 1:size(fc)
    thisu = fc;
    display(size(thisu));
    display(size(fc));
    display(size(A));
    %%projection
   nextu = min(1,max(0,thisu + dt*(-A'*(A*thisu-fc)-(lamda*thisu))));
    iterations = 1;
    while norm(nextu - thisu)/norm(thisu) > threshold
       thisu = nextu;
       nextu = min(1,max(0,thisu + dt*(-A'*(A*thisu-fc)-(lamda*thisu))));
      
       if mod(iterations,10) == 0
           display('Going.............................................')
       end
       iterations = iterations + 1;
    end
    display(iterations)

%%end

end
