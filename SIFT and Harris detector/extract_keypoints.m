function [x,y,scores,Gx,Gy] = extract_keypoints(image)

% convert the image to gray scale
im = rgb2gray(im2double(image));
dx = [-1 0 1; -1 0 1; -1 0 1];
dy = dx';

% derivatives of the image
Gx = conv2(im, dx, 'same');
Gy = conv2(im, dy, 'same');

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
Resp = (Ixx.*Iyy - Ixy.^2) - k*(Ixx + Iyy).^2;
Resp=(1000/max(max(Resp)))*Resp;

% find the local optima of the harris detector response.
R=Resp;
ma=max(max(R));
sze = 2*r+1; 
MX = ordfilt2(R,sze^2,ones(sze));
Resp = (R==MX)&(R>Threshold);
cout=sum(sum(Resp(5:size(Resp,1)-5,5:size(Resp,2)-5)));

% increase or decrease the threshold for several iterations
c_min=1; 
c_max=180; 
loop=0; 
while ((cout<c_min)|(cout>c_max))&(loop<=200) 
    if cout<c_min 
        Threshold=Threshold*0.5; 
    elseif cout>c_max 
        Threshold=Threshold*1.5; 
    end 
    Resp = (R==MX)&(R>Threshold); 
    cout=sum(sum(Resp(5:size(Resp,1)-5,5:size(Resp,2)-5)));
    loop=loop+1;
end

% Compute nonmax suppression
output = Resp > imdilate(Resp, [1 1 1; 1 0 1; 1 1 1]);
[y x] = find(output);

% plot the key point on the image 
scores = zeros(size(y));
for i = 1:size(y)
    scores(i) = R(y(i),x(i));
end

end
