function [ nextk ] = shortblur( f, u )
lamda = 1;
dt = 0.001;
bigU = convmtx(u',length(f));
thisk = f;
A= bigU;


nextk = min(1,max(0,thisk + dt*(-A'*(A*thisk-f)-(lamda*thisk))));
    iterations = 1;
    while norm(nextk - thisk)/norm(thisk) > threshold
       thisk = nextk;
       nextk = min(1,max(0,thisk + dt*(-A'*(A*thisk-f)-(lamda*thisk))));
      
       if mod(iterations,10) == 0
           display('Going.............................................')
       end
       iterations = iterations + 1;
    end
    
    display(iterations)
end

