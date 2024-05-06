% close all
% [audio, fs] = audioread("LabMidAudio.mp3");
% time = input("Enter delay time for echo: ");
% alpha = input("Enter value of Alpha for echo:");
% echoAud = echo(audio, time, alpha);
% sound(audio, fs);
% pause(length(audio)/fs + 1);
% disp("Original Done")
% sound(echoAud, fs);
% % Plot the Audio and Echo
% figure;
% subplot(3,1,1);
% plot(audio);
% title('Original Audio');
% subplot(3,1,2);
% plot(echoAud);
% title('Audio with Echo');
% % Reverberation
% timere = input("Enter delay time for reverberation: ");
% alphare = input("Enter value of Alpha for reverberation: ");
% reverbAud = reverb(audio, timere, alphare);
% sound(reverbAud, fs);
% subplot(3,1,3);
% plot(reverbAud);
% title('Audio Reverberation Effect');
% %%
% % Chorus
% delaychor = input("Enter delay time for chorus: ");
% delay_mod = round(0.005*fs);
% voicesNum = input("Enter Number of voices: ");
% chorAudio = chorus(audio, delaychor, voicesNum, delay_mod, fs);
% disp("Playing Chorus voice")
% sound(chorAudio, fs);
% figure;
% plot(chorAudio);
% title('Audio with Chorus');
% function echoAudio = echo(audio, delay, alpha)
%  echoAudio = zeros(size(audio));
%  for n = delay+1:length(audio)
%  echoAudio(n) = audio(n) + alpha * audio(n-delay);
%  end
% end
% function reverbAudio = reverb(audio, delay, alpha)
%  reverbAudio = zeros(size(audio));
%  for n = delay+1:length(audio)
%  reverbAudio(n) = audio(n) + alpha * reverbAudio(n-delay);
%  end
% end
% function chorAudio = chorus(audio, delay, voiceNum, delay_mod, fs)
%  chorAudio = audio;
%  mod_freq = 2;
%  mod_period = fs / mod_freq; 
% for voice = 1:voiceNum
%  % Generate the modulated delay amount
%  mod_delay = delay * ones(size(audio));
%  for n = 1:length(audio)
%  mod_index = mod(n, mod_period) + 1; 
%  if mod_index <= mod_period/2
%  mod_delay(n) = delay + delay_mod;
%  else
%  mod_delay(n) = delay - delay_mod;
%  end
%  end
 
%  % Apply delay and modulation to the current voice
%  audio_voice = zeros(size(audio));
%  for n = max(mod_delay)+1:length(audio)
%  delay_index = n - mod_delay(n);
%  if delay_index > 0 && delay_index <= length(audio)
%  audio_voice(n) = audio(delay_index);
%  end
%  end
 
%  % Mix the current voice with the chorus signal
%  chorAudio = chorAudio + audio_voice / voiceNum;
% end
% end

%----------------------------------------------------------------------------------------------------------------------------

% close all 
% %Read audio samples from the file "street-drum.mp3"
% [audio_data, fs] = audioread('Assets\LabMidAudio.mp3');

% % Echo Generation
% % Prompt the user to enter the delay amount (n0) and delay mix parameter (α) for the echo effect
% n0_echo = input('Enter the delay amount (in samples) for the echo effect: ');
% alpha_echo = input('Enter the delay mix parameter (between 0 and 1) for the echo effect: ');

% % Apply the echo effect to the audio signal
% audio_echo = zeros(size(audio_data));
% for n = n0_echo+1:length(audio_data)
%     audio_echo(n) = audio_data(n) + alpha_echo * audio_data(n-n0_echo);
% end

% % Play the original audio signal and the audio signal with the echo effect applied
% sound(audio_data, fs);
% pause(length(audio_data)/fs + 1); % Add a pause to allow the original signal to finish playing
% sound(audio_echo, fs);

% % Plot the original audio signal and the audio signal with the echo effect applied
% figure;
% subplot(2,1,1);
% plot(audio_data);
% title('Original Audio Signal');
% xlabel('Sample Index');
% ylabel('Amplitude');
% subplot(2,1,2);
% plot(audio_echo);
% title('Audio Signal with Echo Effect');
% xlabel('Sample Index');
% ylabel('Amplitude');

% % Reverberation
% % Prompt the user to enter the delay amount (n0) and delay mix parameter (α) for the reverberation effect
% n0_reverb = input('Enter the delay amount (in samples) for the reverberation effect: ');
% alpha_reverb = input('Enter the delay mix parameter (between 0 and 1) for the reverberation effect: ');

% % Apply the reverberation effect to the audio signal
% audio_reverb = zeros(size(audio_data));
% for n = n0_reverb+1:length(audio_data)
%     audio_reverb(n) = audio_data(n) + alpha_reverb * audio_reverb(n-n0_reverb);
% end

% % Play the original audio signal and the audio signal with the reverberation effect applied
% sound(audio_data, fs);
% pause(length(audio_data)/fs + 1);
% sound(audio_reverb, fs);

% % Plot the original audio signal and the audio signal with the reverberation effect applied
% figure;
% subplot(2,1,1);
% plot(audio_data);
% title('Original Audio Signal');
% xlabel('Sample Index');
% ylabel('Amplitude');
% subplot(2,1,2);
% plot(audio_reverb);
% title('Audio Signal with Reverberation Effect');
% xlabel('Sample Index');
% ylabel('Amplitude');


% % Chorus
% % Apply the chorus effect to the audio signal by mixing it with several delayed and modulated copies
% delay_chorus = round(0.02*fs); % Initial delay amount (20 ms)
% delay_mod_amount = round(0.005*fs); % Modulation amount (5 ms)
% mod_freq = 2; % Modulation frequency (in Hz)
% num_voices = 4; % Number of voices (delayed and modulated copies)
% mod_period = fs / mod_freq; % Modulation period in samples

% audio_chorus = audio_data; % Initialize the chorus signal with the original audio
% for voice = 1:num_voices
%     % Generate the modulated delay amount
%     mod_delay = delay_chorus * ones(size(audio_data));
%     for n = 1:length(audio_data)
%         mod_index = mod(n, mod_period) + 1; % Index for the modulation pattern
%         if mod_index <= mod_period/2
%             mod_delay(n) = delay_chorus + delay_mod_amount;
%         else
%             mod_delay(n) = delay_chorus - delay_mod_amount;
%         end
%     end
    
%     % Apply delay and modulation to the current voice
%     audio_voice = zeros(size(audio_data));
%     for n = max(mod_delay)+1:length(audio_data)
%         delay_index = n - mod_delay(n);
%         if delay_index > 0 && delay_index <= length(audio_data)
%             audio_voice(n) = audio_data(delay_index);
%         end
%     end
    
%     % Mix the current voice with the chorus signal
%     audio_chorus = audio_chorus + audio_voice / num_voices;
% end

% % Play the original audio signal and the audio signal with the chorus effect applied
% sound(audio_data, fs);
% pause(length(audio_data)/fs + 1);
% sound(audio_chorus, fs);

% % Plot the original audio signal and the audio signal with the chorus effect applied
% figure;
% subplot(2,1,1);
% plot(audio_data);
% title('Original Audio Signal');
% xlabel('Sample Index');
% ylabel('Amplitude');
% subplot(2,1,2);
% plot(audio_chorus);
% title('Audio Signal with Chorus Effect');
% xlabel('Sample Index');
% ylabel('Amplitude');

%----------------------------------------------------------------------------------------------------------------------------

% clc
% clear all
% syms n2

% %a part
% n=[-6:16];
% n1=[zeros(1,7) 1:16];
% x1 = power(2,-n1)-power(-1/2,n1);
% subplot(2,1,1)
% stem(n,x1)

% imp = [zeros(1,11) 1 zeros(1,4) 1 zeros(1,6)];
% x2 = 5*imp;
% subplot(2,1,2)
% stem(n,x2)
 
% %b part
% % figure()
% % subplot(2,1,1)
% % stem(n,abs(x1))
% % subplot(2,1,2)
% % stem(n,abs(x2))
% % figure()
% % subplot(2,1,1)
% % stem(angle(x1))
% % subplot(2,1,2)
% % stem(angle(x2))
% %c part
% x1 = (2)^-n2-(-1/2)^n2;
% x1_z = ztrans(x1)

% %d part
% x1_z
% %part e
% figure()
% num = [0 1 0];
% den = [1 0 -1/4];
% [z,p,k]= residue(num,den)
% zplane(z,p)
% %% 
% clc
% clear all
% t = 0:0.000125:1;
% f1 = 300;
% f2 = 1500;
% f3 = 3000;
% fs = 8000;
% x = 4*sin(2*pi*f1*t)+3*sin(2*pi*f2*t)+2*sin(2*pi*f3*t);
% plot(t,x)
% fftx = abs(fft(x));
% figure()
% plot(fftx)


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
L = 3; % Interpolation factor
interpolated_signal = interp(decimated_signal, L);

% Step 5: Upsampling
upsampled_signal = upsample(interpolated_signal, M);

% Time-domain plots
figure;
subplot(3, 2, 1);
plot(y);
title('Original Audio');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 2, 2);
plot(filtered_signal);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 2, 3);
plot(decimated_signal);
title('Decimated Signal (M=4)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 2, 4);
plot(interpolated_signal);
title('Interpolated Signal (L=3)');
xlabel('Time (s)');
ylabel('Amplitude');

subplot(3, 2, 5);
plot(upsampled_signal);
title('Upsampled Signal');
xlabel('Time (s)');
ylabel('Amplitude');


figure;
subplot(3, 2, 1);
f = linspace(-Fs/2, Fs/2, length(y));
Y = fftshift(fft(y));
plot(f, abs(Y));
title('Original Audio');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3, 2, 2);
Filtered_Y = fftshift(fft(filtered_signal));
plot(f, abs(Filtered_Y));
title('Frequency Domain - Filtered Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3, 2, 3);
Decimated_Y = fftshift(fft(decimated_signal));
plot(linspace(-Fs/2, Fs/2, length(Decimated_Y)), abs(Decimated_Y));
title('Frequency Domain - Decimated Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3, 2, 4);
Interpolated_Y = fftshift(fft(interpolated_signal));
plot(linspace(-Fs/2, Fs/2, length(Interpolated_Y)), abs(Interpolated_Y));
title('Frequency Domain - Interpolated Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(3, 2, 5);
Upsampled_Y = fftshift(fft(upsampled_signal));
plot(linspace(-Fs/2, Fs/2, length(Upsampled_Y)), abs(Upsampled_Y));
title('Frequency Domain - Upsampled Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');
