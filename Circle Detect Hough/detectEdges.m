function [edges] = detectEdges(im, threshold)% convert the image to gray scale
% covert im to grayscale
im = rgb2gray(im);

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
[m n] = size(im);
edges = zeros(m,n);
edges(:,1) = x;
edges(:,2) = y;
edges(:,3) = mag(find(mag>0));
edges(:,4) = sub2ind(size(ang),x,y);
end
