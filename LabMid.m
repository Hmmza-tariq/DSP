
close all 
%% Read audio samples from the file "street-drum.mp3"
[audio_data, fs] = audioread('Assets/LabMidAudio.mp3');

%% Echo Generation
% Prompt the user to enter the delay amount (n0) and delay mix parameter (α) for the echo effect
n0_echo = input('Enter the delay amount (in samples) for the echo effect: ');
alpha_echo = input('Enter the delay mix parameter (between 0 and 1) for the echo effect: ');

% Apply the echo effect to the audio signal
audio_echo = zeros(size(audio_data));
for n = n0_echo+1:length(audio_data)
    audio_echo(n) = audio_data(n) + alpha_echo * audio_data(n-n0_echo);
end

% Play the original audio signal and the audio signal with the echo effect applied
sound(audio_data, fs);
pause(length(audio_data)/fs + 1); % Add a pause to allow the original signal to finish playing
sound(audio_echo, fs);

% Plot the original audio signal and the audio signal with the echo effect applied
figure;
subplot(2,1,1);
plot(audio_data);
title('Original Audio Signal');
xlabel('Sample Index');
ylabel('Amplitude');
subplot(2,1,2);
plot(audio_echo);
title('Audio Signal with Echo Effect');
xlabel('Sample Index');
ylabel('Amplitude');

%% Reverberation
% Prompt the user to enter the delay amount (n0) and delay mix parameter (α) for the reverberation effect
n0_reverb = input('Enter the delay amount (in samples) for the reverberation effect: ');
alpha_reverb = input('Enter the delay mix parameter (between 0 and 1) for the reverberation effect: ');

% Apply the reverberation effect to the audio signal
audio_reverb = zeros(size(audio_data));
for n = n0_reverb+1:length(audio_data)
    audio_reverb(n) = audio_data(n) + alpha_reverb * audio_reverb(n-n0_reverb);
end

% Play the original audio signal and the audio signal with the reverberation effect applied
sound(audio_data, fs);
pause(length(audio_data)/fs + 1);
sound(audio_reverb, fs);

% Plot the original audio signal and the audio signal with the reverberation effect applied
figure;
subplot(2,1,1);
plot(audio_data);
title('Original Audio Signal');
xlabel('Sample Index');
ylabel('Amplitude');
subplot(2,1,2);
plot(audio_reverb);
title('Audio Signal with Reverberation Effect');
xlabel('Sample Index');
ylabel('Amplitude');


%% Chorus
% Apply the chorus effect to the audio signal by mixing it with several delayed and modulated copies
delay_chorus = round(0.02*fs); % Initial delay amount (20 ms)
delay_mod_amount = round(0.005*fs); % Modulation amount (5 ms)
mod_freq = 2; % Modulation frequency (in Hz)
num_voices = 4; % Number of voices (delayed and modulated copies)
mod_period = fs / mod_freq; % Modulation period in samples

audio_chorus = audio_data; % Initialize the chorus signal with the original audio
for voice = 1:num_voices
    % Generate the modulated delay amount
    mod_delay = delay_chorus * ones(size(audio_data));
    for n = 1:length(audio_data)
        mod_index = mod(n, mod_period) + 1; % Index for the modulation pattern
        if mod_index <= mod_period/2
            mod_delay(n) = delay_chorus + delay_mod_amount;
        else
            mod_delay(n) = delay_chorus - delay_mod_amount;
        end
    end
    
    % Apply delay and modulation to the current voice
    audio_voice = zeros(size(audio_data));
    for n = max(mod_delay)+1:length(audio_data)
        delay_index = n - mod_delay(n);
        if delay_index > 0 && delay_index <= length(audio_data)
            audio_voice(n) = audio_data(delay_index);
        end
    end
    
    % Mix the current voice with the chorus signal
    audio_chorus = audio_chorus + audio_voice / num_voices;
end

% Play the original audio signal and the audio signal with the chorus effect applied
sound(audio_data, fs);
pause(length(audio_data)/fs + 1);
sound(audio_chorus, fs);

% Plot the original audio signal and the audio signal with the chorus effect applied
figure;
subplot(2,1,1);
plot(audio_data);
title('Original Audio Signal');
xlabel('Sample Index');
ylabel('Amplitude');
subplot(2,1,2);
plot(audio_chorus);
title('Audio Signal with Chorus Effect');
xlabel('Sample Index');
ylabel('Amplitude');