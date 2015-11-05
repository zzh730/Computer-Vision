function [sim] = compareSimilarity(bow1, bow2)
    % use normalized scalar product to compute the similarity of bows
    sim = sum(bow1.*bow2)/(norm(norm(bow1) * norm(bow2)));
end