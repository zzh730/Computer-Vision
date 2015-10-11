function [features, x, y, scores] = compute_features(image, x,y, scores, Gx,Gy)

% compute the gradient and directions
ang = atan2(Gy, Gx);			
mag = sqrt(Gx.^2 + Gy.^2);
[a b c] = size(image);
n = size(x,1);
for i = 1: min(n,min(a,b))
    % boundary test for 16*16 block
	if (((x(i)-7)>0 && (y(i)-7)>0) && (((n-x(i))>8) && (n-y(i)) > 8))
        % 16*16 window for gradient and angle

        suba = ang(y(i)-7:y(i)+8, x(i)-7:x(i)+8);
        subm = mag(y(i)-7:y(i)+8, x(i)-7:x(i)+8);		
        feat = [];
        % divide 16*16 to 4*4 blocks
        for blockno = 1:16
            v = zeros(1,8);
            jupper = (blockno - floor((blockno-1)/4)*4)*4;
            for j = jupper -3:jupper
                kupper = (floor((blockno-1)/4) + 1)*4;
                % put the angle in 8 bins
                for k = kupper - 3:kupper
                    q = floor((suba(k,j) + pi)./(pi/4));
                    if q == 8
                        q = 1;
                    end
                    v(q+1) = v(q+1) + subm(k,j);
                end
            end
            v = v / sum(v);
            feat = [feat v];
        end
        features(i,:) = feat;        		
    else
        % if key point out of boundary set it to 0
        features(i,:) = zeros(1,128);
    end
    
end
end
