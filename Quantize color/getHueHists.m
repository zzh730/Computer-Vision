function [histEqual, histClustered] = getHueHists(im, k)
% call quantizeHSV to compute clusted image
[outputImg, meanHues, clusterIds] = quantizeHSV(im, k);

% convert two image to hsv space
orihsv = rgb2hsv(im);
outputhsv = rgb2hsv(outputImg);

% draw the histogram of two images
figure;
subplot(1,2,1);
hist(orihsv(:,:,1),k);
title('equal space bins');
histEqual = hist(orihsv(:,:,1),k);
subplot(1,2,2);
hist(outputhsv(:,:,1),k);
title([int2str(k),' clusters bins']);
histClustered = hist(outputhsv(:,:,1),k);
end