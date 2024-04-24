fs = 8000;
duration = 5; 
recObj = audiorecorder(fs, 16, 1); 
disp('Start speaking.')
recordblocking(recObj, duration); 
disp('End of Recording.');
audio = getaudiodata(recObj); 
sound(audio);


decimatedSignal = downsample(audio, 3);

upsampledSignal = upsample(audio, 5);

resampledSignal_3_5 = resample(audio, 3, 5);
resampledSignal_5_3 = resample(audio, 5, 3);


figure;
subplot(2,1,1);
plot(audio);
title('Original Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(abs(fft(audio)));
title('Original Signal in Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Y(f)');

figure;
subplot(2,1,1);
plot(decimatedSignal);
title('Decimated Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(abs(fft(decimatedSignal)));
title('Decimated Signal in Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Y(f)');

figure;
subplot(2,1,1);
plot(upsampledSignal);
title('Upsampled Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(abs(fft(upsampledSignal)));
title('Upsampled Signal in Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Y(f)');

figure;
subplot(2,1,1);
plot(resampledSignal_3_5);
title('3/5 Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(2,1,2);
plot(abs(fft(resampledSignal_3_5)));
title('3/5 Signal in Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Y(f)');

figure;
subplot(2,1,1);
plot(resampledSignal_5_3);
title('5/3 Resampled Signal in Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');


subplot(2,1,2);
plot(abs(fft(resampledSignal_5_3)));
title('5/3 Resampled Signal in Frequency Domain');
xlabel('Frequency (Hz)');
ylabel('Y(f)');