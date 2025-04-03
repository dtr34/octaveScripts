function K = getKfromGT(freqC,GTdesired,options)

    itterations = 1:1000;
    if(options.filterType == "ButterWorthLP")
        for i = itterations
            K = i;
            GT = getGTw(freqC,options.HPorLPStopBandFrequency,K,options);
            if(GT < GTdesired)
                break;
            end
        end
    elseif(options.filterType == "ButterWorthHP")
        for i = itterations
            K = i;
            GT = getGTw(freqC,options.HPorLPStopBandFrequency,K,options);
            if(GT < GTdesired)
                break;
            end
        end
    elseif(options.filterType == "ButterWorthBP")
        for i = itterations
            K = i;
            GTLow = getGTw(freqC,options.BPorBSLowFrequency,K,options);
            GTHigh = getGTw(freqC,options.BPorBSHighFrequency,K,options);
            if((GTLow < GTdesired) && (GTHigh < GTdesired))
                break;
            end
        end
    elseif(options.filterType == "ButterWorthBS")
        for i = itterations
            K = i;
            GTLow = getGTw(freqC,options.BPorBSLowFrequency,K,options.filterType,"HalfPowerBandwidth",options.HalfPowerBandwidth);
            GTHigh = getGTw(freqC,options.BPorBSHighFrequency,K,options.filterType,"HalfPowerBandwidth",options.HalfPowerBandwidth);
            if((GTLow > GTdesired) && (GTHigh > GTdesired))
                break;
            end
        end
    end
end