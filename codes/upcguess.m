function [ g, p ] = upcguess( u, n )
%UNTITLED Summary of this function goes here
%   g = guess of the portion of barcode provided
%   p = how close the guess is to the provided barcode sample
%   u = provided barcode sample, vector of 1's and 0's where 1 = white, 0 =
%   black.
%   n = number of digits assumed to exist in barcode sample

%Set up variables
g = zeros(3+(7*n),1);
p = 1/0;
%Prepare Stretching matrix
s = 0; %index used to track how much matrix needed to be stretched by
S = kron(eye(3+(7*n)),ones(s,1)); %stretching matrix

%keep growing stretching matrix until same size as provided barcode
while size(S,1) < size(u,1)
    s = s+1;
    S = kron(eye(3+(7*n)),ones(s,1)); %stretching matrix
end

place = 0;
while(place < 10^n)
    guess = makecode(place, n);
    guess = 1-S*guess';
    gp = norm(guess - u)/norm(u);
    if gp < p
        g = guess;
        p = gp;
    end
end
end

function [ guess ] = makecode ( number, digits )
i = 1;
if digits < 6
    guess = zeros(3+(7*digits),1);
elseif digits < 12
    guess = zeros(8+(7*digits),1);
else
    guess = zeros(11+(7*digits),1);
end
n = digits;
while digits > 0
  if roundn(number, n) == 0
    u(1+7*(i-1):7+7*(i-1)) = [0 0 0 1 1 0 1];
  elseif roundn(number, n) == 1
    u(1+7*(i-1):7+7*(i-1)) = [0 0 1 1 0 0 1];  
  elseif roundn(number, n) == 2
    u(1+7*(i-1):7+7*(i-1)) = [0 0 1 0 0 1 1];  
  elseif roundn(number, n) == 3
    u(1+7*(i-1):7+7*(i-1)) = [0 1 1 1 1 0 1];   
  elseif roundn(number, n) == 4
    u(1+7*(i-1):7+7*(i-1)) = [0 1 0 0 0 1 1];   
  elseif roundn(number, n) == 5
    u(1+7*(i-1):7+7*(i-1)) = [0 1 1 0 0 0 1];   
  elseif roundn(number, n) == 6
    u(1+7*(i-1):7+7*(i-1)) = [0 1 0 1 1 1 1];   
  elseif roundn(number, n) == 7
    u(1+7*(i-1):7+7*(i-1)) = [0 1 1 1 0 1 1];   
  elseif roundn(number, n) == 8
    u(1+7*(i-1):7+7*(i-1)) = [0 1 1 0 1 1 1];
  else        % upc(i) == 9
    u(1+7*(i-1):7+7*(i-1)) = [0 0 0 1 0 1 1]; 
  end
  i = i + 1;
  n = n - 1;
end
if n > 0
    u(43:47) = [0 1 0 1 0];
    while n > 0
        if roundn(number, n) == 0
            u(48+7*(i-7):54+7*(i-7)) = [1 1 1 0 0 1 0];
        elseif roundn(number, n) == 1
            u(48+7*(i-7):54+7*(i-7)) = [1 1 0 0 1 1 0];
        elseif roundn(number, n) == 2
            u(48+7*(i-7):54+7*(i-7)) = [1 1 0 1 1 0 0];
        elseif roundn(number, n) == 3
            u(48+7*(i-7):54+7*(i-7)) = [1 0 0 0 0 1 0];
        elseif roundn(number, n) == 4
            u(48+7*(i-7):54+7*(i-7)) = [1 0 1 1 1 0 0];
        elseif roundn(number, n) == 5
            u(48+7*(i-7):54+7*(i-7)) = [1 0 0 1 1 1 0];
        elseif roundn(number, n) == 6
            u(48+7*(i-7):54+7*(i-7)) = [1 0 1 0 0 0 0];
        elseif roundn(number, n) == 7
            u(48+7*(i-7):54+7*(i-7)) = [1 0 0 0 1 0 0];
        elseif roundn(number, n) == 8
            u(48+7*(i-7):54+7*(i-7)) = [1 0 0 1 0 0 0];
        else        % upc(i) == 9
            u(48+7*(i-7):54+7*(i-7)) = [1 1 1 0 1 0 0];
        end
        i = i + 1;
        n = n - 1;
    end
end
if(guess < 12)
    guess = [1 0 1 u];
else
    guess = [1 0 1 u 1 0 1];
end
