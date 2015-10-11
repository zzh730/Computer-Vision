function [outputim, meanColors, clusterIds] = quantizeRGB(origim, k)

% distribute the pixel to rgb vector
[a b c] = size(origim);
X = reshape(origim, a*b, 3);

% kmeans cluster for k clusters
[clusterIds,meanColors]=kmeans(double(X),k);

% choose the closest center to each pixel,
clusterIdsK=pdist2(X,meanColors); 

% make double to integer
[~,indMin]=min(clusterIdsK,[],2);  
XNewQ=meanColors(indMin,:);

% arrange the pixel back to rgb image
outputim=origim;
outputim(:,:,1)=reshape(XNewQ(:,1),size(origim(:,:,1))); 
outputim(:,:,2)=reshape(XNewQ(:,2),size(origim(:,:,1)));
outputim(:,:,3)=reshape(XNewQ(:,3),size(origim(:,:,1)));

outputim = uint8(outputim);
figure;
subplot_tight(1,2,1);
imshow(origim,[]);
title('Original Image');
subplot_tight(1,2,2);
imshow(outputim,[]);
title(['Clustered Image with ',int2str(k),' clusters']);
end