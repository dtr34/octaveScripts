function Z = RouthHurwitz(coeffVector)
syms epss;
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
end
%Check the first collumn for 0s


if routhTable(1,1) == 0
    fprintf("\n Zero in the first Collumn Occurred\n")
    routhTable(1,1) = epss;
end
if routhTable(2,1) == 0
    fprintf("\n Zero in the first Collumn Occurred\n")
    routhTable(2,1) = epss;
end




%% Calculate Routh-Hurwitz table's rows

%  Calculate other elements of the table
% i = current row
% j = current collumn
for i = 3:tableLength
  
   
   %"Special Case: Row of all zeros
    if routhTable(i-1,:) == 0
      fprintf("\n Row of Zeros occurred\n")
      fprintf("\n Routh Table so Far\n")
      disp(routhTable)
      return
    end

    %Special Case: Zero in first collumn
    if routhTable(i-1,1)==0
        fprintf("\nZero in first collumn occurred\n")
        routhTable(i-1,1) = epss;
    end
        
    
    
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
    end

end

fprintf("\n Final Routh Table \n")
disp(routhTable)

Z = routhTable;

end


