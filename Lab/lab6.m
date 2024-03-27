close all
% task 1
Fs = 5000;
f = 5;
A = 5;
t = 0:1/Fs:1;
x = A*cos(2*pi*f*t + pi/2);
x(1) = 0;
figure;
subplot(5,1,1);
plot(t, x);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');
X = fft(x);
frequencies = linspace(0, Fs, length(X));
subplot(5,1,2);
plot(frequencies, abs(X));
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('Frequency Domain Representation of Cosine Signal');
grid on;
subplot(5,1,3);
plot(frequencies, abs(X));
title('Fourier Transform Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
xlim([0 100]);
SNR = 10;
y = awgn(x, SNR, 'measured');
subplot(5,1,4);
plot(t, y);
title('Signal with Gaussian Noise');
xlabel('Time (s)');
ylabel('Amplitude');
SNR = 10;
y_noisy = awgn(x, SNR, 'measured');
Y_noisy = fft(y_noisy);
cutoff_frequency = 20;
filter_length = length(Y_noisy);
low_pass_filter = ones(1, filter_length);
low_pass_filter(cutoff_frequency+1:end-cutoff_frequency) = 0;
Y_filtered = Y_noisy .* low_pass_filter;
y_filtered = ifft(Y_filtered);
subplot(5,1,5);
plot(t, real(y_filtered));
title('Filtered Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

% task 2

% n = -8:8;
% x = [zeros(1, 6) 1 2 3 2 1 zeros(1, 6)];
% shifted_x = [zeros(1, 8) 1 2 3 2 1 zeros(1, 4)];
% [freqResponse, w] = freqz(x);
% phaseResponse = phasez(x);
% magResponse = abs(fft(x));
% [shiftedFreqResp, w] = freqz(shifted_x);
% shiftedPhaseResp = phasez(shifted_x);
% shiftedMagResp = abs(fft(shifted_x));
% figure()
% subplot(2, 2, 1)
% stem(n, x)
% title('Original Filter')
% xlabel('Samples')
% ylabel('Amplitude')
% subplot(2, 2, 2)
% plot(real(freqResponse))
% title('Frequency Response of Filter')
% xlabel('Frequency')
% ylabel('Amplitude')
% subplot(2, 2, 3)
% plot(phaseResponse)
% title('Phase Response of Filter')
% xlabel('Frequency')
% ylabel('Phase')
% subplot(2, 2, 4)
% plot(magResponse)
% title('Magnitude Response of Filter')
% xlabel('Frequency')
% ylabel('Magnitude')
% figure()
% subplot(2, 2, 1)
% stem(n, shifted_x)
% title('Shifted Filter')
% xlabel('Samples')
% ylabel('Amplitude')
% subplot(2, 2, 2)
% plot(real(shiftedFreqResp))
% title('Frequency Response of Shifted Filter')
% xlabel('Frequency')
% ylabel('Amplitude')
% subplot(2, 2, 3)
% plot(shiftedPhaseResp)
% title('Phase Response of Shifted Filter')
% xlabel('Frequency')
% ylabel('Phase')
% subplot(2, 2, 4)
% plot(shiftedMagResp)
% title('Magnitude Response of Shifted Filter')
% xlabel('Frequency')
% ylabel('Magnitude')

% task 3
% Define parameters
% M_values = [5, 9, 15, 35]; % Values of M
% fs = 1000; % Sampling frequency
% fc = 100; % Cutoff frequency
% % Design filters for each M
% for i = 1:length(M_values)
%  M = M_values(i);
 
%  % Ideal low-pass filter design using sinc function
%  n = -(M-1)/2 : (M-1)/2;
%  hd = 2 * fc / fs * sinc(2 * fc * n / fs);
 
%  % Make the filter causal by shifting
%  hd_shifted = circshift(hd, [0, (M-1)/2]);
 
%  % Compute frequency response using FFT
%  H = fft(hd_shifted);
%  magnitude = abs(H);
%  phase = angle(H);
 
%  % Plot frequency, phase, and magnitude responses
%  figure;
%  subplot(3, 1, 1);
%  plot((0:M-1) / M * fs, magnitude);
%  title(['Frequency Response (M = ', num2str(M), ')']);
%  xlabel('Frequency (Hz)');
%  ylabel('Magnitude');
%  subplot(3, 1, 2);
%  plot((0:M-1) / M * fs, unwrap(phase));
%  title(['Phase Response (M = ', num2str(M), ')']);
%  xlabel('Frequency (Hz)');
%  ylabel('Phase (rad)');
%  subplot(3, 1, 3);
%  stem(hd_shifted);
%  title(['Impulse Response (M = ', num2str(M), ')']);
%  xlabel('n');
%  ylabel('h[n]');
% end
