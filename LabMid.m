% Step 1: Load Audio
filename = 'Assets/audio.mp3';
[y, Fs] = audioread(filename);

% Step 2: Lowpass Filtering
cutoff_freq = 4000;
filter_order = 8;
[b, a] = butter(filter_order, cutoff_freq/(Fs/2), 'low');
filtered_signal = filter(b, a, y);

% Step 3: Decimation
M = 4;
decimated_signal = downsample(filtered_signal, M);

% Step 4: Interpolation
L = 3; 
interpolated_signal = interp1((1:length(decimated_signal)), decimated_signal, 1:L:length(decimated_signal)*L, 'linear');

% Step 5: Upsampling
upsampled_signal = upsample(interpolated_signal, M);

% Step 6: Plotting
t_original = (0:length(y)-1) / Fs;
t_filtered = (0:length(filtered_signal)-1) / Fs;
t_decimated = (0:length(decimated_signal)-1) / (Fs/M);
t_interpolated = (0:length(interpolated_signal)-1) / (Fs/L);  % Adjusted length for interpolation
t_upsampled = (0:length(upsampled_signal)-1) / (Fs/M);  % Adjusted length for upsampling

% Time-domain plots
figure;
subplot(3, 2, 1);
plot(t_original, y);
title('Original Audio');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 2, 2);
plot(t_filtered, filtered_signal);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 2, 3);
plot(t_decimated, decimated_signal);
title('Decimated Signal (M=4)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 2, 4);
plot(t_interpolated, interpolated_signal);
title('Interpolated Signal (L=3)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 2, 5);
plot(t_upsampled, upsampled_signal);
title('Upsampled Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Frequency-domain plots
f_original = linspace(0, Fs, length(y));
f_filtered = linspace(0, Fs, length(filtered_signal));
f_decimated = linspace(0, Fs/M, length(decimated_signal));
f_interpolated = linspace(0, Fs/L, length(interpolated_signal));
f_upsampled = linspace(0, Fs, length(upsampled_signal));  

Y_original = fft(y);
Y_filtered = fft(filtered_signal);
Y_decimated = fft(decimated_signal);
Y_interpolated = fft(interpolated_signal);
Y_upsampled = fft(upsampled_signal);

figure;
subplot(3, 2, 1);
plot(f_original, abs(Y_original));
title('Original Audio Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3, 2, 2);
plot(f_filtered, abs(Y_filtered));
title('Filtered Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3, 2, 3);
plot(f_decimated, abs(Y_decimated));
title('Decimated Signal (M=4)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3, 2, 4);
plot(f_original, abs(Y_original));
title('Interpolated Signal (L=3)');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3, 2, 5);
plot(f_original, abs(Y_original));
title('Upsampled Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

