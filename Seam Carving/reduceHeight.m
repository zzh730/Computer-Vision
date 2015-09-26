function [reducedColorImage,reducedEnergyImage] = reduceHeight(im, energyImage)

M = cumulative_minimum_energy_map(transpose(energyImage),'VERTICAL');
seam = find_optimal_vertical_seam(M);

[a b] = size(energyImage);
% reduce one pixel of energyimage
for i = 1:b
    energyImage(seam(i):a-1,i) = energyImage(seam(i)+1:a,i);
end
reducedEnergyImage = energyImage(1:a-1,:);
% reduce one pixel of im
for i = 1:b
    im(seam(i):a-1,i,:) = im(seam(i)+1:a,i,:);
end
reducedColorImage = im(1:a-1,:,:);
end
        