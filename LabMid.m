
filename = 'Assets/audio.wav'; 
[y, Fs] = audioread(filename);


t = (0:length(y)-1) / Fs;
figure;
plot(t, y);
xlabel('Time (seconds)');
ylabel('Amplitude');
title('Audio Waveform');
