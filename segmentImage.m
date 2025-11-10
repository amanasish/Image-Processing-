function mask = segmentImage(I)
    % --- Convert RGB to LAB (compatible with R2013b) ---
    cform = makecform('srgb2lab');
    lab_I = applycform(I, cform);

    % Extract only the 'a' and 'b' color channels for clustering
    ab = lab_I(:,:,2:3);
    ab = im2single(ab);
    nColors = 3; % You can change this number for more/less segmentation levels

    % --- Manual K-means Clustering (R2013b Compatible) ---
    % Reshape to N x 2 feature matrix
    ab_reshaped = reshape(ab, [], 2);

    % Perform k-means clustering
    [cluster_idx, ~] = kmeans(ab_reshaped, nColors, 'Distance', 'sqEuclidean', 'Replicates', 3);

    % Reshape cluster labels back to image dimensions
    pixel_labels = reshape(cluster_idx, size(lab_I,1), size(lab_I,2));

    % --- Choose cluster with lowest average brightness ---
    L = lab_I(:,:,1);
    meanL = zeros(1, nColors);
    for k = 1:nColors
        meanL(k) = mean(L(pixel_labels == k));
    end
    [~, idx] = min(meanL);
    mask = pixel_labels == idx;

    % Convert to logical
    mask = logical(mask);
end
