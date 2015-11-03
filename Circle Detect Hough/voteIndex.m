function [ ret ] = voteIndex( x )
% In order to have different bin size of vote space, this function input a 
% num x indicates the x'th row or x'th column position in image, return the
% index for which vote bin x should belong to.

% The BIN_SIZE in voteIndex.m must equal BIN_SIZE in indexToPosition.m

    BIN_SIZE = 5;
    
    ret = floor(x / BIN_SIZE) + 1;
end

