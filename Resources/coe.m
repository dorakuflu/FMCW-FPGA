clear
close all

% Step 1: Generate the Hamming window of length 16
L = 16;
hammingWindow = hamming(L, "symmetric");

% Step 2: Quantize the window coefficients to a suitable fixed-point representation
quantizedWindow = round(hammingWindow * 2^15); % scale and round

% Step 3: Write the fixed-point data to a COE file manually
fileID = fopen('hamming.coe', 'w');
fprintf(fileID, 'Radix=10;\n');
fprintf(fileID, 'CoefData=\n');

for i = 1:length(quantizedWindow)
    if i < length(quantizedWindow)
        fprintf(fileID, '%d,\n', quantizedWindow(i));
    else
        fprintf(fileID, '%d;\n', quantizedWindow(i));
    end
end

fclose(fileID);
