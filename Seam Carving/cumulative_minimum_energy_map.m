function M = cumulative_minimum_energy_map(energyImage,seamDirection)

[a b] = size(energyImage);
M = zeros(a+2,b+2);
M(1,:) = M(1,:) + 256;
M(:,1) = M(:,1) + 256;
M(a+2,:) = M(a+2,:) + 256;
M(:,b+2) = M(:,b+2) + 256;
if strcmp(seamDirection, 'HORIZONTAL') == 1
    M(:,1) = zeros(a+2,1);
    for i = 1:a
        for j = 1:b
            M(i+1,j+1) = energyImage(i,j) + min([M(i,j) M(i+1,j) M(i+2,j)]);
        end
    end
else
    M(1,:) = zeros(1,b+2);
    for i = 1:a
        for j = 1:b
            M(i+1,j+1) = energyImage(i,j) + min([M(i,j) M(i,j+1) M(i,j+2)]);
        end
    end
end 
M = M([2:a+1],[2:b+1]);

end