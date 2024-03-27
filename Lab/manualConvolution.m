 function y = manualConvolution(x, h)
    y = zeros(1, length(x) + length(h) - 1);
    
    for n = 1:length(y)
        for k = 1:length(x)
            if n-k+1 > 0 && n-k+1 <= length(h)
                y(n) = y(n) + x(k) * h(n-k+1);
            end
        end
    end
end
