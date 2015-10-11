image = imread('b.png');
im = rgb2gray(im2double(image));
dx = [-1 0 1; -1 0 1; -1 0 1];
dy = dx';

% derivatives of the image
Gx = conv2(im, dx, 'same');
Gy = conv2(im, dy, 'same');
[numOfRows numOfColumns] = size(im);

% set the windows function
sigma = 1;
w = fspecial('gaussian', fix(6*sigma),sigma);

% second derivatives of the image
Ixx = conv2(Gx.^2, w, 'same');
Iyy = conv2(Gy.^2, w, 'same');
Ixy = conv2(Gx.*Gy, w, 'same');

% compute the response of harris detector
Threshold = 1;
k = 0.04;
r = 6;
R11 = (Ixx.*Iyy - Ixy.^2) - k*(Ixx + Iyy).^2;
% R11=(1000/max(max(R11)))*R11;

% find the local optima of the harris detector response.
R=R11;
ma=max(max(R));
sze = 2*r+1; 
MX = ordfilt2(R,sze^2,ones(sze));
R11 = (R==MX)&(R>Threshold);
cout=sum(sum(R11(5:size(R11,1)-5,5:size(R11,2)-5)));
c_min=10; 
c_max=100; 
loop=0; 
while ((cout<c_min)|(cout>c_max))&(loop<=30) 
    if cout<c_min 
        Threshold=Threshold*0.5; 
    elseif cout>c_max 
        Threshold=Threshold*1.5; 
    end 
 
    R11 = (R==MX)&(R>Threshold); 
    cout=sum(sum(R11(5:size(R11,1)-5,5:size(R11,2)-5)));
    loop=loop+1;
end
R(5:size(R11,1)-5,5:size(R11,2)-5)=R11(5:size(R11,1)-5,5:size(R11,2)-5);
% Compute nonmax suppression
output = R11 > imdilate(R11, [1 1 1; 1 0 1; 1 1 1]);
[y x] = find(output);

scores = zeros(size(y));
for i = 1:size(y)
    scores(i) = R(y(i),x(i));
end

figure;
imshow(im);
hold on;
for i = 1:size(x)
    circle(x(i),y(i),scores(i)*10);
end
