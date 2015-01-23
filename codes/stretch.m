function [u] = stretch(u0, a)
repeat = a/length(u0);
Eindex = 1;
for Sindex = 1:length(u0)
    for Rindex = 0:repeat-1
        u(Eindex) = u0(Sindex);
        Eindex = Eindex + 1;
    end
end