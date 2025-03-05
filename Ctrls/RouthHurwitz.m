function Z = RouthHurwitz(coeffVector)

tableLength = length(coeffVector);
numColumns = round(tableLength/2);
%init table
routhTable = sym(zeros(tableLength,numColumns));
%compute first row
routhTable(1,:) = coeffVector(1,1:2:tableLength);
%  Check if length of coefficients vector is even or odd
if (rem(tableLength,2) ~= 0)
    % if odd, second row of table will be
    routhTable(2,1:numColumns - 1) = coeffVector(1,2:2:tableLength);
else
    % if even, second row of table will be
    routhTable(2,:) = coeffVector(1,2:2:tableLength);
endif
%  Set epss as a small value
epss = 0.01;

%Check the first collumn for 0s


if routhTable(1,1) == 0 || routhTable(2,1) == 0
    fprintf("\n Zero in the first Collumn\n")
    fprintf("\n Routh Table so Far\n")
    routhTable
    return;
    endif


%% Calculate Routh-Hurwitz table's rows

%  Calculate other elements of the table
% i = current row
% j = current collumn
for i = 3:tableLength
  
  
   %"Special Case: Row of all zeros
    if routhTable(i-1,:) == 0
      fprintf("\n Row of Zeros occurred\n")
      fprintf("\n Routh Table so Far\n")
      routhTable
      return
    endif
    
    
    for j = 1:numColumns - 1

        
        %  first element of upper row
        %if (j + 1 > numColumns
        leftTop = routhTable(i-2,1);
        leftBottom = routhTable(i-1,1);
        rightTop  = routhTable(i-2, j+1);
        rightBottom = routhTable(i-1,j+1);
        
        
        
        %  compute each element of the table
        currentDetMat = [leftTop,rightTop; leftBottom, rightBottom];
        
        routhTable(i,j) = -1 * det(currentDetMat) / leftBottom;
    endfor

endfor

fprintf("\n Final Routh Table \n")
routhTable

Z = routhTable;

endfunction


