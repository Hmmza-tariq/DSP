% Low Pass Filter
function [h, a, b] = low_pass_filter(Fs, x)
Rp1 = 0.5;
Rs1 = 30;
Fp1 = 0.1e2 / (Fs / 2);
Fs1 = 0.5e2 / (Fs / 2);
n1 = cheb1ord(Fp1, Fs1, Rp1, Rs1);
[a, b] = cheby1(n1, Rp1, Fp1, 'low');
h = filter(a, b, x);