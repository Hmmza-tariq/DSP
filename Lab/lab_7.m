[data,Fs] = audioread('Assets\audio.mp3'); 
audiowrite('Assets\output.wav',data,44000);   
[data,Fs] = audioread('Assets\output.wav');    
data = data(:,2);                              
T = 1/Fs;                                       
figure
subplot(2,1,1)
t = 0:T:(length(data)*T)-T;

plot(t,data)
title('Original Signal in Time Domain')
xlabel('Time')
ylabel('Amplitude') 

subplot(2,1,2)
FFT= abs(fft(data));
f = (0:length(FFT)-1)*Fs/length(FFT);
plot(f,FFT)
title('Original Signal in Frequency Domain')
xlabel('Frequency')
ylabel('Magnitude') 
Out =filter(band,data);       
figure

subplot(2,1,1)
t = 0:T:(length(Out)*T)-T;
plot(t,Out)
title('Filtered Signal in Time Domain')
xlabel('Time')
ylabel('Amplitude') 

subplot(2,1,2)
FFT= abs(fft(Out));
f = (0:length(FFT)-1)*Fs/length(FFT);
plot(f,FFT)
title('Filtered Signal in Frequency Domain')
xlabel('Frequency')
ylabel('Magnitude') 

