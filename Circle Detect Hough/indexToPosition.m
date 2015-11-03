function [ ret ] = indexToPosition( x )
% In order to have different bin size of vote space, this function input a 
% num x indicates the index for which vote bin x.  
% @return 
%    the ret'th row or ret'th column position in image, indicates the
%    center of circle

% The BIN_SIZE in voteIndex.m must equal BIN_SIZE in indexToPosition.m

    BIN_SIZE = 1;
    
    ret = (x - 1)* BIN_SIZE + round(BIN_SIZE / 2);
end

