clear
clc
% Choose query img
queryImg = 128;
% Make bag of words
load('data.mat')
% Assemble histograms (same as in FullFrameQueries)
nrImages = size(imgs, 3);
histograms = assembleHistograms(assignments, centers, img_idxs, nrImages);

% select region, compute bag of words of region
positions = all_positions(img_idxs == queryImg,:);
figure('name', 'Select an interesting region!');
selected = selectRegion(imgs(:,:,queryImg)/255, positions);
%fprintf('Number of descriptors in region: %d \n', length(selected));
assignments_img = assignments(img_idxs == queryImg,:);
assignments_region = assignments_img(selected,:);
hist = histc(assignments_region, 1:length(centers));

% term frequency - inverse document frequency
hist_all = histc(assignments, 1:length(centers));
weighted_hist = hist.*log(sum(hist_all)./hist_all); %/sum(hist); % would normalize

% show histograms, mainly for debugging
% top: unweighted region
% middle: of all images
% bottom: weighted region
% figure
% subplot(3,1, 1);
% bar(hist); xlim([1 1500]);
% subplot(3,1, 2);
% bar(hist_all); xlim([1 1500]);
% subplot(3,1, 3);
% bar(weighted_hist); xlim([1 1500]);          

% find images that match weighted hist closest
similarities = computeSimilarities(histograms, weighted_hist', nrImages);

% Show 3 images with closest histograms
subplot = @(m,n,p) subtightplot (m, n, p, [0.01 0.05], [0.1 0.01], [0.1 0.01]);
figure
subplot(2,3, 2);
imshow(imgs(:,:,queryImg), [0 255], 'border', 'tight');
hold on;
% scatter(positions(1,selected), positions(2,selected), 'r.');
for similarImg=1:3
    subplot(2, 3, 3 + similarImg);
    imshow(imgs(:,:,similarities(similarImg+4, 2)), [0 255], 'border', 'tight');
end
hold off;
figure;
subplot(4,1, 1);
h = histograms(:,queryImg)';
bar(h); xlim([1 1500]);
subplot(4,1, 2);
h1 = histograms(:,similarities(5, 2));
bar(h1); xlim([1 1500]);
subplot(4,1, 3);
h2 = histograms(:,similarities(6, 2));
bar(h2); xlim([1 1500]);  
subplot(4,1, 4);
h3 = histograms(:,similarities(7, 2));
bar(h3); xlim([1 1500]);  