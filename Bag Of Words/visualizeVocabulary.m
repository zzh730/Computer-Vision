% This script load some SIFT descriptors and compute k-means clustering using 
% those descriptors. Sample 300 frames and at most 100 features per frame.
% For clustering, it use provided script kmeansML.m with k=1500 to cluster
% the descriptors. 
% Two distinct words choosen to show image patches(at least 25 patches).

% % please change these to your directory
addpath(genpath('../'));

framesdir = '../frames/';
siftdir = '../sift';

% struct to hold the name of Sample .mat file
fname = dir([siftdir '/*.mat']);

% % initialize
SampleDes = []; SamplePos = [];
SampleScal = []; SampleOri = [];
imgIdx = []; pathIndex = [];

% generate sample list
namelist = 101:5614;
index = randperm(numel(namelist), 330);
samplist = namelist(index);

for k = 1:300
    i = samplist(k);
    load(fname(i).name, 'imname', 'descriptors', 'positions', 'scales', 'orients'); 
    if size(descriptors,1) < 100
        continue
    end
    featind = [1:min(100,size(descriptors,1))];

    % store row-wise
    imname = [framesdir imname];
    numFeat = size(descriptors,1);
    SampleDes = [SampleDes; descriptors];
    SamplePos = [SamplePos; positions];    
    SampleScal = [SampleScal; scales];    
    SampleOri = [SampleOri; orients];

    % map image ID to amount of descriptors
    desMap = repmat(i, [1 length(descriptors)]);  
    %store column-wise
    imgIdx = [imgIdx, desMap];
    % map gray image with image id
    imgAcc(:,:,i) = single(rgb2gray(imread(imname)));
    % map image path with its numfeature with the images path name for path search
    pathFeats = repmat({imname}, numFeat, 1);
    % store row-wise image path feature look-up
    pathIndex = [pathIndex; pathFeats];
end

k = 1500;

[membership, means] = kmeansML(k, SampleDes');

% create two distinctive sample
while 1
    sampleIdx = randperm(k,2);
    if sumsqr(dist2(means(:,sampleIdx(1)),means(:,sampleIdx(2))))>5
        break
    end
end

for h = sampleIdx
    figure;
    foundFeatureIdxs = find(membership == h);
    len = length(foundFeatureIdxs);

    % display 25 patches
    for k=1:25

        featureIdx = foundFeatureIdxs(k);
 		
 		% get path of the feature index
        imPath = pathIndex{featureIdx,:};

        % get the gray image
        img = imread(imPath);
        grayImg = rgb2gray(img);
        
        % find patch
        patch = getPatchFromSIFTParameters(SamplePos(featureIdx,:), ...
                    SampleScal(featureIdx), SampleOri(featureIdx), grayImg);
        subplot(5,5,k)
        imshow(patch);

    end
    
end

% save all to file
save('membership','means','sampleIdx');