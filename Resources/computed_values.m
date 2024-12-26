close all
clear

% Define the number of samples
numSamples = 16;

% Generate equally spaced sample points
samplePoints = linspace(0, 2*pi, numSamples + 1);
samplePoints = samplePoints(1:end-1); % Remove the last point to get exactly one period

cosine_wave = (1/16)*cos(samplePoints);

% Generate Hamming window
hamming_window = hamming(numSamples, "symmetric")';

% Apply Hamming window to cosine wave
windowed_cosine = cosine_wave .* hamming_window;

% Define the range for 16-bit signed integers
maxInt16 = 2^15 - 1;
minInt16 = -2^15;

% Scale the window function to the range of 16-bit signed integers
scaledHamming = hamming_window * maxInt16;
scaledCos = cosine_wave * maxInt16;
scaledResult = windowed_cosine * maxInt16;

% Convert the scaled signal to 16-bit signed integers
fixedPointHamming = typecast(int16(scaledHamming), 'uint16');
fixedPointCos = typecast(int16(scaledCos), 'uint16');
fixedPointResult = typecast(int16(scaledResult), 'uint16');

%FFT
fft_output = fft(windowed_cosine, 16);
fft_output_real = real(fft_output);
fft_output_complex = imag(fft_output);

fixedPointReal = typecast(int16(fft_output_real * maxInt16), 'uint16');
fixedPointComp = typecast(int16(fft_output_complex * maxInt16), 'uint16');

%{
% Plot
figure;
plot(t, cosine_wave, 'b--', 'LineWidth', 1.5);
hold on;
plot(t, hamming_window, 'r:', 'LineWidth', 1.5);
plot(t, windowed_cosine, 'g-', 'LineWidth', 2);
hold off;

% Customize plot
title('Cosine Wave through Hamming Window');
xlabel('Time');
ylabel('Amplitude');
legend('Original Cosine', 'Hamming Window', 'Windowed Cosine');
grid on;
axis([0 1 -1.1 1.1]);
%}