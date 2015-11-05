% 1. Choose 3 different frames from the entire video dataset to serve as queries.
% 2. Display the M=5 most similar frames to each of these queries based on the 
% normalized scalar product between their bag of words histograms. 
% 3. Sort the similarity scores between a query histogram and the histograms
% associated with the rest of the images in the video. 
% 4. Pull up the images associated with the M most similar examples. 
clear;
clc;

% % please change these to your directory
addpath(genpath('../'));

framesdir = '../frames/';
siftdir = '../sift';

% struct to hold the name of Sample .mat file
sname = dir([siftdir '/*.mat']);
load('clust.mat');

% query id
query = [ 0 0 0 ];
while 1
    query = randperm(5714,3);
    if min(query) > 100
        break
    end
end

% make bows for every frame in framebase
bows = zeros(length(SampleDes), 1500);
for i = 1:length(SampleDes)
    bows(i,:) = computeBOWRepr(SampleDes(i,:), means);
end

load('bows.mat');

for i = query
    % change name format
    if i < 1000
        id = strcat('0',int2str(i));
    else
        id = int2str(i);
    end
    queryname = strcat('friends_000000',id,'.jpeg.mat');
    load(queryname);
    % create bow for query frame
    bow1 = computeBOWRepr(descriptors, means);
    % compare the query frame to framebase
    similarities = [];
    for j = 1:length(bows)
        similar = compareSimilarity(bow1',bows(j,:).*size(descriptors,1));
        similarities = [similarities; j similar];
    end
    % sort the similarities
    [aa bb] = sort(similarities(:,2));
    similarities = similarities(bb,:);
    % show the frame
    figure
    subplot(6,2,1);
    imshow(strcat('friends_000000',id,'.jpeg'));
    % show the most similar 5 frames
    for similarImg=1:5
        subplot(6, 2, 1 + similarImg);
        p = imgIdx(similarities(similarImg, 1));
        if p < 1000
            tempid = strcat('0',int2str(p));
        else
            tempid = int2str(p);
        end
        imshow(strcat('friends_000000',tempid,'.jpeg'));
    end
    
end
