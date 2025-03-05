function M = twoComponentLMatch(Xs,Rs,RL)
  printf("\n series match \n")
  twoComponentLMatchSeries(Xs,Rs,RL)
  printf("\n parallel match \n")
  twoComponentLMatchParallel(Xs,Rs,RL)
  
  endfunction