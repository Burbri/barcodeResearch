function [ signal ] = shortupc2signal( upc )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
signal = zeros(1,17);
signal(1:3) = [1 0 1];
for i = 1:2
  if double(upc(i))-48 == 0
    signal(4+7*(i-1):10+7*(i-1)) = [0 0 0 1 1 0 1];
  elseif double(upc(i))-48 == 1
    signal(4+7*(i-1):10+7*(i-1)) = [0 0 1 1 0 0 1];  
  elseif double(upc(i))-48 == 2
    signal(4+7*(i-1):10+7*(i-1)) = [0 0 1 0 0 1 1];  
  elseif double(upc(i))-48 == 3
    signal(4+7*(i-1):10+7*(i-1)) = [0 1 1 1 1 0 1];   
  elseif double(upc(i))-48 == 4
    signal(4+7*(i-1):10+7*(i-1)) = [0 1 0 0 0 1 1];   
  elseif double(upc(i))-48 == 5
    signal(4+7*(i-1):10+7*(i-1)) = [0 1 1 0 0 0 1];   
  elseif double(upc(i))-48 == 6
    signal(4+7*(i-1):10+7*(i-1)) = [0 1 0 1 1 1 1];   
  elseif double(upc(i))-48 == 7
    signal(4+7*(i-1):10+7*(i-1)) = [0 1 1 1 0 1 1];   
  elseif double(upc(i))-48 == 8
    signal(4+7*(i-1):10+7*(i-1)) = [0 1 1 0 1 1 1];
  else        % upc(i) == 9
    signal(4+7*(i-1):10+7*(i-1)) = [0 0 0 1 0 1 1]; 
  end;          
end;
end