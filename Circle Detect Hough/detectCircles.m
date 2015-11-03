function [centers] = detectCircles(im, edges, radius, top_k)
% detect gradient direction
xGradient = imfilter(intensity, [-1, 1] );
yGradient = imfilter(intensity, [-1, 1]');
gradientDire = atan2(yGradient, xGradient);

% initial the Accelerator matrix
intensity = double(im);
imEdge = edge(intensity);
[row, col] = size(imEdge);
Accelerate = zeros(voteIndex(row), voteIndex(col));

[searchRows, searchCols] = find(im == 1);
% hough transformation
for s = 1:length(searchRows)
    r = searchRows(s);
    c = searchCols(s);
    for i = 1:2
        theta = (-1)^i * gradientDire(r, c);
        a = round(c - radius * cos(theta)); 
        b = round(r + radius * sin(theta));
        if a >= 1 && a <= col && b >= 1 && b <= row
            Accelerate(voteIndex(b), voteIndex(a)) = Accelerate(voteIndex(b), voteIndex(a)) + 1; 
        end 
    end
end
 
% normalization
Hnorm = (Accelerate ./ max(max(Accelerate)));
[mx,my] = find(Hnorm > .7);

% change the scale back
BIN_SIZE = 5;
mx = (mx - 1).* BIN_SIZE + round(BIN_SIZE / 2);
my = (my - 1).* BIN_SIZE + round(BIN_SIZE / 2);

% keep top_k points
if (nargin==3)
    top_k = 1;
end
if top_k < size(mx,1);
    mx = mx(1:top_k);
    my = my(1:top_k);
end
centers = horzcat(my,mx);

% show the centers
figure; 
imshow(im); 
viscircles(centers, radius * ones(size(centers, 1), 1));


end