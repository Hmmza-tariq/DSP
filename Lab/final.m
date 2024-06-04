fs = 5000;
fs_new = 5000 * (5/4);

t = 0:1/fs:1-1/fs;
t_resampled = 0:1/fs_new:1-1/fs_new;

x = sin(2*pi*200*t) + cos(2*pi*2000*t);

x_resampled = resample(x, 5, 4);

f_cutoff = 1000;
[b, a] = butter(6, f_cutoff/(fs_new/2));
x_filtered = filter(b, a, x_resampled);

figure;
subplot(3,2,1);
plot(t, x);
title('Original Signal - Time Domain');

subplot(3,2,3);
plot(t_resampled, x_resampled);
title('Resampled Signal - Time Domain');

subplot(3,2,5);
plot(t_resampled, x_filtered);
title('Filtered Signal - Time Domain');

X = fft(x);
f = (0:length(X)-1)*fs/length(X);
subplot(3,2,2);
plot(f, abs(X));
title('Original Signal - Frequency Domain');
xlim([0 3000]);

X_resampled = fft(x_resampled);
f_resampled = (0:length(X_resampled)-1)*fs_new/length(X_resampled);
subplot(3,2,4);
plot(f_resampled, abs(X_resampled));
title('Resampled Signal - Frequency Domain');
xlim([0 3000]);

X_filtered = fft(x_filtered);
subplot(3,2,6);
plot(f_resampled, abs(X_filtered));
title('Filtered Signal - Frequency Domain');
xlim([0 3000]);


