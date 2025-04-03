function GT = getGTw(freqC, freqDesired, K, options)

    wc = 2*pi*freqC;
    w = 2*pi*freqDesired;
    if(options.filterType == "ButterWorthLP")
        denom = 1 + ((w/wc).^(2*K));
        GT = 1 / denom;
    elseif(options.filterType == "ButterWorthHP")
        denom = 1 + ((wc/w).^(2*K));
        GT = 1 / denom;
    elseif(options.filterType == "ButterWorthBP")
        x = abs(w - wc);
        fraction = ((2*x) / (2*pi*options.HalfPowerBandwidth)).^(2*K);
        denom = 1 + fraction;
        GT = 1 / denom;
    elseif(options.filterType == "ButterWorthBS")
        x = abs(w - wc);
        fraction = ((2*pi*options.HalfPowerBandwidth) / (2*x)).^(2*K);
        denom = 1 + fraction;
        GT = 1 / denom;
    end
end