function horizontalSeam = find_optimal_horizontal_seam(M)
% find the min of every col
% trick is to call find_optimal_vericla_seam() with transpose
% of M
    horizontalSeam = find_optimal_vertical_seam(transpose(M));
    horizontalSeam = horizontalSeam';
end