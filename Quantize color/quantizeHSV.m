function [outputImg, meanHues, clusterIds] = quantizeHSV(origImg, k)

new = rgb2hsv(origImg);

hue=reshape(new(:,:,1),[],1);
[clusterIds,meanHues]=kmeans(double(hue),k);
clusterIdsK=pdist2(hue,meanHues);


% make double to integer
[~,indMin]=min(clusterIdsK,[],2);  
XNewQ=meanHues(indMin,:);

% arrange the pixel back to rgb image
outputImg=new;
outputImg(:,:,1)=reshape(XNewQ(:,1),size(origImg(:,:,1)));
outputImg = uint8(hsv2rgb(outputImg) * 255);


figure;
% title('Quantized image in HSV');
subplot_tight(1,2,1);
imshow(origImg,[]);
title('Original Image');
subplot_tight(1,2,2);
imshow(outputImg,[]);
title(['Clustered Image with ',int2str(k),' clusters']);
% text(0,0,'\bf Quantized image in HSV','HorizontalAlignment','center','VerticalAlignment', 'top');
end
