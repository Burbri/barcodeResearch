function upc = signal2upc (signal)
upc = zeros(1,12);

for number = 1:6
    if signal(4+(7*(number-1)):10+(7*(number-1))) == [0 0 0 1 1 0 1]
        upc(number) = 0;
    elseif signal(4+(7*(number-1)):10+(7*(number-1))) == [0 0 1 1 0 0 1]
        upc(number) = 1;
    elseif signal(4+(7*(number-1)):10+(7*(number-1))) == [0 0 1 0 0 1 1]
        upc(number) = 2;
    elseif signal(4+(7*(number-1)):10+(7*(number-1))) == [0 1 1 1 1 0 1]
        upc(number) = 3;
    elseif signal(4+(7*(number-1)):10+(7*(number-1))) == [0 1 0 0 0 1 1]
        upc(number) = 4;
    elseif signal(4+(7*(number-1)):10+(7*(number-1))) == [0 1 1 0 0 0 1]
        upc(number) = 5;
    elseif signal(4+(7*(number-1)):10+(7*(number-1))) == [0 1 0 1 1 1 1]
        upc(number) = 6;
    elseif signal(4+(7*(number-1)):10+(7*(number-1))) == [0 1 1 1 0 1 1]
        upc(number) = 7;
    elseif signal(4+(7*(number-1)):10+(7*(number-1))) == [0 1 1 0 1 1 1]
        upc(number) = 8;
    else
        upc(number) = 9;
    end
end
for number = 7:12
    if signal(50+(7*(number-1)):56+(7*(number-1))) == [1 1 1 0 0 1 0]
        upc(number) = 0;
    elseif signal(50+(7*(number-1)):56+(7*(number-1))) == [1 1 0 0 1 1 0]
        upc(number) = 1;
    elseif signal(50+(7*(number-1)):56+(7*(number-1))) == [1 1 0 1 1 0 0]
        upc(number) = 2;
    elseif signal(50+(7*(number-1)):56+(7*(number-1))) == [1 0 0 0 0 1 0]
        upc(number) = 3;
    elseif signal(50+(7*(number-1)):56+(7*(number-1))) == [1 0 1 1 1 0 0]
        upc(number) = 4;
    elseif signal(50+(7*(number-1)):56+(7*(number-1))) == [1 0 0 1 1 1 0]
        upc(number) = 5;
    elseif signal(50+(7*(number-1)):56+(7*(number-1))) == [1 0 1 0 0 0 0]
        upc(number) = 6;
    elseif signal(50+(7*(number-1)):56+(7*(number-1))) == [1 0 0 0 1 0 0]
        upc(number) = 7;
    elseif signal(50+(7*(number-1)):56+(7*(number-1))) == [1 0 0 1 0 0 0]
        upc(number) = 8;
    else
        upc(number) = 9;
    end
end
end