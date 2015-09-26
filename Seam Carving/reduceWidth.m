function [reducedColorImage,reducedEnergyImage] = reduceWidth(im, energyImage)
M = cumulative_minimum_energy_map(energyImage,'VERTICAL');
seam = find_optimal_vertical_seam(M);
[a b] = size(energyImage);
% reduce one pixel of energyimage
for i = 1:a
    energyImage(i,seam(i):b-1) = energyImage(i,seam(i)+1:b);
end
reducedEnergyImage = energyImage(:,1:b-1);
% reduce one pixel of im
for i = 1:a
    im(i,seam(i):b-1,:) = im(i,seam(i)+1:b,:);
end
reducedColorImage = im(:,1:b-1,:);
end
        