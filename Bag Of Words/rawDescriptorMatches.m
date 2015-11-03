% this script allow allows a user to select a region of interest in one 
% frame and then match descriptors in that region to descriptors in the
% second image based on Euclidean distance in SIFT space

load('twoFrameData');

% get the region
[oninds] = selectRegion(im1, positions1);

% match feature
des = descriptors1(oninds,:);
ind = matchRawDescriptors(des,descriptors2);



% display the matched patch on second image;
po2 = positions2(ind,:);
or2 = orients2(ind,:);
sc2 = scales2(ind,:);
figure;
imshow(im2);
displaySIFTPatches(po2, sc2, or2, im2);

