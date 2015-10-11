imageset = cell(10);
for i=1:10
    str = strcat(int2str(i),'.png')
    image = imread(str);
    [x,y,scores,Gx,Gy] = extract_keypoints(image);
    [features,x,y,scores] = compute_features(image, x,y,scores,Gx,Gy);
    
    figure;
    imshow(image);
    hold on;
    for j = 1:size(x)
        circle(x(j),y(j),scores(j)/200);
    end
    hold off;
    str = strcat(int2str(i),'_point.png');
    saveas(gcf, str);
    %imageset(i) = struct('image',image,'features',features,'x',x,'y',y,'scores',scores);

end

