function components = getFilterComponents(freqC,K,Zin,options)


%% BUTTERWORTH FILTERS

%% BUTTERWORTH LOW PASS
    if(options.filterType == "ButterWorthLP")
        wc = 2*pi*freqC;
        components = zeros(1,K);
        disp('This ButterWorth Low Pass Filter consists of the following components in order:')
        for i = 1:K
            pk = getpk(K,i,options);
            pk = pk / wc;
            if(~isEven(i))
                components(i) = pk / Zin;
                fprintf('%0.5g: Parallel Capacitor (%0.5g F)\n',i,components(i));
            else
                components(i) = pk*Zin;
                fprintf('%0.5g: Series Inductor (%0.5g H)\n',i,components(i));
            end
        end

%% BUTTERWORTH HIGH PASS
    elseif(options.filterType == "ButterWorthHP")
        wc = 2*pi*freqC;
        components = zeros(1,K);
        disp('This ButterWorth High Pass Filter consists of the following components in order:')
        for i = 1:K
            pk = getpk(K,i,options);
            pk = pk / wc;
            if(~isEven(i))
                components(i) = pk*Zin;
                fprintf('%0.5g: Parallel Inductor (%0.5g H)\n',i,components(i));
            else
                components(i) = pk / Zin;
                fprintf('%0.5g: Series Capacitor (%0.5g H)\n',i,components(i));
            end
        end

%% BUTTERWORTH BAND PASS
    elseif(options.filterType == "ButterWorthBP")
        wcBP = 2*pi*options.HalfPowerBandwidth;
        wc = 2*pi*freqC;
        components = zeros(2,K);
        disp('This ButterWorth Band Pass Filter consists of the following components in order:')
        for i = 1:K
            pk = getpk(K,i,options);
            pk = pk / wcBP;
            if(~isEven(i))
                pk = pk / Zin;
                L = 1 / ((wc.^2)*pk);
                components(1,i) = pk;
                components(2,i) = L;
                fprintf('%0.5g: Parallel Combo of Inductor(%0.5g) and Capacitor(%0.5g) in Parallel\n',i,components(2,i),components(1,i));
            else
                pk = pk*Zin;
                C = 1 / ((wc.^2)*pk);
                components(1,i) = pk;
                components(2,i) = C;
                fprintf('%0.5g: Series Combo of Inductor(%0.5g) and Capacitor(%0.5g) in Series\n',i,components(1,i),components(2,i));
            end
        end

%% BUTTERWORTH BAND STOP
    elseif(options.filterType == "ButterWorthBS")
        wcBS = 2*pi*options.HalfPowerBandwidth;
        wc = 2*pi*freqC;
        components = zeros(2,K);
        disp('This ButterWorth Band Stop Filter consists of the following components in order:')
        for i = 1:K
            pk = getpk(K,i,"filterType","ButterWorthHP");
            pk = pk / wcBS;
            if(~isEven(i))
                pk = pk*Zin;
                C = 1 / ((wc.^2)*pk);
                components(1,i) = pk;
                components(2,i) = C;
                fprintf('%0.5g: Series Combo of Inductor(%0.5g) and Capacitor(%0.5g) in Parallel\n',i,components(1,i),components(2,i));
            else
                pk = pk / Zin;
                L = 1 / ((wc.^2)*pk);
                components(1,i) = pk;
                components(2,i) = L;
                fprintf('%0.5g: Parallel Combo of Inductor(%0.5g) and Capacitor(%0.5g) in Series\n',i,components(2,i),components(1,i));
            end
        end


%% CHEBYSHEV FILTERS

%% CHEBYSHEV LOW PASS
    elseif(options.filterType == "ChebyshevLP")
        wc = 2*pi*freqC;
        components = zeros(1,K);
        disp('This Chebyshev Low Pass Filter consists of the following components in order:')
        for i = 1:K
            pk = getpk(K,i,"filterType",options.filterType,"ChebyshevRipple",options.ChebyshevRipple);
            pk(i) = pk(i) / wc;
            if(~isEven(i))
                components(i) = pk(i) / Zin;
                fprintf('%0.5g: Parallel Capacitor (%0.5g F)\n',i,components(i));
            else
                components(i) = pk(i)*Zin;
                fprintf('%0.5g: Series Inductor (%0.5g H)\n',i,components(i));
            end
        end

%% CHEBYSHEV HIGH PASS
    elseif(options.filterType == "ChebyshevHP")
        wc = 2*pi*freqC;
        components = zeros(1,K);
        disp('This Chebyshev High Pass Filter consists of the following components in order:')
        for i = 1:K
            pk = getpk(K,i,"filterType",options.filterType,"ChebyshevRipple",options.ChebyshevRipple);
            pk(i) = pk(i) / wc;
            if(~isEven(i))
                components(i) = pk(i)*Zin;
                fprintf('%0.5g: Parallel Inductor (%0.5g H)\n',i,components(i));
            else
                components(i) = pk(i) / Zin;
                fprintf('%0.5g: Series Capacitor (%0.5g H)\n',i,components(i));
            end
        end

%% CHEBYSHEV BAND PASS
    elseif(options.filterType == "ChebyshevBP")
        wcBP = 2*pi*options.HalfPowerBandwidth;
        wc = 2*pi*freqC;
        components = zeros(2,K);
        disp('This Chebyshev Band Pass Filter consists of the following components in order:')
        for i = 1:K
            pk = getpk(K,i,"filterType","ChebyshevLP","ChebyshevRipple",options.ChebyshevRipple);
            pk(i) = pk(i) / wcBP;
            if(~isEven(i))
                pk(i) = pk(i) / Zin;
                L = 1 / ((wc.^2)*pk(i));
                components(1,i) = pk(i);
                components(2,i) = L;
                fprintf('%0.5g: Parallel Combo of Inductor(%0.5g) and Capacitor(%0.5g) in Parallel\n',i,components(2,i),components(1,i));
            else
                pk(i) = pk(i)*Zin;
                C = 1 / ((wc.^2)*pk(i));
                components(1,i) = pk(i);
                components(2,i) = C;
                fprintf('%0.5g: Series Combo of Inductor(%0.5g) and Capacitor(%0.5g) in Series\n',i,components(1,i),components(2,i));
            end
        end

%% CHEBYSHEV BAND STOP
    elseif(options.filterType == "ChebyshevBS")
        wcBS = 2*pi*options.HalfPowerBandwidth;
        wc = 2*pi*freqC;
        components = zeros(2,K);
        disp('This Chebyshev Band Stop Filter consists of the following components in order:')
        for i = 1:K
            pk = getpk(K,i,"filterType","ChebyshevHP","ChebyshevRipple",options.ChebyshevRipple);
            pk(i) = pk(i) / wcBS;
            if(~isEven(i))
                pk(i) = pk(i)*Zin;
                C = 1 / ((wc.^2)*pk(i));
                components(1,i) = pk(i);
                components(2,i) = C;
                fprintf('%0.5g: Series Combo of Inductor(%0.5g) and Capacitor(%0.5g) in Parallel\n',i,components(1,i),components(2,i));
            else
                pk(i) = pk(i) / Zin;
                L = 1 / ((wc.^2)*pk(i));
                components(1,i) = pk(i);
                components(2,i) = L;
                fprintf('%0.5g: Parallel Combo of Inductor(%0.5g) and Capacitor(%0.5g) in Series\n',i,components(2,i),components(1,i));
            end
        end
    end
end
