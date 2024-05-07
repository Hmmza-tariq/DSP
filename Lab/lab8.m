lpf = fdesign.lowpass('Fp,Fst,Ap,Ast',0.2,0.3,1,60);
lpf_design = design(lpf,'butter');

fvtool(lpf_design); 

hpf = fdesign.highpass('Fst,Fp,Ast,Ap',0.2,0.3,60,1);
hpf_design = design(hpf,'butter');

fvtool(hpf_design); 


[y, fs] = audioread('Assets\audio.mp3'); 

y_lpf = filter(lpf_design, y); 
y_hpf = filter(hpf_design, y); 

t = (0:length(y)-1)/fs;
figure;
subplot(3,1,1);
plot(t, y);
title('Original Signal');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,1,2);
plot(t, y_lpf);
title('Lowpass Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(3,1,3);
plot(t, y_hpf);
title('Highpass Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');
