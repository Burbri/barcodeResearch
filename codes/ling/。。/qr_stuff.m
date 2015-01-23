%after downloading ZXing from 

%http://www.mathworks.com/matlabcentral/fileexchange/29239-qr-code-encode-and-decode

%you can use the following commands to generate and decode qr barcodes:



%set path stuff for java stuff that barcode generator uses

javaaddpath('C:\ZXing\ZXing-2.1\zxing-2.1\core\core.jar');

javaaddpath('C:\ZXing\ZXing-2.1\zxing-2.1\javase\javase.jar');



%generate 2D barcode

message = 'blah blah blah blah blah blah';

Mb = 594;

Nb = 594;

disp('generating barcode');

qr = encode_qr(message,[Nb Mb]);

decoded_message = decode_qr(qr)
