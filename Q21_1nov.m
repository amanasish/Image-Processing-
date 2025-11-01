clc; clear; close all;

%% Step 1: Read and preprocess image
I = imread('peppers.png');      % Replace with your own image
I = im2double(I);               % Convert to double precision
figure, imshow(I), title('Original Image');

% Convert image from RGB to L*a*b* color space (better for clustering)
lab_I = rgb2lab(I);
[m, n, ~] = size(lab_I);

% Reshape image into 2D array (each pixel = 3 color features)
X = reshape(lab_I, m*n, 3);

%% ==============================================================
% ? PART 1: Image Segmentation using K-Means Clustering
% ==============================================================

K = 3; % Number of clusters (segments)
[idx, C] = kmeans(X, K, 'distance', 'sqEuclidean', 'Replicates', 3);

% Reconstruct segmented image
segmented = reshape(idx, m, n);

% Assign each cluster its mean color
I_kmeans = zeros(m, n, 3);
for k = 1:K
    I_kmeans(repmat(segmented == k, [1 1 3])) = repmat(reshape(C(k, :), [1 1 3]), sum(segmented(:)==k), 1);
end

figure('Name','K-Means Segmentation');
subplot(1,2,1), imshow(I), title('Original Image');
subplot(1,2,2), imshow(I_kmeans), title(['Segmented Image (K = ' num2str(K) ')']);

%% ==============================================================
% ? PART 2: Image Segmentation using KNN Classification
% ==============================================================

% For demonstration, let’s create a few labeled training samples manually
% We’ll use the segmented image from K-Means as pseudo ground truth
% Randomly select pixels from each cluster as training data
num_train = 500;
train_idx = [];
train_labels = [];
for k = 1:K
    cluster_pixels = find(segmented == k);
    sel = randsample(cluster_pixels, min(num_train, numel(cluster_pixels)));
    train_idx = [train_idx; sel];
    train_labels = [train_labels; k*ones(length(sel),1)];
end

% Prepare training and test data
X_train = X(train_idx, :);
Y_train = train_labels;

X_test = X;
Y_test = segmented(:); % True labels (for evaluation)

% Apply KNN classification
Mdl = fitcknn(X_train, Y_train, 'NumNeighbors', 5, 'Distance', 'euclidean');
Y_pred = predict(Mdl, X_test);

% Reconstruct segmented image from predicted labels
seg_knn = reshape(Y_pred, m, n);

% Assign each cluster mean color (same C from K-Means)
I_knn = zeros(m, n, 3);
for k = 1:K
    I_knn(repmat(seg_knn == k, [1 1 3])) = repmat(reshape(C(k, :), [1 1 3]), sum(seg_knn(:)==k), 1);
end

figure('Name','KNN Segmentation');
subplot(1,2,1), imshow(I), title('Original Image');
subplot(1,2,2), imshow(I_knn), title('Segmented Image (KNN Classification)');

% ==============================================================
% Step 3: Evaluation (optional)
% ==============================================================
accuracy = sum(Y_pred == Y_test) / numel(Y_test);
fprintf('KNN Segmentation Accuracy (vs K-Means baseline): %.2f%%\n', accuracy * 100);
