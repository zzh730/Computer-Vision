im = imread('1.png');
I = rgb2gray(im);

  corners = detectHarrisFeatures(I);
  [features, valid_corners] = extractFeatures(I, corners);
  
  imshow(im);
  hold on;
  plot(valid_corners);