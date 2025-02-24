function [Xpar1,Xser1,Xpar2,Xser2] = twoComponentLMatchParallel(Xs,Rs,RL)
  if (RL > Rs) % this is unchecked
    disp("no solutions")
    return;
  endif
  Zs = Xs * j + Rs
  local = poles((RL-Rs)s**2 + (2*Xs*RL)*s**2 + RL*abs(Zs)**2 == 0)
  Xpar1 = local[1]
  Xpar2 = local[2]
  
  Xser = -Im((j*Xpar1*(Zs))/(j*Xpar+Zs))
  end