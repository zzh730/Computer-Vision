function energyImage = energy_image(im)

% convert it to gray scale
im = im2double(im);
im = rgb2gray(im);

% define the finte differences filters and build the "Win Summation" kernel 
% which sums all elements within a window
win = ones(3,3);
vGradXFilter = [-0.5, 0, 0.5];
vGradYFilter = [-0.5; 0; 0.5];

% calculate the image gradients
dx = imfilter(im,vGradXFilter,'replicate', 'same', 'corr');
dy = imfilter(im,vGradYFilter,'replicate', 'same', 'corr');

% calculate the gradient and sum the norm of the gradient within the window
grad = sqrt(dx.^2.0+dy.^2.0);
energyImage = imfilter(grad, win,0, 'same', 'corr');

end