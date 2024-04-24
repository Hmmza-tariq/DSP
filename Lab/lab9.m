f = 5 ;                         %frequency of cosine wave

Fs1 = 5000 ;                    %sampling frequency of original signal
dt = 1/Fs1;                     %seconds per sample 
Time = 1;                       %End time 
t1 = (0:dt:Time)';              %range of time axis  
x1 = cos(2*pi*f*t1);            %cosine signal 
 
Fs2 = 10 ;                      %sampling frequency Fs = 2*fc
dt = 1/Fs2;                     %seconds per sample 
Time = 1;                       %End time 
t2 = (0:dt:Time)';              %range of time axis  
x2 = cos(2*pi*f*t2);            %cosine signal 
 
Fs3 = 20 ;                      %sampling frequency Fs > 2*fc 
dt = 1/Fs3;                     %seconds per sample 
Time = 1;                       %End time 
t3 = (0:dt:Time)';              %range of time axis  
x3 = cos(2*pi*f*t3);            %cosine signal 
 
Fs4 = 5 ;                       %sampling frequency Fs < 2*fc
dt = 1/Fs4;                     %seconds per sample 
Time = 1;                       %End time 
t4 = (0:dt:Time)';              %range of time axis  
x4 = cos(2*pi*f*t4);            %cosine signal 
  
subplot(2,2,1)                  %Plot Original Signal
plot (t1,x1)
xlabel('Time (sec)')
ylabel('Amplitude')
title('Original Signal of fc 5 Hz and Fs 5000 Hz')
 
subplot(2,2,2)                  %Plot Sampled Signal with Fs=2*fc
plot (t1,x1)
hold on
stem (t2,x2)
hold off
xlabel('Time (sec)')
ylabel('Amplitude')
title('Sampled Signal at Fs 10 Hz (Fs=2*fc)')
 
subplot(2,2,3)                  %Plot Sampled Signal with Fs>2*fc
plot (t1,x1)
hold on
stem (t3,x3)
hold off
xlabel('Time (sec)')
ylabel('Amplitude')
title('Sampled Signal at Fs 20 Hz (Fs>2*fc)')
 
subplot(2,2,4)                  %Plot Sampled Signal with Fs<2*fc
plot (t1,x1)
hold on
stem (t4,x4)
hold off
xlabel('Time (sec)')
ylabel('Amplitude')
title('Sampled Signal at Fs 5 Hz (Fs<2*fc)')
