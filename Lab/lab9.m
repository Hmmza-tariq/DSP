filename = 'Assets/audio.wav';
[audio_signal, Fs_orig] = audioread(filename);

duration = size(audio_signal, 1) / Fs_orig;

Fs_1 = 2 * Fs_orig;
Fs_2 = 0.8 * Fs_orig;
Fs_3 = 1.5 * Fs_orig;

t_1 = 0:1/Fs_1:duration-1/Fs_1;
t_2 = 0:1/Fs_2:duration-1/Fs_2;
t_3 = 0:1/Fs_3:duration-1/Fs_3;

sampled_signal_1 = audio_signal(1:round(duration*Fs_1));
sampled_signal_2 = audio_signal(1:round(duration*Fs_2));
sampled_signal_3 = audio_signal(1:round(duration*Fs_3));

figure;

subplot(3, 1, 1);
plot(t_1, sampled_signal_1);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled Audio Signal (Fs = 2Fc)');

subplot(3, 1, 2);
plot(t_2, sampled_signal_2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled Audio Signal (Fs < 2Fc)');

subplot(3, 1, 3);
plot(t_3, sampled_signal_3);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled Audio Signal (Fs > 2Fc)');
