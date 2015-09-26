function displaySeam(im, seam, seamDirection)
    [a b c] = size(seam);
    imshow(im);
    hold on;
    if strcmp(seamDirection, 'VERTICAL')==1
        x = 1:a;
        plot(seam,x);
    elseif strcmp(seamDirection, 'HORIZONTAL')==1
        x = 1:b;
        plot(x,seam);
    end
        
end
