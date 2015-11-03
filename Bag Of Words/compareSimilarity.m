function [sim] = compareSimilarity(bow1, bow2)

    % use normalized scalar product to compute the similarity of bows
    sim = dot(bow1,bow2)/sqrt(dot(bow1,bow1) * dot(bow2,bow2));

end