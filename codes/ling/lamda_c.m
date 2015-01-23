function [lamda] = lamda_c(fc)
%lamda = varience of noise / varience of clean barcode
v_clean = var(upc2signal('123456789012'));
v_noise = var(fc);
lamda = v_noise/v_clean;

end

