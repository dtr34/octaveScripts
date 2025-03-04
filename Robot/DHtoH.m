function H = DHtoH(rot, twist, disp, offs)
  row1 = [cos(rot), -sin(rot)*cos(twist), sin(rot)*sin(twist), offs*cos(rot)];
  row2 = [sin(rot), cos(rot)*cos(twist), -cos(rot)*sin(twist), offs*sin(rot)];
  row3 = [0, sin(twist), cos(twist), disp];
  row4 = [0, 0, 0, 1];
  H = [row1;row2;row3; row4];
 
 end