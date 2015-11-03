function [inds] = matchRawDescriptors(d1, d2)
    % compute the nearest raw SIFT descriptors
    % from d1 to d2 
    n = dist2(d1,d2);
    [v inds] = min(n,[],2);
    inds = unique(inds);
end