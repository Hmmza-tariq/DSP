% Task 1
% --------------------------------------

A = 5;
f = 5;
Fs = 5000;
t = (0:1 / Fs:1);

signal = A * cos((2*pi*f*t) - pi/2);
dtft = abs(fft(signal));

noise = awgn(signal, 10, 'measured');

fourier_noise = awgn(dtft, 10, 'measured');
idtft = abs(ifft(fourier_noise));

% using the low pass filter
f1 = filter(Hd, noise);
f2 = filter(Hd, idtft);

%% plotting cosine signal x(t)
subplot(4, 3, 1);% Task 1

clc
clear
close all

% --------------------------------------

A = 5;
f = 5;
Fs = 5000;
t = (0:1 / Fs:1);

signal = A * cos((2*pi*f*t) - pi/2);
dtft = abs(fft(signal));

noise = awgn(signal, 10, 'measured');

fourier_noise = awgn(dtft, 10, 'measured');
idtft = abs(ifft(fourier_noise));

% using the low pass filter
f1 = low_pass_filter(Fs, noise);
f2 = low_pass_filter(Fs, idtft);

%% plotting cosine signal x(t)
subplot(4, 3, 1);
plot(t, signal);
title('Input Signal');
xlabel('Time (t)');
ylabel('x(t)');

%% plotting fourier transform of x(t)
subplot(4, 3, 2);
plot(dtft);
title('FFT of x(t)');
xlabel('Frequency (f)');
ylabel('|F(x)|');
axis([-1000, 5500, 0, 15000]);



%% plotting the noise + x(t)
subplot(4, 3, 4);
plot(t, noise);
title('Noise of x(t)');
xlabel('Time (t)');
ylabel('Noisy Signal in Time Domain');

%% plotting the fourier noise
subplot(4, 3, 5);
plot(t, fourier_noise);
title('Noise in FFT');
xlabel('Time (t)');
ylabel('Noisy Signal in Time Domain');

%% plotting the filtered signal
subplot(4, 3, 6);
plot(t, f1);
xlabel('Time (t)');
ylabel('Filtered x(t)');
title('Filtered DTFT Signal');

%% first 100 samples noise
subplot(4, 3, 7);
plot(dtft(1:100));
title('Noise in first 100 samples of x(t)');
xlabel('Time (t)');
ylabel('Noise');

%% first 100 samples noise
subplot(4, 3, 8);
plot(fourier_noise(1:100));
title('Noise in first 100 samples of FFT');
xlabel('Time (t)');
ylabel('Noise');

%% plotting the inverse fourier noise
subplot(4, 3, 10);
plot(t, idtft);
title('Noise of IDTFT');
xlabel('Time (t)');
ylabel('Noisy Signal in Time Domain');

%% plotting the IDTFT filtered signal
subplot(4, 3, 11);
plot(t, f2);
xlabel('Time (t)');
ylabel('Filtered x(t)');
title('Filtered IDTFT Signal');
plot(t, signal);
title('Input Signal');
xlabel('Time (t)');
ylabel('x(t)');

%% plotting fourier transform of x(t)
subplot(4, 3, 2);
plot(dtft);
title('FFT of x(t)');
xlabel('Frequency (f)');
ylabel('|F(x)|');
axis([-1000, 5500, 0, 15000]);



%% plotting the noise + x(t)
subplot(4, 3, 4);
plot(t, noise);
title('Noise of x(t)');
xlabel('Time (t)');
ylabel('Noisy Signal in Time Domain');

%% plotting the fourier noise
subplot(4, 3, 5);
plot(t, fourier_noise);
title('Noise in FFT');
xlabel('Time (t)');
ylabel('Noisy Signal in Time Domain');

%% plotting the filtered signal
subplot(4, 3, 6);
plot(t, f1);
xlabel('Time (t)');
ylabel('Filtered x(t)');
title('Filtered DTFT Signal');

%% first 100 samples noise
subplot(4, 3, 7);
plot(dtft(1:100));
title('Noise in first 100 samples of x(t)');
xlabel('Time (t)');
ylabel('Noise');

%% first 100 samples noise
subplot(4, 3, 8);
plot(fourier_noise(1:100));
title('Noise in first 100 samples of FFT');
xlabel('Time (t)');
ylabel('Noise');

%% plotting the inverse fourier noise
subplot(4, 3, 10);
plot(t, idtft);
title('Noise of IDTFT');
xlabel('Time (t)');
ylabel('Noisy Signal in Time Domain');

%% plotting the IDTFT filtered signal
subplot(4, 3, 11);
plot(t, f2);
xlabel('Time (t)');
ylabel('Filtered x(t)');
title('Filtered IDTFT Signal');