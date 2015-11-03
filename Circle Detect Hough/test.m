im=imread('egg.jpg');

im = rgb2gray(im);
intensity = double(im);
% blur the image
h = fspecial('gaussian');
im = imfilter(im,h);
% covert im to grayscale

dx = [-1 0 1; -1 0 1; -1 0 1];
dy = dx';

% derivatives of the image
Gx = conv2(im, dx, 'same');
Gy = conv2(im, dy, 'same');

mag = sqrt(Gx.^2+Gy.^2);
ang = atan(Gy/Gx);

threshold = mean(mag(:));


% set threshold
if (nargin == 1)
    threshold = mean(mag(:),1)*2;
end

% non-maxima suppression
temp = mag > threshold;
output = imdilate(temp, [1 1 1; 1 0 1; 1 1 1]);
output = imerode(output, [1 1 1; 1 0 1; 1 1 1]);

% find the coordinates
in = output < 1;
mag(in) = 0;
[m n] = size(mag);
mag(1,:)=0;mag(m,:)=0;mag(:,1)=0;mag(:,n)=0;
ang(in) = 0;
[m n] = size(ang);
ang(1,:)=0;ang(m,:)=0;ang(:,1)=0;ang(:,n)=0;

[y x z] = find(mag > 0);


%return the results;
[m n] = size(x);

edges = zeros(m,4);
edges(:,1) = x;
edges(:,2) = y;
edges(:,3) = mag(find(mag>0));
edges(:,4) = sub2ind(size(ang),x,y);

intensity = double(im);
imEdge = edge(intensity);
radius = 8;
   
%TODO detect gradient
xGradient = imfilter(intensity, [-1, 1] );
yGradient = imfilter(intensity, [-1, 1]');
gradientDire = atan2(yGradient, xGradient);
%    
% ANGLE_ITERATION = 4 + 4 * radius;
% THETA_MIN = 2 * pi / ANGLE_ITERATION;
% 
[row, col] = size(im);
fixRadiusVotes = zeros(voteIndex(row), voteIndex(col));
    

[searchRows, searchCols] = find(imEdge == 1);
for s = 1:length(searchRows)
    r = searchRows(s);
    c = searchCols(s);
    for i = 1:2
        theta = (-1)^i * gradientDire(r, c);
        a = round(c - radius * cos(theta)); 
        b = round(r + radius * sin(theta));

        if a >= 1 && a <= col && b >= 1 && b <= row
            fixRadiusVotes(voteIndex(b), voteIndex(a)) = fixRadiusVotes(voteIndex(b), voteIndex(a)) + 1; 
        end 
    end
end
 
    
Hnorm = (fixRadiusVotes ./ max(max(fixRadiusVotes)));
[mx,my] = find(Hnorm > .5);
BIN_SIZE = 5;
mx = (mx - 1).* BIN_SIZE + round(BIN_SIZE / 2);
my = (my - 1).* BIN_SIZE + round(BIN_SIZE / 2);
top_k = 5;
mx = mx(1:top_k);
my = my(1:top_k);
centers = horzcat(my,mx);
figure; 
imshow(im); 
viscircles(centers, radius * ones(size(centers, 1), 1));

