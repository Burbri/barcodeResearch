function [ signal ] = shortupc2signal( upc )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
signal = zeros(1:17);
for i = 1:2
  if double(upc(i))-48 == 0
    u(1+7*(i-1):7+7*(i-1)) = [0 0 0 1 1 0 1];
  elseif double(upc(i))-48 == 1
    u(1+7*(i-1):7+7*(i-1)) = [0 0 1 1 0 0 1];  
  elseif double(upc(i))-48 == 2
    u(1+7*(i-1):7+7*(i-1)) = [0 0 1 0 0 1 1];  
  elseif double(upc(i))-48 == 3
    u(1+7*(i-1):7+7*(i-1)) = [0 1 1 1 1 0 1];   
  elseif double(upc(i))-48 == 4
    u(1+7*(i-1):7+7*(i-1)) = [0 1 0 0 0 1 1];   
  elseif double(upc(i))-48 == 5
    u(1+7*(i-1):7+7*(i-1)) = [0 1 1 0 0 0 1];   
  elseif double(upc(i))-48 == 6
    u(1+7*(i-1):7+7*(i-1)) = [0 1 0 1 1 1 1];   
  elseif double(upc(i))-48 == 7
    u(1+7*(i-1):7+7*(i-1)) = [0 1 1 1 0 1 1];   
  elseif double(upc(i))-48 == 8
    u(1+7*(i-1):7+7*(i-1)) = [0 1 1 0 1 1 1];
  else        % upc(i) == 9
    u(1+7*(i-1):7+7*(i-1)) = [0 0 0 1 0 1 1]; 
  end;          
end;
signal(1:3) = [1 0 1];
end