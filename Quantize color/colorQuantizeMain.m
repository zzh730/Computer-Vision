% load the image
origim = imread('fish.jpg');

for k = [6  4 2];
% quantize rgb to k cluster
[outputim, meanColors, clusterRGBIds] = quantizeRGB(origim, k);

% quantize hsv hue value to k cluster
[outputImg, meanHues, clusterHSVIds] = quantizeHSV(origim, k);

% ssd of two cluster images
error = computeQuantizationError(outputim, outputImg);

% histogram of two image
[histRGBEqual, histRGBClustered] = getHueHists(origim, k);

end