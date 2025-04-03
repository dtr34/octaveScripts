function pk = getpk(K,k,options)

    if(options.filterType == "ButterWorthLP")
        frac = (((2*k -1 )*pi) / (2*K));
        pk = 2*sin(frac);
    elseif(options.filterType == "ButterWorthHP")
        frac = (((2*k -1 )*pi) / (2*K));
        pk = 1 / (2*sin(frac));
    elseif(options.filterType == "ChebyshevLP")
        if(options.ChebyshevRipple == "0.1 dB")
            if(K == 3)
                pk = [1.4328,1.5937,1.4328];
            elseif(K == 5)
                pk = [1.3013, 1.5559, 2.2411, 1.5559, 1.3013];
            elseif(K == 7)
                pk = [1.2615, 1.5196, 2.2392, 1.6804, 1.2392, 1.5196, 1.2615];
            else
                disp('K should be 3, 5, or 7 not whatever you put');
            end
        elseif(options.ChebyshevRipple == "0.5 dB")
            if(K == 3)
                pk = [1.8636, 1.2804, 1.8636];
            elseif(K == 5)
                pk = [1.8068, 1.3025, 2.6914, 1.3025, 1.8068];
            elseif(K == 7)
                pk = [1.7896, 1.2961, 2.7177, 1.3848, 2.7177, 1.2961, 1.7896];
            else
                disp('K should be 3, 5, or 7 not whatever you put');
            end
        end
    elseif(options.filterType == "ChebyshevHP")
        if(options.ChebyshevRipple == "0.1 dB")
            if(K == 3)
                pk = [(1/1.4328), (1/1.5937), (1/1.4328)];
            elseif(K == 5)
                pk = [(1/1.3013), (1/1.5559), (1/2.2411), (1/1.5559), (1/1.3013)];
            elseif(K == 7)
                pk = [(1/1.2615), (1/1.5196), (1/2.2392), (1/1.6804), (1/1.2392), (1/1.5196), (1/1.2615)];
            else
                disp('K should be 3, 5, or 7 not whatever you put');
            end
        elseif(options.ChebyshevRipple == "0.5 dB")
            if(K == 3)
                pk = [(1/1.8636), (1/1.2804), (1/1.8636)];
            elseif(K == 5)
                pk = [(1/1.8068), (1/1.3025), (1/2.6914), (1/1.3025), (1/1.8068)];
            elseif(K == 7)
                pk = [(1/1.7896), (1/1.2961), (1/2.7177), (1/1.3848), (1/2.7177), (1/1.2961), (1/1.7896)];
            else
                disp('K should be 3, 5, or 7 not whatever you put');
            end
        end
    end
end