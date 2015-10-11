imageset = struct('name',{},'feature',{},'x',{},'y',{},'scores',{},'subset',{});
for i=1:10
    str = strcat(int2str(i),'.png');
    image = imread(str);
    [x,y,scores,Gx,Gy] = extract_keypoints(image);
    [features,x,y,scores] = compute_features(image, x,y,scores,Gx,Gy);
    imageset(i).name = str;
    imageset(i).feature = features;
    imageset(i).x = x;
    imageset(i).y = y;
    imageset(i).scores = scores;
end

se = 10;
rank = struct('first',{},'second',{},'similarity',{});
for i = 1:10
    if i ~= se;
        dis = [];
        k = min(size(imageset(i).x,1),100);
        m = randperm(min(size(imageset(se).feature,1),size(imageset(i).feature,1)),k);
        for j = 1:size(m)
            dis(i) = sqrt(sum(power(imageset(se).feature(m(j), :) - imageset(i).feature(m(j), :), 2)));
        end
        siml = mean(dis);
        rank(i).first = imageset(se).name;
        rank(i).second = imageset(i).name;
        rank(i).similarity = siml;
    end
    
end
