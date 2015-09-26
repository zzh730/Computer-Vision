function verticalSeam = find_optimal_vertical_seam(x)
% find the min of every row
[rows cols]=size(x);
for i=rows:-1:1
    if i==rows
        [value, j]=min(x(rows,:));  %finds min value of last row
    else    %accounts for boundary issues
        if verticalSeam(i+1)==1
            Vector=[Inf x(i,verticalSeam(i+1)) x(i,verticalSeam(i+1)+1)];
        elseif verticalSeam(i+1)==cols
            Vector=[x(i,verticalSeam(i+1)-1) x(i,verticalSeam(i+1)) Inf];
        else
            Vector=[x(i,verticalSeam(i+1)-1) x(i,verticalSeam(i+1)) x(i,verticalSeam(i+1)+1)];
        end
        
        %find min value and index of 3 neighboring pixels in prev. row.
        [Value Index]=min(Vector);
        IndexIncrement=Index-2;
        j=verticalSeam(i+1)+IndexIncrement;
    end
    verticalSeam(i,1)=j;
end

end