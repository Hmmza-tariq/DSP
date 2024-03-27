% task 1
% x = [1, 2, 3];
% h = [4, 5, 6];
% y = manualConvolution(x, h);
% y1 = conv(x, h);
% disp(y1);
% disp(y);

% task 2
% x = [1, 2, 3];
% h = [4, 5, 6];
% y1 = conv(x, h);
% disp(y1);

% task 3

% t = linspace(0, 0.1, 100);  
% signal = sin(t) + 0.5 * randn(size(t));  
% window_size = 10;  
% filtered_signal = zeros(size(signal)); 
% for i = 1:length(signal)
 
%     start_index = max(1, i - floor(window_size / 2));
%     end_index = min(length(signal), i + floor(window_size / 2));
    
%     filtered_signal(i) = mean(signal(start_index:end_index));
% end
% figure;
% plot(t, signal, 'b', 'LineWidth', 1.5); hold on;
% plot(t, filtered_signal, 'r', 'LineWidth', 1.5);
% legend('Original Signal', 'Filtered Signal');
% xlabel('Time');
% ylabel('Amplitude');
% title('Moving Average Filter Applied to Noisy Signal');

% task 4
t = linspace(0, 0.1, 100);  
signal = sin(t) + 0.5 * randn(size(t));  
window_size = 10;  % Size of the moving average window
kernel = ones(1, window_size) / window_size;
filtered_signal = conv(signal, kernel, 'same');
figure;
plot(t, signal, 'b', 'LineWidth', 1.5); hold on;
plot(t, filtered_signal, 'r', 'LineWidth', 1.5);
legend('Original Signal', 'Filtered Signal');
xlabel('Time');
ylabel('Amplitude');
title('Moving Average Filter Applied to Noisy Signal using Convolution');

