function [bow] = computeBOWRepr(descriptors, means)
    % Map a raw SIFT descriptor to its visual word. The raw descriptor 
    % is assigned to the nearest visual word. bow is a normalized bag-of
    % -words histogram. descriptors is the Mx128 set of descriptors for 
    % the image or image region, and means is the kx128 set of cluster means.
    
    n = dist2(descriptors, means');
    [v inds] = min(n,[],2);
    bow = histc(inds, 1:length(means));
end