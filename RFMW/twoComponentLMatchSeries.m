function reactances = twoComponentLMatchSeries(Xs,Rs,RL)
  if (RL < Rs)
    disp("no solutions")
    return;
  endif
  Xpar1 = sqrt((RL**2*Rs)/(RL-Rs))
  Xser1 = -Xs - imag((j*Xpar1*RL)/(j*Xpar1 +RL))
  Xpar2 = -sqrt((RL**2*Rs)/(RL-Rs))
  Xser2 = -Xs - imag((j*Xpar2*RL)/(j*Xpar2 +RL))
  reactances = struct(...
        'Xpar1', Xpar1, ...
        'Xser1', Xser1, ...
        'Xpar2', Xpar2, ...
        'Xser2', Xser2);
  
  endfunction