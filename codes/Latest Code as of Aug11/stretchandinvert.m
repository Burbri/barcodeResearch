function [ u ] = stretchandinvert( u0, a )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

S = kron(eye(95),ones(a,1)); %stretching matrix
u = 1-S*u0';

end

